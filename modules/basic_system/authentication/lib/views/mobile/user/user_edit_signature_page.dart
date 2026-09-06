import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_user_core/fx_user_core.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:l10n/l10n.dart';
import 'package:utils/utils.dart';

/// 用户签名编辑页。
class UserEditSignaturePage extends StatefulWidget {
  final String signature;

  const UserEditSignaturePage({super.key, required this.signature});

  @override
  State<UserEditSignaturePage> createState() => _UserEditSignaturePageState();
}

class _UserEditSignaturePageState extends State<UserEditSignaturePage> {
  late final TextEditingController _controller;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.signature);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor =
        isDark ? Colors.black : const Color(0xffededed);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          context.l10n.editSignature,
          style: const TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
            child: TextButton(
              style: TextButton.styleFrom(minimumSize: const Size(60, 32)),
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const CupertinoActivityIndicator()
                  : Text(context.l10n.save),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 8),
          Container(
            color: Theme.of(context).listTileTheme.tileColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: TextField(
              controller: _controller,
              autofocus: true,
              maxLength: 100,
              maxLines: 1,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: context.l10n.signatureHint,
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              context.l10n.signatureLimit,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }

  /// 更新签名；空字符串表示清除已有签名。
  Future<void> _save() async {
    final String value = _controller.text.trim();
    if (value == widget.signature) {
      Navigator.of(context).pop();
      return;
    }
    setState(() => _saving = true);
    try {
      await context.read<FxUserSessionCubit>().updateProfile(
            UserProfilePatch(fields: <String, dynamic>{'signature': value}),
          );
      if (!mounted) return;
      Toast.success(context, context.l10n.signatureUpdated);
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      Toast.error(context, context.l10n.signatureUpdateFailed);
    }
  }
}
