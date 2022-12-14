import 'package:app_config/app_config.dart';
import 'package:db_storage/db_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';



class FlutterUnitSplash extends StatefulWidget {
  const FlutterUnitSplash({Key? key}) : super(key: key);

  @override
  State<FlutterUnitSplash> createState() => _FlutterUnitSplashState();
}

class _FlutterUnitSplashState extends State<FlutterUnitSplash> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc,AppState>(
      listener: _listenStart,
      child: Material(
        child: Center(
          child: Text('捷特', textDirection: TextDirection.ltr,),
        ),
      ),
    );
  }

  // 监听资源加载完毕，启动，触发事件
  void _listenStart(BuildContext context, AppState state) {
    print('======_listenStart========');
    BlocProvider.of<WidgetsBloc>(context).add(const EventTabTap(WidgetFamily.statelessWidget));
    BlocProvider.of<LikeWidgetBloc>(context).add(const EventLoadLikeData());
    BlocProvider.of<CategoryBloc>(context).add(const EventLoadCategory());
    // _loaded = true;
    // if(_splashDone){
    //   Navigator.of(context).pushReplacementNamed(UnitRouter.nav);
    // }
  }
}
