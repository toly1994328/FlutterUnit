// import 'dart:math';
//
// import 'package:components/components.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/rendering/sliver.dart';
//
// class ArtifactPage extends StatefulWidget {
//   const ArtifactPage({Key? key}) : super(key: key);
//
//   @override
//   State<ArtifactPage> createState() => _ArtifactPageState();
// }
//
// class _ArtifactPageState extends State<ArtifactPage> {
//
//   final ScrollController _controller = ScrollController();
//   ValueNotifier<double> rate = ValueNotifier(0);
//
//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(_refresh);
//   }
//
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           NestedScrollView(
//             // controller: _controller,
//             // floatHeaderSlivers: true,
//             body:  RefreshIndicator(
//       onRefresh: _onRefresh,
//         child:   CustomScrollView(
//                 controller: _controller,
//                   slivers: [
//                     SliverToBoxAdapter(
//                       child: Container(
//                         height: 240,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [Color(0xffFDF2EC),Color(0xffFCC194)],
//                               transform:GradientRotation(pi/4)
//                           )
//                         ),
//                       ),
//                     ),
//                     SliverToBoxAdapter(
//                       child: Container(
//                         height: 1240,
//                         decoration: BoxDecoration(color: Colors.redAccent),
//                       ),
//                     ),
//                     SliverToBoxAdapter(
//                       child: Container(
//                         height: 1240,
//                         decoration: BoxDecoration(color: Colors.greenAccent),
//                       ),
//                     ),
//                   ],
//               ),
//             ), headerSliverBuilder: _headerSliverBuilder,
//
//           ),
//           _buildTopBar(context),
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _headerSliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
//     return [
//       // SliverLayoutBuilder(builder: _buildByLayout)
//       // SliverAppBar(
//       //   pinned: true,
//       //     title: CupertinoTextField()
//       // )
//     ];
//   }
//
//   Widget _buildByLayout(BuildContext context, SliverConstraints constraints) {
//     double top = MediaQuery.of(context).padding.top;
//     double rate = constraints.scrollOffset/(64 + top);
//     print("=====${constraints.scrollOffset}===${64 + top}=======");
//     return SliverPinnedHeader(
//       child: PreferredSize(
//         preferredSize: Size.fromHeight(64 + top),
//         child: Container(
//           height: 64 + top,
//           decoration: BoxDecoration(color: Color.lerp(Colors.orangeAccent, Colors.white, rate)),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTopBar(BuildContext context,) {
//     double top = MediaQuery.of(context).padding.top;
//     // double rate = constraints.scrollOffset/(64 + top);
//     // double rate = 0;
//     Color color = Colors.white;
//
//     return ValueListenableBuilder<double>(
//       valueListenable: rate,
//       builder:(_,v,__) {
//         double _rate =  rate.value/(64+top);
//         _rate = _rate>=1? 1: _rate;
//         int a = (255*_rate).toInt();
//         Color bgColor = Color.fromARGB(a, 255, 255, 255);
//         return Container(
//           height: 64 + top,
//           padding: EdgeInsets.only(top: top,right: 16,left: 16),
//           alignment: Alignment.centerLeft,
//           decoration: BoxDecoration(color: bgColor),
//           child: Wrap(
//             spacing: 8,
//             children: [
//               Text('捷文宝具'),
//               Text('布局宝具'),
//               Text('编程宝具'),
//               // Expanded(child: CupertinoTextField())
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _refresh() {
//     if(_controller.position.pixels<200){
//       rate.value = _controller.position.pixels;
//     }
//   }
//
//   Future<void> _onRefresh() async{
//     await Future.delayed(Duration(seconds: 3));
//   }
// }
