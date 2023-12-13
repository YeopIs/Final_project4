package com.finalproject.team4.shouldbe.controller;

import com.finalproject.team4.shouldbe.service.*;
import com.finalproject.team4.shouldbe.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.messaging.handler.annotation.*;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.*;
import java.util.List;

@Controller
public class ChatController {
    @Autowired
    MypageService myservice;
    @Autowired
    ChatService chatservice;

    @RequestMapping("/chat/list")
    public ModelAndView chat_room_list(HttpSession session,
                                       @RequestParam(required = false, defaultValue = "1") int page) throws Exception {
        ModelAndView mav = new ModelAndView();
        if (session.getAttribute("logStatus") != "Y") {
            mav.setViewName("redirect:/login");
            return mav;
        }
        String userId = (String) session.getAttribute("logId");
        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(chatservice.totalRecord(userId));
        List<ChatRoomVO> vo = chatservice.getCurrentUserChatRooms(pvo, userId);
        System.out.println(vo);
        mav.addObject("myId", userId);
        mav.addObject("pVO", pvo);
        mav.addObject("chatRoom", vo);
        mav.setViewName("chat/chatRoomList");
        return mav;
    }

    @RequestMapping("/chat")
    public ModelAndView privateChat(@RequestParam("chat_id") int chatId,
                                    @RequestParam("other_user_id") String otherUserId,
                                    @RequestParam("from_id") String fromId,
                                    HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        HttpSession session = request.getSession();
        if(session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/login");
            return mav;
        }
        String userId = (String) session.getAttribute("logId");
        session.setAttribute("chatId", chatId);
        try{
            List<MessageVO> pastMessages = chatservice.getMessagesByChatId(chatId, userId);
            String profile_img = chatservice.getProfileImg(userId);
            String other_profile_img = chatservice.getProfileImg(otherUserId);
            mav.addObject("other_profile_img", other_profile_img);
            mav.addObject("profile_img", profile_img);
            mav.addObject("otherId", otherUserId);
            mav.addObject("userId", userId);
            mav.addObject("chatId", chatId);
            mav.addObject("fromId", fromId);
            mav.addObject("pastMessages", pastMessages);
            mav.setViewName("chat/chat");

            return mav;
        }
        catch (NullPointerException ex) {
            mav.setViewName("redirect:/chat/list");
            return mav;
        }
    }

    @MessageMapping("/chat.sendMessage/{chatId}")
    @SendTo("/topic/public/{chatId}")
    public MessageVO sendPrivateMessage(@Payload MessageVO vo) throws Exception {
        String userId = vo.getSender();
        String fromId = vo.getFrom_id();
        if (userId.equals(fromId)) {
            vo.setIs_from_id(1);
        } else {
            vo.setIs_from_id(0);
        }
        vo.setMsg_id(chatservice.saveMessage(vo));
        return vo;
    }

    @MessageMapping("/chat.addUser/{chatId}")
    @SendTo("/topic/public/{chatId}")
    public MessageVO addUser(
            @Payload MessageVO chatMessage,
            SimpMessageHeaderAccessor headerAccessor
    ) {
        String username = (String) headerAccessor.getSessionAttributes().get("username");
        String sessionChatId = (String) headerAccessor.getSessionAttributes().get("chatId");
        return chatMessage;
    }

    @RequestMapping("/chat/partners")
    public ModelAndView chat_partner(HttpSession session,
                                     @RequestParam(required = false, defaultValue = "1") int page) {
        ModelAndView mav = new ModelAndView();
        if (session.getAttribute("logStatus") != "Y") {
            mav.setViewName("redirect:/login");
            return mav;
        }
        String userId = (String) session.getAttribute("logId");
        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(chatservice.totalPartnerRecord(userId));
        List<UserVO> partner = chatservice.getPartnerById(pvo, userId);
        System.out.println(partner);
        mav.addObject("pVO", pvo);
        mav.addObject("partner", partner);
        mav.setViewName("chat/chatPartner");
        return mav;
    }

    @RequestMapping("/chat/start")
    public String startChat(@RequestParam("userId") String otherUserId, HttpSession session) throws Exception {
        String currentUserId = (String) session.getAttribute("logId");
        int chatId = chatservice.startChat(currentUserId, otherUserId);
        return "redirect:/chat?chat_id=" + chatId + "&other_user_id=" + otherUserId + "&from_id=" + currentUserId;
    }

    @PostMapping("/chat/reportMessage")
    public ResponseEntity<?> reportMessage(@RequestParam("msg_id") int msgId, HttpSession session) {
        String userId = (String) session.getAttribute("logId");
        try {
            chatservice.reportMessage(userId, msgId);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error reporting message");
        }
    }

    @PostMapping("/chat/saveMessage")
    public ResponseEntity<?> saveMessageToMypage(@RequestParam("msg_id") int msgId, HttpSession session) {
        String userId = (String) session.getAttribute("logId");
        System.out.println(7);
        try {
            System.out.println(8);
            chatservice.saveMessageToMypage(userId, msgId);
            System.out.println(9);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            System.out.println(10);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error reporting message");
        }
    }

    @PostMapping("/follow")
    public ResponseEntity<?> followUser(@RequestParam String userId, @RequestParam String otherId) {
        try {
            chatservice.addFriend(otherId, userId);
            return ResponseEntity.ok("Followed successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error following user");
        }
    }

    @PostMapping("/block")
    public ResponseEntity<?> blockUser(@RequestBody BlockRequest blockRequest) {
        System.out.println(blockRequest);
        try {
            chatservice.blockUserAndUpdateChat(blockRequest);
            System.out.println("7");
            return ResponseEntity.ok("User blocked and chat updated successfully");
        } catch (Exception e) {
            System.out.println("8");
            return ResponseEntity.badRequest().body("Error in blocking user or updating chat");
        }
    }
}