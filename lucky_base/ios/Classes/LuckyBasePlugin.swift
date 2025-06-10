import Flutter
import UIKit
import NeoUtility

public class LuckyBasePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "lucky_base", binaryMessenger: registrar.messenger())
    let instance = LuckyBasePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    if let flutterController = UIApplication.shared.windows.first?.rootViewController as? FlutterViewController {
            let flutterView = flutterController.view
             if let flutterView = flutterView {
                NeoUtility.mainInstance().measureRubber(flutterController, moveListBox: flutterView)
             }
        }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    //a包调用
    case "func1":
          NeoUtility.mainInstance().backupPencil()
          result("")
          //b包调用
        case "func2":
          NeoUtility.mainInstance().downgradeVelocity()
          result("")
             //b包调用
        case "func3":
          NeoUtility.mainInstance().translateAirforce()
          result("")
             //跳h5
        case "func4":
          NeoUtility.mainInstance().logController()
          result("")
        default:
          result(FlutterMethodNotImplemented)
    }
  }
}
