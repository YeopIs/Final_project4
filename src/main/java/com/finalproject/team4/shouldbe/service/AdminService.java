package com.finalproject.team4.shouldbe.service;

import com.finalproject.team4.shouldbe.vo.*;

import java.util.List;

public interface AdminService {
    //대시보드=====================================================
    List<DashboardVO> getMonthlyVisitorStats();
    List<DashboardVO> countUsersByNation();
    List<BoardVO> latestBoard();
    List<BoardReplyVO> latestReply();
    //현재회원관리=====================================================
    int totalMemberRecord();
    List<AdminMemberVO> adminMemberList(PagingVO pvo);
    int postsCount(String user_id);
    int commentsCount(String user_id);

    //정지회원관리======================================================
    int totalSuspendedMemberRecord();
    List<AdminMemberVO> adminSuspendedList(PagingVO pvo);

    //정지회원관리_정지버튼
    int suspendInsert(String user_id,int time,String reason);
    //정지회원관리_정지해제버튼
    int suspendDelete(int suspended_id);

    //탈퇴회원관리======================================================
    int totalWithdrawnMemberRecord();
    List<AdminMemberVO> adminWithdrawnList(PagingVO pvo);
    AdminMemberVO adminWithdrawnListUsers(String user_id);
    void withdrawExpiredUsers();
    void deleteUserById(String userId);
    //게시글관리======================================================
    int totalBoardRecord();
    List<BoardReportVO> getBoardReportList(PagingVO pvo);
    BoardReportVO getPostsVO( int post_id);
    //게시글관리_보드삭제 버튼
    void boardReportDelete(int report_id);
    //댓글관리======================================================
    int totalReplyRecord();
    List<AdminCommentReportVO> getReplyList_admin(PagingVO pvo);
    AdminCommentReportVO commentContent(int comment_id);
    void commentDelete(int comment_id);
    void commentReportDelete(int reportId);
    //퀴즈관리======================================================
    List<QuizVO> quizlist(int level);
    QuizVO quiz_table(int quiz_id);
    //퀴즈관리_퀴즈등록페이지버튼
    int quizInsert(String quiz_content,int level);
    int selectQuizId(String quiz_content);
    int answerInsert(int quiz_id, String answer, String answer_lang);
    //퀴즈관리_등록된 answer 삭제 버튼
    int answerDelete(String answer);
    //퀴즈관리_등록된 quiz 삭제 버튼======================================================
    int quizDelete(int quiz_id);
    //퀴즈관리_유저퀴즈등록버튼
    //퀴즈관리_등록된 퀴즈 리스트
    List<QuizVO> editlist(int quiz_id);
    //채팅관리======================================================
    int totalMessageRecord();
    List<AdminChatVO> adminChatList(PagingVO pvo);
    void messageReportDelete(int report_id);
    void messageReportDelete2(int messageReportId);

    //List<BoardVO> getBoardList_admin(PagingVO pvo);
    //List<MessageVO> getMessageList_admin(PagingVO pvo);
    //List<UserVO> getMemberList_admin(PagingVO pvo);




}
