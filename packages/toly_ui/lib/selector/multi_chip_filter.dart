import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-07
/// contact me by email 1981462002@qq.com
/// 说明: 

typedef BoolWidgetBuilder = Widget Function(BuildContext context, bool selected);

class MultiChipFilter<T> extends StatefulWidget {
  final List<T> data;
  final BoolWidgetBuilder labelBuilder;
  final IndexedWidgetBuilder? avatarBuilder;
  final Function(List<int>) onChange;

  const MultiChipFilter({Key? key, required this.data,required this.labelBuilder,this.avatarBuilder,required this.onChange}) : super(key: key);

  @override
  _MultiChipFilterState createState() => _MultiChipFilterState();
}

class _MultiChipFilterState<T> extends State<MultiChipFilter<T>> {
  final List<int> _selected = <int>[];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.data.map((e) =>
          _buildChild(context,widget.data.indexOf(e))).toList(),
    );
  }

  Widget _buildChild(BuildContext context,int index) {
    bool selected = _selected.contains(index);
    return FilterChip(
      selectedColor: Colors.orange.withAlpha(55),
      labelPadding: const EdgeInsets.only(left: 5,right: 5),
      selectedShadowColor: Colors.blue,
      shadowColor: Colors.orangeAccent,
      pressElevation: 5,
      elevation: 3,
      avatar: widget.avatarBuilder==null?null:widget.avatarBuilder!(context,index),
      label: widget.labelBuilder(context,selected),
      selected: selected,
      onSelected: (bool value) {
        setState(() {
          if (value) {
            _selected.add(index);
          } else {
            _selected.removeWhere((i) => i == index);
          }
          widget.onChange(_selected);
        });
      },
    );
  }
}
