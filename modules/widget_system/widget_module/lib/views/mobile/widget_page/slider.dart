// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:app/app.dart';
//
// import 'widget_page.dart';
//
// class Carousel extends StatefulWidget {
//   final List<WidgetMeta> data;
//
//   const Carousel({Key? key, required this.data}) : super(key: key);
//
//   @override
//   _CarouselState createState() => _CarouselState();
// }
//
// class _CarouselState extends State<Carousel> {
//   final ValueNotifier<double> factor = ValueNotifier<double>(0);
//
//   late PageController _ctrl;
//
//   final int _firstOffset = 1000; //初始偏移
//   int _position = 0; //页面位置
//
//   @override
//   void initState() {
//     super.initState();
//     _position = _position + _firstOffset;
//
//     double value = ((_position - _firstOffset + 1) % 5) / 5;
//     factor.value = value == 0 ? 1 : value;
//     _ctrl = PageController(
//       viewportFraction: 0.9,
//       initialPage: _position,
//     )..addListener(() {
//         if (_ctrl.page != null) {
//           double value = (_ctrl.page! - _firstOffset + 1) % 5 / 5;
//           factor.value = value == 0 ? 1 : value;
//         }
//       });
//   }
//
//   @override
//   void dispose() {
//     _ctrl.dispose();
//     factor.dispose();
//     super.dispose();
//   }
//
//   Color get color => Colors.blue;
//
//   Color get nextColor => Colors.orangeAccent;
//
//   bool get isDark => Theme.of(context).brightness == Brightness.dark;
//
//   BoxDecoration get boxDecoration => BoxDecoration(
//         color: isDark ? Colors.white.withAlpha(33) : Colors.white,
//         borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(40), topRight: Radius.circular(40)),
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     List<WidgetMeta> data = widget.data;
//     Widget child = PageView.builder(
//       controller: _ctrl, // itemCount: 7,
//       itemBuilder: (_, index) {
//         return AnimatedBuilder(
//           child: _buildByIndex(context, index, data),
//           animation: _ctrl,
//           builder: (context, child) => _buildAnimItemByIndex(
//             context,
//             child,
//             index,
//           ),
//         );
//       },
//       onPageChanged: (index) {
//         _position = index;
//         setState(() {});
//       },
//     );
//
//     int realIndex = _fixPosition(_position, _firstOffset, data.length);
//
//     child = Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         child,
//         Padding(
//           padding: const EdgeInsets.only(bottom: 16.0),
//           child: Wrap(
//             spacing: 6,
//             children: widget.data.asMap().keys.map((int index) {
//               return GestureDetector(
//                 onTap: () {
//                   int deta = index - realIndex;
//                   _position += deta;
//                   print('$_position,$realIndex');
//                   // _position = index;
//                   _ctrl.animateToPage(_position,
//                       duration: Duration(milliseconds: 500),
//                       curve: Curves.easeIn);
//                 },
//                 child: Container(
//                   width: 8,
//                   height: 8,
//                   decoration: BoxDecoration(
//                       color: realIndex == index
//                           ? Colors.white
//                           : Colors.black.withValues(alpha: 0.4),
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.white.withValues(alpha: 0.3),
//                             spreadRadius: 1,
//                             blurRadius: 10,
//                             blurStyle: BlurStyle.outer)
//                       ]),
//                 ),
//               );
//             }).toList(),
//           ),
//         )
//       ],
//     );
//
//     if (!kIsDesk) {
//       return child;
//     }
//
//     return MouseRegion(
//       onEnter: _onEnter,
//       onExit: _onExit,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 48.0),
//               child: child),
//           Positioned(
//               right: 0,
//               child: IconButton(
//                   onPressed: () {
//                     _position += 1;
//                     _ctrl.animateToPage(_position,
//                         duration: Duration(milliseconds: 500),
//                         curve: Curves.easeIn);
//                   },
//                   icon: Icon(Icons.navigate_next_outlined))),
//           Positioned(
//               left: 0,
//               child: IconButton(
//                   onPressed: () {
//                     _position -= 1;
//                     _ctrl.animateToPage(_position,
//                         duration: Duration(milliseconds: 500),
//                         curve: Curves.easeIn);
//                   },
//                   icon: Icon(Icons.navigate_before))),
//         ],
//       ),
//     );
//   }
//
//   Widget? _buildByIndex(
//       BuildContext context, int index, List<WidgetMeta> data) {
//     int realIndex = _fixPosition(index, _firstOffset, data.length);
//     return WidgetDisplay(
//       widget: data[realIndex],
//     );
//   }
//
//   Widget _buildAnimItemByIndex(BuildContext context, Widget? child, int index) {
//     double value;
//     if (_ctrl.position.haveDimensions && _ctrl.page != null) {
//       value = _ctrl.page! - index;
//     } else {
//       value = (_position - index).toDouble();
//     }
//     value = (1 - ((value.abs()) * .3)).clamp(0, 1).toDouble();
//     value = Curves.easeOut.transform(value);
//
//     return Transform(
//       transform: Matrix4.diagonal3Values(1.0, value, 1.0),
//       alignment: Alignment.center,
//       child: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: child,
//       ),
//     );
//   }
//
//   int _fixPosition(int realPos, int initPos, int length) {
//     final int offset = realPos - initPos;
//     int result = offset % length;
//     return result < 0 ? length + result : result;
//   }
//
//   bool _hover = false;
//
//   void _onEnter(PointerEnterEvent event) {
//     setState(() {
//       _hover = true;
//     });
//   }
//
//   void _onExit(PointerExitEvent event) {
//     setState(() {
//       _hover = false;
//     });
//   }
// }
