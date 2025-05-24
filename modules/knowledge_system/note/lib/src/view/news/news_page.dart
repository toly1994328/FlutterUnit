import 'package:flutter/material.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:note/note.dart';

class NewsPage extends StatefulWidget {
  final String title;
  const NewsPage({super.key, required this.title});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<ArticlePo> data = [];
  final ArticleRepository _repository = HttpArticleRepository();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 4),
          itemExtent: 76,
          itemCount: data.length,
          itemBuilder: (_, index) => MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      data[index].cover ?? '',
                      width: 68,
                      height: 68,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data[index].subtitle ?? '',
                          maxLines: 2,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _loadData() async {
    ApiRet<List<ArticlePo>> ret = await _repository.getArticlesByTag(1,
        filter: const SizeFilter(
          page: 1,
          pageSize: 40,
        ));
    if (ret.success) {
      data = ret.data;
      setState(() {});
    }
  }
}
