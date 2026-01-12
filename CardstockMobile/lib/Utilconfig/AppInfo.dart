import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static late final PackageInfo _packageInfo;

  /// Call this once in main() before runApp()
  static Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  static String get version => _packageInfo.version;       // e.g. "1.0.3"
  static String get buildNumber => _packageInfo.buildNumber; // e.g. "10"
  static String get fullVersion => "${_packageInfo.version}+${_packageInfo.buildNumber}";
}
