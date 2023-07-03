import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'zendesk_chat_support_method_channel.dart';

abstract class ZendeskChatSupportPlatform extends PlatformInterface {
  /// Constructs a ZendeskChatSupportPlatform.
  ZendeskChatSupportPlatform() : super(token: _token);

  static final Object _token = Object();

  static ZendeskChatSupportPlatform _instance = MethodChannelZendeskChatSupport();

  /// The default instance of [ZendeskChatSupportPlatform] to use.
  ///
  /// Defaults to [MethodChannelZendeskChatSupport].
  static ZendeskChatSupportPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ZendeskChatSupportPlatform] when
  /// they register themselves.
  static set instance(ZendeskChatSupportPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
