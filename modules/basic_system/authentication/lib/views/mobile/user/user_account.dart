import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:utils/utils.dart';

import '../../user_avatar.dart';
import 'avatar/avatar_crop_page.dart';
import 'user_edit_name_page.dart';
import 'user_edit_signature_page.dart';

/// 当前登录用户的账户资料页，布局与交互对齐 ViewX 移动端账号管理页。
class UserAccountPage extends StatelessWidget {
  /// 头像原图大小上限。
  static const int _maxAvatarBytes = 2 * 1024 * 1024;

  const UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor =
        isDark ? Colors.black : const Color(0xffF5F5F5);
    final Color textColor = isDark ? Colors.white : const Color(0xff333333);
    final Color appBarColor = isDark ? const Color(0xff121318) : Colors.white;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        surfaceTintColor: appBarColor,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, size: 18, color: textColor),
        ),
        title: Text(
          '账号管理',
          style: TextStyle(
            color: textColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: DefaultTextStyle(
        style: TextStyle(fontSize: 16, color: textColor),
        child: BlocBuilder<FxUserSessionCubit, FxUserSession>(
          builder: _buildSession,
        ),
      ),
    );
  }

  Widget _buildSession(BuildContext context, FxUserSession session) {
    if (session is! FxAuthed) {
      return const Center(child: Text('未登录'));
    }
    return _buildContent(context, session.user);
  }

  Widget _buildContent(BuildContext context, FxIdentity user) {
    final Color? tileColor = Theme.of(context).listTileTheme.tileColor;
    final String signature = user.read(FxIdentityFields.signature) ?? '';
    return ListView(
      children: <Widget>[
        const SizedBox(height: 8),
        _ProfileGroup(
          tileColor: tileColor,
          children: <Widget>[
            _ProfileRow(
              label: '头像',
              onTap: () => _pickAvatar(context),
              value: const Align(
                alignment: Alignment.centerRight,
                child: SizedBox.square(
                  dimension: 48,
                  child: SessionUserAvatar(size: 48, cornerRadius: 6),
                ),
              ),
              verticalPadding: 12,
            ),
            _ProfileRow(
              label: '用户名',
              onTap: () => _openNameEditor(context, user.displayName ?? ''),
              value: _ValueText(user.displayName ?? ''),
            ),
            _ProfileRow(
              label: '个性签名',
              onTap: () => _openSignatureEditor(context, signature),
              value: _ValueText(
                signature.isEmpty ? '未设置' : signature,
                placeholder: signature.isEmpty,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _ProfileGroup(
          tileColor: tileColor,
          children: <Widget>[
            _ProfileRow(
              label: 'FlutterUnit ID',
              value: _ValueText(user.id),
              trailing: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () => _copyId(context, user.id),
                icon: const Icon(
                  Icons.copy,
                  size: 18,
                  color: Color(0xffBDBDBD),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        InkWell(
          onTap: () => _confirmLogout(context),
          child: Container(
            height: 54,
            color: tileColor,
            alignment: Alignment.center,
            child: const Text(
              '退出登录',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  /// 选择头像、校验文件并进入与 ViewX 一致的拖拽缩放裁剪页。
  Future<void> _pickAvatar(BuildContext context) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );
      if (result == null || result.files.isEmpty) return;
      final PlatformFile file = result.files.single;
      if (file.size > _maxAvatarBytes) {
        if (context.mounted) Toast.warning(context, '图片大小不能超过 2MB');
        return;
      }
      final String extension = file.extension?.toLowerCase() ?? '';
      if (!<String>{'jpg', 'jpeg', 'png'}.contains(extension)) {
        if (context.mounted) Toast.warning(context, '仅支持 JPG、JPEG、PNG 图片');
        return;
      }
      final Uint8List? sourceBytes = file.bytes;
      if (sourceBytes == null || sourceBytes.isEmpty || !context.mounted) {
        return;
      }
      final Uint8List? croppedBytes = await AvatarCropPage.open(
        context,
        imageBytes: sourceBytes,
      );
      if (croppedBytes == null || croppedBytes.isEmpty || !context.mounted) {
        return;
      }
      await context.read<FxUserSessionCubit>().updateAvatar(croppedBytes);
      if (context.mounted) Toast.success(context, '头像修改成功');
    } catch (_) {
      if (context.mounted) Toast.error(context, '头像上传失败，请稍后重试');
    }
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

/// ViewX 风格的白底资料分组。
class _ProfileGroup extends StatelessWidget {
  /// 分组背景色。
  final Color? tileColor;

  /// 分组内的资料行。
  final List<Widget> children;

  const _ProfileGroup({required this.tileColor, required this.children});

  @override
  Widget build(BuildContext context) {
    final List<Widget> separated = <Widget>[];
    for (int index = 0; index < children.length; index++) {
      separated.add(children[index]);
      if (index < children.length - 1) {
        separated.add(
          const Divider(
            height: 0.5,
            thickness: 0.5,
            indent: 16,
            color: Color(0xffEEEEEE),
          ),
        );
      }
    }
    return Container(color: tileColor, child: Column(children: separated));
  }
}

/// ViewX 风格的账户资料行。
class _ProfileRow extends StatelessWidget {
  /// 左侧字段名称。
  final String label;

  /// 右侧字段内容。
  final Widget value;

  /// 点击行为；为空时不显示箭头。
  final VoidCallback? onTap;

  /// 自定义尾部组件。
  final Widget? trailing;

  /// 行的垂直内边距。
  final double verticalPadding;

  const _ProfileRow({
    required this.label,
    required this.value,
    this.onTap,
    this.trailing,
    this.verticalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    final Widget? end = trailing ??
        (onTap == null
            ? null
            : const Icon(
                Icons.chevron_right,
                size: 20,
                color: Color(0xffBDBDBD),
              ));
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: verticalPadding,
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 104,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(child: value),
            if (end != null) ...<Widget>[const SizedBox(width: 4), end],
          ],
        ),
      ),
    );
  }
}

/// 资料行右侧的统一文本样式。
class _ValueText extends StatelessWidget {
  /// 展示文本。
  final String text;

  /// 是否使用未设置占位色。
  final bool placeholder;

  const _ValueText(this.text, {this.placeholder = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.right,
      style: TextStyle(
        color: placeholder ? Colors.grey[400] : Colors.grey[600],
        fontSize: 16,
      ),
    );
  }
}
