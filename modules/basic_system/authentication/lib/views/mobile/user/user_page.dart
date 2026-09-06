import 'package:app/app.dart';
import 'package:authentication/views/mobile/user/user_account.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:l10n/l10n.dart';

import 'package:toly_ui/toly_ui.dart';
import 'package:utils/utils.dart';

import '../../../authentication.dart';
import '../../../repository/user_skin_repository.dart';
import 'skin/user_header_decoration.dart';

/// create by 张风捷特烈 on 2020/4/26
/// contact me by email 1981462002@qq.com
/// 说明:

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  static const int _maxSkinBytes = 10 * 1024 * 1024;

  /// 负责自定义皮肤的文件复制与路径持久化。
  final UserSkinRepository _skinRepository = UserSkinRepository();

  /// 亮色主题的自定义皮肤路径。
  String? _lightSkinPath;

  /// 暗色主题的自定义皮肤路径。
  String? _darkSkinPath;

  @override
  void initState() {
    super.initState();
    _loadSkins();
  }

  /// 加载亮色和暗色主题各自保存的皮肤路径。
  Future<void> _loadSkins() async {
    final String? lightPath = await _skinRepository.load(UserSkinMode.light);
    final String? darkPath = await _skinRepository.load(UserSkinMode.dark);
    if (!mounted) return;
    setState(() {
      _lightSkinPath = lightPath;
      _darkSkinPath = darkPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle!,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 32),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildHeaderImage(isDark),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(
                              alpha: isDark ? 0.28 : 0.12,
                            ),
                          ],
                          stops: const [0.45, 1],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 32,
                child: UserHeaderDecoration(),
              ),
              Positioned(
                top: 50,
                right: 20,
                child: GestureDetector(
                  onTap: _chooseCurrentSkin,
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4)),
                      child: const Icon(
                        Icons.color_lens_outlined,
                        color: Colors.white,
                        size: 20,
                      )),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 40,
                right: 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FeedbackWidget(
                      onPressed: () => _openAvatarHonors(context),
                      child: const SessionUserAvatar(
                        size: 80,
                        showBorder: true,
                        borderColor: Colors.white,
                        showShadow: false,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FeedbackWidget(
                        onPressed: () => _openAccountEntry(context),
                        child: BlocBuilder<FxUserSessionCubit, FxUserSession>(
                          builder: _buildByState,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Expanded(child: MePageItem())
        ],
      ),
    ));
  }

  /// 根据当前亮度选择自定义皮肤或内置默认图片。
  Widget _buildHeaderImage(bool isDark) {
    final String? customPath = isDark ? _darkSkinPath : _lightSkinPath;
    if (customPath != null) {
      return ImageRender(source: customPath, fit: BoxFit.cover);
    }
    if (isDark) {
      return Image.asset('assets/images/anim_draw.webp', fit: BoxFit.cover);
    }
    return SvgPicture.asset(
      'assets/images/user_header_light.svg',
      fit: BoxFit.cover,
    );
  }

  /// 直接选择图片，并保存为当前亮度模式的主页皮肤。
  Future<void> _chooseCurrentSkin() async {
    final UserSkinMode mode = Theme.of(context).brightness == Brightness.dark
        ? UserSkinMode.dark
        : UserSkinMode.light;
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );
      if (result == null || result.files.isEmpty) return;
      final PlatformFile image = result.files.single;
      if (image.size > _maxSkinBytes) {
        if (mounted) Toast.warning(context, context.l10n.skinTooLarge);
        return;
      }
      final Uint8List? bytes = image.bytes;
      final String extension = image.extension?.toLowerCase() ?? 'jpg';
      if (bytes == null || bytes.isEmpty) {
        if (mounted) Toast.error(context, context.l10n.imageReadFailed);
        return;
      }
      final String path = await _skinRepository.save(mode, bytes, extension);
      if (!mounted) return;
      setState(() {
        if (mode == UserSkinMode.light) {
          _lightSkinPath = path;
        } else {
          _darkSkinPath = path;
        }
      });
      Toast.success(
        context,
        context.l10n.skinUpdated(_modeLabel(context, mode)),
      );
    } catch (_) {
      if (mounted) Toast.error(context, context.l10n.skinUpdateFailed);
    }
  }

  String _modeLabel(BuildContext context, UserSkinMode mode) {
    return mode == UserSkinMode.light ? context.l10n.light : context.l10n.dark;
  }

  Widget _buildByState(BuildContext context, FxUserSession state) {
    final ThemeData theme = Theme.of(context);
    if (state is FxAuthed) {
      final String signature =
          state.user.read(FxIdentityFields.signature) ?? '';
      return _buildUserSummary(
        context,
        name: state.user.displayName ?? state.user.id,
        signature: signature.isEmpty ? context.l10n.noBio : signature,
      );
    }
    return _buildUserSummary(
      context,
      name: context.l10n.loginOrRegister,
      signature: context.l10n.loginSyncHint,
      nameStyle: TextStyle(
        fontSize: 18,
        color: theme.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// 将用户名放在背景分界线上方，并把个人简介展示在内容区内。
  Widget _buildUserSummary(
    BuildContext context, {
    required String name,
    required String signature,
    TextStyle? nameStyle,
  }) {
    final ThemeData theme = Theme.of(context);
    final Color signatureColor = theme.brightness == Brightness.dark
        ? Colors.white70
        : const Color(0xff7A7A7A);
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildOutlinedName(
              context,
              name,
              nameStyle ?? TextStyle(fontSize: 18, color: theme.primaryColor),
            ),
            Text(
              signature,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: signatureColor),
            ),
          ],
        ),
      ),
    );
  }

  /// 叠加白色描边和主题色填充，保证用户名在图片上清晰可见。
  Widget _buildOutlinedName(
    BuildContext context,
    String name,
    TextStyle style,
  ) {
    final Paint outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: Stack(
            children: <Widget>[
              ExcludeSemantics(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style.copyWith(foreground: outlinePaint),
                ),
              ),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style,
              ),
            ],
          ),
        ),
        EquippedBadges(
          size: 19,
          onTap: () => context.push(AppRoute.honors.url),
        ),
      ],
    );
  }

  void _openAccountEntry(BuildContext context) {
    final FxUserSession state = context.read<FxUserSessionCubit>().state;
    if (state is FxAuthed) {
      Navigator.of(context).push(
        SlidePageRoute(child: const UserAccountPage()),
      );
      return;
    }
    openUserLogin(context);
  }

  /// 登录用户点击头像时进入头像徽章佩戴页，游客仍先进入登录流程。
  void _openAvatarHonors(BuildContext context) {
    final FxUserSession state = context.read<FxUserSessionCubit>().state;
    if (state is FxAuthed) {
      context.push(AppRoute.honors.url);
      return;
    }
    openUserLogin(context);
  }
}
