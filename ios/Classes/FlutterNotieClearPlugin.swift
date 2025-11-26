import Flutter
import UIKit
import UserNotifications

public class FlutterNotieClearPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_notie_clear", binaryMessenger: registrar.messenger())
    let instance = FlutterNotieClearPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
        
    case "clear_all":
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
    case "create_test_notie":
        UNUserNotificationCenter.current().requestAuthorization(
            options: [ .alert, .badge, .sound ],
        ) { granted, error in
            if granted {
                print( "granted YEP" )
            } else if let error = error {
                print( "no perm sadface \(error)" )
                return
            }
        }
        
        let args:[String] = call.arguments.flatMap { [$0] as? [String]  } ?? ["asd", "qwe"]
        let content = UNMutableNotificationContent()
        content.title = args[0]
        content.body = args[1]
        content.sound = .default
        content.badge = 69
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false )
        
        let notie = UNNotificationRequest(
            identifier: "beep_boop",
            content: content,
            trigger: trigger,
        )
        
        UNUserNotificationCenter.current().add( notie ) { error in
            if let error = error {
                print( "error sending \(error)" )
            } else {
                print( "jippeee" )
            }
        }
        
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
