import 'dart:typed_data';
import 'package:app/app.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:l10n/l10n.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:utils/utils.dart';
import '../../../repository/user_skin_repository.dart';
import '../../mobile/login/login_page.dart';
import '../../mobile/user/user_account.dart';
import '../../user_avatar.dart';
import 'account_ui.dart';

/// 个人资料和账号管理入口，沿用现有头像、资料编辑和封面存储。
class AccountProfilePanel extends StatefulWidget {
  const AccountProfilePanel({super.key, required this.authenticated});

  /// 是否展示资料编辑入口。
  final bool authenticated;
  @override
  State<AccountProfilePanel> createState() => _AccountProfilePanelState();
}

class _AccountProfilePanelState extends State<AccountProfilePanel> {
  /// 与移动端共用的本地皮肤仓库。
  final UserSkinRepository _skins = UserSkinRepository();

  /// 当前主题对应的皮肤类型。
  UserSkinMode? _mode;

  /// 当前模式的封面读取任务。
  Future<String?>? _skin;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final UserSkinMode mode = Theme.of(context).brightness == Brightness.dark
        ? UserSkinMode.dark
        : UserSkinMode.light;
    if (_mode == mode) return;
    _mode = mode;
    _skin = _skins.load(mode);
  }

  @override
  Widget build(BuildContext context) {
    return AccountSurface(
        padding: EdgeInsets.zero,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                  height: 138,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 100,
                        child: FutureBuilder<String?>(
                            future: _skin, builder: _buildCover)),
                    const Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                            child: SessionUserAvatar(
                                size: 76, showShadow: false))),
                    Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton.filledTonal(
                            onPressed: _chooseCover,
                            iconSize: 16,
                            constraints: const BoxConstraints.tightFor(
                                width: 28, height: 28),
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.palette_outlined))),
                  ])),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                  child: BlocBuilder<FxUserSessionCubit, FxUserSession>(
                      builder: _buildIdentity)),
              Divider(
                  height: 1,
                  color: Theme.of(context)
                      .colorScheme
                      .outlineVariant
                      .withValues(alpha: 0.5)),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(children: <Widget>[
                    AccountEntry(
                        icon: Icons.tune_rounded,
                        label: context.l10n.appSettings,
                        onTap: () => context.push(AppRoute.settings.url)),
                    AccountEntry(
                        icon: Icons.storage_outlined,
                        label: context.l10n.dataManagement,
                        onTap: () => context.push(AppRoute.dataManage.url)),
                    AccountEntry(
                        icon: Icons.chat_bubble_outline_rounded,
                        label: context.l10n.messageBoard,
                        onTap: () => context.push(AppRoute.note.url)),
                    AccountEntry(
                        icon: Icons.person_off_outlined,
                        label: context.l10n.blacklist,
                        onTap: () => context.push(AppRoute.blacklist.url)),
                    AccountEntry(
                        icon: Icons.favorite_border_rounded,
                        label: context.l10n.homeAccountSupport,
                        onTap: () => context.push(AppRoute.supportMe.url)),
                  ])),
            ]));
  }

  Widget _buildIdentity(BuildContext context, FxUserSession session) {
    final bool authed = session is FxAuthed;
    final String name = session is FxAuthed
        ? _resolveName(context, session.user)
        : context.l10n.loginOrRegister;
    final String signature = session is FxAuthed
        ? session.user.read<String>(FxIdentityFields.signature) ?? ''
        : context.l10n.loginSyncHint;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(signature.isEmpty ? context.l10n.noBio : signature,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12,
                  height: 1.6,
                  color: Theme.of(context).colorScheme.onSurfaceVariant)),
          const SizedBox(height: 18),
          OutlinedButton.icon(
              onPressed: _editProfile,
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              icon: Icon(authed ? Icons.edit_outlined : Icons.login_rounded,
                  size: 15),
              label: Text(
                  authed
                      ? context.l10n.accountEditProfile
                      : context.l10n.loginOrRegister,
                  style: const TextStyle(fontSize: 12))),
        ]);
  }

  /// 公开名称为空字符串时回退到账号标识，避免资料区出现空标题。
  String _resolveName(BuildContext context, FxIdentity identity) {
    final String name = identity.displayName?.trim() ?? '';
    if (name.isNotEmpty) return name;
    return identity.id.isNotEmpty && identity.id != 'null'
        ? identity.id
        : context.l10n.accountManagement;
  }

  Widget _buildCover(BuildContext context, AsyncSnapshot<String?> snapshot) {
    if (snapshot.data != null) {
      return ImageRender(source: snapshot.data!, fit: BoxFit.cover);
    }
    return _mode == UserSkinMode.dark
        ? Image.asset('assets/images/anim_draw.webp', fit: BoxFit.cover)
        : SvgPicture.asset('assets/images/user_header_light.svg',
            fit: BoxFit.cover);
  }

  void _editProfile() {
    if (!widget.authenticated) {
      openUserLogin(context);
      return;
    }
    Navigator.of(context).push(SlidePageRoute(child: const UserAccountPage()));
  }

  /// 封面仍保存到原有皮肤目录，两种亮度各自独立。
  Future<void> _chooseCover() async {
    final UserSkinMode mode = _mode!;
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image, allowMultiple: false, withData: true);
      if (result == null || result.files.isEmpty || !mounted) return;
      final PlatformFile image = result.files.single;
      if (image.size > 10 * 1024 * 1024) {
        Toast.warning(context, context.l10n.skinTooLarge);
        return;
      }
      final Uint8List? bytes = image.bytes;
      if (bytes == null || bytes.isEmpty) {
        Toast.error(context, context.l10n.imageReadFailed);
        return;
      }
      final String path = await _skins.save(
          mode, bytes, image.extension?.toLowerCase() ?? 'jpg');
      if (!mounted) return;
      if (_mode == mode) setState(() => _skin = Future<String?>.value(path));
      Toast.success(
          context,
          context.l10n.skinUpdated(mode == UserSkinMode.light
              ? context.l10n.light
              : context.l10n.dark));
    } catch (_) {
      if (mounted) {
        Toast.error(context, context.l10n.skinUpdateFailed);
      }
    }
  }
}
