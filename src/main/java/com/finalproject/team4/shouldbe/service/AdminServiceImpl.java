package com.finalproject.team4.shouldbe.service;

import com.finalproject.team4.shouldbe.mapper.AdminMapper;
import com.finalproject.team4.shouldbe.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminMapper mapper;


    //대시보드
    @Override
    public List<DashboardVO> getMonthlyVisitorStats() {
        return mapper.monthVisitor();
    }
    @Override
    public List<DashboardVO> countUsersByNation() {
        return mapper.countUsersByNation();
    }
    @Override
    public List<BoardVO> latestBoard() {
        return mapper.latestBoard();
    }
    @Override
    public List<BoardReplyVO> latestReply() {
        return mapper.latestReply();
    }
    //현재회원관리=====================================================
    @Override
    public int totalMemberRecord() {
        return mapper.countMember();
    }
    @Override
    public List<AdminMemberVO> adminMemberList(PagingVO pvo) {
        return mapper.adminMemberList(pvo);
    }
    @Override
    public int postsCount(String user_id){return mapper.postsCount(user_id);}
    @Override
    public int commentsCount(String user_id){return mapper.postsCount(user_id);}


    //정지회원관리======================================================
    @Override
    public int totalSuspendedMemberRecord() {
        return mapper.countSuspendedMember();
    }
    @Override
    public List<AdminMemberVO> adminSuspendedList(PagingVO pvo) {
        return mapper.adminSuspendedList(pvo);
    }


    //정지회원관리_정지버튼======================================================
    @Override
    public int suspendInsert(String user_id,int time,String reason){return mapper.suspendInsert(user_id,time,reason);}
    //정지회원관리_정지해제버튼
    @Override
    public int suspendDelete(int suspended_id){return mapper.suspendDelete(suspended_id);}


    //탈퇴회원관리======================================================
    @Override
    public int totalWithdrawnMemberRecord() {
        return mapper.countWithdrawnMember();
    }
    @Override
    public List<AdminMemberVO> adminWithdrawnList(PagingVO pvo) {
        return mapper.adminWithdrawnList(pvo);
    }
    public AdminMemberVO adminWithdrawnListUsers(String user_id){return mapper.adminWithdrawnListUsers(user_id);}
    @Override
    @Transactional
    public void withdrawExpiredUsers() {
        mapper.withdrawExpiredUsers();
    }
    @Override
    @Transactional
    public void deleteUserById(String userId) {
        mapper.deleteUserById(userId);
    }
    //게시글관리======================================================
    @Override
    public int totalBoardRecord() {
        return mapper.countBoard();
    }
    @Override
    public List<BoardReportVO> getBoardReportList(PagingVO pvo){return mapper.getBoardReportList(pvo);}
    @Override
    public BoardReportVO getPostsVO( int post_id){return mapper.getPostsVO(post_id);}
    @Override
    public void boardReportDelete(int report_id){
        String userId = mapper.selectUserIdForBoardReport(report_id);
        mapper.boardReportDelete(report_id);
        mapper.decrementCountReport(userId);
    }


    //댓글관리======================================================
    @Override
    public int totalReplyRecord() {
        return mapper.countBoardReply();
    }
    @Override
    public List<AdminCommentReportVO> getReplyList_admin(PagingVO pvo) {
        return mapper.selectBoardReply(pvo);
    }
    @Override
    public AdminCommentReportVO commentContent(int comment_id){return mapper.commentContent(comment_id);}
    @Override
    public void commentDelete(int comment_id){
        mapper.commentDelete(comment_id);
    }
    @Override
    public void commentReportDelete(int reportId){
        String userId = mapper.selectUserIdForCommentReport(reportId);
        mapper.commentReportDelete(reportId);
        mapper.decrementCountReport(userId);
    }
    //퀴즈관리======================================================
    @Override
    public List<QuizVO> quizlist(int level){return mapper.quizlist(level);}


    //퀴즈관리_퀴즈등록페이지버튼======================================================
    @Override
    public int quizInsert(String quiz_content,int level){return mapper.quizInsert(quiz_content,level);}
    @Override
    public int selectQuizId(String quiz_content){return mapper.selectQuizId(quiz_content);}
    @Override
    public  int answerInsert(int quiz_id, String answer, String answer_lang){return mapper.answerInsert(quiz_id,answer, answer_lang);}


    //퀴즈관리_등록된 퀴즈 삭제 버튼
    @Override
    public int answerDelete(String answer){return mapper.answerDelete(answer);}

    //퀴즈관리_등록된 quiz 삭제 버튼======================================================
    @Override
    public int quizDelete(int quiz_id){return mapper.quizDelete(quiz_id);}
    @Override
    public QuizVO quiz_table(int quiz_id){return mapper.quiz_table(quiz_id);}

    //퀴즈관리_유저퀴즈등록버튼======================================================
    //퀴즈관리_등록된 퀴즈 리스트======================================================
    @Override
    public List<QuizVO> editlist(int quiz_id){return mapper.editlist(quiz_id);}


    //채팅관리======================================================
    @Override
    public int totalMessageRecord() {
        return mapper.countMessage();
    }
    @Override
    public List<AdminChatVO> adminChatList(PagingVO pvo) {
        return mapper.adminChatList(pvo);
    }
    @Override
    public void messageReportDelete(int report_id){
        mapper.messageReportDelete(report_id);
    }

    @Override
    public void messageReportDelete2(int messageReportId){
        String userId = mapper.selectUserIdForMessageReport(messageReportId);
        mapper.messageReportDelete2(messageReportId);
        mapper.decrementCountReport(userId);
    }

   /* @Override
   public List<BoardVO> getBoardList_admin(PagingVO pvo) {
        return mapper.selectBoard(pvo);
    }
        @Override
    public List<MessageVO> getMessageList_admin(PagingVO pvo) {
        return mapper.selectMessage(pvo);
    }



    @Override
    public List<UserVO> getMemberList_admin(PagingVO pvo) {
        return mapper.selectMember(pvo);
    }

    */






}
