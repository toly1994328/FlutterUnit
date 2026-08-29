import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'aes_cipher.dart';

typedef AesCipherOperation = Future<String> Function(AesCipherRequest request);

/// AES 数据加解密工具。
class AesCipherTool extends StatefulWidget {
  const AesCipherTool({super.key});

  @override
  State<AesCipherTool> createState() => _AesCipherToolState();
}

class _AesCipherToolState extends State<AesCipherTool> {
  /// 无状态 AES 加解密服务。
  final AesCipherService _service = const AesCipherService();

  /// Base64 密钥输入控制器。
  final TextEditingController _keyController = TextEditingController();

  /// Base64 IV 或 Nonce 输入控制器。
  final TextEditingController _nonceController = TextEditingController();

  /// 明文或密文输入控制器。
  final TextEditingController _inputController = TextEditingController();

  /// 加解密结果控制器。
  final TextEditingController _outputController = TextEditingController();

  /// 当前 AES 工作模式。
  AesCipherMode _mode = AesCipherMode.gcm;

  /// 当前 AES 密钥规格。
  AesKeySize _keySize = AesKeySize.bits256;

  /// 最近一次处理错误。
  String? _errorMessage;

  /// 当前是否正在执行异步加解密。
  bool _processing = false;

  @override
  void initState() {
    super.initState();
    _inputController.text = 'FlutterUnit AES';
    _generateCredentials();
  }

