import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String _githubClientId = String.fromEnvironment('GITHUB_CLIENT_ID');
const String _githubRedirectUri = String.fromEnvironment('GITHUB_REDIRECT_URI');

/// GitHub OAuth 授权页，授权完成后向宿主返回 authorization code。
class GitHubAuthPage extends StatefulWidget {
  const GitHubAuthPage({super.key});

  static bool get isConfigured =>
      _githubClientId.isNotEmpty && _githubRedirectUri.isNotEmpty;

  @override
  State<GitHubAuthPage> createState() => _GitHubAuthPageState();
}

class _GitHubAuthPageState extends State<GitHubAuthPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: _handleNavigationRequest,
          onPageFinished: _handlePageFinished,
          onWebResourceError: _handleWebResourceError,
        ),
      )
      ..loadRequest(_authorizationUri());
  }

  Uri _authorizationUri() => Uri.https(
        'github.com',
        '/login/oauth/authorize',
        <String, String>{
          'client_id': _githubClientId,
          'redirect_uri': _githubRedirectUri,
          'scope': 'read:user user:email',
        },
      );

  NavigationDecision _handleNavigationRequest(NavigationRequest request) {
    if (!request.url.startsWith(_githubRedirectUri)) {
      return NavigationDecision.navigate;
    }
    final Uri callback = Uri.parse(request.url);
    Navigator.of(context).pop(callback.queryParameters['code']);
    return NavigationDecision.prevent;
  }

  void _handlePageFinished(String _) {
    if (mounted) setState(() => _isLoading = false);
  }

  void _handleWebResourceError(WebResourceError error) {
    if (!mounted || error.isForMainFrame == false) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.githubLogin),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator.adaptive()),
        ],
      ),
    );
  }
}
