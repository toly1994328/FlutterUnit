// import 'package:app/app.dart';
// import 'package:components/components.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// /// create by 张风捷特烈 on 2020-04-10
// /// contact me by email 1981462002@qq.com
// /// 说明: item样式切换支持
//
// class ItemStyleSettingPage extends StatelessWidget {
//   const ItemStyleSettingPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: UnitColor.scaffoldBgLight,
//     appBar: const UnitAppbar(title: 'item样式设置'),
//       body: BlocBuilder<AppBloc, AppState>(builder: (_, state) {
//         return _buildCell(context, state.itemStyleIndex);
//       }),
//     );
//   }
//
//   List<Widget> get items=> HomeItemSupport.itemSimples();
//
//   Widget _buildCell(BuildContext context, int index) {
//     return ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (_, i) => Padding(
//           padding: const EdgeInsets.only(bottom: 8,left: 8,right: 8),
//           child: FeedbackWidget(
//                   a: 0.95,
//                   duration: const Duration(milliseconds: 200),
//                   onPressed: () {
//                     BlocProvider.of<AppBloc>(context).changeItemStyle(i);
//                   },
//                   child: Stack(
//                     children: <Widget>[
//                       items[i],
//                       if (index == i)
//                         Positioned(
//                           left: 25,
//                           top: 15,
//                           child: Circle(
//                             color: Theme.of(context).primaryColor,
//                             radius: 10,
//                             child: const Icon(
//                               Icons.check,
//                               color: Colors.white,
//                               size: 15,
//                             ),
//                           ),
//                         )
//                     ],
//                   )),
//         ));
//   }
// }
