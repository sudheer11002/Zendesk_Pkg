import 'package:flutter_test/flutter_test.dart';
import 'package:zendesk_chat_support/zendesk_chat_support.dart';
import 'package:zendesk_chat_support/zendesk_chat_support_platform_interface.dart';
import 'package:zendesk_chat_support/zendesk_chat_support_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockZendeskChatSupportPlatform
    with MockPlatformInterfaceMixin
    implements ZendeskChatSupportPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ZendeskChatSupportPlatform initialPlatform = ZendeskChatSupportPlatform.instance;

  test('$MethodChannelZendeskChatSupport is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelZendeskChatSupport>());
  });

  test('getPlatformVersion', () async {
    ZendeskChatSupport zendeskChatSupportPlugin = ZendeskChatSupport();
    MockZendeskChatSupportPlatform fakePlatform = MockZendeskChatSupportPlatform();
    ZendeskChatSupportPlatform.instance = fakePlatform;

    expect(await zendeskChatSupportPlugin.getPlatformVersion(), '42');
  });
}
