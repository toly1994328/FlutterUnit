import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/note.dart';
import 'package:tolyui/tolyui.dart';
import '../../repository/model/article.dart';

class ArticleDisplay extends StatelessWidget {
  const ArticleDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    ArticlePo? selected =
        context.select((ArtSysBloc bloc) => bloc.state.active);
    if (selected == null) {
      return SizedBox();
    }
    if (selected.type == ArticleType.net.index) {
      return NetworkArticleDisplay(
        article: selected,
      );
    }
    return TextField(
      style: TextStyle(fontSize: 14),
      onChanged: (text) => context.read<ArtSysBloc>().write(text),
      maxLines: null,
      minLines: null,
      controller: context.read<ArtSysBloc>().ctrl,
      expands: true,
      decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          )),
    );
    return const Placeholder();
  }
}

class NetworkArticleDisplay extends StatelessWidget {
  final ArticlePo article;

  const NetworkArticleDisplay({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        width: 300,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(8)),
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              article.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (article.subtitle != null)
              Text(
                article.subtitle!,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            Image.network(article.cover ?? ''),
            ElevatedButton(
              onPressed: () {},
              child: Text('前往查看'),
              style: FillButtonPalette(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                foregroundPalette: Palette.all(Colors.white),
                borderRadius: BorderRadius.circular(6),
                backgroundPalette: const Palette(
                  normal: Color(0xff1890ff),
                  hover: Color(0xff40a9ff),
                  pressed: Color(0xff096dd9),
                ),
              ).style,
            ),
          ],
        ),
      ),
    );
  }
}
