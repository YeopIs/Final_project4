package com.finalproject.team4.shouldbe.controller;


import com.finalproject.team4.shouldbe.service.ReplyService;
import com.finalproject.team4.shouldbe.vo.BoardReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BoardReplyController {
    @Autowired
    ReplyService replyService;

    @GetMapping("/boardReply/list")
    @ResponseBody
    public List<BoardReplyVO> replyList(int no,HttpSession session){
        //댓글 데이터
        String userId = (String) session.getAttribute("logId");
        if (userId == null || userId.isEmpty()) {
            userId = "not_login";
        }
        var rVOList = replyService.replyList(no,userId);

        System.out.println(rVOList);
        return rVOList;
    }
    @PostMapping("/boardReply/add")
    @ResponseBody
    public Map<String, Object> addReply(HttpSession session, BoardReplyVO rVO){
        System.out.println(rVO);
        var map = new HashMap<String, Object>();
        if("Y".equals((String)session.getAttribute("logStatus"))){
            var id = (String)session.getAttribute("logId");
            rVO.setWriter(id);
            System.out.println(rVO);
            int result = replyService.addReply(rVO);
            if(result>0) {

                map.put("result", true);
                return map;
            }
        }
        map.put("result", false);
        return map;
    }

    @PostMapping("/boardReply/reply")
    @ResponseBody
    public int replyReply(@RequestParam("post_id") int post_id,
                                        @RequestParam("comment_id") int comment_id,
                                        @RequestParam("content") String content,
                                        HttpSession session){
        String userId = (String)session.getAttribute("logId");
        System.out.println(post_id+" "+comment_id+" "+content);
        boolean updateStatus = replyService.addReplyReply(post_id, comment_id, userId, content);
        return 1;
    }

    @PostMapping("/boardReply/delete")
    @ResponseBody
    public Map<String, Object> deleteReply(HttpSession session, int replyNo, int postNo){

        var map = new HashMap<String, Object>();
        var reply = replyService.selectReply(postNo, replyNo);
        if(reply.getWriter().equals(session.getAttribute("logId"))){
            int result = replyService.deleteReply(postNo, replyNo);
            if(result>0) {
                map.put("result", true);
                return map;
            }
        }
        map.put("result", false);
        return map;
    }
    @PostMapping("/boardReply/report")
    @ResponseBody
    public Map<String, Object> report(HttpSession session, String id,int no){
        var map = new HashMap<String, Object>();
        if("Y".equals(session.getAttribute("logStatus"))){
            System.out.println(id+" "+no);
            int result = replyService.report(no, id);
            if(result>0){
                map.put("result", true);
                return map;
            }
            map.put("result", false);
            map.put("msg", "이미 신고되었습니다!");

        }
        map.put("result", false);
        map.put("message", "로그인해주세요.");
        return map;
    }

    @PostMapping("/boardReply/like")
    @ResponseBody
    public Map<String, Object> like(HttpSession session, int no){
        var map = new HashMap<String, Object>();
        if("Y".equals(session.getAttribute("logStatus"))){
            var id = (String)session.getAttribute("logId");
            int result = replyService.like(no, id);
            if(result==0){
                replyService.increaseLike(no,id);
                map.put("result", true);
                map.put("msg","좋아요를 눌렀습니다!");
                return map;
            } else {
                replyService.decreaseLike(no, id);
                map.put("result", false);
                map.put("msg", "좋아요를 취소했습니다!");
                return map;
            }
        }
        map.put("result", false);
        map.put("message", "로그인해주세요.");
        return map;
    }

    @PostMapping("/boardReply/edit")
    public ResponseEntity<?> editComment(@RequestParam("post_id") int post_id,
                                         @RequestParam("comment_id") int comment_id,
                                         @RequestParam("content") String content,
                                         HttpSession session) {
        // Retrieve the user ID from the session
        String userId = (String)session.getAttribute("logId");
        System.out.println(post_id+" "+comment_id+" "+content);
        // Call the service method to update the comment
        boolean updateStatus = replyService.updateComment(post_id, comment_id, userId, content);

        if(updateStatus) {
            return ResponseEntity.ok("Comment updated successfully");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating comment");
        }
    }
}
