package com.finalproject.team4.shouldbe.service;

import com.finalproject.team4.shouldbe.vo.BoardReplyVO;

import java.util.List;

public interface ReplyService {

    public List<BoardReplyVO> replyList(int post_id, String logId);
    public int addReply(BoardReplyVO rVO);
    public BoardReplyVO selectReply(int post_id, int comment_id);
    public int deleteReply(int post_id, int comment_id);
    public int report(int comment_id, String user_id);
    public int like(int comment_id, String user_id);
    public void decreaseLike(int comment_id, String user_id);
    public void increaseLike(int comment_id, String user_id);
    public boolean updateComment(int postId, int commentId, String userId, String content);
    public boolean addReplyReply(int postId, int commentId, String userId, String content);
}
