import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//    GeneratedPluginRegistrant.register(with: self)
//    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      
      // A method involed from the UI thread.Handles battery messages
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let batteryChannel = FlutterMethodChannel(name: "com.example.flutter_native", binaryMessenger: controller.binaryMessenger)
      
      batteryChannel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          // wuuee okay
          guard call.method == "getBatteryLevel" else {
              result(FlutterMethodNotImplemented)
              return
          }
//          self?. remove this if you get Swift Compiler Error (Xcode): Value of type 'AppDelegate' has no member 'receiveBatteryLevel' error
          self?.receiveBatteryLevel(result: result)
//          AppDelegate.receiveBatteryLevelS(result: result)
      })
      
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func receiveBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
      if device.batteryState == UIDevice.BatteryState.unknown {
        result(FlutterError(code: "UNAVAILABLE",
                            message: "Battery level not available.",
                            details: nil))
      } else {
        result(Int(device.batteryLevel * 100))
      }
    }
    
//    static private func receiveBatteryLevelS(result: FlutterResult) {
//      let device = UIDevice.current
//      device.isBatteryMonitoringEnabled = true
//      if device.batteryState == UIDevice.BatteryState.unknown {
//        result(FlutterError(code: "UNAVAILABLE",
//                            message: "Battery level not available.",
//                            details: nil))
//      } else {
//        result(Int(device.batteryLevel * 100))
//      }
//    }
}