  @override
  void dispose() {
    _keyController.dispose();
    _nonceController.dispose();
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  /// 生成当前模式需要的安全随机密钥和 IV。
  Future<void> _generateCredentials() async {
    final String key = await _service.generateKey(_mode, _keySize);
    final String nonce = _service.generateNonce(_mode, _keySize);
    if (!mounted) {
      return;
    }
    setState(() {
      _keyController.text = key;
      _nonceController.text = nonce;
      _errorMessage = null;
    });
  }

  /// 生成当前模式要求的安全随机 IV。
  void _generateNonce() {
    setState(() {
      _nonceController.text = _service.generateNonce(_mode, _keySize);
      _errorMessage = null;
    });
  }

  /// 使用当前参数加密输入区的 UTF-8 明文。
  Future<void> _encrypt() async {
    await _runCipher(_service.encrypt);
  }

  /// 使用当前参数解密输入区的 Base64 密文。
  Future<void> _decrypt() async {
    await _runCipher(_service.decrypt);
  }

  /// 统一执行加解密任务并同步结果或错误状态。
  Future<void> _runCipher(AesCipherOperation operation) async {
    setState(() {
      _processing = true;
      _errorMessage = null;
    });
    try {
      final String result = await operation(_buildRequest());
      if (!mounted) {
        return;
      }
      setState(() => _outputController.text = result);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _outputController.clear();
        _errorMessage = '处理失败：$error';
      });
    } finally {
      if (mounted) {
        setState(() => _processing = false);
      }
    }
  }

  AesCipherRequest _buildRequest() {
    return AesCipherRequest(
      mode: _mode,
      keySize: _keySize,
      key: _keyController.text,
      nonce: _nonceController.text,
      input: _inputController.text,
    );
  }

  void _useResultAsInput() {
    setState(() {
      _inputController.text = _outputController.text;
      _outputController.clear();
      _errorMessage = null;
    });
  }

  Future<void> _copyResult() async {
    if (_outputController.text.isEmpty) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: _outputController.text));
  }

  @override
  Widget build(BuildContext context) {
    final Color background = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xff1e2024)
        : const Color(0xfffbfcfd);
    return ColoredBox(
      color: background,
      child: Column(
        children: <Widget>[
          _buildConfiguration(context),
          Divider(
              height: 1, color: Theme.of(context).colorScheme.outlineVariant),
          Expanded(child: _buildWorkspace(context)),
        ],
      ),
    );
  }

  /// 构建模式、密钥规格、密钥和 IV 配置区。
  Widget _buildConfiguration(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonFormField<AesCipherMode>(
                  initialValue: _mode,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: '模式'),
                  items: AesCipherMode.values
                      .map(_buildModeItem)
                      .toList(growable: false),
                  onChanged: _changeMode,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<AesKeySize>(
                  initialValue: _keySize,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: '密钥长度'),
                  items: AesKeySize.values
                      .map(_buildKeySizeItem)
                      .toList(growable: false),
                  onChanged: _changeKeySize,
                ),
              ),
              IconButton(
                tooltip: '重新生成密钥和 IV',
                onPressed: _generateCredentials,
                icon: const Icon(Icons.refresh_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _keyController,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            decoration: const InputDecoration(
              labelText: 'Key · Base64',
              prefixIcon: Icon(Icons.key_rounded, size: 19),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _nonceController,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            decoration: InputDecoration(
              labelText: 'IV / Nonce · Base64',
              prefixIcon: const Icon(Icons.fingerprint_rounded, size: 19),
              suffixIcon: IconButton(
                tooltip: '重新生成 IV',
                onPressed: _generateNonce,
                icon: const Icon(Icons.refresh_rounded, size: 19),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<AesCipherMode> _buildModeItem(AesCipherMode mode) {
    return DropdownMenuItem<AesCipherMode>(
      value: mode,
      child: Text(mode.label, overflow: TextOverflow.ellipsis),
    );
  }

  DropdownMenuItem<AesKeySize> _buildKeySizeItem(AesKeySize size) {
    return DropdownMenuItem<AesKeySize>(
      value: size,
      child: Text('${size.bits} bit'),
    );
  }

  void _changeMode(AesCipherMode? mode) {
    if (mode == null || mode == _mode) {
      return;
    }
    setState(() => _mode = mode);
    _generateNonce();
  }

  void _changeKeySize(AesKeySize? keySize) {
    if (keySize == null || keySize == _keySize) {
      return;
    }
    setState(() => _keySize = keySize);
    _generateCredentials();
  }

  /// 根据窗口宽度构建左右或上下加解密工作区。
  Widget _buildWorkspace(BuildContext context) {
    final Widget input = _AesTextPanel(
      title: '输入',
      controller: _inputController,
      hintText: '加密时输入明文；解密时输入 Base64 密文',
      actions: <Widget>[
        TextButton(
            onPressed: _processing ? null : _encrypt, child: const Text('加密')),
        TextButton(
            onPressed: _processing ? null : _decrypt, child: const Text('解密')),
      ],
    );
    final Widget output = _AesTextPanel(
      title: '结果',
      controller: _outputController,
      hintText: '处理结果',
      readOnly: true,
      errorMessage: _errorMessage,
      actions: <Widget>[
        IconButton(
          tooltip: '作为输入',
          onPressed: _useResultAsInput,
          icon: const Icon(Icons.input_rounded, size: 18),
        ),
        IconButton(
          tooltip: '复制结果',
          onPressed: _copyResult,
          icon: const Icon(Icons.copy_outlined, size: 18),
        ),
      ],
    );
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Color dividerColor = Theme.of(context).colorScheme.outlineVariant;
        if (constraints.maxWidth < 720) {
          return Column(
            children: <Widget>[
              Expanded(child: input),
              Divider(height: 1, color: dividerColor),
              Expanded(child: output),
            ],
          );
        }
        return Row(
          children: <Widget>[
            Expanded(child: input),
            VerticalDivider(width: 1, color: dividerColor),
            Expanded(child: output),
          ],
        );
      },
    );
  }
}

class _AesTextPanel extends StatelessWidget {
  /// 面板标题。
  final String title;

  /// 文本控制器。
  final TextEditingController controller;

  /// 空内容提示。
  final String hintText;

  /// 面板操作按钮。
  final List<Widget> actions;

  /// 是否禁止编辑。
  final bool readOnly;

  /// 待展示的错误信息。
  final String? errorMessage;

  const _AesTextPanel({
    required this.title,
    required this.controller,
    required this.hintText,
    required this.actions,
    this.readOnly = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 42,
          child: Padding(
            padding: const EdgeInsets.only(left: 14, right: 6),
            child: Row(
              children: <Widget>[
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const Spacer(),
                ...actions,
              ],
            ),
          ),
        ),
        if (errorMessage != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            color: Theme.of(context).colorScheme.errorContainer,
            child: Text(
              errorMessage!,
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onErrorContainer,
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
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
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
