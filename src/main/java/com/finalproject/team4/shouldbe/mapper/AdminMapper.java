package com.finalproject.team4.shouldbe.mapper;

import com.finalproject.team4.shouldbe.vo.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AdminMapper {
    //대시보드=====================================================
    List<DashboardVO> monthVisitor();
    List<DashboardVO> countUsersByNation();
    List<BoardVO> latestBoard();
    List<BoardReplyVO> latestReply();
    //현재회원관리=====================================================
    int countMember();
    List<AdminMemberVO> adminMemberList(@Param("pvo") PagingVO pvo);
    int postsCount(String user_id);


    //정지회원관리======================================================
    int countSuspendedMember();
    List<AdminMemberVO> adminSuspendedList(@Param("pvo") PagingVO pvo);


    //정지회원관리_정지버튼======================================================
    int suspendInsert(String user_id,int time,String reason);
    //정지회원관리_정지해제버튼
    int suspendDelete(int suspended_id);


    //탈퇴회원관리======================================================
    int countWithdrawnMember();
    List<AdminMemberVO> adminWithdrawnList(@Param("pvo") PagingVO pvo);
    AdminMemberVO adminWithdrawnListUsers(String user_id);
    void deleteUserById(String userId);
    void withdrawExpiredUsers();

    //게시글관리======================================================
    int countBoard();
    List<BoardReportVO> getBoardReportList(@Param("pvo") PagingVO pvo);
    BoardReportVO getPostsVO(int post_id);

    //게시글관리_보드삭제 버튼======================================================
    void boardReportDelete(int report_id);

    //댓글관리======================================================
    int countBoardReply();
    List<AdminCommentReportVO> selectBoardReply(@Param("pvo") PagingVO pvo);
    AdminCommentReportVO commentContent(int comment_id);
    void commentDelete(int comment_id);
    void commentReportDelete(int report_id);

    //퀴즈관리======================================================
    List<QuizVO> quizlist(int level);
    QuizVO quiz_table(int quiz_id);


    //퀴즈관리_퀴즈등록페이지버튼======================================================
    int quizInsert(String quiz_content,int level);
    int selectQuizId(String quiz_content);
    int answerInsert(int quiz_id,String answer,String answer_lang);

    //퀴즈관리_등록된 answer 삭제 버튼======================================================
    int answerDelete(String answer);
    //퀴즈관리_등록된 quiz 삭제 버튼======================================================
    int quizDelete(int quiz_id);

    //퀴즈관리_유저퀴즈등록버튼======================================================
    //퀴즈관리_등록된 퀴즈 리스트======================================================
    List<QuizVO> editlist(int quiz_id);



    //채팅관리======================================================
    int countMessage();
    List<AdminChatVO> adminChatList(@Param("pvo") PagingVO pvo);
    void messageReportDelete(int report_id);

    void messageReportDelete2(int messageReportId);

    String selectUserIdForMessageReport(int messageReportId);

    void decrementCountReport(String userId);

    String selectUserIdForCommentReport(int reportId);

    String selectUserIdForBoardReport(int reportId);




    /*
    int commentsCount(String user_id);
    List<BoardVO> selectBoard(@Param("pvo") PagingVO pvo);
    List<MessageVO> selectMessage(@Param("pvo") PagingVO pvo);
    List<UserVO> selectMember(@Param("pvo") PagingVO pvo);
    */





}
