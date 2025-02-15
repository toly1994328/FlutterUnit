import 'package:flutter/cupertino.dart';
import 'package:app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';

import '../../widget_module.dart';


extension WidgetContext on BuildContext{

  void initWidgetData(){
    switchWidgetFamily(WidgetFamily.stateless);
  }

  void switchWidgetFamily(WidgetFamily family){
    String locale = read<AppConfigBloc>().state.language.code;
    read<WidgetsBloc>().add(EventTabTap(family,locale: locale));
  }

}
