package com.finalproject.team4.shouldbe.controller;

import com.finalproject.team4.shouldbe.service.ChatService;
import com.finalproject.team4.shouldbe.service.MypageService;
import com.finalproject.team4.shouldbe.util.EncryptUtil;
import com.finalproject.team4.shouldbe.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpSession;
import java.util.List;



@Controller
public class MypageController {
    @Autowired
    MypageService service;
    @Autowired
    ChatService chatservice;
    EncryptUtil encrypt = new EncryptUtil();

    @GetMapping("/mypage")
    public ModelAndView mypage(HttpSession session){
        ModelAndView mav = new ModelAndView();
        if(session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/login");
            return mav;
        }
        String userid = (String) session.getAttribute("logId");
        MypageVO myvo = service.mypage_info(userid);
        System.out.println(myvo);

        mav.addObject("myvo", myvo);
        mav.setViewName("mypage/mypage");
        return mav;
    }


    // 마이페이지 프로필
    @GetMapping("/mypage/change_user")
    public ModelAndView mypage_change_user(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if (session.getAttribute("logStatus") != "Y") {
            mav.setViewName("redirect:/login");
            return mav;
        }
        String userid = (String) session.getAttribute("logId");
        MypageVO myvo = service.mypage_info(userid);
        System.out.println(myvo.toString());
        mav.addObject("myvo", myvo);
        mav.setViewName("mypage/change_user");

        return mav;
    }

    // 프로필 수정
    @PostMapping("/mypage/editProfileOk")
    public String mypageEdit(MypageVO vo, @RequestParam("user_id") String user_id, @RequestParam("password") String password, @RequestParam("now_password") String now_password, RedirectAttributes redirect) {
        MypageVO mVo = service.mypage_info(user_id);
        if (mVo == null) {
            return "redirect:/mypage/change_user";
        }
        if (! encrypt.encrypt(now_password, mVo.getSalt()).equals(mVo.getPassword())) {
            System.out.println("1");
            redirect.addFlashAttribute("result", "회원수정 실패, 비밀번호를 확인해주세요!");
            return "mypage/mypage_editResult";
        } else if (encrypt.encrypt(password, mVo.getSalt()).equals(mVo.getPassword())) {
            System.out.println("2");
            redirect.addFlashAttribute("result", "회원수정 실패, 기존 비밀번호와 동일합니다!");
            return "mypage/mypage_editResult";
        }
        System.out.println("3");
        vo.setPassword(encrypt.encrypt(password,mVo.getSalt()));
        service.mypage_edit(vo);
        redirect.addFlashAttribute("result", "회원수정가 수정되었습니다!");
        return "redirect:/mypage/change_user";
    }

    // 친구목록
    @GetMapping("/mypage/friend_user")
    public ModelAndView mypage_friend_user(HttpSession session, @RequestParam(required = false, defaultValue = "1") int page) {
        ModelAndView mav = new ModelAndView();
        if(session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/login");
            return mav;
        }
        String followed_user_id = (String) session.getAttribute("logId");

        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(service.countfriendList(followed_user_id));

        List<FriendVO> flist = service.friendList(pvo, followed_user_id);
        System.out.println(flist);
        for(int i=0;i< flist.size();i++) {
            FriendVO fvo = service.selectChatId(followed_user_id, flist.get(i).getFollowing_user_id());
            if (fvo != null) {
                flist.get(i).setChat_id(fvo.getChat_id());
                flist.get(i).setFrom_id(fvo.getFrom_id());
                flist.get(i).setTo_id(fvo.getTo_id());
            } else {
                flist.get(i).setChat_id(0);
                flist.get(i).setFrom_id("null");
                flist.get(i).setTo_id("null");
            }
        }
        System.out.println(flist);
        mav.addObject("myId", followed_user_id);
        mav.addObject("pVO", pvo);
        mav.addObject("flist", flist);
        mav.setViewName("mypage/friend_user");
        return mav;
    }

    // 친구삭제
    @GetMapping("/mypage/deletefriend")
    @ResponseBody
    public String friendDelete(String followed_user_id, String following_user_id) {
        return service.friendDelete(followed_user_id, following_user_id) + "";
    }

    // 차단목록
    @GetMapping("/mypage/blockList")
    public ModelAndView mypage_blocklist(HttpSession session, @RequestParam(required = false, defaultValue = "1") int page) {
        ModelAndView mav = new ModelAndView();
        if(session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/login");
            return mav;
        }
        String user_id = (String) session.getAttribute("logId");

        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(service.countblockList(user_id));

        List<BlockVO> blist = service.blockList(pvo, user_id);

        mav.addObject("pVO", pvo);
        mav.addObject("blist", blist);
        mav.setViewName("mypage/blocklist_user");

        return mav;
    }

    // 차단 해제
    @GetMapping("/mypage/unlock")
    @ResponseBody
    public String unlock(@RequestParam("block_id") String block_id, @RequestParam("user_id") String user_id) {
        return service.block_id_unlock(block_id, user_id) + "";
    }

    // 게시글
    @GetMapping("/mypage/post_user")
    public ModelAndView mypage_post_user(HttpSession session, @RequestParam(required = false, defaultValue = "1") int page) {
        ModelAndView mav = new ModelAndView();
        if(session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/login");
            return mav;
        }
        String user_id = (String) session.getAttribute("logId");

        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(service.countBoard(user_id));
        
        List<BoardVO> list = service.mypage_post_board(pvo, user_id);
        
        mav.addObject("pVO", pvo);
        mav.addObject("list", list);
        mav.setViewName("mypage/post_user");
        return mav;
    }

