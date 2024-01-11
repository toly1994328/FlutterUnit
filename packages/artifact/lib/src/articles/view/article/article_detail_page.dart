import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../data/exp.dart';



class ArticleDetailPage extends StatefulWidget {
  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  late WebViewController controller;

  int progress = 0;

  @override
  void initState() {
    print(widget.article.url);
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse('https://juejin.cn${widget.article.url}'))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print(progress);
            this.progress =progress;
            setState(() {

            });
          },
          onPageStarted: (String url) {

          },
          onPageFinished: (String url) {
          },
        ));
  }

  _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(uri,mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text(widget.article.title),actions: [
        IconButton(onPressed: (){
          _launchURL('https://juejin.cn${widget.article.url}');
        }, icon: Icon(TolyIcon.icon_artifact,size: 20,))
      ],),
      body: Stack(
        alignment: Alignment.center,
        children: [
          WebViewWidget(controller: controller),
          if(progress!=100)
          Center(
            child: CupertinoActivityIndicator(),
          )
        ],
      ),
    );
  }
}
