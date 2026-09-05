import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_account/fx_account.dart';
import 'package:fx_exception/fx_exception.dart';
import 'package:fx_user_core/fx_user_core.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:utils/utils.dart';

import '../../user_avatar.dart';
import 'avatar/avatar_update_flow.dart';
import 'user_edit_name_page.dart';
import 'user_edit_signature_page.dart';

/// 当前登录用户的账户资料页，布局与交互对齐 ViewX 移动端账号管理页。
class UserAccountPage extends StatelessWidget {
  const UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FxUserSessionCubit, FxUserSession>(
      builder: _buildSession,
    );
  }

  Widget _buildSession(BuildContext context, FxUserSession session) {
    if (session is! FxAuthed) {
      return const Scaffold(body: Center(child: Text('未登录')));
    }
    final FxIdentity user = session.user;
    final String signature = user.read(FxIdentityFields.signature) ?? '';
    final String? email = user.read(FxIdentityFields.email);
    final bool hasPassword = user.read(FxIdentityFields.hasPassword) ?? false;
    return AccountManagementPage(
      data: AccountManagementData(
        title: '账号管理',
        avatar: const Align(
          alignment: Alignment.centerRight,
          child: SizedBox.square(
            dimension: 48,
            child: SessionUserAvatar(size: 48, cornerRadius: 6),
          ),
        ),
        username: user.displayName ?? '',
        signature: signature,
        userId: user.id,
        userIdLabel: '匠心Id',
        contactItems: <AccountManagementItem>[
          AccountManagementItem(
            label: '邮箱',
            value: email?.isNotEmpty == true ? email! : '去绑定',
            valueColor:
                email?.isNotEmpty == true ? null : const Color(0xFFFF7A00),
            onTap: () => _openBindEmailPage(context, email),
          ),
        ],
        hasPassword: hasPassword,
        onSetPassword: () => _openSetPasswordPage(context),
        onChangePassword: () => _openChangePasswordPage(context),
        onAvatarTap: () => AvatarUpdateFlow.start(context),
        onUsernameTap: () => _openNameEditor(context, user.displayName ?? ''),
        onSignatureTap: () => _openSignatureEditor(context, signature),
        onCopyUserId: () async => _copyId(context, user.id),
        onDeleteAccount: () => _openDeleteAccountPage(context),
        onLogout: () => _confirmLogout(context),
      ),
    );
  }

  /// 打开公共邮箱绑定页并接入统一会话能力。
  Future<void> _openBindEmailPage(
    BuildContext context,
    String? currentEmail,
  ) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext pageContext) => BindEmailPage(
          currentEmail: currentEmail,
          onValidateEmail: (String email) => _checkEmail(context, email),
          onRequestCode: (String email) =>
              context.read<FxUserSessionCubit>().requestCode(
                    channel: 'email',
                    identifier: email,
                    scene: FxVerificationCodeScene.bindEmail,
                  ),
          onSubmit: (String email, String code) =>
              _bindEmail(pageContext, email, code),
          onMessage: (String message) => Toast.warning(context, message),
        ),
      ),
    );
  }

  /// 检查邮箱是否可以绑定到当前账号。
  Future<bool> _checkEmail(BuildContext context, String email) async {
    final FxAccountCheckResult result = await context
        .read<FxUserSessionCubit>()
        .checkAccount(type: 'email', identifier: email);
    if (!result.available && context.mounted) {
      Toast.warning(context, '该邮箱已被其他账号绑定');
    }
    return result.available;
  }

  /// 绑定邮箱并返回账号管理页。
  Future<void> _bindEmail(
    BuildContext context,
    String email,
    String code,
  ) async {
    await context
        .read<FxUserSessionCubit>()
        .bindEmail(email: email, code: code);
    if (!context.mounted) return;
    Toast.success(context, '邮箱绑定成功');
    Navigator.of(context).pop();
  }

  /// 打开公共修改密码页。
  Future<void> _openChangePasswordPage(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext pageContext) => ChangePasswordPage(
          onForgotPassword: () => _openForgotPasswordPage(pageContext),
          onSubmit: (String oldPassword, String newPassword) =>
              _changePassword(pageContext, oldPassword, newPassword),
        ),
      ),
    );
  }

  /// 为尚未拥有密码的账号打开首次设置页。
  Future<void> _openSetPasswordPage(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext pageContext) => SetPasswordPage(
          onSubmit: context.read<FxUserSessionCubit>().setPassword,
          onMessage: (String message) => Toast.warning(context, message),
        ),
      ),
    );
  }

  /// 修改当前账号密码并返回账号管理页。
  Future<void> _changePassword(
    BuildContext context,
    String oldPassword,
    String newPassword,
  ) async {
    final bool changed =
        await context.read<FxUserSessionCubit>().changePassword(
              oldPassword: oldPassword,
              newPassword: newPassword,
            );
    if (!context.mounted) return;
    if (!changed) {
      Toast.error(context, '密码修改失败');
      return;
    }
    Toast.success(context, '密码修改成功');
    Navigator.of(context).pop();
  }

  /// 打开公共邮箱验证码找回密码页。
  Future<void> _openForgotPasswordPage(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext pageContext) => ForgotPasswordPage(
          onRequestCode: (String email) =>
              context.read<FxUserSessionCubit>().requestCode(
                    channel: 'email',
                    identifier: email,
                    scene: FxVerificationCodeScene.resetPassword,
                  ),
          onSubmit: (String email, String code, String newPassword) =>
              _resetPassword(pageContext, email, code, newPassword),
          onMessage: (String message) => Toast.warning(context, message),
        ),
      ),
    );
  }

  /// 通过邮箱验证码重置密码。
  Future<void> _resetPassword(
    BuildContext context,
    String email,
    String code,
    String newPassword,
  ) async {
    await context.read<FxUserSessionCubit>().resetPassword(
          email: email,
          code: code,
          newPassword: newPassword,
        );
    if (!context.mounted) return;
    Toast.success(context, '密码重置成功');
    Navigator.of(context).pop();
  }

  Future<void> _openNameEditor(BuildContext context, String name) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => UserEditNamePage(name: name),
      ),
    );
  }

  Future<void> _openSignatureEditor(
    BuildContext context,
    String signature,
  ) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            UserEditSignaturePage(signature: signature),
      ),
    );
  }

  /// 复制用户 ID 并通过统一 Toast 反馈。
  void _copyId(BuildContext context, String id) {
    Clipboard.setData(ClipboardData(text: id));
    Toast.success(context, '已复制');
  }

  /// 打开 FrameworkX 提供的风险确认与密码验证页面。
  Future<void> _openDeleteAccountPage(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext pageContext) => DeleteAccountPage(
          onMessage: (String message) => Toast.warning(context, message),
          onSubmit: (String password) => _deleteAccount(context, password),
        ),
      ),
    );
  }

  /// 注销远端账号、清理本地会话，并返回应用首页。
  Future<void> _deleteAccount(BuildContext context, String password) async {
    try {
      await context.read<FxUserSessionCubit>().deleteAccount(password);
      if (!context.mounted) return;
      Toast.success(context, '账号已注销');
      Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
    } on RequestException catch (error) {
      if (!context.mounted) return;
      Toast.error(context, error.message ?? '账号注销失败，请稍后重试');
    } catch (_) {
      if (!context.mounted) return;
      Toast.error(context, '账号注销失败，请稍后重试');
    }
  }

  /// 二次确认后退出登录并回到应用首页。
  Future<void> _confirmLogout(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertConformDialog(
        title: '退出登录',
        content: '确定要退出当前账号吗？',
        conformText: '退出',
        conformTextColor: Colors.red,
        onConform: () async {
          await context.read<FxUserSessionCubit>().logout();
          if (context.mounted) Navigator.of(context).pop();
        },
      ),
    );
  }
}
