import Flutter
import UIKit

public class SwiftZendeskChatSupportPlugin: NSObject, FlutterPlugin {
    let TAG = "[SwiftZendeskMessagingPlugin]"

    private var channel: FlutterMethodChannel
        var isInitialized = false

        init(channel: FlutterMethodChannel) {
            self.channel = channel
        }


  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "zendesk_chat_support", binaryMessenger: registrar.messenger())
    let instance = SwiftZendeskChatSupportPlugin(channel:channel )
    registrar.addMethodCallDelegate(instance, channel: channel)

  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

         let method = call.method
        let arguments = call.arguments as? Dictionary<String, Any>
          let zendeskMessaging = ZendeskSupportChat(flutterPlugin: self, channel: channel)


     switch(method){
            case "getPlatformVersion":
               result("iOS " + UIDevice.current.systemVersion)
                break;
            case "initialize":
                if (isInitialized) {
                    print("\(TAG) - Messaging is already initialize!\n")
                    return
                }
                let accountKey: String = (arguments?["accountKey"] ?? "") as! String
                let zenDeskUrl: String = (arguments?["zenDeskUrl"] ?? "") as! String
                let appId: String = (arguments?["appId"] ?? "") as! String
                let oAuthId: String = (arguments?["oAuthId"] ?? "") as! String
                zendeskMessaging.initialize(
                accountKey: accountKey,zenDeskUrl: zenDeskUrl,
                          appId: appId, oAuthId: oAuthId
                )
                break;
            case "show":
                if (!isInitialized) {
                    print("\(TAG) - Messaging needs to be initialized first.\n")
                }
                zendeskMessaging.show(rootViewController: UIApplication.shared.delegate?.window??.rootViewController)
                break

            case "isInitialized":
                result(handleInitializedStatus())
                break
            default:
                break
        }

        result(nil)

  }

  private func handleInitializedStatus() ->Bool{
          return isInitialized
      }
}
