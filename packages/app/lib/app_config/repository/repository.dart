import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:storage/storage.dart';
import '../bloc/state.dart';

class AppStateRepository {

  Future<AppConfigState> initApp() async {
    AppConfigPo po = await SpStorage.instance.appConfig.read();
    ConnectivityResult netConnect = await (Connectivity().checkConnectivity());
    return AppConfigState.fromPo(po).copyWith(netConnect: netConnect);
  }
}
