import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';

import '../../../data/exp.dart';

class AppSearchBar extends StatefulWidget {

  const AppSearchBar({Key? key}):super(key: key);

  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController _controller = TextEditingController(); //文本控制器

  @override
  Widget build(BuildContext context) {
    bool isDesk = Platform.isMacOS||Platform.isWindows||Platform.isLinux;
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        SizedBox(
            height: 35,
            child: TextField(
              autofocus: true,
              controller: _controller,
              maxLines: 1,
              decoration:  InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(top: isDesk?6:1),//调整文字边距
                  prefixIcon: Icon(Icons.search),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  hintText: "搜点啥...",
                  hintStyle: TextStyle(fontSize: 14)),
              onChanged: _doSearch,
              onSubmitted: (str) {
                //提交后,收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
            )),
        _buildClearIcon()
      ],
    );
  }

  void _doSearch(String str) {
    WidgetsBloc widgetsBloc = BlocProvider.of<WidgetsBloc>(context);
    final WidgetFilter filter = widgetsBloc.state.filter.copyWith(
      name: str,
    );
    widgetsBloc.add(
      EventSearchWidget(filter: filter),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildClearIcon() {
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: _controller,
        builder: (_, TextEditingValue value, __) => value.text.isNotEmpty
            ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _controller.clear();
                  _doSearch('');
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
                  child: Icon(
                    CupertinoIcons.clear_circled,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              )
            : const SizedBox.shrink());
  }
}
