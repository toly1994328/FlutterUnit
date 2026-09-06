import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:unit_env/unit_env.dart';

import 'blacklist_repository.dart';
import 'blocked_user.dart';

/// 当前登录用户的黑名单管理页。
class BlacklistPage extends StatefulWidget {
  const BlacklistPage({super.key});

  @override
  State<BlacklistPage> createState() => _BlacklistPageState();
}

class _BlacklistPageState extends State<BlacklistPage> {
  final BlacklistRepository _repository = BlacklistRepository();
  List<BlockedUser> _users = const <BlockedUser>[];
  String? _error;
  bool _loading = true;
  final Set<int> _removingUsers = <int>{};

  @override
  void initState() {
    super.initState();
    _load();
  }

  /// 从服务端刷新当前账号的黑名单。
  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final ApiRet<List<BlockedUser>> result = await _repository.load();
    if (!mounted) return;
    setState(() {
      _loading = false;
      if (result.success) {
        _users = result.data;
      } else {
        _error = result.msg;
      }
    });
  }

  /// 解除拉黑并立即从当前列表移除该用户。
  Future<void> _unblock(BlockedUser user) async {
    setState(() => _removingUsers.add(user.userId));
    final ApiRet<dynamic> result = await _repository.unblock(user.userId);
    if (!mounted) return;
    setState(() => _removingUsers.remove(user.userId));
    if (!result.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.msg)),
      );
      return;
    }
    setState(() {
      _users = _users
          .where((BlockedUser item) => item.userId != user.userId)
          .toList();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.userUnblocked(user.nickname))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.blacklist)),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(_error!),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _load,
              child: Text(context.l10n.reload),
            ),
          ],
        ),
      );
    }
    if (_users.isEmpty) {
      return Center(child: Text(context.l10n.noBlockedUsers));
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _users.length,
        separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
        itemBuilder: _buildUserItem,
      ),
    );
  }

  Widget _buildUserItem(BuildContext context, int index) {
    final BlockedUser user = _users[index];
    final bool removing = _removingUsers.contains(user.userId);
    return ListTile(
      leading: UserAvatar(
        displayName: user.nickname,
        source: _resolveAvatar(user.avatar),
        radius: 22,
        showShadow: false,
      ),
      title: Text(user.nickname),
      subtitle: Text(
        user.signature?.trim().isNotEmpty == true
            ? user.signature!
            : context.l10n.userHasNoBio,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: TextButton(
        onPressed: removing ? null : () => _unblock(user),
        child: removing
            ? const SizedBox.square(
                dimension: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(context.l10n.unblock),
      ),
    );
  }

  String _resolveAvatar(String? avatar) {
    if (avatar == null || avatar.trim().isEmpty) return '';
    return FlutterUnitHost.resolveImageResource(
      avatar,
      width: 88,
      height: 88,
    ).toString();
  }
}
