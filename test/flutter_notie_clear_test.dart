import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_notie_clear/flutter_notie_clear.dart';
import 'package:flutter_notie_clear/flutter_notie_clear_platform_interface.dart';
import 'package:flutter_notie_clear/flutter_notie_clear_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNotieClearPlatform
    with MockPlatformInterfaceMixin
    implements FlutterNotieClearPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterNotieClearPlatform initialPlatform = FlutterNotieClearPlatform.instance;

  test('$MethodChannelFlutterNotieClear is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterNotieClear>());
  });

  test('getPlatformVersion', () async {
    FlutterNotieClear flutterNotieClearPlugin = FlutterNotieClear();
    MockFlutterNotieClearPlatform fakePlatform = MockFlutterNotieClearPlatform();
    FlutterNotieClearPlatform.instance = fakePlatform;

    expect(await flutterNotieClearPlugin.getPlatformVersion(), '42');
  });
}
