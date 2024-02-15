import 'package:app/app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/point_bloc/point_bloc.dart';
import '../../bloc/point_system_bloc.dart';
import '../../data/model/repository.dart';
import '../issues_point/issues_point_page.dart';
import 'github_repo_panel.dart';

class DeskPointPage extends StatefulWidget {
  const DeskPointPage({Key? key}) : super(key: key);

  @override
  State<DeskPointPage> createState() => _DeskPointPageState();
}

class _DeskPointPageState extends State<DeskPointPage> {

  final Repository _repository = Repository.fromJson({
    'full_name': 'toly1994328/FlutterUnit',
    'license': {"spdx_id": 'GPL-3.0'},
    'description':
        '【Flutter 集录指南 App】The unity of flutter, The unity of coder.',
    'stargazers_count': 7958,
    'forks_count': 1039,
    'subscribers_count': 126,
    'open_issues_count': 40,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PointBloc()..add(EventLoadPoint()),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: Row(
              children: [
                Column(
                  children: [
                    GithubRepoPanel(
                      repository: _repository,
                    ),
                    Expanded(
                        child: SizedBox(
                            width: 250,
                            child: IssuesTip())
                        )
                  ],
                ),
                VerticalDivider(width: 1,),
                Expanded(flex: 2, child: IssuesPointContent()),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class IssuesTip extends StatelessWidget {
  const IssuesTip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
              text: '* 注： ',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text:
              '要点集录中的 QA 数据收录在 FlutterUnit 以 point 为标签的 issues 中。如果需要提供数据，在 issues 中问答即可。'),
          TextSpan(
              text: '点击这里跳转',
              mouseCursor: SystemMouseCursors.click,
              recognizer: TapGestureRecognizer()
                ..onTap = _toUrl,
              style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold)),
        ]),
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  void _toUrl() async{
    String url = 'https://github.com/toly1994328/FlutterUnit/issues?q=label%3Apoint+';
    if (!await launchUrl(Uri.parse(url))) {
       throw Exception('Could not launch $url');
    }
  }
}


class SimpleDeskTopBar extends StatelessWidget {
  final Widget? leading;
  final Widget? tail;
  final double height;

  const SimpleDeskTopBar({super.key, this.leading,this.tail,this.height=64});

  @override
  Widget build(BuildContext context) {

    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return DragToMoveAreaNoDouble(
      child: Container(
        height: height,
        color: isDark? Color(0xff2C3036):Colors.white,
        child: Row(
          children: [
            if (leading != null) Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: leading!,
            ),
            const Spacer(),
            const SizedBox(
              width: 20,
            ),
            if(tail!=null) tail!,
            const WindowButtons(),
          ],
        ),
      ),
    );
  }
}


