import 'dart:async';

import 'package:app_config/app_config.dart';
import 'package:db_storage/db_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_repository/widget_repository.dart';

class DeskSearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const DeskSearchBar({Key? key, this.onChanged}) : super(key: key);

  @override
  State<DeskSearchBar> createState() => _DeskSearchBarState();
}

class _DeskSearchBarState extends State<DeskSearchBar> {
  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<WidgetModel>(
      optionsBuilder: buildOptions,
      onSelected: onSelected,
      optionsViewBuilder: _buildOptionsView,
      fieldViewBuilder: _buildFieldView,
    );

  }

  void onSelected(WidgetModel model) {
  }

  Future<Iterable<WidgetModel>> buildOptions(TextEditingValue textEditingValue) async {
    if (textEditingValue.text == '') {
      return  const Iterable<WidgetModel>.empty();
    }
    return searchByArgs(textEditingValue.text);

  }

  Future<Iterable<WidgetModel>> searchByArgs(String text) {
    WidgetRepository repository = context.read<WidgetsBloc>().repository;
    return repository.searchWidgets(WidgetFilter(
      name: text
    ));

  }

  Widget _buildOptionsView(BuildContext context, AutocompleteOnSelected<WidgetModel> onSelected, Iterable<WidgetModel> options) {
    return  Align(
      alignment: Alignment.topLeft,
      child: Material(
        color: Colors.white,
            elevation: 6,
            borderRadius: BorderRadius.circular(8),
            shadowColor: Colors.black,
            child:  ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 350,maxWidth: 250),
              child:ListView.builder(
                itemCount:options.length ,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (_,index) {
              WidgetModel model = options.elementAt(index);
              return InkWell(
                onTap: ()=>_toDetaile(model),
                child: Ink(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                child: Row(children: [
                  Expanded(child: Text.rich(formSpan(model.name,_controller.text),maxLines:1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12))),
                  // Spacer(),
                  const SizedBox(width: 10,),
                  Text(model.nameCN,style: TextStyle(fontSize: 12),),
                ],),
            ),
              );
            }),
        ),
      ),
    );
  }

  Widget _buildFieldView(BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
    _controller = textEditingController;
    return TextField(
      controller: textEditingController,
      onChanged: widget.onChanged,
      style: const TextStyle(fontSize: 12),
      maxLines: 1,
      focusNode: focusNode,
      decoration:  InputDecoration(
          prefixIconConstraints: BoxConstraints(
            minWidth: 30,
          ),
          filled: true,
          hoverColor: Colors.transparent,
          contentPadding: EdgeInsets.only(top: 0),
          fillColor: Color(0xffF1F2F3),
          prefixIcon: Icon(
            Icons.search,
            size: 18,
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(

            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),

          enabledBorder : OutlineInputBorder(

            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          hintText: "输入组件名称",
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
    );

  }

  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.red,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  InlineSpan formSpan(String src, String pattern) {
    List<TextSpan> span = [];
    RegExp regExp = RegExp(pattern, caseSensitive: false);
    src.splitMapJoin(regExp, onMatch: (Match match) {
      span.add(TextSpan(text: match.group(0), style: lightTextStyle));
      return '';
    }, onNonMatch: (str) {
      span.add(TextSpan(
          text: str,
          style: lightTextStyle.copyWith(color: const Color(0xff2F3032),fontSize: 12)));
      return '';
    });
    return TextSpan(children: span);
  }

  void _toDetaile(WidgetModel model) {
    final FocusScopeNode focusScope = FocusScope.of(context);
    if (focusScope.hasFocus) {
      focusScope.unfocus();
    }
    _controller.clear();

    Navigator.pushNamed(
      context,
      UnitRouter.widget_detail,
      arguments: model,
    );
  }
}