    // 댓글
    @GetMapping("/mypage/post_user/reply")
    public ModelAndView mypage_post_user_reply(HttpSession session, @RequestParam(required = false, defaultValue = "1") int page) {
        ModelAndView mav = new ModelAndView();
        if(session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/login");
            return mav;
        }
        String user_id = (String) session.getAttribute("logId");
        
        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(service.countReply(user_id));

        List<BoardReplyVO> list = service.mypage_post_board_reply(pvo, user_id);
        
        mav.addObject("pVO", pvo);
        mav.addObject("list", list);
        mav.setViewName("mypage/post_user_reply");
        return mav;
    }

    // 회원탈퇴
    @GetMapping("/mypage/withdraw_user")
    public String mypage_withdraw_user(HttpSession session) {
        if(session.getAttribute("logStatus") != "Y"){
            return "redirect:/login";
        }
        return "mypage/withdraw_user";
    }

    // 회원탈퇴
    @GetMapping("/mypage/withdrawOk")
    public String withdrawOk(@RequestParam("user_id") String user_id, @RequestParam("password") String password, RedirectAttributes redirect, HttpSession session) {
        MypageVO mVo = service.mypage_info(user_id);
        System.out.println(mVo.toString());

        if (mVo == null) {
            return "redirect:/mypage/withdraw_user";
        } else if (encrypt.encrypt(password, mVo.getSalt()).equals(mVo.getPassword())) {
            int result = service.withdraw_user_date(user_id);
            int wresult = service.withdraw_user(user_id);
            session.invalidate();
            return "redirect:/";
        }

        redirect.addFlashAttribute("result", "회원탈퇴 실패, 비밀번호를 확인해주세요!");
        return "redirect:/mypage/withdraw_user";
    }

    // 저장소
    @GetMapping("/mypage/save_chat")
    public ModelAndView saveChat(HttpSession session, @RequestParam(required = false, defaultValue = "1") int page) {
        ModelAndView mav = new ModelAndView("mypage/save_user");
        if(session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/login");
            return mav;
        }
        String userId = (String) session.getAttribute("logId");
        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(service.totalRecord(userId));
        List<SaveMessageVO> saveMessages = service.getSaveMessageList(pvo, userId);
        System.out.println(saveMessages);
        mav.addObject("saveMessages", saveMessages);
        mav.addObject("pVO", pvo);

        return mav;
    }

    @PostMapping("/mypage/save_chat/delete")
    public String deleteSavedChat(@RequestParam("msg_id") int msgId, HttpSession session, RedirectAttributes redirectAttributes) {
        String userId = (String) session.getAttribute("logId");
        boolean success = service.deleteSavedMsg(msgId, userId);
        redirectAttributes.addFlashAttribute("deleteSuccess", success);
        return "redirect:/mypage/save_chat";
    }

    @GetMapping("/mypage/save_quiz")
    public ModelAndView saveQuiz(HttpSession session, @RequestParam(required = false, defaultValue = "1") int page) {
        ModelAndView mav = new ModelAndView("mypage/save_quiz");
        if(session.getAttribute("logStatus") != "Y"){
            mav.setViewName("redirect:/login");
            return mav;
        }
        String userId = (String) session.getAttribute("logId");
        PagingVO pvo = new PagingVO();
        pvo.setOnePageRecord(10);
        pvo.setNowPage(page);
        pvo.setTotalRecord(service.countSaveQuiz(userId));

        List<SaveQuizVO> saveQuiz = service.selectSaveQuiz(pvo, userId);

        mav.addObject("saveQuiz", saveQuiz);
        mav.addObject("pVO", pvo);

        return mav;
    }

    @PostMapping("/mypage/save_quiz/delete")
    public String deleteSavedQuiz(@RequestParam("quiz_id") int quizId, HttpSession session, RedirectAttributes redirectAttributes) {
        String userId = (String) session.getAttribute("logId");
        boolean success = service.deleteSavedQuiz(quizId, userId);
        redirectAttributes.addFlashAttribute("deleteSuccess", success);
        return "redirect:/mypage/save_quiz";
    }

    // 프로필이미지
    @GetMapping("/mypage/proflieimgChange")
    public String profileimgChange(){
        return "mypage/change_profileimg";
    }

    @PostMapping("/mypage/basicimg")
    @ResponseBody
    public String basicImg(MypageVO mVO, HttpSession session){
        mVO.setUser_id((String)session.getAttribute("logId"));
        mVO.setProfile_img("user.png");
        return service.change_basic_profileimg(mVO)+"";
    }

    @PostMapping("/mypage/profileimgChangeOk")
    @ResponseBody
    public String profileimgChangeOk(@RequestParam("filename") MultipartFile file, MypageVO mVO, HttpSession session){
        String user_id = (String)session.getAttribute("logId");
        mVO.setUser_id(user_id);

        String path = session.getServletContext().getRealPath("/image/profile");
        System.out.println(path);

        String fileName= FileUpload.fileUpload(path, file);
        System.out.println(fileName);
        mVO.setProfile_img(fileName);
        
        return service.change_profileimg(mVO)+"";
    }
}