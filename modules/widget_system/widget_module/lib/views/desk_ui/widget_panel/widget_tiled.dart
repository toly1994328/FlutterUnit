import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:widget_module/blocs/action/widget_action.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:wrapper/wrapper.dart';
import 'package:tolyui/tolyui.dart';
import '../../components/widget_logo_map.dart';
import '../like_tag.dart';
import 'package:l10n/l10n.dart';

import 'widget_id_view.dart';

class WidgetTiled extends StatelessWidget {
  final WidgetModel model;
  final VoidCallback onTap;
  final String? searchArg;

  const WidgetTiled({
    super.key,
    required this.model,
    required this.onTap,
    this.searchArg,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ListTileThemeData data = theme.listTileTheme;
    Color? tileColor = data.tileColor;
    Color? textColor = data.textColor;
    bool isDark = theme.brightness == Brightness.dark;
    textColor = isDark ? textColor : const Color(0xff2F3032);
    Color color = theme.primaryColor;
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8);

    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: tileColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 2,
                )
              ],
            ),
            child: Row(
              children: [
                GestureDetector(
                  onLongPress: () => context.toggleLike(model.id),
                  child: Hero(
                      tag: model.heroId,
                      child: WidgetLogo(
                          background: color, widgetName: model.name)),
                ),
                Expanded(
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTitle(color, textColor, isDark),
                        _buildContent(textColor),
                        _buildFoot(isDark)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        LikeTag(widget: model),
        Positioned(bottom: 2, left: 6, child: WidgetIdView(model: model))
      ],
    );
  }

  Widget linkText(BuildContext context) => Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 5),
            child: Icon(Icons.link, color: Colors.blue),
          ),
          Text(context.l10n.relatedComponents, style: UnitTextStyle.labelBold),
        ],
      );

  Widget listTitle(Color? textColor) {
    return GestureDetector(
      child: Text(
        model.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onLongPress: () async {
        await Clipboard.setData(ClipboardData(text: model.name));
        $message.success(message: '名称复制成功!');
      },
    );
  }

  Widget _buildTitle(Color color, Color? textColor, bool isDark) {
    Widget title;
    if (searchArg == null) {
      title = listTitle(textColor);
    } else {
      title = Text.rich(formSpan(model.name, searchArg!));
    }
    return Row(
      children: [
        Expanded(child: title),
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
        style: TextStyle(fontSize: 13, color: textColor),
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
        Expanded(
          child: Text(
            model.nameCN,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 12, height: 1, color: Color(0xff86909c)),
          ),
        ),
        Wrapper.just(
          radius: 4,
          color: isDark ? const Color(0xff292A2D) : const Color(0xffF3F3F5),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            Cons.kWidgetFamilyLabelMap[model.family]!,
            style: TextStyle(
                color:
                    isDark ? const Color(0xffCCCCCC) : const Color(0xff878D96),
                height: 1,
                fontSize: 10,
                shadows: [
                  Shadow(
                      color: isDark ? Colors.black : Colors.white,
                      blurRadius: 2,
                      offset: const Offset(1, 1))
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
