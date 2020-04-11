import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/blocs/search/search_bloc.dart';
import 'package:flutter_unit/blocs/search/search_event.dart';
import 'package:flutter_unit/database/widget_dao.dart';

/// create by 张风捷特烈 on 2020-04-07
/// contact me by email 1981462002@qq.com
/// 说明: 

typedef BoolWidgetBuilder = Widget Function(BuildContext context, bool selected);

class MultiChipFilter<T> extends StatefulWidget {
  final List<T> data;
  final BoolWidgetBuilder labelBuilder;
  final IndexedWidgetBuilder avatarBuilder;
  final Function(List<int>) onChange;

  MultiChipFilter({@required this.data,@required this.labelBuilder,this.avatarBuilder,@required this.onChange});

  @override
  _MultiChipFilterState createState() => _MultiChipFilterState();
}

class _MultiChipFilterState<T> extends State<MultiChipFilter<T>> {
  List<int> _selected = <int>[];

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
      labelPadding: EdgeInsets.only(left: 5,right: 5),
      selectedShadowColor: Colors.blue,
      shadowColor: Colors.orangeAccent,
      pressElevation: 5,
      elevation: 3,
      avatar: widget.avatarBuilder==null?null:widget.avatarBuilder(context,index),
      label: widget.labelBuilder(context,selected),
      selected: selected,
      onSelected: (bool value) {
        setState(() {
          if (value) {
            _selected.add(index);
          } else {
            _selected.removeWhere((i) => i == index);
          }
          if(widget.onChange!=null) widget.onChange(_selected);
        });
      },
    );
  }
}

//class StartFilter extends StatefulWidget {
//  @override
//  _StartFilterState createState() => _StartFilterState();
//}
//
//class _StartFilterState extends State<StartFilter> {
//  List<int> data = [1,2,3,4,5];
//  List<int> _selected = <int>[];
//
//  @override
//  Widget build(BuildContext context) {
//   return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      children: data.map((e) =>
//          _buildChild(e)).toList(),
//    );
//  }
//
//  Widget _buildChild(int e) {
//   bool selected = _selected.contains(e);
//    return FilterChip(
//      selectedColor: Colors.orange.withAlpha(55),
//      labelPadding: EdgeInsets.only(left: 5,right: 5),
//      selectedShadowColor: Colors.blue,
//      shadowColor: Colors.orangeAccent,
//      pressElevation: 5,
//      elevation: 3,
//      avatar: CircleAvatar(child: Text((data.indexOf(e)+1).toString())),
//      label: Icon(Icons.star,color: selected?Colors.blue:Colors.grey,size: 18,),
//      selected: selected,
//      onSelected: (bool value) {
//        setState(() {
//          if (value) {
//            _selected.add(e);
//          } else {
//            _selected.removeWhere((name) => name == e);
//          }
//          var args = _selected.map((e)=>e).toList();
//          if(args.length<5){
//            args.addAll(List.generate(5-args.length, (e)=>-1));
//          }
//          BlocProvider.of<SearchBloc>(context)
//              .add(EventTextChanged(args:SearchArgs(name: '',stars: args)));
//        });
//      },
//    );
//  }
//}



