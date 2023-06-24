package com.example.boardinfo.config;

import com.example.boardinfo.model.chat.dto.ChatMessageDTO;
import com.example.boardinfo.service.chat.ChatRoomStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.web.socket.config.annotation.*;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import javax.inject.Inject;
import java.util.Map;

@Configuration
//@EnableWebSocket
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {


    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Inject
    ChatRoomStore chatRoomStore;


    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker("/sub");
        config.setApplicationDestinationPrefixes("/pub");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws-stomp").addInterceptors(new HttpSessionHandshakeInterceptor())
                .setAllowedOrigins("*").withSockJS().setHeartbeatTime(10000);
    }


    @Override
    public void configureClientInboundChannel(ChannelRegistration registration) {
        registration.interceptors(new ChannelInterceptor() {
            @Override
            public Message<?> preSend(Message<?> message, MessageChannel channel) {
                StompHeaderAccessor accessor =
                        MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);

                if (StompCommand.DISCONNECT.equals(accessor.getCommand())) {
                String session_id = (String) message.getHeaders().get("simpSessionId");
               ChatMessageDTO chatMessage = chatRoomStore.leaveOrRemoveRoom(session_id);
               chatMessage.setMessage(session_id);
               if(chatMessage.getUserId()!=null){
                   messagingTemplate.convertAndSend("/sub/alarm/user/" +
                           chatMessage.getUserId(), chatMessage);
               }
                }

                return message;

            }
        });
    }
}
