import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';

double px1 = 1/window.devicePixelRatio;

bool isDesk = kIsWeb || Platform.isMacOS||Platform.isWindows||Platform.isLinux;