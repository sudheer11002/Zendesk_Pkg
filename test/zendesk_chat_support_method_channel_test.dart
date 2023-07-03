import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zendesk_chat_support/zendesk_chat_support_method_channel.dart';

void main() {
  MethodChannelZendeskChatSupport platform = MethodChannelZendeskChatSupport();
  const MethodChannel channel = MethodChannel('zendesk_chat_support');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
