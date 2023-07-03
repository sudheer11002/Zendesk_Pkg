#import "ZendeskChatSupportPlugin.h"
#if __has_include(<zendesk_chat_support/zendesk_chat_support-Swift.h>)
#import <zendesk_chat_support/zendesk_chat_support-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "zendesk_chat_support-Swift.h"
#endif

@implementation ZendeskChatSupportPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZendeskChatSupportPlugin registerWithRegistrar:registrar];
}
@end
