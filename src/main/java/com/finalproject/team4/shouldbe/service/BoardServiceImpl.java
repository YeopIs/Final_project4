package com.finalproject.team4.shouldbe.service;

import com.finalproject.team4.shouldbe.mapper.BoardMapper;
import com.finalproject.team4.shouldbe.mapper.ChatMapper;
import com.finalproject.team4.shouldbe.vo.BoardVO;
import com.finalproject.team4.shouldbe.vo.PagingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    BoardMapper Mapper;

    @Autowired
    ChatMapper chatMapper;

    @Override
    public int boardInsert(BoardVO vo) {
        return Mapper.boardInsert(vo);
    }

    @Override
    public List<BoardVO> boardPageList(PagingVO pVO) {
        return Mapper.boardPageList(pVO);
    }

    @Override
    public Map<String, Object> totalRecord(PagingVO pVO) {
        return Mapper.totalRecord(pVO);
    }

    @Override
    public BoardVO boardSelect(int post_id, String userId) {
        return Mapper.boardSelect(post_id,userId);
    }

    @Override
    public void viewCount(int post_id) {
        Mapper.viewCount(post_id);
    }

    @Override
    public int boardUpdate(BoardVO vo) {
        return Mapper.boardUpdate(vo);
    }

    @Override
    public int boardDelete(int post_id) {
        return Mapper.boardDelete(post_id);
    }

    @Override
    public int increaseLike(int post_id, String user_id) {
       return Mapper.increaseLike(post_id, user_id);
    }
    @Override
    public void decreaseLike(int post_id, String user_id) {
        Mapper.decreaseLike(post_id, user_id);
    }
    @Override
    public int getLikeStatus(int post_id, String user_id) {
        return Mapper.getLikeStatus(post_id, user_id);
    }

    @Override
    public int getLike(int post_id) {
        return Mapper.getLike(post_id);
    }

    @Override
    public int report(int post_id, String userId) {
        chatMapper.updateUserReport(userId);
        return Mapper.report(post_id, userId);
    }

    @Override
    public int getReport(int no, String userId) {
        return Mapper.getReport(no, userId);

    }
}
