import 'package:flutter/material.dart';

/// 可折叠的 JSON 数据树。
class JsonTreeView extends StatefulWidget {
  const JsonTreeView({super.key, required this.data});

  /// JSON 根节点数据。
  final Object? data;

  @override
  State<JsonTreeView> createState() => _JsonTreeViewState();
}

class _JsonTreeViewState extends State<JsonTreeView> {
  /// 垂直滚动控制器。
  final ScrollController _verticalController = ScrollController();

  /// 水平滚动控制器。
  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double contentWidth =
            constraints.maxWidth > 24 ? constraints.maxWidth - 24 : 0;
        return Scrollbar(
          controller: _verticalController,
          child: SingleChildScrollView(
            controller: _verticalController,
            primary: false,
            padding: const EdgeInsets.all(12),
            child: Scrollbar(
              controller: _horizontalController,
              child: SingleChildScrollView(
                controller: _horizontalController,
                primary: false,
                scrollDirection: Axis.horizontal,
                child: _JsonNode(
                  value: widget.data,
                  depth: 0,
                  isLast: true,
                  minimumWidth: contentWidth,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _JsonNode extends StatefulWidget {
  const _JsonNode({
    required this.value,
    required this.depth,
    required this.isLast,
    this.name,
    this.minimumWidth,
  });

  /// 节点名称。
  final String? name;

  /// 节点值。
  final Object? value;

  /// 节点深度。
  final int depth;

  /// 是否为父节点的最后一个子节点。
  final bool isLast;

  /// 根节点需要占据的最小可视宽度。
  final double? minimumWidth;

  @override
  State<_JsonNode> createState() => _JsonNodeState();
}

class _JsonNodeState extends State<_JsonNode> {
  /// 容器节点是否展开。
  bool _isExpanded = true;

  bool get _isContainer => widget.value is Map || widget.value is List;

  @override
  Widget build(BuildContext context) {
    if (!_isContainer) {
      return _buildLeaf(context);
    }
    return _buildContainer(context);
  }

  Widget _buildLeaf(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: widget.minimumWidth ?? 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 26),
            if (widget.name != null) _KeyLabel(name: widget.name!),
            _ValueLabel(value: widget.value),
            if (!widget.isLast) const _PunctuationLabel(','),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    final List<_JsonEntry> entries = _entriesOf(widget.value);
    final bool isObject = widget.value is Map;
    final String opening = isObject ? '{' : '[';
    final String closing = isObject ? '}' : ']';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: widget.minimumWidth ?? 0),
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: <Widget>[
                  Icon(
                    _isExpanded
                        ? Icons.expand_more_rounded
                        : Icons.chevron_right_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  if (widget.name != null) _KeyLabel(name: widget.name!),
                  _PunctuationLabel(opening),
                  const SizedBox(width: 8),
                  Text(
                    '${entries.length} 项',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (!_isExpanded) ...<Widget>[
                    const SizedBox(width: 8),
                    _PunctuationLabel(closing),
                    if (!widget.isLast) const _PunctuationLabel(','),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (_isExpanded) ...<Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildChildren(entries),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26, top: 3, bottom: 3),
            child: Row(
              children: <Widget>[
                _PunctuationLabel(closing),
                if (!widget.isLast) const _PunctuationLabel(','),
              ],
            ),
          ),
        ],
      ],
    );
  }

  List<Widget> _buildChildren(List<_JsonEntry> entries) {
    return List<Widget>.generate(entries.length, (int index) {
      final _JsonEntry entry = entries[index];
      return _JsonNode(
        name: entry.name,
        value: entry.value,
        depth: widget.depth + 1,
        isLast: index == entries.length - 1,
      );
    });
  }

  List<_JsonEntry> _entriesOf(Object? value) {
    if (value is Map) {
      return value.entries.map((_JsonMapEntry entry) {
        return _JsonEntry(name: entry.key.toString(), value: entry.value);
      }).toList();
    }
    if (value is List) {
      return List<_JsonEntry>.generate(
        value.length,
        (int index) => _JsonEntry(name: '[$index]', value: value[index]),
      );
    }
    return const <_JsonEntry>[];
  }
}

typedef _JsonMapEntry = MapEntry<dynamic, dynamic>;

class _JsonEntry {
  const _JsonEntry({required this.name, required this.value});

  /// 节点名称。
  final String name;

  /// 节点值。
  final Object? value;
}

class _KeyLabel extends StatelessWidget {
  const _KeyLabel({required this.name});

  /// JSON 键名。
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      '"$name": ',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _ValueLabel extends StatelessWidget {
  const _ValueLabel({required this.value});

  /// JSON 基础类型值。
  final Object? value;

  @override
  Widget build(BuildContext context) {
    final _ValueStyle style = _resolveStyle(context);
    return Text(
      style.text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.35,
        color: style.color,
      ),
    );
  }

  _ValueStyle _resolveStyle(BuildContext context) {
    if (value == null) {
      return const _ValueStyle(text: 'null', color: Color(0xff8b5cf6));
    }
    if (value is String) {
      return _ValueStyle(text: '"$value"', color: const Color(0xff16865c));
    }
    if (value is num) {
      return _ValueStyle(text: '$value', color: const Color(0xffd0642b));
    }
    if (value is bool) {
      return _ValueStyle(text: '$value', color: const Color(0xff326bd6));
    }
    return _ValueStyle(
        text: '$value', color: Theme.of(context).colorScheme.onSurface);
  }
}

class _ValueStyle {
  const _ValueStyle({required this.text, required this.color});

  /// 格式化文本。
  final String text;

  /// 类型颜色。
  final Color color;
}

class _PunctuationLabel extends StatelessWidget {
  const _PunctuationLabel(this.text);

  /// 标点文本。
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
