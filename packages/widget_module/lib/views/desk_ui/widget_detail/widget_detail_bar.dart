import 'dart:math';

import 'package:app/app.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:utils/utils.dart';


import 'package:widget_module/blocs/blocs.dart';
import '../../../../data/exp.dart';

class DeskSliverWidgetDetailBar extends StatelessWidget {
  final WidgetModel model;

  const DeskSliverWidgetDetailBar({Key? key, required this.model})
      : super(key: key);

  final Color backgroundColor = const Color(0xffFAFAFA);
  static const Color textColor = Color(0xff262626);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color? appBarColor = Theme.of(context).appBarTheme.backgroundColor;
    Color? appBarTextColor = Theme.of(context).appBarTheme.titleTextStyle?.color;

    return SliverAppBar(
      pinned: true,
      backgroundColor: isDark? appBarColor:backgroundColor,
      titleTextStyle:  TextStyle(color: isDark?appBarTextColor:Color(0xff696969)),
      iconTheme:  IconThemeData(color: isDark?appBarTextColor:Color(0xff696969)),
      expandedHeight: 120.0,
      scrolledUnderElevation: 0.5,
      flexibleSpace: DragToMoveAreaNoDouble(
        child: DiyFlexibleSpaceBar(
          centerTitle: false,
          expandedTitleScale: 2,
          titleIconBuilder: (t) => WindmillWidget(
            rotate: t * 2 * pi * 2,
            radius: 15,
          ),
          fixedSubtitle: Text(
            model.name,
            style:  TextStyle(color:isDark?appBarTextColor:Color(0xff696969), fontSize: 12),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              model.nameCN,
              style:  TextStyle(color:isDark?appBarTextColor: textColor, fontSize: 16),
            ),
          ),
          //伸展处布局
          titlePadding: const EdgeInsets.only(left: 20, bottom: 10),
          //标题边距
          collapseMode: CollapseMode.parallax,
        ),
      ),
      elevation: 0,
      actions: [

         WindowButtons(
           actions: [
             _buildToHome(context),
             FeedbackWidget(
               onPressed: () => _toggleLikeState(context),
               child: BlocConsumer<LikeWidgetBloc, LikeWidgetState>(
                 listener: _listenLikeStateChange,
                 builder: _buildByLikeState,
               ),
             ),
           ],
         )
      ],
    );
  }

  void _toggleLikeState(BuildContext context) {
    BlocProvider.of<LikeWidgetBloc>(context).add(
      ToggleLikeWidgetEvent(id: model.id),
    );
  }

  // 监听 LikeWidgetBloc 伺机弹出 toast
  void _listenLikeStateChange(BuildContext context, LikeWidgetState state) {
    bool collected = state.widgets.contains(model);
    String msg =
        collected ? "收藏【${model.name}】组件成功!" : "已取消【${model.name}】组件收藏!";
    Toast.toast(
      context,
      msg,
      duration: Duration(milliseconds: collected ? 1500 : 600),
      action: collected
          ? SnackBarAction(
              textColor: Colors.white,
              label: '收藏夹管理',
              onPressed: () => Scaffold.of(context).openEndDrawer())
          : null,
    );
  }

  // 根据 [LikeWidgetState ] 构建图标
  Widget _buildByLikeState(BuildContext context, LikeWidgetState state) {
    bool liked = state.widgets.contains(model);
    return SizedBox(
      width: 30,
      height: 30,
      child: Icon(
        liked ? TolyIcon.icon_star_ok : TolyIcon.icon_star_add,
        size: 20,
      ),
    );
  }

  Widget _buildToHome(BuildContext context) => GestureDetector(
      onLongPress: () => Scaffold.of(context).openEndDrawer(),
      child:const SizedBox(
        width: 30,
        height: 30,
        child: Icon(Icons.home,size: 20,),
      ),
      onTap: () => Navigator.of(context).pop());
}
