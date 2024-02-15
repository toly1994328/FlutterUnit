import 'dart:convert';
import 'dart:math';

import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import '../../bloc/article/bloc.dart';
import '../../bloc/exp.dart';
import '../../data/model/columnize.dart';
import '../../data/repository/article_repository.dart';

import 'column_detail_page.dart';

DateFormat formatLong = DateFormat('yyyy-MM-dd HH:mm:ss');

const colors = [
  Color(0xFF0829FB),
  Color(0xFFF60C0C),
  Color(0xFFE7F716),
  Color(0xFFF3B913),
  Color(0xFF3DF30B),
  Color(0xFFB709F4),
  Color(0xFF0DF6EF),
];

class ColumnizePageView extends StatefulWidget {
  const ColumnizePageView({Key? key}) : super(key: key);

  @override
  _ColumnizePageViewState createState() => _ColumnizePageViewState();
}

class _ColumnizePageViewState extends State<ColumnizePageView> {
  final ValueNotifier<double> factor = ValueNotifier<double>(0);

  late PageController _ctrl;

  final int _firstOffset = 1000; //初始偏移
  int _position = 0; //页面位置

  @override
  void initState() {
    super.initState();
    _position = _position + _firstOffset;

    double value = ((_position - _firstOffset + 1) % 5) / 5;
    factor.value = value == 0 ? 1 : value;
    _ctrl = PageController(
      viewportFraction: 0.9,
      initialPage: _position,
    )..addListener(() {
        if (_ctrl.page != null) {
          double value = (_ctrl.page! - _firstOffset + 1) % 5 / 5;
          factor.value = value == 0 ? 1 : value;
        }
      });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    factor.dispose();
    super.dispose();
  }

  Color get color => Colors.blue;

  Color get nextColor => Colors.orangeAccent;
  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  BoxDecoration get boxDecoration => BoxDecoration(
        color: isDark ? Colors.white.withAlpha(33) : Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      );

  @override
  Widget build(BuildContext context) {
    List<Columnize> data = context.watch<ColumnizeBloc>().state.data;
    Widget child =  PageView.builder(
        controller: _ctrl, // itemCount: 7,
        itemBuilder: (_, index) {
          return AnimatedBuilder(
            child: _buildByIndex(context, index, data),
            animation: _ctrl,
            builder: (context, child) => _buildAnimItemByIndex(
              context,
              child,
              index,
            ),
          );
        },
        onPageChanged: (index) {
          _position = index;
        },
    );
    if(!isDesk){
      return child;
    }

    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: child),
          Positioned(
              right: 0,
              child: IconButton(onPressed: (){
                _position+=1;
                _ctrl.animateToPage(_position, duration: Duration(milliseconds: 500),curve: Curves.easeIn);
              }, icon: Icon(Icons.navigate_next_outlined))),
          Positioned(
              left: 0,
              child: IconButton(onPressed: (){
                _position-=1;
                _ctrl.animateToPage(_position, duration: Duration(milliseconds: 500),curve: Curves.easeIn);
              }, icon: Icon(Icons.navigate_before))),
        ],
      ),
    );
  }

  Widget? _buildByIndex(BuildContext context, int index, List<Columnize> data) {
    int realIndex = _fixPosition(index, _firstOffset, data.length);
    return ColumnizeItem(
      columnize: data[realIndex],
      color: colors[realIndex % colors.length],
    );
  }

  Widget _buildAnimItemByIndex(BuildContext context, Widget? child, int index) {
    double value;
    if (_ctrl.position.haveDimensions && _ctrl.page != null) {
      value = _ctrl.page! - index;
    } else {
      value = (_position - index).toDouble();
    }
    value = (1 - ((value.abs()) * .3)).clamp(0, 1).toDouble();
    value = Curves.easeOut.transform(value);

    return Transform(
      transform: Matrix4.diagonal3Values(1.0, value, 1.0),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: child,
      ),
    );
  }

  int _fixPosition(int realPos, int initPos, int length) {
    final int offset = realPos - initPos;
    int result = offset % length;
    return result < 0 ? length + result : result;
  }

  bool _hover = false;
  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _hover = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _hover = false;
    });
  }
}

class ColumnizeItem extends StatelessWidget {
  final Columnize columnize;
  final Color color;
  const ColumnizeItem({Key? key, required this.columnize, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ArticleRepository repository = context.read<ArticleBloc>().repository;
        Navigator.of(context).push(SlidePageRoute(
            child: MultiBlocProvider(providers: [
          BlocProvider<ArticleBloc>(
            create: (_) =>
                ArticleBloc(repository, groupId: columnize.id,pageSize: 100)..init(),
          ),
        ], child: ColumnDetailPage(columnize: columnize))));
      },
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        // margin: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      columnize.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      '作者: ${columnize.username}',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(
                            0xff6A6D76,
                          )),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Color(0xff3872E0))),
                  child: Text(
                    '${columnize.count} 篇',
                    style: TextStyle(
                        color: Color(0xff3872E0), fontSize: 12, height: 1.1),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              '专栏简介: ${columnize.subtitle}',
              style: TextStyle(
                  color: Color(
                    0xffA3A3A3,
                  ),
                  fontSize: 12),
              maxLines: 3,
            ),
            Spacer(),
            Row(
              children: [
                Text(
                  '更新时间: ${formatLong.format(DateTime.fromMillisecondsSinceEpoch(columnize.update, isUtc: true))}',
                  style: TextStyle(
                      color: Color(
                        0xff6A6D76,
                      ),
                      fontSize: 12),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient:
              LinearGradient(transform: GradientRotation(3 * pi / 4), colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.08),
            color.withOpacity(0),
            // Theme.of(context).primaryColor.withAlpha(88)
          ]), // color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
