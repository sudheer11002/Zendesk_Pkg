import UIKit
import ChatSDK
import ChatProvidersSDK
import MessagingSDK

public class ZendeskSupportChat: NSObject {


    let TAG = "[ZendeskChat]"

    private var zendeskPlugin: SwiftZendeskChatSupportPlugin? = nil
    private var channel: FlutterMethodChannel? = nil

    init(flutterPlugin: SwiftZendeskChatSupportPlugin, channel: FlutterMethodChannel) {
        self.zendeskPlugin = flutterPlugin
        self.channel = channel
    }

    func initialize(accountKey: String,zenDeskUrl: String,
          appId: String, oAuthId: String) {
          self.zendeskPlugin?.isInitialized = true
         print("\(self.TAG) - Channel Key - \(accountKey)\n")
         Chat.initialize(accountKey: accountKey)
    }

    func show(rootViewController: UIViewController?) {

            do{
             let chatEngine = try  ChatEngine.engine()
             let messagingViewController =  try Messaging.instance.buildUI(engines: [chatEngine], configs: [])
            guard let viewController = rootViewController else { return }
              viewController.present(messagingViewController, animated: true, completion: nil)
             print("\(self.TAG) - show")

            }catch{
            }



    }



}