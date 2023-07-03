
import 'zendesk_chat_support_platform_interface.dart';

class ZendeskChatSupport {
  Future<String?> getPlatformVersion() {
    return ZendeskChatSupportPlatform.instance.getPlatformVersion();
  }
}
