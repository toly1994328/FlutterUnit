import 'package:equatable/equatable.dart';

class AppInfo extends Equatable {
  final String appName;
  final String appVersion;
  final String appUrl;
  final int appSize;
  final String? description;
  final String? sha256;

  const AppInfo({
    required this.appName,
    required this.appVersion,
    required this.appUrl,
    required this.appSize,
    required this.description,
    required this.sha256,
  });

  @override
  List<Object?> get props => [appName, appVersion, appUrl, appSize];

  @override
  String toString() {
    return 'AppInfo{appName: $appName, appVersion: $appVersion, appUrl: $appUrl, appSize: $appSize}';
  }

  bool shouldUpgrade(String current) {
    List<String> currentArray = current.split(".");
    List<String> upgradeArray = appVersion.split(".");
    int length = currentArray.length;
    if (length == upgradeArray.length) {
      for (int i = 0; i < length; i++) {
        if (int.parse(currentArray[i]) == int.tryParse(upgradeArray[i])) {
          continue;
        }
        return int.parse(currentArray[i]) < int.parse(upgradeArray[i]);
      }
    }
    return false;
  }
}
