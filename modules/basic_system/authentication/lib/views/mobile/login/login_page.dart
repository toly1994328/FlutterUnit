import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:fx_user_ui/fx_user_ui.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:unit_env/unit_env.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utils/utils.dart';

import 'github_auth_page.dart';

/// FlutterUnit 对 FrameworkX 通用登录界面的宿主组装。
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool supportsNativeApple = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS);
    final bool supportsEmbeddedGithub = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS);
    return FxLoginPage(
      config: FxUserUiConfig(
        title: 'FLUTTER UNIT',
        subtitle: '群英荟萃，匠心者也',
        logo: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/images/flutter_unit_logo.webp',
            fit: BoxFit.cover,
          ),
        ),
        methods: const {FxLoginMethod.emailCode, FxLoginMethod.password},
        onUserAgreement: () => _openLegalDocument(
          context,
          _agreementUrl,
        ),
        onPrivacyPolicy: () => _openLegalDocument(
          context,
          _privacyUrl,
        ),
        showGithub: supportsEmbeddedGithub && GitHubAuthPage.isConfigured,
        showApple: supportsNativeApple,
        onGithubLogin: () => _loginWithGithub(context),
        onAppleLogin: () => _loginWithApple(context),
      ),
      onLogin: ({
        required FxLoginMethod method,
        required String identifier,
        required String credential,
      }) {
        final FxUserSessionCubit session = context.read<FxUserSessionCubit>();
        if (method == FxLoginMethod.emailCode) {
          return session.authenticate(
            VerificationCodeAuth(
              channel: 'email',
              identifier: identifier,
              code: credential,
            ),
          );
        }
        return session.authenticate(
          PasswordAuth(identifier: identifier, password: credential),
        );
      },
      onRequestCode: ({
        required FxLoginMethod method,
        required String identifier,
      }) {
        if (method != FxLoginMethod.emailCode) {
          throw UnsupportedError('FlutterUnit 当前仅支持邮箱验证码');
        }
        return context.read<FxUserSessionCubit>().requestCode(
              channel: 'email',
              identifier: identifier,
            );
      },
      onAuthenticated: () => Navigator.of(context).pop(),
      onClose: () => Navigator.of(context).pop(),
      onError: (Object error) => _showAuthError(context, error),
    );
  }

  /// 将认证异常转换成用户提示，并交给宿主 Toast 通道展示。
  void _showAuthError(BuildContext context, Object error) {
    Toast.error(context, _friendlyAuthError(error));
  }

  /// 根据稳定业务码和网络异常特征生成可操作的提示文案。
  String _friendlyAuthError(Object error) {
    final String? serverCode =
        error is RequestException ? error.serverCode : null;
    switch (serverCode) {
      case 'AUTH_CODE_INVALID':
        return '验证码错误，请重新输入';
      case 'AUTH_CODE_EXPIRED':
        return '验证码已失效，请重新获取';
      case 'AUTH_CODE_RATE_LIMITED':
        return '验证码发送过于频繁，请稍后再试';
      case 'AUTH_EMAIL_INVALID':
        return '邮箱格式不正确，请检查后重试';
      case 'AUTH_CREDENTIAL_INVALID':
        return '账号或密码错误，请重新输入';
    }
    final String message = error.toString();
    if (message.contains('request exception') ||
        message.contains('DioException') ||
        message.contains('SocketException') ||
        message.contains('Connection failed')) {
      return '网络连接异常，请检查网络后重试';
    }
    return '登录失败，请稍后重试';
  }

  Future<bool> _loginWithGithub(BuildContext context) async {
    final String? code = await Navigator.of(context).push<String>(
      MaterialPageRoute<String>(
        builder: (BuildContext context) => const GitHubAuthPage(),
      ),
    );
    if (code == null || code.isEmpty || !context.mounted) return false;
    await context.read<FxUserSessionCubit>().authenticate(
          OAuthAuth(provider: 'github', code: code),
        );
    return true;
  }

  Future<bool> _loginWithApple(BuildContext context) async {
    try {
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: const <AppleIDAuthorizationScopes>[
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final String? identityToken = credential.identityToken;
      if (identityToken == null || identityToken.isEmpty || !context.mounted) {
        return false;
      }
      await context.read<FxUserSessionCubit>().authenticate(
            OAuthAuth(provider: 'apple', code: identityToken),
          );
      return true;
    } on SignInWithAppleAuthorizationException catch (error) {
      if (error.code == AuthorizationErrorCode.canceled) return false;
      rethrow;
    }
  }

  /// 使用系统浏览器打开用户协议或隐私政策。
  Future<void> _openLegalDocument(BuildContext context, Uri? uri) async {
    if (uri == null) {
      Toast.error(context, '协议地址配置异常');
      return;
    }
    final bool opened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!opened && context.mounted) {
      Toast.error(context, '暂时无法打开该页面，请稍后重试');
    }
  }
}

/// FlutterUnit 用户协议地址，由客户端环境文件注入。
final Uri? _agreementUrl = _parseLegalUrl(
  const String.fromEnvironment('AGREEMENT_URL'),
);

/// FlutterUnit 隐私政策地址，由客户端环境文件注入。
final Uri? _privacyUrl = _parseLegalUrl(
  const String.fromEnvironment('PRIVACY_URL'),
);

Uri? _parseLegalUrl(String rawUrl) {
  final Uri? uri = Uri.tryParse(rawUrl.trim());
  if (uri == null || !uri.hasAuthority) return null;
  if (uri.scheme != 'http' && uri.scheme != 'https') return null;
  return uri;
}
