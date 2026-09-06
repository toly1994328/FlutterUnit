import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:l10n/l10n.dart';
import 'package:unit_env/unit_env.dart';

import '../../honors/bloc/avatar_frame_cubit.dart';
import '../../honors/model/user_honor.dart';
import '../mobile/user/avatar/avatar_update_flow.dart';
import '../user_avatar.dart';
import 'equipped_badges.dart';

enum _HonorSection { avatarFrame, badge }

/// 当前用户查看并选择头像框的页面。
class AvatarHonorsPage extends StatefulWidget {
  const AvatarHonorsPage({super.key, this.initialKind = 'avatar_frame'});

  /// 首次打开时激活的荣誉类型，支持 avatar_frame 与 badge。
  final String initialKind;

  @override
  State<AvatarHonorsPage> createState() => _AvatarHonorsPageState();
}

class _AvatarHonorsPageState extends State<AvatarHonorsPage> {
  /// 当前展示的荣誉类型。
  late _HonorSection _selectedSection;

  @override
  void initState() {
    super.initState();
    _selectedSection = widget.initialKind == 'badge'
        ? _HonorSection.badge
        : _HonorSection.avatarFrame;
    context.read<AvatarFrameCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 2,
      initialIndex: _selectedSection.index,
      child: Scaffold(
        backgroundColor: colors.surfaceContainer,
        appBar: AppBar(
          title: Text(context.l10n.avatarAchievements),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: colors.surfaceContainer,
          foregroundColor: colors.onSurface,
          titleTextStyle: TextStyle(
            color: colors.onSurface,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: BlocBuilder<FxUserSessionCubit, FxUserSession>(
          builder: _buildBySession,
        ),
      ),
    );
  }

  void _selectKind(int index) {
    final _HonorSection selectedSection = _HonorSection.values[index];
    if (_selectedSection == selectedSection) return;
    setState(() => _selectedSection = selectedSection);
  }

  Widget _buildBySession(BuildContext context, FxUserSession session) {
    if (session is! FxAuthed) {
      return Center(child: Text(context.l10n.signInToViewHonors));
    }
    return BlocConsumer<AvatarFrameCubit, AvatarFrameState>(
      listenWhen: _shouldShowError,
      listener: _showError,
      builder: _buildContent,
    );
  }

  bool _shouldShowError(
    AvatarFrameState previous,
    AvatarFrameState current,
  ) {
    return current.error != null && current.error != previous.error;
  }

  void _showError(BuildContext context, AvatarFrameState state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.operationFailed)),
    );
  }

  Widget _buildContent(BuildContext context, AvatarFrameState state) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Size viewportSize = MediaQuery.sizeOf(context);
    final bool isMobile = viewportSize.shortestSide < 600;
    final int columnCount = _frameColumnCount(viewportSize.width, isMobile);
    final double cardHeight = isMobile ? 136 : 180;
    final bool showAvatarFrames = _selectedSection == _HonorSection.avatarFrame;
    final String kind = showAvatarFrames ? 'avatar_frame' : 'badge';
    final List<UserHonor> honors =
        state.honors.where((UserHonor honor) => honor.kind == kind).toList();
    return RefreshIndicator(
      color: colors.primary,
      onRefresh: context.read<AvatarFrameCubit>().load,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(child: _buildAvatarPreview(context, state)),
          SliverToBoxAdapter(
            child: ColoredBox(
              color: colors.surface,
              child: TabBar(
                indicatorColor: colors.primary,
                labelColor: colors.primary,
                unselectedLabelColor: colors.onSurfaceVariant,
                dividerColor: colors.outlineVariant,
                onTap: _selectKind,
                tabs: <Tab>[
                  Tab(text: context.l10n.avatarFrames),
                  Tab(text: context.l10n.badges),
                ],
              ),
            ),
          ),
          ...<Widget>[
            SliverToBoxAdapter(
              child: _SectionTitle(showAvatarFrames: showAvatarFrames),
            ),
            if (state.loading && honors.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(color: colors.primary),
                ),
              )
            else if (honors.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    showAvatarFrames
                        ? context.l10n.noAvatarFrames
                        : context.l10n.noBadges,
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 32),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) =>
                        _buildHonorCard(context, honors[index], state),
                    childCount: honors.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnCount,
                    mainAxisExtent: cardHeight,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  /// 移动端固定展示三列，大屏根据可用宽度增加列数。
  int _frameColumnCount(double viewportWidth, bool isMobile) {
    if (isMobile) return 3;
    final int columnCount = (viewportWidth / 190).floor();
    return columnCount.clamp(3, 6);
  }

  Widget _buildAvatarPreview(
    BuildContext context,
    AvatarFrameState state,
  ) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(vertical: 28),
      color: colors.surface,
      child: Column(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => AvatarUpdateFlow.start(context),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                const SessionUserAvatar(size: 104, showShadow: false),
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.surface, width: 2),
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: colors.onPrimary,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text(
                  state.frame?.name ?? context.l10n.noAvatarFrameEquipped,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const EquippedBadges(size: 22),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHonorCard(
    BuildContext context,
    UserHonor honor,
    AvatarFrameState state,
  ) {
    final bool selected = honor.equipped;
    final ColorScheme colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: selected
            ? Color.alphaBlend(
                colors.primary.withValues(alpha: 0.07),
                colors.surface,
              )
            : colors.surface,
        border: Border.all(
          color: selected ? colors.primary : colors.outlineVariant,
          width: selected ? 1.5 : 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          overlayColor: WidgetStatePropertyAll(
            colors.primary.withValues(alpha: 0.08),
          ),
          onTap: state.loading ? null : () => _toggleHonor(honor, selected),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Expanded(child: _HonorImage(honor: honor)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        honor.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected ? colors.primary : colors.onSurface,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Icon(
                    Icons.check_circle,
                    color: colors.primary,
                    size: 18,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// 按奖励类型切换头像框或徽章的装配状态。
  Future<void> _toggleHonor(UserHonor honor, bool selected) async {
    if (honor.kind == 'badge') {
      await _toggleBadge(honor, selected);
      return;
    }
    if (selected) {
      await _unequip();
      return;
    }
    await _equip(honor);
  }

  /// 切换单枚徽章的装配状态。
  Future<void> _toggleBadge(UserHonor badge, bool selected) async {
    final AvatarFrameCubit cubit = context.read<AvatarFrameCubit>();
    if (selected) {
      await cubit.unequipBadge(badge.code);
      return;
    }
    await cubit.equipBadge(badge.code);
  }

  /// 佩戴所选头像框，全局头像会随状态同步刷新。
  Future<void> _equip(UserHonor frame) async {
    await context.read<AvatarFrameCubit>().equip(frame.code);
  }

  /// 卸下当前头像框。
  Future<void> _unequip() async {
    await context.read<AvatarFrameCubit>().unequip();
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.showAvatarFrames});

  /// 是否展示头像框分区。
  final bool showAvatarFrames;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        showAvatarFrames ? context.l10n.myAvatarFrames : context.l10n.myBadges,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _HonorImage extends StatelessWidget {
  const _HonorImage({required this.honor});

  /// 当前展示的荣誉。
  final UserHonor honor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String source =
        FlutterUnitHost.resolveImageResource(honor.assetUrl).toString();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Image.network(
          source,
          fit: BoxFit.contain,
          errorBuilder: _buildError,
        ),
      ),
    );
  }

  Widget _buildError(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return const Center(child: Icon(Icons.broken_image_outlined));
  }
}
