import 'dart:convert';

import 'package:flutter/material.dart';

/// 颜色定义
class FieldColor {
  static const keyColor = Colors.grey;
  static const intColor = Colors.deepOrange;
  static const stringColor = Colors.green;
  static const nullColor = Colors.blueGrey;
  static const arrayColor = Colors.blue;
  static const objectColor = Colors.purple;
}

/// 基础类型抽象类
abstract class BaseValue<T> {
  final String? key;
  final T value;
  bool isExpanded;

  BaseValue(this.value, {this.key, this.isExpanded = true});

  Widget buildValue();
}

/// 整数值
class IntValue extends BaseValue<int> {
  IntValue(super.value, {super.key});

  @override
  Widget buildValue() {
    return Text(value.toString()+",",
        style: const TextStyle(color: FieldColor.intColor));
  }
}

/// 字符串值
class StringValue extends BaseValue<String> {
  StringValue(super.value, {super.key});

  @override
  Widget buildValue() {
    return Text('"$value",',
        style: const TextStyle(color: FieldColor.stringColor));
  }
}

/// Null 值
class NullValue extends BaseValue<Null> {
  NullValue({super.key}) : super(null);

  @override
  Widget buildValue() {
    return const Text('null', style: TextStyle(color: FieldColor.nullColor));
  }
}

/// 数组值
class ArrayValue extends BaseValue<List<dynamic>> {
  ArrayValue(super.value, {super.key});

  @override
  Widget buildValue() {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              children: [
                Icon(isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                    color: FieldColor.arrayColor),
                 Text('(Array)${isExpanded?'【':'【...'}',
                    style: TextStyle(color: FieldColor.arrayColor)),

                if (!isExpanded)
                  const Text('】',
                      style: TextStyle(color: FieldColor.arrayColor)),
              ],
            ),
          ),
          if (isExpanded) ...[
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: value.map((e) => parseJson(e).buildValue()).toList(),
              ),
            ),
            const Text('】', style: TextStyle(color: FieldColor.arrayColor)),
          ]
        ],
      );
    });
  }
}

/// 对象值
class ObjectValue extends BaseValue<Map<String, dynamic>> {
  ObjectValue(super.value, {super.key});

  @override
  Widget buildValue() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded; // 触发 UI 重新渲染
                });
              },
              child: Row(
                children: [
                  Icon(isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                      color: FieldColor.objectColor),
                   Text('(Object)${isExpanded?'{':'{...'}',
                      style: TextStyle(color: FieldColor.objectColor)),
                  if (!isExpanded)
                    const Text('}',
                        style: TextStyle(color: FieldColor.objectColor)),
                ],
              ),
            ),
            if (isExpanded) ...[
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: value.entries
                      .map((e) =>
                          KeyBlock(keyText: e.key, value: parseJson(e.value)))
                      .toList(),
                ),
              ),
              const Text('}', style: TextStyle(color: FieldColor.objectColor)),
            ]
          ],
        );
      },
    );
  }
}

/// 键值对组件
class KeyBlock extends StatelessWidget {
  final String keyText;
  final BaseValue value;

  const KeyBlock({super.key, required this.keyText, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$keyText: ',
            style: const TextStyle(
                color: FieldColor.keyColor, fontWeight: FontWeight.bold)),
        Expanded(child: value.buildValue()),
      ],
    );
  }
}

/// 解析 JSON 数据
BaseValue parseJson(dynamic json, {String? key}) {
  if (json == null) return NullValue(key: key);
  if (json is int) return IntValue(json, key: key);
  if (json is String) return StringValue(json, key: key);
  if (json is List) return ArrayValue(json, key: key);
  if (json is Map<String, dynamic>) return ObjectValue(json, key: key);
  return StringValue(json.toString(), key: key);
}

/// JSON 解析工具 UI
class JsonAnalysisTool extends StatefulWidget {
  const JsonAnalysisTool({super.key});

