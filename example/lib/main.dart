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
      platformVersion = await _zendeskChatSupportPlugin.getPlatformVersion() ??
          'Unknown platform version';

      _zendeskChatSupportPlugin.initialize(
          androidChannelKey: "5dVenha72NIlrwWZLrxUZxPboNSMRT33",
          iosChannelKey: "5dVenha72NIlrwWZLrxUZxPboNSMRT33",
          zenDeskUrl: "https://jacanawarranty.zendesk.com",
          appId: "af8d0208d1a4b5a0690848f5f469c01db8d86608d16a5193",
          oAuthId: "mobile_sdk_client_d051a1cf71d50f49d7b4");
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
                          androidChannelKey: "5dVenha72NIlrwWZLrxUZxPboNSMRT33",
                          iosChannelKey: "5dVenha72NIlrwWZLrxUZxPboNSMRT33",
                          zenDeskUrl: "https://jacanawarranty.zendesk.com",
                          appId:
                              "af8d0208d1a4b5a0690848f5f469c01db8d86608d16a5193",
                          oAuthId: "mobile_sdk_client_d051a1cf71d50f49d7b4");
                    }
                  });
                },
                child: Text("Start Chat"))
          ],
        ),
      ),
    );
  }
}
