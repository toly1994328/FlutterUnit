import 'package:app/app.dart';

import 'src/ability/flutter_unit_toast.dart';
import 'src/starter/fx_application.dart';

void main(List<String> args) {
  registerFlutterUnitAbilities();
  registerFlutterUnitHost();
  const FxApplication().run(args);
}
