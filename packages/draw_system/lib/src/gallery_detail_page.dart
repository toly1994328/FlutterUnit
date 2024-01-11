import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toly_ui/toly_ui.dart';

import 'gallery_card_item.dart';



/// create by 张风捷特烈 on 2020/12/4
/// contact me by email 1981462002@qq.com
/// 说明:

class GalleryDetailPage extends StatefulWidget {
  final GalleryInfo galleryInfo;
  final List<Widget> children;

  const GalleryDetailPage({Key? key,required this.galleryInfo, this.children = const []})
      : super(key: key);

  @override
  _GalleryDetailPageState createState() => _GalleryDetailPageState();
}

class _GalleryDetailPageState extends State<GalleryDetailPage> {
  late PageController _ctrl;
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _ctrl = PageController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _currentIndex.dispose();
    super.dispose();
  }

  // 按钮颜色
  Color get btnColor => Theme.of(context).primaryColor.withOpacity(0.6);

  bool get isFirst => _currentIndex.value == 0;

  bool get isEnd => _currentIndex.value == widget.children.length - 1;

  // 顶部 bar 圆角装饰
  BoxDecoration get topBoxDecoration => BoxDecoration(
      image: DecorationImage(
          fit: BoxFit.cover, image: AssetImage(widget.galleryInfo.image)),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ));

  // 上一页按钮外层包裹装饰
  BoxDecoration get prevWrapDecoration => BoxDecoration(
      color: Colors.white.withOpacity(0.3),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ));

  // 下一页按钮外层包裹装饰
  BoxDecoration get nextWrapDecoration => BoxDecoration(
      color: Colors.white.withOpacity(0.3),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        topLeft: Radius.circular(20),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value:const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light
        ),
        child: Column(
          children: [
            Expanded(
              flex: 20,
              child: buildTopBar(context),
            ),
            Expanded(
                flex: 80,
                child: PageView(
                  controller: _ctrl,
                  children: widget.children,
                  onPageChanged: _onPageChanged,
                ))
          ],
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    _currentIndex.value = index;
  }

  Widget buildTopBar(BuildContext context) {
    return Hero(
      tag: widget.galleryInfo.name,
      child: Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.topLeft,
          decoration: topBoxDecoration,
          child: Column(
            children: [
              buildTitle(context),
              Expanded(
                child: Row(
                  children: [_buildPrevBtn(), const Spacer(), _buildNextBtn()],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrevBtn() {
    return Container(
      width: 80,
      height: 40,
      alignment: Alignment.centerRight,
      decoration: prevWrapDecoration,
      padding: const EdgeInsets.only(right: 5 / 2),
      child: FeedbackWidget(
        onPressed: _switchPrevPage,
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(color: btnColor, shape: BoxShape.circle),
          child: const Icon(Icons.navigate_before, color: Colors.white),
        ),
        // height: 60,
      ),
    );
  }

  Widget _buildNextBtn() {
    return Container(
        width: 80,
        height: 40,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 5 / 2),
        decoration: nextWrapDecoration,
        child: FeedbackWidget(
            onPressed: _switchNextPage,
            child: Container(
              width: 35,
              height: 35,
              decoration:
                  BoxDecoration(color: btnColor, shape: BoxShape.circle),
              child: const Icon(Icons.navigate_next, color: Colors.white),
              // height: 60,
            )));
  }

  // 跳转上一页
  void _switchPrevPage() {
    if (widget.children.isNotEmpty) {
      int page = (_currentIndex.value - 1) % widget.children.length;
      _ctrl.animateToPage(page,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    }
  }

  // 跳转下一页
  void _switchNextPage() {
    if (widget.children.isNotEmpty) {
      int page = (_currentIndex.value + 1) % widget.children.length;
      _ctrl.animateToPage(page,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    }
  }

  bool isDesk = Platform.isMacOS || Platform.isWindows || Platform.isLinux;


  Widget buildTitle(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(top: isDesk?26:46, bottom: 10, left: isDesk?20:0, right: 10),
      child: Row(
        children: [
          // if(isDesk)
          const BackButton(color: Colors.white,),

          Text(
            widget.galleryInfo.name,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                      color: Theme.of(context).primaryColor,
                      offset: const Offset(.2, .2),
                      blurRadius: .5)
                ]),
          ),
          const Spacer(),
          ValueListenableBuilder<int>(
            valueListenable: _currentIndex,
            builder: _buildIndicatorText,
          )
        ],
      ),
    );
  }

  Widget _buildIndicatorText(BuildContext context, int value, Widget? child) {
    String indicatorText =
        "${widget.children.isNotEmpty ? (value + 1) : 0} / ${widget.children.length}";

    return Text(
      indicatorText,
      style: const TextStyle(shadows: [
        Shadow(color: Colors.black, offset: Offset(.2, .2), blurRadius: .5)
      ], fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
    );
  }
}
