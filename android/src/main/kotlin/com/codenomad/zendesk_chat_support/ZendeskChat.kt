package com.codenomad.zendesk_chat_support


import io.flutter.plugin.common.MethodChannel
import zendesk.chat.Chat
import zendesk.chat.ChatEngine
import zendesk.classic.messaging.MessagingActivity
import zendesk.core.AnonymousIdentity
import zendesk.core.Identity
import zendesk.core.Zendesk
import zendesk.support.Support

class ZendeskChat(private  val zendeskChatSupportPlugin: ZendeskChatSupportPlugin, private val  channel: MethodChannel){
    companion object {
        const val tag = "[Zendesk Chat]"

    }

    fun  initializeChatSdk(zenDeskUrl: String,
      appId: String, oAuthId: String,
    channelAccountId: String,){

        println("$tag - zenDeskUrl - $zenDeskUrl")
        println("$tag - appId - $appId")
        println("$tag - oAuthId - $oAuthId")
        println("$tag - channelAccountId - $channelAccountId")

        Zendesk.INSTANCE.init(
            zendeskChatSupportPlugin.activity!!, zenDeskUrl,
            appId,
            oAuthId,
        )

        zendeskChatSupportPlugin.isInitialized = true

        val identity: Identity = AnonymousIdentity()
        Zendesk.INSTANCE.setIdentity(identity)

        Support.INSTANCE.init(Zendesk.INSTANCE)

        Chat.INSTANCE.init(zendeskChatSupportPlugin.activity!!, channelAccountId);
    }


    fun show(titleName: String) {
        println("$tag - zendeskChatSupportPluginActivity - ${zendeskChatSupportPlugin.activity!!}")
        MessagingActivity.builder()
            .withToolbarTitle(titleName)
            .withEngines(ChatEngine.engine())
            .show(zendeskChatSupportPlugin.activity!!)
    }
}