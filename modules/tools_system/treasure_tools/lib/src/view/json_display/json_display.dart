import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'json_tree_view.dart';

/// JSON 解析工具页面。
class JsonAnalysisTool extends StatefulWidget {
  const JsonAnalysisTool({super.key});

  @override
  State<JsonAnalysisTool> createState() => _JsonAnalysisToolState();
}

class _JsonAnalysisToolState extends State<JsonAnalysisTool> {
  /// JSON 输入控制器。
  final TextEditingController _controller = TextEditingController(
    text: const JsonEncoder.withIndent('  ').convert(_sampleJson),
  );

  /// 当前成功解析的数据。
  Object? _parsedData;

  /// 当前是否存在成功解析的输入，包括合法的 null。
  bool _hasParsedData = false;

  /// 当前解析错误。
  String? _errorMessage;

  /// 输入字符数。
  int _characterCount = 0;

  @override
  void initState() {
    super.initState();
    _parseJson();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 解析输入内容并同步预览状态。
  void _parseJson() {
    final String source = _controller.text.trim();
    Object? parsedData;
    String? errorMessage;
    bool hasParsedData = false;

    if (source.isNotEmpty) {
      try {
        parsedData = jsonDecode(source) as Object?;
        hasParsedData = true;
      } catch (error) {
        errorMessage = _readableError(error);
      }
    }

    setState(() {
      _characterCount = _controller.text.length;
      _parsedData = parsedData;
      _hasParsedData = hasParsedData;
      _errorMessage = errorMessage;
    });
  }

  String _readableError(Object error) {
    if (error is FormatException) {
      final int? offset = error.offset;
      return offset == null
          ? 'JSON 格式有误：${error.message}'
          : '第 $offset 个字符附近格式有误：${error.message}';
    }
    return 'JSON 解析失败：$error';
  }

  /// 将输入内容格式化为易读的缩进形式。
  void _formatJson() {
    if (!_hasParsedData || _errorMessage != null) {
      _showMessage('请先输入有效的 JSON');
      return;
    }
    _replaceText(const JsonEncoder.withIndent('  ').convert(_parsedData));
  }

  /// 将输入内容压缩为单行 JSON。
  void _compactJson() {
    if (!_hasParsedData || _errorMessage != null) {
      _showMessage('请先输入有效的 JSON');
      return;
    }
    _replaceText(jsonEncode(_parsedData));
  }

  void _replaceText(String text) {
    _controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    _parseJson();
  }

  Future<void> _copyJson() async {
    if (_controller.text.isEmpty) {
      _showMessage('当前没有可复制的内容');
      return;
    }
    await Clipboard.setData(ClipboardData(text: _controller.text));
    if (mounted) {
      _showMessage('JSON 已复制');
    }
  }

  void _clearJson() {
    _controller.clear();
    _parseJson();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color backgroundColor = theme.brightness == Brightness.dark
        ? const Color(0xff1b1d21)
        : const Color(0xfff7f8fa);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: _buildWorkspace(context),
      ),
    );
  }

  Widget _buildWorkspace(BuildContext context) {
    final Widget editor = _EditorPanel(
      controller: _controller,
      characterCount: _characterCount,
      onChanged: _parseJson,
      onFormat: _formatJson,
      onCompact: _compactJson,
      onCopy: _copyJson,
      onClear: _clearJson,
    );
    final Widget preview = _PreviewPanel(
      data: _parsedData,
      hasData: _hasParsedData,
      errorMessage: _errorMessage,
    );
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 720) {
          return Column(
            children: <Widget>[
              Expanded(child: editor),
              Divider(
                height: 1,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              Expanded(child: preview),
            ],
          );
        }
        return Row(
          children: <Widget>[
            Expanded(child: editor),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            Expanded(child: preview),
          ],
        );
      },
    );
  }
}

class _EditorPanel extends StatelessWidget {
  const _EditorPanel({
    required this.controller,
    required this.characterCount,
    required this.onChanged,
    required this.onFormat,
    required this.onCompact,
    required this.onCopy,
    required this.onClear,
  });

