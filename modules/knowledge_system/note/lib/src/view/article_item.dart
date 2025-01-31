// import 'package:flutter/material.dart';
// import 'package:tolyui/tolyui.dart';
//
// import '../repository/model/model.dart';
// import 'article_editor.dart';
//
// class ArticleItem extends StatelessWidget {
//   final ArticlePo article;
//   final int index;
//   const ArticleItem({super.key, required this.article, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: index % 2 == 0 ? const Color(0xfff7f9f9) : Colors.white,
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//       child: Row(
//         children: [
//           Text(
//             article.title,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const Spacer(),
//           TolyAction(
//               child: const Icon(Icons.edit, size: 20),
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return EditArticleDialog(
//                       article: article,
//                       onSave: (updatedArticle) {
//                         // 在这里处理更新后的文章
//                         // print('Updated Article: ${updatedArticle.}');
//                       },
//                     );
//                   },
//                 );
//               })
//         ],
//       ),
//     );
//   }
// }
//
