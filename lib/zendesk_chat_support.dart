import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'zendesk_chat_support_platform_interface.dart';

class ZendeskChatSupport {
  static const MethodChannel _channel = MethodChannel('zendesk_chat_support');
  Future<String?> getPlatformVersion() {
    return ZendeskChatSupportPlatform.instance.getPlatformVersion();
  }

  Future<void> initialize({
    required String androidChannelKey,
    required String iosChannelKey,
    required String zenDeskUrl,
    required String appId,
    required String oAuthId,
  }) async {
    if (androidChannelKey.isEmpty || iosChannelKey.isEmpty) {
      debugPrint('ZendeskChatSupport - initialize - keys can not be empty');
      return;
    }

    try {
      /*_channel.setMethodCallHandler(
          _onMethodCall); */ // start observing channel messages

      await _channel.invokeMethod('initialize', {
        'channelAccountId':
            Platform.isAndroid ? androidChannelKey : iosChannelKey,
        'zenDeskUrl': zenDeskUrl,
        'appId': appId,
        'oAuthId': oAuthId,
      });
      return;
    } catch (e) {
      debugPrint('ZendeskMessaging - initialize - Error: $e}');
      return;
    }
  }

  Future<bool> isInitialize() async {
    try {
      return await _channel.invokeMethod(
        'isInitialized',
      );
    } catch (e) {
      debugPrint('ZendeskMessaging - isInitialized - Error: $e}');
      return false;
    }
  }

  Future<void> show() async {
    try {
      await _channel.invokeMethod('show');
    } catch (e) {
      debugPrint('ZendeskMessaging - show - Error: $e}');
    }
  }
}
