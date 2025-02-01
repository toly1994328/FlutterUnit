import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:l10n/l10n.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_module/event/widget_event.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:tolyui/tolyui.dart';
import 'package:fx_trace/fx_trace.dart';

class GlobalFindDialog extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const GlobalFindDialog({Key? key, this.onChanged}) : super(key: key);

  @override
  State<GlobalFindDialog> createState() => _GlobalFindDialogState();
}

class _GlobalFindDialogState extends State<GlobalFindDialog> {
  late TextEditingController _controller = TextEditingController();

  // final PopoverController controller = PopoverController();

  @override
  void initState() {
    _focusNode.addListener(_onFocusChange);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_onFocusChange);
  }

  void _onFocusChange() {
    // if (_focusNode.hasFocus) {
    //   controller.open();
    // } else {
    //   controller.close();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
          width: 400,
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 32, child: _buildFieldView()),
                Expanded(child: _buildOptionsView()),
              ],
            ),
          ),
        ));
    ;
  }

  void onSelected(WidgetModel model) {
    final FocusScopeNode focusScope = FocusScope.of(context);
    if (focusScope.hasFocus) {
      focusScope.unfocus();
    }
    _controller.clear();
    Navigator.of(context).pop();
    FxEmitter().emit(SelectWidgetEvent(name: model.name));
  }

  Iterable<WidgetModel> options = [];

  void searchByArgs(String text) async {
    WidgetRepository repository = context.read<WidgetsBloc>().repository;
    options = await repository.searchWidgets(WidgetFilter(name: text));
    setState(() {});
  }

  Widget _buildOptionsView() {
    return Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ListView.builder(
            itemCount: options.length,
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (_, index) {
              WidgetModel model = options.elementAt(index);
              return InkWell(
                onTap: () => onSelected(model),
                child: Ink(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text.rich(
                              formSpan(model.name, _controller.text),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12))),
                      // Spacer(),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        model.nameCN,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  final FocusNode _focusNode = FocusNode();
  FocusNode get focusNode => _focusNode;

  Widget _buildFieldView() {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      autofocus: true,
      controller: _controller,
      onChanged: (value) {
        searchByArgs(value);
      },
      style: const TextStyle(fontSize: 12),
      maxLines: 1,
      focusNode: focusNode,
      decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(minWidth: 30),
          filled: true,
          hoverColor: Colors.transparent,
          contentPadding: const EdgeInsets.only(top: 0),
          fillColor: isDark ? null : const Color(0xffF1F2F3),
          prefixIcon: const Icon(
            Icons.search,
            size: 18,
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          hintText: '搜索',
          hintStyle: const TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }

  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.red,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  InlineSpan formSpan(String src, String pattern) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color? textColor = Theme.of(context).listTileTheme.textColor;

    List<TextSpan> span = [];
    RegExp regExp = RegExp(RegExp.escape(pattern), caseSensitive: false);
    src.splitMapJoin(regExp, onMatch: (Match match) {
      span.add(TextSpan(text: match.group(0), style: lightTextStyle));
      return '';
    }, onNonMatch: (str) {
      span.add(TextSpan(
          text: str,
          style: lightTextStyle.copyWith(
              color: isDark ? textColor : const Color(0xff2F3032),
              fontSize: 12)));
      return '';
    });
    return TextSpan(children: span);
  }
}
