package com.finalproject.team4.shouldbe.service;

import com.finalproject.team4.shouldbe.mapper.ChatMapper;
import com.finalproject.team4.shouldbe.mapper.ReplyMapper;
import com.finalproject.team4.shouldbe.vo.BoardReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyServiceImpl implements ReplyService {
    @Autowired
    ReplyMapper mapper;
    @Autowired
    ChatMapper chatMapper;

    @Override
    public List<BoardReplyVO> replyList(int post_id) {
        return mapper.replyList(post_id);
    }

    @Override
    public int addReply(BoardReplyVO rVO) {
        return mapper.addReply(rVO);
    }

    @Override
    public BoardReplyVO selectReply(int post_id, int comment_id) {
        return mapper.selectReply(post_id, comment_id);
    }

    @Override
    public int deleteReply(int post_id, int comment_id) {
        return mapper.deleteReply(post_id, comment_id);
    }

    @Override
    public int report(int comment_id, String user_id) {
        chatMapper.updateUserReport(user_id);
        return mapper.report(comment_id, user_id);
    }

    @Override
    public int like(int comment_id, String user_id) {
        return mapper.like(comment_id, user_id);
    }

    @Override
    public boolean updateComment(int postId, int commentId, String userId, String content) {
        try {
            mapper.updateComment(postId, commentId, userId, content);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
