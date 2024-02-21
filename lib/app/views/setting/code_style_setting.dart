import 'package:app/app.dart';
import 'package:l10n/l10n.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// create by 张风捷特烈 on 2020-04-10
/// contact me by email 1981462002@qq.com
/// 说明:

class CodeStyleSettingPage extends StatelessWidget {

  const CodeStyleSettingPage({Key? key}) : super(key: key);

  final String code = """
const String _kCounty = 'China';

class Hello {
  final String name;//言语
  final String county;//国家
  final int age;//年龄

  Hello({
    this.name = "张风捷特烈",
    this.age = 26,
    this.county = _kCounty
  });
}""";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text(context.l10n.codeHighlightStyle)),
      body: BlocBuilder<AppConfigBloc, AppConfigState>(
          builder: (_, state) => _buildFontCell(context,
              Cons.codeThemeSupport.keys.toList(), state.codeStyleIndex)),
    );
  }

  Widget _buildFontCell(
      BuildContext context, List<HighlighterStyle> styles, int index) {
    return ListView.builder(
      itemCount: styles.length,
      itemBuilder: (_ctx, i) =>  FeedbackWidget(
        a: 0.95,
        duration: const Duration(milliseconds: 200),
      onPressed: (){
        BlocProvider.of<AppConfigBloc>(context).switchCoderTheme(i);
      },
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
         Card(
              margin: const EdgeInsets.all(10),
              child: CodeWidget(
                code: code,
                style: styles[i],
              ),
          ),

          Positioned(
            right: 20,
            bottom: 20,
            child: Text(Cons.codeThemeSupport.values.toList()[i],style: TextStyle(
              fontSize: 14,
              color: styles[i].stringStyle!.color,
              shadows: const [Shadow(
                color: Colors.white,
                offset: Offset(.5,.5),
                blurRadius: 1
              ),]
            ),),
          ),

          if(index == i)
          Positioned(
            right: 20,
            top: 20,
            child: Circle(radius: 10,
              color: Theme.of(context).primaryColor,
              child: const Icon(Icons.check,color:Colors.white,size: 15,),),
          )
        ],
      ),
    ));
  }
}
