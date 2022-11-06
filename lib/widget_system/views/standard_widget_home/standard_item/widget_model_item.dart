import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:flutter_unit/app/res/cons/cons.dart';
import 'package:flutter_unit/widget_system/blocs/liked_widget_bloc/liked_widget_bloc.dart';
import 'package:flutter_unit/widget_system/blocs/liked_widget_bloc/liked_widget_state.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:wrapper/wrapper.dart';

class StandardWidgetItem extends StatelessWidget {
  final WidgetModel model;
  final VoidCallback onTap;
  final String? searchArg;

  const StandardWidgetItem(
      {Key? key, required this.model, required this.onTap, this.searchArg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          // margin:
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTitle(Theme.of(context).primaryColor),
              _buildContent(),
              _buildFoot()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(Color color) {
    return Row(
      children: [
        if (searchArg == null)
          Text(
            model.name,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xff2F3032),
              fontWeight: FontWeight.bold,
            ),
          ),
        if (searchArg != null) Text.rich(formSpan(model.name, searchArg!)),
        const SizedBox(
          width: 8,
        ),
        BlocBuilder<LikeWidgetBloc, LikeWidgetState>(builder: (_, s) {
          bool show = s.widgets.contains(model);
          return Opacity(
            opacity: show ? 1.0 : 0.0,
            child: Wrapper.just(
              radius: 10,
              color: const Color(0xffF3F3F5),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                '已收藏',
                style: TextStyle(
                    color: color,
                    height: 1,
                    fontSize: 10,
                    shadows: const [
                      Shadow(
                          color: Colors.white,
                          blurRadius: 2,
                          offset: Offset(1, 1))
                    ]),
              ),
            ),
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

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        model.info,
        style: const TextStyle(fontSize: 14, color: Color(0xff2F3032)),
      ),
    );
  }

  Widget _buildFoot() {
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
          color: const Color(0xffF3F3F5),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            Cons.kWidgetFamilyLabelMap[model.family]!,
            style: const TextStyle(
                color: Color(0xff878D96),
                height: 1,
                fontSize: 12,
                shadows: [
                  Shadow(
                      color: Colors.white, blurRadius: 2, offset: Offset(1, 1))
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
