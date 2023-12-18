package com.finalproject.team4.shouldbe.mapper;

import com.finalproject.team4.shouldbe.vo.BoardVO;
import com.finalproject.team4.shouldbe.vo.PagingVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface BoardMapper {
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
    public int report(int post_id, String user_id);
    public int getReport(int post_id, String user_id);

    void decreaseLike(int postId, String userId);
}
