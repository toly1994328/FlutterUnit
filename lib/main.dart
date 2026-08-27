import 'package:app/app.dart';

import 'src/starter/fx_application.dart';

void main(List<String> args) {
  registerFlutterUnitHost();
  const FxApplication().run(args);
}
