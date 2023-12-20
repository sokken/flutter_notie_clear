import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_notie_clear_method_channel.dart';

abstract class FlutterNotieClearPlatform extends PlatformInterface {
  /// Constructs a FlutterNotieClearPlatform.
  FlutterNotieClearPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNotieClearPlatform _instance = MethodChannelFlutterNotieClear();

  /// The default instance of [FlutterNotieClearPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterNotieClear].
  static FlutterNotieClearPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNotieClearPlatform] when
  /// they register themselves.
  static set instance(FlutterNotieClearPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