  /// 输入控制器。
  final TextEditingController controller;

  /// 当前字符数。
  final int characterCount;

  /// 输入变化回调。
  final VoidCallback onChanged;

  /// 格式化回调。
  final VoidCallback onFormat;

  /// 压缩回调。
  final VoidCallback onCompact;

  /// 复制回调。
  final VoidCallback onCopy;

  /// 清空回调。
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return _PanelShell(
      title: '原始数据',
      subtitle: '$characterCount 个字符',
      actions: <Widget>[
        _ToolButton(
            icon: Icons.format_align_left_rounded,
            tooltip: '格式化',
            onTap: onFormat),
        _ToolButton(
            icon: Icons.compress_rounded, tooltip: '压缩', onTap: onCompact),
        _ToolButton(icon: Icons.copy_outlined, tooltip: '复制', onTap: onCopy),
        _ToolButton(
            icon: Icons.delete_outline_rounded, tooltip: '清空', onTap: onClear),
      ],
      child: TextField(
        controller: controller,
        onChanged: (String value) => onChanged(),
        expands: true,
        maxLines: null,
        minLines: null,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.45,
        ),
        decoration: const InputDecoration(
          hintText: '在这里粘贴 JSON…',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}

class _PreviewPanel extends StatelessWidget {
  const _PreviewPanel({
    required this.data,
    required this.hasData,
    required this.errorMessage,
  });

  /// 成功解析的数据。
  final Object? data;

  /// 是否存在成功解析的数据。
  final bool hasData;

  /// 解析错误。
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return _PanelShell(
      title: '结构预览',
      subtitle: errorMessage == null ? '可折叠数据树' : '等待修复',
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (errorMessage != null) {
      return _EmptyState(
        icon: Icons.error_outline_rounded,
        title: '无法解析 JSON',
        message: errorMessage!,
        color: Theme.of(context).colorScheme.error,
      );
    }
    if (!hasData) {
      return const _EmptyState(
        icon: Icons.data_object_rounded,
        title: '等待 JSON 数据',
        message: '输入内容后，这里会展示可折叠的数据结构。',
      );
    }
    return JsonTreeView(data: data);
  }
}

class _PanelShell extends StatelessWidget {
  const _PanelShell({
    required this.title,
    required this.subtitle,
    required this.child,
    this.actions = const <Widget>[],
  });

  /// 面板标题。
  final String title;

  /// 面板辅助说明。
  final String subtitle;

  /// 面板内容。
  final Widget child;

  /// 面板工具按钮。
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;
    final Color contentColor =
        isDark ? const Color(0xff1e2024) : const Color(0xfffbfcfd);
    final Color toolbarColor =
        isDark ? const Color(0xff24272c) : const Color(0xfff2f4f7);
    return ColoredBox(
      color: contentColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 42,
            child: ColoredBox(
              color: toolbarColor,
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
                    const SizedBox(width: 8),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    ...actions,
                  ],
                ),
              ),
            ),
          ),
          Divider(height: 1, color: colors.outlineVariant),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _ToolButton extends StatelessWidget {
  const _ToolButton(
      {required this.icon, required this.tooltip, required this.onTap});

  /// 按钮图标。
  final IconData icon;

  /// 按钮提示。
  final String tooltip;

  /// 点击回调。
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onTap,
      visualDensity: VisualDensity.compact,
      icon: Icon(icon, size: 17),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.color,
  });

  /// 状态图标。
  final IconData icon;

  /// 状态标题。
  final String title;

  /// 状态说明。
  final String message;

  /// 状态强调色。
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color resolvedColor = color ?? Theme.of(context).colorScheme.primary;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 42, color: resolvedColor.withValues(alpha: 0.75)),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

const Map<String, Object> _sampleJson = <String, Object>{
  'name': 'FlutterUnit',
  'description': 'Flutter 组件学习与检索应用',
  'version': 3,
  'openSource': true,
  'features': <String>['组件检索', '属性探索', '代码生成'],
  'author': <String, String>{'name': '张风捷特烈', 'role': 'Developer'},
};
