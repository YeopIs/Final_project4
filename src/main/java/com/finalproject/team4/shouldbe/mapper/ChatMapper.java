package com.finalproject.team4.shouldbe.mapper;

import com.finalproject.team4.shouldbe.vo.ChatRoomVO;
import com.finalproject.team4.shouldbe.vo.MessageVO;
import com.finalproject.team4.shouldbe.vo.PagingVO;
import com.finalproject.team4.shouldbe.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ChatMapper {

    List<ChatRoomVO> getCurrentUserChatRooms(PagingVO pvo, String userId);

    int countUnreadMessages(int chatId, int isFromId);

    int countUserChatRooms(String userId);

    List<MessageVO> getMessagesByChatId(int chatId);

    void updateMessagesAsRead(int chatId);

    String getProfileImg(String userId);

    void insertMessage(MessageVO message);

    void insertLastMessage(MessageVO message);

    int countUserPartner(String userId);

    List<UserVO> getUserPartnerList(PagingVO pvo, String userId);

    void createChatRoom(ChatRoomVO newChatRoom);

    void updateLastContent(int chatId, String last_content);

    void storeEncryptionKey(int chat_id, String user_id, String symmetric_key);

    String getSharedKey(int chatId, String userId);

    MessageVO findMessageInfo(int msgId);

    void reportMessage(String userId, int msgId, String content);

    ChatRoomVO getChatByChatId(int chatId);

    void saveMessageToMypage(String userId, int msgId, String content);

    String getUserLang(String userId);

    void insertTransMessage(int msgId, String s);

    String getTransMsg(int msgId);

    int countFriendRelationship(String followingUserId, String followedUserId);
    void insertFriend(String followingUserId, String followedUserId);

    void insertBlockList(String userId, String blockId, String reason);

    String getStateByChatId(int chatId);

    void updateState(int chatId, String userId);

    void deleteChatAndRelatedData(int chatId);

    void friendDelete(String followed_user_id, String following_user_id);

    void createChatRoomState(int chatId);

    int saveMessageToMypageCheck(String userId, int msgId);

    void updateUserReport(String otherId);
}