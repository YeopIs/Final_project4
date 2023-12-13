package com.finalproject.team4.shouldbe.service;

import com.finalproject.team4.shouldbe.mapper.*;
import com.finalproject.team4.shouldbe.util.*;
import com.finalproject.team4.shouldbe.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.KeyPair;
import java.util.List;

@Service
public class ChatService {

    @Autowired
    ChatMapper chatMapper;

    public int totalRecord(String userId) {
        return chatMapper.countUserChatRooms(userId);
    }

    public List<ChatRoomVO> getCurrentUserChatRooms(PagingVO pvo, String userId) throws Exception {
        List<ChatRoomVO> chatRooms = chatMapper.getCurrentUserChatRooms(pvo, userId);
        for (ChatRoomVO chatRoom : chatRooms) {
            String sharedKey = chatMapper.getSharedKey(chatRoom.getChat_id(), userId);
            String decryptedContent = EncryptUtil.decryptAES(chatRoom.getLast_content(), sharedKey);
            chatRoom.setLast_content(decryptedContent);
            int unreadCount;
            if (chatRoom.getFrom_id().equals(userId)) {
                unreadCount = chatMapper.countUnreadMessages(chatRoom.getChat_id(), 1);
            } else {
                unreadCount = chatMapper.countUnreadMessages(chatRoom.getChat_id(), 0);
            }
            chatRoom.setNot_read(unreadCount);
        }
        return chatRooms;
    }


    public List<MessageVO> getMessagesByChatId(int chatId, String userId) throws Exception {
        List<MessageVO> messages = chatMapper.getMessagesByChatId(chatId);
        String sharedKey = chatMapper.getSharedKey(chatId, userId);
        for (MessageVO message : messages) {
            message.setTrans_content(chatMapper.getTransMsg(message.getMsg_id()));
            String decryptedContent = EncryptUtil.decryptAES(message.getContent(), sharedKey);
            String decryptedTransContent=EncryptUtil.decryptAES(message.getTrans_content(), sharedKey);
            message.setContent(decryptedContent);
            message.setTrans_content(decryptedTransContent);
        }
        chatMapper.updateMessagesAsRead(chatId);
        return messages;
    }


    public String getProfileImg(String userId) {
        return chatMapper.getProfileImg(userId);
    }

    public int saveMessage(MessageVO message) throws Exception {
        String sharedKey = chatMapper.getSharedKey(message.getChat_id(), message.getSender());
        String encryptedContent = EncryptUtil.encryptAES(message.getContent(), sharedKey);
        String contentLang= Translate.detect_lang(message.getContent());
        System.out.println("contentLang "+ contentLang);
        String userLang=chatMapper.getUserLang(message.getOther_id());
        System.out.println(contentLang+" "+userLang+" "+message.getContent());
        if (!contentLang.equals(userLang)) {
            String transContext;
            if (Translate.isDirectTrans(contentLang, userLang)) {
                transContext = Translate.translate_content(contentLang, userLang, message.getContent());
            } else {
                String intermediateTranslation = Translate.translate_content(contentLang, "ko", message.getContent());
                transContext = Translate.translate_content("ko", userLang, intermediateTranslation);
            }
            message.setTrans_content(transContext);
        } else {
            message.setTrans_content(message.getContent());
        }
        message.setTrans_content(EncryptUtil.encryptAES(message.getTrans_content(), sharedKey));
        message.setContent(encryptedContent);
        chatMapper.insertMessage(message);
        chatMapper.insertLastMessage(message);
        chatMapper.insertTransMessage(message.getMsg_id(), message.getTrans_content());
        message.setContent(EncryptUtil.decryptAES(message.getContent(), sharedKey));
        message.setTrans_content(EncryptUtil.decryptAES(message.getTrans_content(), sharedKey));
        return message.getMsg_id();
    }

    public int totalPartnerRecord(String userId) {
        return chatMapper.countUserPartner(userId);
    }

    public List<UserVO> getPartnerById(PagingVO pvo, String userId) {
        return chatMapper.getUserPartnerList(pvo, userId);
    }

    public int startChat(String currentUserId, String otherUserId) throws Exception {
        ChatRoomVO newChatRoom = new ChatRoomVO();
        newChatRoom.setFrom_id(currentUserId);
        newChatRoom.setTo_id(otherUserId);
        chatMapper.createChatRoom(newChatRoom);
        int chat_id=newChatRoom.getChat_id();
        chatMapper.createChatRoomState(chat_id);
        KeyPair keyPairMe = EncryptUtil.generateKeyPair();
        KeyPair keyPairOther = EncryptUtil.generateKeyPair();
        String sharedKey = EncryptUtil.generateSharedKey(keyPairMe.getPrivate(), keyPairOther.getPublic());
        String encryptedContent = EncryptUtil.encryptAES("new chat", sharedKey);
        chatMapper.storeEncryptionKey(chat_id, currentUserId, sharedKey);
        chatMapper.storeEncryptionKey(chat_id, otherUserId, sharedKey);
        chatMapper.updateLastContent(chat_id, encryptedContent);
        return chat_id;
    }

    public void reportMessage(String userId, int msgId) throws Exception {
        MessageVO messageInfo = chatMapper.findMessageInfo(msgId);
        ChatRoomVO chatInfo=chatMapper.getChatByChatId(messageInfo.getChat_id());
        String sharedKey = chatMapper.getSharedKey(messageInfo.getChat_id(), userId);
        String senderUserId = messageInfo.getIs_from_id() == 1 ? chatInfo.getFrom_id() : chatInfo.getTo_id();
        String content=EncryptUtil.decryptAES(messageInfo.getContent(), sharedKey);
        chatMapper.reportMessage(senderUserId, msgId, content);
    }

    public void saveMessageToMypage(String userId, int msgId) throws Exception {
        System.out.println(1);
        MessageVO messageInfo = chatMapper.findMessageInfo(msgId);
        System.out.println(2);
        String sharedKey = chatMapper.getSharedKey(messageInfo.getChat_id(), userId);
        System.out.println(sharedKey);
        String content=EncryptUtil.decryptAES(messageInfo.getContent(), sharedKey);
        System.out.println(4);
        int a=chatMapper.saveMessageToMypageCheck(userId,msgId);
        if (a == 0) {
            chatMapper.saveMessageToMypage(userId, msgId, content);
            System.out.println(5);
        }
    }

    public void addFriend(String followingUserId, String followedUserId) {
        int exists = chatMapper.countFriendRelationship(followingUserId, followedUserId);
        if (exists == 0) {
            chatMapper.insertFriend(followingUserId, followedUserId);
        }
    }

    @Transactional
    public void blockUserAndUpdateChat(BlockRequest blockRequest) {
        chatMapper.insertBlockList(blockRequest.getUserId(),blockRequest.getOtherId(),blockRequest.getReason());
        chatMapper.updateUserReport(blockRequest.getOtherId());
        System.out.println("1");
        chatMapper.friendDelete(blockRequest.getUserId(),blockRequest.getOtherId());
        System.out.println("2");
        String currentState = chatMapper.getStateByChatId(Integer.parseInt(blockRequest.getChatId()));
        System.out.println("3");
        System.out.println(currentState);
        if ("0".equals(currentState)) {
            chatMapper.updateState(Integer.parseInt(blockRequest.getChatId()),blockRequest.getUserId());
            System.out.println("4");
        } else {
            chatMapper.deleteChatAndRelatedData(Integer.parseInt(blockRequest.getChatId()));
            System.out.println("5");
        }
        System.out.println("6");
    }
}