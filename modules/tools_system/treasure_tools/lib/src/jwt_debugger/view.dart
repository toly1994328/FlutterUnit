import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models.dart';
import 'parser.dart';

/// 本地 JWT 解码与声明检查页面。
class JwtDebuggerTool extends StatefulWidget {
  /// 创建 JWT 调试器。
  const JwtDebuggerTool({super.key});

  @override
  State<JwtDebuggerTool> createState() => _JwtDebuggerToolState();
}

class _JwtDebuggerToolState extends State<JwtDebuggerTool> {
  /// 输入区在宽窗口下允许占用的最大宽度。
  static const double _maximumInputPanelWidth = 328;

  /// 输入区在工作区内所占的宽度比例。
  static const double _inputPanelWidthFactor = 0.42;

  /// 用于展示页面能力的标准 JWT 示例。
  static const String _sampleToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.'
      'eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.'
      'SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';

  /// JWT 输入控制器。
  final TextEditingController _tokenController = TextEditingController();

  /// 无状态 JWT 解析器。
  final JwtParser _parser = JwtParser();

  /// 最近一次成功解码的结果。
  JwtDebugResult? _result;

  /// 最近一次解码错误。
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _tokenController.text = _sampleToken;
    _result = _parser.parse(_sampleToken);
  }

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  /// 解码当前输入，并将成功或失败状态同步到页面。
  void _decode() {
    try {
      final JwtDebugResult result = _parser.parse(_tokenController.text);
      setState(() {
        _result = result;
        _errorMessage = null;
      });
    } on JwtDecodeException catch (error) {
      setState(() {
        _result = null;
        _errorMessage = error.message;
      });
    }
  }

  void _clear() {
    _tokenController.clear();
    setState(() {
      _result = null;
      _errorMessage = null;
    });
  }

  Future<void> _paste() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (!mounted || data?.text == null) {
      return;
    }
    _tokenController.text = data!.text!;
    _decode();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color background =
        isDark ? const Color(0xff1e2024) : const Color(0xfffbfcfd);
    return ColoredBox(
      color: background,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 720) {
            return _buildVerticalWorkspace(context);
          }
          return _buildHorizontalWorkspace(context, constraints.maxWidth);
        },
      ),
    );
  }

  /// 在移动端按上下结构组织输入区和结果区。
  Widget _buildVerticalWorkspace(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(flex: 5, child: _buildInputPanel(context)),
        Divider(
          height: 1,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        Expanded(flex: 6, child: _buildResultPanel(context)),
      ],
    );
  }

  /// 始终按桌面工作台的左右结构组织输入区和结果区。
  Widget _buildHorizontalWorkspace(BuildContext context, double width) {
    final double inputPanelWidth = (width * _inputPanelWidthFactor)
        .clamp(0, _maximumInputPanelWidth)
        .toDouble();
    return Row(
      children: <Widget>[
        SizedBox(width: inputPanelWidth, child: _buildInputPanel(context)),
        VerticalDivider(
          width: 1,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        Expanded(child: _buildResultPanel(context)),
      ],
    );
  }

  Widget _buildInputPanel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('输入 JWT',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              const Spacer(),
              _JwtActionButton(
                  icon: Icons.content_paste_rounded,
                  tooltip: '粘贴并解码',
                  onPressed: _paste),
              _JwtActionButton(
                  icon: Icons.delete_outline_rounded,
                  tooltip: '清空',
                  onPressed: _clear),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(3),
              ),
              child: TextField(
                controller: _tokenController,
                expands: true,
                minLines: null,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                decoration: const InputDecoration(
                  hintText: '粘贴三段式 JWT…',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 34,
            child: FilledButton.icon(
              onPressed: _decode,
              icon: const Icon(Icons.play_arrow_rounded, size: 17),
              label: const Text('解码 JWT',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultPanel(BuildContext context) {
    final JwtDebugResult? result = _result;
    if (_errorMessage != null) {
      return _JwtMessage(
        icon: Icons.error_outline_rounded,
        title: '无法解码 JWT',
        message: _errorMessage!,
        color: Theme.of(context).colorScheme.error,
      );
    }
    if (result == null) {
      return const _JwtMessage(
        icon: Icons.key_rounded,
        title: '等待 JWT',
        message: '输入 Token 后，这里会展示 Header、Payload 和时间声明。',
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            children: [
              _JsonSection(title: '头部信息（Header）', data: result.header),
              const SizedBox(height: 20),
              _JsonSection(title: '载荷信息（Payload）', data: result.payload),
              const SizedBox(height: 20),
              _SignatureSection(signature: result.signature),
              const SizedBox(height: 18),
              _SignatureHint(result: result),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignatureHint extends StatelessWidget {
  /// JWT 解码结果。
  final JwtDebugResult result;

  /// 创建签名验证提示。
  const _SignatureHint({required this.result});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.08),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, size: 18, color: primaryColor),
          const SizedBox(width: 9),
          const Expanded(
            child: Text(
              '如需验证签名，请提供密钥或公钥',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
          ),
          Icon(Icons.chevron_right_rounded, size: 18, color: primaryColor),
        ],
      ),
    );
  }
}

class _JsonSection extends StatelessWidget {
  /// 区块标题。
  final String title;

  /// 待显示的 JSON 对象。
  final Map<String, Object?> data;

  /// 创建 JSON 展示区块。
  const _JsonSection({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final String content = const JsonEncoder.withIndent('  ').convert(data);
    return _ResultSection(
      title: title,
      trailing: IconButton(
        tooltip: '复制 $title',
        onPressed: () => Clipboard.setData(ClipboardData(text: content)),
        icon: const Icon(Icons.copy_outlined, size: 17),
      ),
      child: SelectableText(
        content,
        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
    );
  }
}

class _SignatureSection extends StatelessWidget {
  /// JWT 原始签名段。
  final String signature;

  /// 创建签名展示区块。
  const _SignatureSection({required this.signature});

  @override
  Widget build(BuildContext context) {
    final String content = signature.isEmpty ? '空签名' : signature;
    return _ResultSection(
      title: 'Signature · 未验证',
      child: SelectableText(
        content,
        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
    );
  }
}

class _ResultSection extends StatelessWidget {
  /// 区块标题。
  final String title;

  /// 区块正文。
  final Widget child;

  /// 标题栏尾部操作。
  final Widget? trailing;

  /// 创建结果区块。
  const _ResultSection({
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 32,
          child: Row(
            children: <Widget>[
              Text(
                title,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
        ),
        Divider(
          height: 1,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: child,
        ),
        Divider(
          height: 1,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ],
    );
  }
}

class _JwtActionButton extends StatelessWidget {
  /// 按钮图标。
  final IconData icon;

  /// 按钮提示。
  final String tooltip;

  /// 点击回调。
  final VoidCallback onPressed;

  /// 创建面板操作按钮。
  const _JwtActionButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 28,
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints.tightFor(width: 28, height: 28),
        visualDensity: VisualDensity.compact,
        icon: Icon(icon, size: 17),
      ),
    );
  }
}

class _JwtMessage extends StatelessWidget {
  /// 状态图标。
  final IconData icon;

  /// 状态标题。
  final String title;

  /// 状态说明。
  final String message;

  /// 可选强调色。
  final Color? color;

  /// 创建空白或错误状态。
  const _JwtMessage({
    required this.icon,
    required this.title,
    required this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedColor = color ?? Theme.of(context).colorScheme.primary;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 42, color: resolvedColor),
          const SizedBox(height: 12),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
