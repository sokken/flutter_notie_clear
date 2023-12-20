
import 'package:flutter_notie_clear/flutter_notie_clear_method_channel.dart';

import 'flutter_notie_clear_platform_interface.dart';

class FlutterNotieClear {
  Future<String?> getPlatformVersion() {
    //return FlutterNotieClearPlatform.instance.getPlatformVersion();
    return MethodChannelFlutterNotieClear().getPlatformVersion();
  }

  static Future<void> clearAll() async {
    await MethodChannelFlutterNotieClear().clearAll();
    return;
  }

  static Future<void> createTestNotie() async {
    const String title = 'FNC_testTitle';
    const String body = 'FNC_testBody';
    await MethodChannelFlutterNotieClear().createTestNotie( title, body );
  }
}