  @override
  State<JsonAnalysisTool> createState() => _JsonAnalysisToolState();
}

class _JsonAnalysisToolState extends State<JsonAnalysisTool> {
  final TextEditingController _controller = TextEditingController(
    text: """
{
  "id": 1,
  "name": "Container",
  "localName": "容器组件",
  "info": "用于容纳单个子组件的容器组件。集成了若干个单子组件的功能，如内外边距、形变、装饰、约束等...",
  "lever": 5,
  "family": 0,
  "linkIds": [
    74,
    85,
    80,
    78,
    70,
    123
  ],
  "nodes": [
    {
      "file": "node1_base.dart",
      "name": "可用于显示一个指定宽高的区域",
      "desc": [
        "【width】 : 宽   【int】",
        "【height】: 高   【int】",
        "【color】: 颜色    【Color】"
      ]
    },
    {
      "file": "node2_child.dart",
      "name": "可以在区域中放入一个子组件",
      "desc": [
        "【padding】 : 内边距   【EdgeInsetsGeometry】",
        "【margin】: 外边距   【EdgeInsetsGeometry】",
        "【child】: 子组件    【Widget】"
      ]
    },
    {
      "file": "node3_alignment.dart",
      "name": "可对子组件进行对齐定位",
      "desc": [
        "【alignment】 : 对齐定位   【AlignmentGeometry】"
      ]
    },
    {
      "file": "node4_decoration.dart",
      "name": "可对子组件进行装饰",
      "desc": [
        "【decoration】 : 装饰   【Decoration】",
        "可装饰: 边线、圆弧、颜色、渐变色、阴影、图片等内容"
      ]
    },
    {
      "file": "node5_transform.dart",
      "name": "Container还具有变换性",
      "desc": [
        "【transform】 : 变换矩阵   【Matrix4】",
        "基于Matrix4的矩阵变换，变换详情见线性代数"
      ]
    },
    {
      "file": "node6_constraints.dart",
      "name": "Container的约束性",
      "desc": [
        "【constraints】 : 约束   【BoxConstraints】",
        "会约束该区域的尺寸，不会小于指定的最小宽高，也不会大于指定的最大宽高。"
      ]
    }
  ]
}""",
  );
  BaseValue? _parsedData;
  String? _error;

  final ScrollController _hCtrl = ScrollController();
  final ScrollController _vCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _parseJson();
  }

  void _parseJson() {
    setState(() {
      _error = null;
      try {
        final parsed = jsonDecode(_controller.text);
        _parsedData = parseJson(parsed);
      } catch (e) {
        _error = 'JSON 解析失败: $e';
        _parsedData = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(fontSize: 14,fontFamily: '楷体'),
                controller: _controller,
                onChanged: _onChanged,
                expands: true,
                maxLines: null,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: '输入 JSON',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4)
                ),
                margin: EdgeInsets.all(8),
                child: Scrollbar( //-> ::tag1::
    thumbVisibility: true,
    //-> ::tag6::
    notificationPredicate: (ScrollNotification notification) => notification.depth == 1,
    key: const Key('debuggerCodeViewVerticalScrollbarKey'),
    controller: _vCtrl,
    child: LayoutBuilder(
      builder: (context,cts) {
        final double boxHeight = 800;
        return Scrollbar( //-> ::tag2::
        key: const Key('debuggerCodeViewHorizontalScrollbarKey'),
        thumbVisibility: true,
        controller: _hCtrl,
        child: SingleChildScrollView(
          controller: _hCtrl, //-> ::tag3::
          child:  SingleChildScrollView(
            controller: _vCtrl,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                            child: SizedBox(
                              width: boxHeight,
                              child: _error != null
                                  ? Text(_error!, style: const TextStyle(color: Colors.red))
                                  : _parsedData?.buildValue() ?? const Text('请输入 JSON'),
                            ),
                          ),
        ),
        );
      }
    ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onChanged(String value) {
    _parseJson();
  }
}
