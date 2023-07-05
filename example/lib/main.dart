import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zendesk_chat_support/zendesk_chat_support.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String androidChannelKey = 'YOUR_ANDROID_CHANNEL_KEY';
  String iosChannelKey = 'IOS_CHANNEL_KEY';
  String zenDeskUrl = 'https://YOUR_DOMAIN_NAME.zendesk.com';
  String appId = 'YOUR_APP_ID';
  String oAuthId = 'YOUR_O_AUTH_ID';
  final _zendeskChatSupportPlugin = ZendeskChatSupport();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.

    try {
      platformVersion = await _zendeskChatSupportPlugin.getPlatformVersion() ?? 'Unknown platform version';

      _zendeskChatSupportPlugin.initialize(
        androidChannelKey: androidChannelKey,
        iosChannelKey: iosChannelKey,
        zenDeskUrl: zenDeskUrl,
        appId: appId,
        oAuthId: oAuthId,
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Running on: $_platformVersion\n'),
            ElevatedButton(
                onPressed: () async {
                  await _zendeskChatSupportPlugin.isInitialize().then((value) {
                    log("isInitialize: ${value}");
                    if (value) {
                      _zendeskChatSupportPlugin.show();
                    } else {
                      _zendeskChatSupportPlugin.initialize(
                        androidChannelKey: androidChannelKey,
                        iosChannelKey: iosChannelKey,
                        zenDeskUrl: zenDeskUrl,
                        appId: appId,
                        oAuthId: oAuthId,
                      );
                    }
                  });
                },
                child: const Text("Start Chat"))
          ],
        ),
      ),
    );
  }
}
