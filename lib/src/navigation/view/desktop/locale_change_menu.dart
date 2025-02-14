import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';
import 'package:tolyui/tolyui.dart';
import 'package:app/app.dart';

class LocaleChangeMenu extends StatelessWidget {
  const LocaleChangeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> labels = Language.values.map((e) => e.label).toList();

    DropMenuCellStyle lightStyle = const DropMenuCellStyle(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        borderRadius: BorderRadius.all(Radius.circular(6)),
        foregroundColor: Color(0xff1f1f1f),
        backgroundColor: Colors.transparent,
        disableColor: Color(0xffbfbfbf),
        hoverBackgroundColor: Color(0xfff5f5f5),
        hoverForegroundColor: Color(0xff1f1f1f),
        textStyle: TextStyle(fontFamily: '微软雅黑', fontSize: 12,));
    Language language =
        context.select((AppConfigBloc bloc) => bloc.state.language);
    int index = Language.values.indexOf(language);
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Icon(Icons.translate,color: Colors.white,size: 14),
        ),
        IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: TolySelect(
              fontSize: 12,
              cellStyle: lightStyle,
              data: labels,
              selectIndex: index,
              iconSize: 16,
              height: 26,
              width: 100,
              minWidth: 100,
              maxHeight: 180,
              padding: const EdgeInsets.only(right: 6,left: 24),
              onSelected: (int index) async {
                Language type = Language.values[index];
                context.read<AppConfigBloc>().switchLanguage(type);
              },
            ),
          ),
        ),
      ],
    );
  }
}
