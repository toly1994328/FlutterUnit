import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unit_env/unit_env.dart';

import '../../honors/bloc/avatar_frame_cubit.dart';
import '../../honors/model/user_honor.dart';

/// 展示当前用户已经装配的徽章，最多展示三枚。
class EquippedBadges extends StatelessWidget {
  const EquippedBadges({super.key, this.size = 18, this.onTap});

  /// 单枚徽章的显示尺寸。
  final double size;

  /// 点击整组徽章时触发的操作；为空时仅展示徽章。
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvatarFrameCubit, AvatarFrameState>(
      buildWhen: _badgesChanged,
      builder: _buildBadges,
    );
  }

  bool _badgesChanged(AvatarFrameState previous, AvatarFrameState current) {
    return _equippedCodes(previous) != _equippedCodes(current);
  }

  String _equippedCodes(AvatarFrameState state) {
    return state.honors
        .where((UserHonor honor) => honor.kind == 'badge' && honor.equipped)
        .map<String>((UserHonor honor) => honor.code)
        .join(',');
  }

  Widget _buildBadges(BuildContext context, AvatarFrameState state) {
    final List<UserHonor> badges = state.honors
        .where((UserHonor honor) => honor.kind == 'badge' && honor.equipped)
        .take(3)
        .toList();
    if (badges.isEmpty) return const SizedBox.shrink();
    final Widget badgesView = Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: badges.map<Widget>(_buildBadge).toList(),
      ),
    );
    if (onTap == null) return badgesView;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: badgesView,
    );
  }

  Widget _buildBadge(UserHonor badge) {
    final String source =
        FlutterUnitHost.resolveImageResource(badge.assetUrl).toString();
    return Tooltip(
      message: badge.name,
      child: Image.network(
        source,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: _buildError,
      ),
    );
  }

  Widget _buildError(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return SizedBox.square(dimension: size);
  }
}
