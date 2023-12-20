import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_notie_clear_platform_interface.dart';

/// An implementation of [FlutterNotieClearPlatform] that uses method channels.
class MethodChannelFlutterNotieClear extends FlutterNotieClearPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_notie_clear');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<void> clearAll( ) async {
    await methodChannel.invokeMethod<String>( 'clear_all' );
    return;
  }

  Future<void> createTestNotie( String title, String body ) async {
    await methodChannel.invokeMethod<String>(
      'create_test_notie',
      <String>[
        title,
        body,
      ]
    );
  }
}
