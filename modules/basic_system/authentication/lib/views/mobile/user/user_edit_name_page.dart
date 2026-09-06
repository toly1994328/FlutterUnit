import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_user_core/fx_user_core.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:l10n/l10n.dart';
import 'package:utils/utils.dart';

/// 用户昵称编辑页。
class UserEditNamePage extends StatefulWidget {
  final String name;

  const UserEditNamePage({super.key, required this.name});

  @override
  State<UserEditNamePage> createState() => _UserEditNamePageState();
}

class _UserEditNamePageState extends State<UserEditNamePage> {
  late final TextEditingController _controller;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.name);
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
          context.l10n.editUsername,
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
              maxLength: 50,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: context.l10n.usernameHint,
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              context.l10n.usernameLimit,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }

  /// 校验昵称并更新当前用户资料。
  Future<void> _save() async {
    final String value = _controller.text.trim();
    if (value.isEmpty) {
      Toast.warning(context, context.l10n.nicknameRequired);
      return;
    }
    if (value == widget.name) {
      Navigator.of(context).pop();
      return;
    }
    setState(() => _saving = true);
    try {
      await context
          .read<FxUserSessionCubit>()
          .updateProfile(UserProfilePatch(displayName: value));
      if (!mounted) return;
      Toast.success(context, context.l10n.nicknameUpdated);
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      Toast.error(context, context.l10n.nicknameUpdateFailed);
    }
  }
}
