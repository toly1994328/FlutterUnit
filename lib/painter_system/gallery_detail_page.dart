import 'package:flutter/material.dart';
import 'package:flutter_unit/views/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/views/components/project/items/gallery/gallery_card_item.dart';


/// create by 张风捷特烈 on 2020/12/4
/// contact me by email 1981462002@qq.com
/// 说明:

class GalleryDetailPage extends StatefulWidget {
  final GalleryInfo galleryInfo;
  final List<Widget> children;

  GalleryDetailPage({Key key, this.galleryInfo, this.children = const []})
      : super(key: key);

  @override
  _GalleryDetailPageState createState() => _GalleryDetailPageState();
}

class _GalleryDetailPageState extends State<GalleryDetailPage> {
  PageController _ctrl;
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _ctrl = PageController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: widget.galleryInfo.name,
            child: Material(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height * 0.21,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(widget.galleryInfo.image)),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: Column(
                  children: [
                    buildTitle(context),
                    Expanded(
                      child: Row(
                        children: [
                          _buildPrevBtn(context),
                          Spacer(),
                          _buildNextBtn(context)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: PageView(
            controller: _ctrl,
            children: widget.children,
            onPageChanged: (int index) {
              _currentIndex.value = index;
            },
          ))
        ],
      ),
    );
  }

  Widget _buildPrevBtn(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      padding: EdgeInsets.only(right: 5 / 2),
      child: FeedbackWidget(
        onPressed: () {
          if (widget.children.length > 0) {
            _ctrl.animateToPage(
                (_currentIndex.value - 1) % widget.children.length,
                duration: Duration(milliseconds: 500),
                curve: Curves.linear);
          }
        },
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.6),
              shape: BoxShape.circle),
          child: Icon(Icons.navigate_before, color: Colors.white),
        ),
        // height: 60,
      ),
    );
  }

  Widget _buildNextBtn(BuildContext context) {
    return Container(
        width: 80,
        height: 40,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 5 / 2),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
        child: FeedbackWidget(
            onPressed: () {
              if (widget.children.length > 0) {
                _ctrl.animateToPage(
                    (_currentIndex.value + 1) % widget.children.length,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
              }
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                  shape: BoxShape.circle),
              child: Icon(Icons.navigate_next, color: Colors.white),
              // height: 60,
            )));
  }

  bool get isFirst => _currentIndex.value == 0;

  bool get isEnd => _currentIndex.value == widget.children.length - 1;

  Widget buildTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 46, bottom: 10, left: 20, right: 10),
      child: Row(
        children: [
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
          Spacer(),
          ValueListenableBuilder<int>(
            valueListenable: _currentIndex,
            builder: _buildIndicatorText,
          )
        ],
      ),
    );
  }

  Widget _buildIndicatorText(BuildContext context, int value, Widget child) {
    return Text(
      "${widget.children.length != 0 ? (value + 1) : 0} / ${widget.children.length}",
      style: TextStyle(shadows: [
        Shadow(
            color: Colors.black, offset: const Offset(.2, .2), blurRadius: .5)
      ], fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
    );
  }
}
