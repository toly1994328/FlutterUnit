import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_unit/widget_system/blocs/widget_system_bloc.dart';
import 'package:flutter_unit/widget_system/repositories/repositories.dart';


class AppSearchBar extends StatefulWidget {

  const AppSearchBar({Key? key}):super(key: key);

  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController _controller=TextEditingController();//文本控制器

  @override
  Widget build(BuildContext context) => Container(
        height: 35,
        child:
        TextField(
          autofocus: false, //自动聚焦，闪游标
          controller: _controller,
          maxLines: 1,
          decoration: InputDecoration(//输入框装饰
              filled: true,//填满
              fillColor: Colors.white,//白色
              prefixIcon:  Icon(Icons.search),//前标
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: "搜点啥...",
              hintStyle: TextStyle(fontSize: 14)
          ),
          onChanged: (str) => BlocProvider.of<SearchBloc>(context)
              .add(SearchWidgetEvent(args:SearchArgs(name: str,stars: [1,2,3,4,5]))),
          onSubmitted: (str) {//提交后
            FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
          },
        ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
