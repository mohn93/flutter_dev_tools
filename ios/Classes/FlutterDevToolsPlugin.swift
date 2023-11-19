import Flutter
import UIKit
import FirebaseDynamicLinks

public class FlutterDevToolsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_dev_tools", binaryMessenger: registrar.messenger())
    let instance = FlutterDevToolsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
   case "diagnoseDynamicLinks":
          DynamicLinks.performDiagnostics(completion: {
                        (desc, boolean) in
                            result([desc:boolean])
                        }
                    )
      default:
        result(FlutterMethodNotImplemented)
    }
  }
}
