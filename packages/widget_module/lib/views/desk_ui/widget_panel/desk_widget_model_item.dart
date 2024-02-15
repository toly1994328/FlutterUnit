import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_module/views/components/collected_tag.dart';

import '../../../../data/exp.dart';
import 'package:wrapper/wrapper.dart';



class DeskWidgetItem extends StatelessWidget {
  final WidgetModel model;
  final VoidCallback onTap;
  final String? searchArg;

  const DeskWidgetItem(
      {Key? key, required this.model, required this.onTap, this.searchArg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    Color? tileColor = Theme.of(context).listTileTheme.tileColor;
    Color? textColor = Theme.of(context).listTileTheme.textColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    textColor = isDark?textColor: Color(0xff2F3032);

    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              blurRadius: 2,
            )
          ]
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        // margin:
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle(Theme.of(context).primaryColor,textColor,isDark),
            _buildContent(textColor),
            _buildFoot(isDark)
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(Color color,Color? textColor,bool isDark) {
    return Row(
      children: [
        if (searchArg == null)
          Text(
            model.name,
            style:  TextStyle(
              fontSize: 15,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (searchArg != null) Text.rich(formSpan(model.name, searchArg!)),
        const SizedBox(width: 8),
        BlocBuilder<LikeWidgetBloc, LikeWidgetState>(builder: (_, s) {
          bool show = s.widgets.contains(model);
          if (!show) return const SizedBox();
          return Opacity(
            opacity: show ? 1.0 : 0.0,
            child: const CollectedTag(),
          );
        }),
        const Spacer(),
        StarScore(
          star: Star(emptyColor: Colors.white, size: 12, fillColor: color),
          score: model.lever,
        ),
      ],
    );
  }

  Widget _buildContent(Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        model.info,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style:  TextStyle(fontSize: 14, color: textColor),
      ),
    );
  }

  Widget _buildFoot(bool isDark) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 4,
          margin: const EdgeInsets.only(right: 6),
          decoration: const BoxDecoration(
              color: Color(0xff86909c), shape: BoxShape.circle),
        ),
        Text(
          model.nameCN,
          style: const TextStyle(
              fontSize: 12, height: 1, color: Color(0xff86909c)),
        ),
        const Spacer(),
        Wrapper.just(
          radius: 2,
          color:  isDark? Color(0xff292A2D):const Color(0xffF3F3F5),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            Cons.kWidgetFamilyLabelMap[model.family]!,
            style:  TextStyle(
                color:  isDark?Color(0xffCCCCCC):Color(0xff878D96),
                height: 1,
                fontSize: 12,
                shadows: [
                  Shadow(
                      color: isDark? Colors.black:Colors.white, blurRadius: 2, offset: Offset(1, 1))
                ]),
          ),
        ),
      ],
    );
  }

  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.red,
    fontSize: 16,
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
          style: lightTextStyle.copyWith(color: const Color(0xff2F3032))));
      return '';
    });
    return TextSpan(children: span);
  }
}
