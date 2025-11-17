import 'package:flutter_test/flutter_test.dart';
import 'package:unit_env/unit_env.dart';

void main() async {
  late Host host;

  setUpAll(() async {
    host = ScienceHost();
    FxDio().register(host);
    // initHttp(app);
    // request = HouseDetailRequest();
  });
  group('System API Tests', () {
    test('/v', () async {
      await host.get('/v', convertor: (e) {
        print(e);
      });
    });
  });
}
