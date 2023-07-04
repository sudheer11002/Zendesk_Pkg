package com.codenomad.zendesk_chat_support

import android.app.Activity
import androidx.annotation.NonNull
import com.codenomad.zendesk_chat_support.ZendeskChat.Companion.tag

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** ZendeskChatSupportPlugin */
class ZendeskChatSupportPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  var activity: Activity? = null
  var isInitialized: Boolean = false


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "zendesk_chat_support")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val sendData: Any? = call.arguments
    val zendeskChat = ZendeskChat(this, channel)
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "initialize" -> {
        if (isInitialized) {
          println("$tag - Messaging is already initialized!")
          return
        }
        val zenDeskUrl = call.argument<String>("zenDeskUrl")!!
        val appId = call.argument<String>("appId")!!
        val oAuthId = call.argument<String>("oAuthId")!!
        val channelAccountId = call.argument<String>("channelAccountId")!!

        zendeskChat.initializeChatSdk(zenDeskUrl, appId, oAuthId, channelAccountId)

      }
      "show" -> {
        if (!isInitialized) {
          println("$tag - Messaging needs to be initialized first")
          return
        }
        zendeskChat.show()
      }
      "isInitialized" -> {
        result.success(isInitialized)
      }

      else -> {
        result.notImplemented()
      }
    }


    if (sendData != null) {
      result.success(sendData)
    } else {
      result.success(0)
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}
