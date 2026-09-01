import 'package:flutter/material.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package:provider/provider.dart';

import 'comment_avatar.dart';

typedef ModerationChangedCallback = Future<void> Function();
typedef ModerationAction = Future<ApiRet<dynamic>> Function();

Future<void> showCommentModerationSheet(
  BuildContext context,
  Comment comment, {
  required ModerationChangedCallback onChanged,
}) async {
  final PkgPlayerConfig config = context.read<PkgPlayerConfig>();
  if (!config.isAuthenticated) {
    await config.onLoginRequired(context);
    return;
  }
  if (!context.mounted) return;
  final ThemeData appTheme = Theme.of(context);
  final ColorScheme sheetColors = appTheme.colorScheme.copyWith(
    surface: Colors.white,
    onSurface: const Color(0xFF202124),
    onSurfaceVariant: const Color(0xFF6B6B73),
    surfaceContainerHighest: const Color(0xFFF5F5F7),
    outline: const Color(0xFF9A9AA1),
    outlineVariant: const Color(0xFFE5E5EA),
  );
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (BuildContext sheetContext) => Theme(
      data: appTheme.copyWith(
        colorScheme: sheetColors,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          dragHandleColor: Color(0xFF4A4A50),
        ),
      ),
      child: _CommentModerationSheet(
        comment: comment,
        onChanged: onChanged,
      ),
    ),
  );
}

class _CommentModerationSheet extends StatefulWidget {
  /// 当前操作所针对的评论。
  final Comment comment;

  /// 拉黑后触发评论列表刷新。
  final ModerationChangedCallback onChanged;

  const _CommentModerationSheet({
    required this.comment,
    required this.onChanged,
  });

  @override
  State<_CommentModerationSheet> createState() =>
      _CommentModerationSheetState();
}

class _CommentModerationSheetState extends State<_CommentModerationSheet> {
  /// 插件评论与内容治理接口。
  final PackageRequest _request = PackageRequest();

  /// 评论作者的公开资料。
  PublicUserProfile? _profile;

  /// 是否正在提交举报或拉黑操作。
  bool _loading = false;

  /// 举报表单是否已经展开。
  bool _reportExpanded = false;

  /// 用户填写的举报说明。
  final TextEditingController _reportController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final int? userId = widget.comment.userId;
    if (userId == null) return;
    final ApiRet<PublicUserProfile> result =
        await _request.getPublicUserProfile(userId);
    if (mounted && result.success) {
      setState(() => _profile = result.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String nickname = _profile?.nickname ?? widget.comment.guestName;
    final String signature = _profile?.signature?.trim() ?? '';
    final ColorScheme colors = Theme.of(context).colorScheme;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CommentAvatar(
                avatar: _profile?.avatar ?? widget.comment.avatar,
                name: nickname,
                size: 60,
              ),
              const SizedBox(height: 10),
              Text(
                nickname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (signature.isNotEmpty) ...<Widget>[
                const SizedBox(height: 4),
                Text(
                  signature,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                ),
              ],
              const SizedBox(height: 18),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildActionTile(
                      icon: Icons.flag_outlined,
                      iconColor: colors.primary,
                      title: '举报该评论',
                      subtitle: _reportExpanded ? '请选择原因并补充说明' : '提交给管理员审核',
                      trailingIcon: _reportExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.chevron_right,
                      onTap: _loading ? null : _toggleReportForm,
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      child: _reportExpanded
                          ? _buildReportForm(colors)
                          : const SizedBox.shrink(),
                    ),
                    if (widget.comment.userId != null) ...<Widget>[
                      Divider(
                        height: 1,
                        indent: 58,
                        color: colors.outlineVariant.withValues(alpha: 0.6),
                      ),
                      _buildActionTile(
                        icon: Icons.block_outlined,
                        iconColor: colors.error,
                        title: '拉黑该用户',
                        subtitle: '不再显示该用户的评论',
                        onTap: _loading ? null : _block,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建与面板视觉一致的内容治理操作项。
  Widget _buildActionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    IconData trailingIcon = Icons.chevron_right,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 19, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                trailingIcon,
                size: 20,
                color: Theme.of(context).colorScheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 展开或收起举报表单。
  void _toggleReportForm() {
    setState(() => _reportExpanded = !_reportExpanded);
  }

  /// 构建举报说明输入框与提交操作。
  Widget _buildReportForm(ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _reportController,
            enabled: !_loading,
            autofocus: true,
            minLines: 2,
            maxLines: 4,
            maxLength: 500,
            onChanged: _onReportChanged,
            decoration: InputDecoration(
              hintText: '请描述需要举报的问题',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.outlineVariant),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.outlineVariant),
              ),
            ),
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: _loading || _reportController.text.trim().isEmpty
                ? null
                : _report,
            child: _loading
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('提交举报'),
          ),
        ],
      ),
    );
  }

  void _onReportChanged(String value) {
    setState(() {});
  }

  Future<void> _report() async {
    await _submit(
      () => _request.submitReport(
        resourceType: 'package_comment',
        resourceId: '${widget.comment.id}',
        targetUserId: widget.comment.userId,
        reason: '用户举报',
        detail: _reportController.text.trim(),
        metadata: <String, dynamic>{
          'package_id': widget.comment.packageId,
        },
      ),
      '举报已提交，我们会尽快处理',
      refresh: false,
    );
  }

  Future<void> _block() async {
    await _submit(
      () => _request.blockCommentAuthor(
        widget.comment.id,
        reason: '拉黑用户并举报评论',
      ),
      '已拉黑该用户',
      refresh: true,
    );
  }

  Future<void> _submit(
    ModerationAction action,
    String successMessage, {
    required bool refresh,
  }) async {
    setState(() => _loading = true);
    final ApiRet<dynamic> result = await action();
    if (!mounted) return;
    if (!result.success) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.msg)),
      );
      return;
    }
    if (refresh) await widget.onChanged();
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(successMessage)),
    );
  }
}
