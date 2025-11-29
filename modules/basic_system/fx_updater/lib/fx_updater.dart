import 'dart:io';

import 'package:flutter/foundation.dart';


export 'bloc/bloc.dart';
export 'bloc/state.dart';
export 'bloc/event.dart';
export 'repository/model/app_info.dart';
export 'views/app_update_panel.dart';
export 'views/update_red_point.dart';
export 'views/version_shower.dart';

export 'repository/api/upgrade_api.dart';


bool kIsDesk =
    kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isLinux;
