import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_star/star.dart';
import 'package:flutter_star/star_score.dart';
import 'package:tolyui_message/tolyui_message.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:wrapper/wrapper.dart';

import '../../../widget_ui.dart';

sealed class WidgetAction {}

class JumpWidgetDetail extends WidgetAction {
  final int? widgetId;
  final String? widgetName;
  final WidgetModel? model;

  JumpWidgetDetail({
    this.widgetId,
    this.model,
    this.widgetName,
  });
}

class ToggleLikeWidget extends WidgetAction {
  final int widgetId;

  ToggleLikeWidget(this.widgetId);
}

/// 组价主页单体的样式
class WidgetItem extends StatelessWidget {
  final WidgetModel model;
  final ValueChanged<WidgetAction> onWidget;

  const WidgetItem({
    super.key,
    required this.model,
    required this.onWidget,
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
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    );

    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () => onWidget.call(JumpWidgetDetail(model: model)),
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
                  onLongPress: () => onWidget.call(ToggleLikeWidget(model.id)),
                  child: Hero(
                      tag: model.heroId,
                      child: WidgetLogo(
                          lever: model.lever,
                          background: color,
                          widgetName: model.name,
                          widgetId: model.id)),
                ),
                Expanded(
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        listTitle(textColor),
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
        LikeTag(model: model, onWidget: onWidget),
      ],
    );
  }

  Widget _buildTitle(Color color, Color? textColor, bool isDark) {
    return Row(
      children: [
        Expanded(child: listTitle(textColor)),
        StarScore(
          star: Star(emptyColor: Colors.white, size: 12, fillColor: color),
          score: model.lever,
        ),
      ],
    );
  }

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
            kWidgetFamilyLabelMap[model.family]!,
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
}

Map<WidgetFamily, String> get kWidgetFamilyLabelMap => {
      WidgetFamily.stateless: "Stateless",
      WidgetFamily.stateful: "Stateful",
      WidgetFamily.singleChildRender: "SingleChild",
      WidgetFamily.multiChildRender: "MultiChild",
      WidgetFamily.sliver: "Sliver",
      WidgetFamily.proxy: "Proxy",
      WidgetFamily.other: "Other",
    };
