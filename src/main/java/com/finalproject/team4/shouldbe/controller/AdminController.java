package com.finalproject.team4.shouldbe.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.finalproject.team4.shouldbe.service.AdminService;
import com.finalproject.team4.shouldbe.service.BoardService;
import com.finalproject.team4.shouldbe.service.UserService;
import com.finalproject.team4.shouldbe.vo.*;
import oracle.jdbc.proxy.annotation.Post;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class AdminController {
    @Autowired
    AdminService service;

    @Autowired
    BoardService boardService;

    @Autowired
    UserService userService;

    //대시보드======================================================
    @GetMapping("/admin")
    public ModelAndView admin(HttpSession session) throws JsonProcessingException {
        ModelAndView mav = new ModelAndView();
        if(! userService.ismanager((String) session.getAttribute("logId"))||session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/");
            return mav;
        }
        ObjectMapper objectMapper = new ObjectMapper();
        mav.addObject("profile_img", session.getAttribute("profile_img"));
        mav.addObject("visitorStats", objectMapper.writeValueAsString(service.getMonthlyVisitorStats()));
        mav.addObject("nationStats", objectMapper.writeValueAsString(service.countUsersByNation()));
        mav.addObject("latestBoards", service.latestBoard());
        mav.addObject("latestReplies", service.latestReply());
        mav.setViewName("admin/admin_dashboard");
        return mav;
    }

    //현재 회원 관리
    @GetMapping("/admin/member/management")
    public ModelAndView GoMember_management(@RequestParam(required = false, defaultValue = "1") int page,
                                            HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if(! userService.ismanager((String) session.getAttribute("logId"))||session.getAttribute("logStatus") != "Y"){
            mav.setViewName("/");
            return mav;
        }
        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(service.totalMemberRecord());
        List<AdminMemberVO> amlist = service.adminMemberList(pvo);
        mav.addObject("amlist", amlist);
        for(int i=0;i<amlist.size();i++){
            String user_id=amlist.get(i).getUser_id();
            amlist.get(i).setPosts_count(service.postsCount(user_id));
            amlist.get(i).setComments_count(service.commentsCount(user_id));
        }
        //List<UserVO> message = service.getMemberList_admin(pvo);
        //mav.addObject("message", message);
        mav.addObject("pVO", pvo);
        mav.setViewName("management/member_management");
        return mav;
    }

    //정지회원관리======================================================
    @GetMapping("/admin/suspended/management")
    public ModelAndView GoSuspended_management(@RequestParam(required = false, defaultValue = "1") int page,
                                               HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if(! userService.ismanager((String) session.getAttribute("logId"))|| session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/");
            return mav;
        }
        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(service.totalSuspendedMemberRecord());
        List<AdminMemberVO> aslist = service.adminSuspendedList(pvo);
        mav.addObject("aslist", aslist);
        mav.addObject("pVO", pvo);
        mav.setViewName("management/suspended_management");
        return mav;
    }
    //정지회원관리_정지버튼
    @PostMapping("/suspend")
    public ModelAndView suspend(String user_id,int time,String reason) {
        ModelAndView mav = new ModelAndView();
        System.out.println(user_id+" "+time+" "+reason);
        int result = service.suspendInsert(user_id,time,reason);
        mav.setViewName("admin/admin_dashboard");
        mav.setViewName("redirect:/admin/suspended/management");
        return mav;
    }
    //정지회원관리_정지해제버튼
    @GetMapping("/suspendDelete")
    public ModelAndView suspendDelete(int suspended_id) {
        ModelAndView mav = new ModelAndView();
        System.out.println(suspended_id);
        int result = service.suspendDelete(suspended_id);
        mav.setViewName("redirect:/admin/suspended/management");
        return mav;
    }

    //탈퇴회원관리======================================================
    @GetMapping("/admin/withdrawn/management")
    public ModelAndView GoWithdrawn_management(@RequestParam(required = false, defaultValue = "1") int page,
                                               HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if(! userService.ismanager((String) session.getAttribute("logId")) || session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/");
            return mav;
        }
        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(service.totalWithdrawnMemberRecord());
        List<AdminMemberVO> awlist = service.adminWithdrawnList(pvo);

        for(int i=0;i<awlist.size();i++){
            String user_id=awlist.get(i).getUser_id();
            AdminMemberVO userVO= service.adminWithdrawnListUsers(user_id);
            awlist.get(i).setProfile_img(userVO.getProfile_img());
            awlist.get(i).setUser_name(userVO.getUser_name());
            awlist.get(i).setCount_report(userVO.getCount_report());
            awlist.get(i).setTime(userVO.getTime());
            awlist.get(i).setPosts_count(service.postsCount(user_id));
            awlist.get(i).setComments_count(service.commentsCount(user_id));
        }
        mav.addObject("awlist", awlist);
        mav.addObject("pVO", pvo);
        mav.setViewName("management/withdrawn_management");
        return mav;
    }

    @GetMapping("/admin/withdrawn/all")
    public ModelAndView withdrawAll() {
        service.withdrawExpiredUsers();
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redirect:/admin");
        return mav;
    }

    @PostMapping("/admin/withdrawn/personal")
    public ModelAndView withdrawPersonal(@RequestParam("userId") String userId) {
        service.deleteUserById(userId);
        ModelAndView mav = new ModelAndView();
        System.out.println(userId);
        mav.setViewName("redirect:/admin");
        return mav;
    }

    //게시글관리======================================================
    @GetMapping("/admin/board")
    public ModelAndView admin_board(@RequestParam(required = false, defaultValue = "1") int page,
                                    HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if(! userService.ismanager((String) session.getAttribute("logId")) || session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/");
            return mav;
        }
        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(service.totalBoardRecord());

        //List<BoardVO> board = service.getBoardReportList(pvo);
        //getBoardList_admin   getBoardReportList
        List<BoardReportVO> board = service.getBoardReportList(pvo);
        System.out.println(board);

        for(int i=0;i<board.size();i++){
            int post_id=board.get(i).getPost_id();
            BoardReportVO postsVO=service.getPostsVO(post_id);
            if (postsVO != null) {
                board.get(i).setTitle(postsVO.getTitle());
                board.get(i).setContent(postsVO.getContent());
                board.get(i).setBoard_cat(postsVO.getBoard_cat());
            }
            else{
                board.get(i).setTitle("삭제된 게시글");
                board.get(i).setContent("삭제된 게시글");
                board.get(i).setBoard_cat("삭제된 게시글");
            }
        }
        mav.addObject("pVO", pvo);
        mav.addObject("board", board);
        mav.addObject("profile_img", session.getAttribute("profile_img"));
        mav.setViewName("admin/admin_board");
        return mav;
    }
    @PostMapping("/suspend/board")
    public ModelAndView suspend_board(String user_id,int time,String reason,int post_id) {
        ModelAndView mav = new ModelAndView();
        System.out.println(user_id+" "+time+" "+reason);
        service.suspendInsert(user_id,time,reason);
        boardService.boardDelete(post_id);
        mav.setViewName("admin/admin_dashboard");
        mav.setViewName("redirect:/admin/suspended/management");
        return mav;
    }
    //게시글관리_보드삭제 버튼
    @GetMapping("/boardDelete")
    public ModelAndView boardDelete(int post_report_id) {
        ModelAndView mav = new ModelAndView();
        System.out.println(post_report_id);
        service.boardReportDelete(post_report_id);
        mav.setViewName("redirect:/admin/board");
        return mav;
    }

    //댓글관리======================================================
    @GetMapping("/admin/reply")
    public ModelAndView admin_reply(@RequestParam(required = false, defaultValue = "1") int page,
                                    HttpSession session) {
        ModelAndView mav = new ModelAndView("admin/admin_reply");
        if(! userService.ismanager((String) session.getAttribute("logId")) || session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/");
            return mav;
        }
        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(service.totalReplyRecord());
        List<AdminCommentReportVO> board = service.getReplyList_admin(pvo);
        for(int i=0;i<board.size();i++){
            AdminCommentReportVO brVO= service.commentContent(board.get(i).getComment_id());
            if (brVO != null) {
                board.get(i).setContent(brVO.getContent());
            }
            else{
                board.get(i).setContent("삭제된 게시글");
            }
        }
        mav.addObject("board", board);
        mav.addObject("pVO", pvo);
        return mav;
    }
    @PostMapping("/suspend/reply")
    public ModelAndView suspend_reply(String user_id,int time,String reason, int comment_id) {
        ModelAndView mav = new ModelAndView();
        System.out.println(user_id+" "+time+" "+reason);
        //boardService.commentReportDelete(comment_id);
        service.commentDelete(comment_id);
        int result = service.suspendInsert(user_id,time,reason);
        mav.setViewName("admin/admin_dashboard");
        mav.setViewName("redirect:/admin/suspended/management");
        return mav;
    }

    //댓글삭제 버튼
    @GetMapping("/commentDelete")
    public ModelAndView commentDelete(int comment_report_id) {
        ModelAndView mav = new ModelAndView();
        service.commentReportDelete(comment_report_id);
        mav.setViewName("redirect:/admin/board");
        return mav;
    }

    //퀴즈관리======================================================
    @GetMapping("/admin/quiz/list")
    public ModelAndView GoQuiz_list(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if(! userService.ismanager((String) session.getAttribute("logId")) || session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/");
            return mav;
        }
        mav.setViewName("quiz_management/quiz_list");
        List<QuizVO> quizlist1=service.quizlist(1);
        List<QuizVO> quizlist2=service.quizlist(2);
        List<QuizVO> quizlist3=service.quizlist(3);
        //System.out.println(quizlist1.toString());
        mav.addObject("quizlist1", quizlist1);
        mav.addObject("quizlist2", quizlist2);
        mav.addObject("quizlist3", quizlist3);
        return mav;
    }

    //퀴즈관리_등록된 퀴즈 리스트
    @GetMapping("/admin/quiz_edit")
    public ModelAndView GoQuiz_edit(int quiz_id, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if(! userService.ismanager((String) session.getAttribute("logId")) || session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/");
            return mav;
        }
        QuizVO qVO=service.quiz_table(quiz_id);
        List<QuizVO> editlist=service.editlist(quiz_id);
        System.out.println(editlist.toString());
        mav.addObject("qVO", qVO);
        mav.addObject("editlist", editlist);
        mav.setViewName("quiz_management/quiz_edit");
        return mav;
    }
    @PostMapping("/quiz/answer_insert")
    public ModelAndView AnswerInsert(String answer,int quiz_id, String answer_lang){
        ModelAndView mav= new ModelAndView();
        System.out.println(answer + answer_lang + quiz_id);
        //System.out.println(answer+quiz_id);
        //int quizInsertResult=service.quizInsert(quiz_content,level);
       // int quiz_id=service.selectQuizId(quiz_content);
        int answerInsertResult=service.answerInsert(quiz_id,answer,answer_lang);
        mav.setViewName("redirect:/admin/quiz_edit?quiz_id="+quiz_id);
        return mav;
    }
    //퀴즈관리_등록된 answer 삭제 버튼
    @GetMapping("/answerDelete")
    public ModelAndView answerDelete(String answer,int quiz_id) {
        ModelAndView mav = new ModelAndView();
        System.out.println(quiz_id);
        int result = service.answerDelete(answer);
        mav.setViewName("redirect:/admin/quiz_edit?quiz_id="+quiz_id);
        return mav;
    }
    //퀴즈관리_등록된 quiz 삭제 버튼
    @GetMapping("/quizDelete")
    public ModelAndView quizDelete(int quiz_id) {
        ModelAndView mav = new ModelAndView();
        int result = service.quizDelete(quiz_id);
        mav.setViewName("redirect:/admin/quiz/list");
        return mav;
    }
    //채팅관리======================================================
    @GetMapping("/admin/chat/management")
    public ModelAndView GoChat_management(@RequestParam(required = false, defaultValue = "1") int page,
                                          HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if(! userService.ismanager((String) session.getAttribute("logId"))){
            mav.setViewName("redirect:/");
            return mav;
        }
        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(service.totalMessageRecord());
        List<AdminChatVO> aclist = service.adminChatList(pvo);
        mav.addObject("aclist", aclist);
        mav.addObject("pVO", pvo);
        mav.setViewName("management/chat_management");
        return mav;
    }
    @PostMapping("/suspend/chat")
    public ModelAndView suspend_chat(String user_id,int time,String reason, int report_id) {
        ModelAndView mav = new ModelAndView();
        System.out.println(user_id+" "+time+" "+reason);
        service.messageReportDelete(report_id);
        int result = service.suspendInsert(user_id,time,reason);
        mav.setViewName("admin/admin_dashboard");
        mav.setViewName("redirect:/admin/suspended/management");
        return mav;
    }

    @GetMapping("/chatDelete")
    public ModelAndView chatDelete(int message_report_id) {
        ModelAndView mav = new ModelAndView();
        service.messageReportDelete2(message_report_id);
        mav.setViewName("redirect:/admin/board");
        return mav;
    }











}