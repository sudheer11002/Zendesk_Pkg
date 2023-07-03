import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'zendesk_chat_support_platform_interface.dart';

/// An implementation of [ZendeskChatSupportPlatform] that uses method channels.
class MethodChannelZendeskChatSupport extends ZendeskChatSupportPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('zendesk_chat_support');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
