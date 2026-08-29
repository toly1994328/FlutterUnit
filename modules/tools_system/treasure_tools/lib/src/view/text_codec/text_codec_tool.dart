import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef TextCodec = String Function(String source);

/// Base64 编解码工具。
class Base64CodecTool extends StatelessWidget {
  const Base64CodecTool({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TextCodecWorkbench(
      sourceHint: '输入需要处理的文本',
      resultHint: 'Base64 结果',
      encode: _encodeBase64,
      decode: _decodeBase64,
    );
  }

  static String _encodeBase64(String source) {
    return base64Encode(utf8.encode(source));
  }

  static String _decodeBase64(String source) {
    return utf8.decode(base64Decode(source.trim()));
  }
}

/// URL 编解码工具。
class UrlCodecTool extends StatelessWidget {
  const UrlCodecTool({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TextCodecWorkbench(
      sourceHint: '输入 URL 或普通文本',
      resultHint: '百分号编解码结果',
      encode: Uri.encodeComponent,
      decode: Uri.decodeComponent,
    );
  }
}

class _TextCodecWorkbench extends StatefulWidget {
  const _TextCodecWorkbench({
    required this.sourceHint,
    required this.resultHint,
    required this.encode,
    required this.decode,
  });

  /// 输入区提示文字。
  final String sourceHint;

  /// 输出区提示文字。
  final String resultHint;

  /// 编码函数。
  final TextCodec encode;

  /// 解码函数。
  final TextCodec decode;

  @override
  State<_TextCodecWorkbench> createState() => _TextCodecWorkbenchState();
}

class _TextCodecWorkbenchState extends State<_TextCodecWorkbench> {
  /// 原文控制器。
  final TextEditingController _sourceController = TextEditingController();

  /// 结果控制器。
  final TextEditingController _resultController = TextEditingController();

  /// 最近一次处理错误。
  String? _errorMessage;

  @override
  void dispose() {
    _sourceController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  /// 执行编码并更新右侧结果。
  void _encode() {
    _transform(widget.encode);
  }

  /// 执行解码并更新右侧结果。
  void _decode() {
    _transform(widget.decode);
  }

  void _transform(TextCodec codec) {
    try {
      final String result = codec(_sourceController.text);
      setState(() {
        _resultController.text = result;
        _errorMessage = null;
      });
    } catch (error) {
      setState(() {
        _resultController.clear();
        _errorMessage = '无法处理当前内容：$error';
      });
    }
  }

  void _swap() {
    final String source = _sourceController.text;
    _sourceController.text = _resultController.text;
    _resultController.text = source;
    setState(() => _errorMessage = null);
  }

  void _clear() {
    _sourceController.clear();
    _resultController.clear();
    setState(() => _errorMessage = null);
  }

  Future<void> _copyResult() async {
    if (_resultController.text.isEmpty) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: _resultController.text));
    if (mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('结果已复制')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color backgroundColor =
        isDark ? const Color(0xff1e2024) : const Color(0xfffbfcfd);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Widget sourcePanel = _buildSourcePanel();
          final Widget resultPanel = _buildResultPanel();
          if (constraints.maxWidth < 720) {
            return Column(
              children: <Widget>[
                Expanded(child: sourcePanel),
                Divider(height: 1, color: theme.colorScheme.outlineVariant),
                Expanded(child: resultPanel),
              ],
            );
          }
          return Row(
            children: <Widget>[
              Expanded(child: sourcePanel),
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: theme.colorScheme.outlineVariant,
              ),
              Expanded(child: resultPanel),
            ],
          );
        },
      ),
    );
  }

  /// 构建原文输入与转换操作面板。
  Widget _buildSourcePanel() {
    return _CodecPanel(
      title: '原文',
      hintText: widget.sourceHint,
      controller: _sourceController,
      actions: <Widget>[
        _ActionButton(
          icon: Icons.arrow_forward_rounded,
          tooltip: '编码',
          onPressed: _encode,
        ),
        _ActionButton(
          icon: Icons.subdirectory_arrow_left_rounded,
          tooltip: '解码',
          onPressed: _decode,
        ),
        _ActionButton(
          icon: Icons.swap_horiz_rounded,
          tooltip: '交换',
          onPressed: _swap,
        ),
        _ActionButton(
          icon: Icons.delete_outline_rounded,
          tooltip: '清空',
          onPressed: _clear,
        ),
      ],
    );
  }

  /// 构建只读结果与复制操作面板。
  Widget _buildResultPanel() {
    return _CodecPanel(
      title: '结果',
      hintText: widget.resultHint,
      controller: _resultController,
      readOnly: true,
      errorMessage: _errorMessage,
      actions: <Widget>[
        _ActionButton(
          icon: Icons.copy_outlined,
          tooltip: '复制结果',
          onPressed: _copyResult,
        ),
      ],
    );
  }
}

class _CodecPanel extends StatelessWidget {
  const _CodecPanel({
    required this.title,
    required this.hintText,
    required this.controller,
    this.actions = const <Widget>[],
    this.readOnly = false,
    this.errorMessage,
  });

  /// 面板标题。
  final String title;

  /// 输入提示。
  final String hintText;

  /// 文本控制器。
  final TextEditingController controller;

  /// 工具按钮。
  final List<Widget> actions;

  /// 是否只读。
  final bool readOnly;

  /// 处理错误。
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color toolbarColor =
        isDark ? const Color(0xff24272c) : const Color(0xfff2f4f7);

    return Column(
      children: <Widget>[
        ColoredBox(
          color: toolbarColor,
          child: SizedBox(
            height: 42,
            child: Padding(
              padding: const EdgeInsets.only(left: 14, right: 6),
              child: Row(
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  ...actions,
                ],
              ),
            ),
          ),
        ),
        Divider(height: 1, color: theme.colorScheme.outlineVariant),
        if (errorMessage != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            color: theme.colorScheme.errorContainer,
            child: Text(
              errorMessage!,
              style: TextStyle(
                fontSize: 11,
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
        Expanded(
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            expands: true,
            minLines: null,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.45,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  /// 按钮图标。
  final IconData icon;

  /// 按钮提示。
  final String tooltip;

  /// 点击回调。
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
      icon: Icon(icon, size: 17),
    );
  }
}
