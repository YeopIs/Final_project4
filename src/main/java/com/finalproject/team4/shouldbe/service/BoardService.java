package com.finalproject.team4.shouldbe.service;

import com.finalproject.team4.shouldbe.vo.BoardVO;
import com.finalproject.team4.shouldbe.vo.PagingVO;

import java.util.List;
import java.util.Map;

public interface BoardService {
    public int boardInsert(BoardVO vo);

    public List<BoardVO> boardPageList(PagingVO pVO);

    public Map<String, Object> totalRecord(PagingVO pVO);

    public BoardVO boardSelect(int post_id, String userId);

    public void viewCount(int post_id);

    public int boardUpdate(BoardVO vo);

    public int boardDelete(int post_id);
    public int increaseLike(int post_id, String user_id);
    public int getLikeStatus(int post_id, String user_id);
    public int getLike(int post_id);

    public int report(int no, String userId);
    public int getReport(int no, String userId);

    void decreaseLike(int no, String userId);
}
