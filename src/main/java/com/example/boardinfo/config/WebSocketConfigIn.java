package com.example.boardinfo.config;

import com.example.boardinfo.model.gathering.dto.GatheringAlarmDTO;
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

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfigIn implements WebSocketMessageBrokerConfigurer {


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
        registry.addEndpoint("/ws-stomp/in").addInterceptors(new HttpSessionHandshakeInterceptor())
                .setAllowedOrigins("*").withSockJS().setHeartbeatTime(10000);
    }


    @Override
    public void configureClientInboundChannel(ChannelRegistration registration) {
        registration.interceptors(new ChannelInterceptor() {
            @Override
            public Message<?> preSend(Message<?> message, MessageChannel channel) {
                StompHeaderAccessor accessor =
                        MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);


                if(StompCommand.CONNECT.equals(accessor.getCommand())){
                    if (accessor.containsNativeHeader("inChatRoom")) {
                        String user_id = accessor.getFirstNativeHeader("user_id");
                        Integer gathering_id = Integer.parseInt(accessor.getFirstNativeHeader("inChatRoom"));
                        String session_id = (String) message.getHeaders().get("simpSessionId");
                        chatRoomStore.joinOrCreateRoom(gathering_id, user_id, session_id);
                    }
                }


                else if (StompCommand.DISCONNECT.equals(accessor.getCommand())) {
                    String sessionId = (String) message.getHeaders().get("simpSessionId");
                    GatheringAlarmDTO alarm = chatRoomStore.leaveOrRemoveRoom(sessionId);
                    if(alarm!=null){
                        alarm.setMessage(sessionId);
                        messagingTemplate.convertAndSend("/sub/alarm/user/" +
                                    alarm.getUser_id(), alarm);
                    }
                }


                return message;

            }
        });
    }
}
