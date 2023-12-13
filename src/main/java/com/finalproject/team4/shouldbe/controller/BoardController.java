package com.finalproject.team4.shouldbe.controller;

import com.finalproject.team4.shouldbe.service.BoardService;
import com.finalproject.team4.shouldbe.util.UriUtil;
import com.finalproject.team4.shouldbe.vo.BoardVO;
import com.finalproject.team4.shouldbe.vo.PagingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BoardController {
    @Autowired
    BoardService boardService;

    private String getUri(PagingVO pVO) {
        int page = pVO.getNowPage();
        String searchType = pVO.getSearchKey();
        String keyword = pVO.getSearchWord();
        String category = pVO.getBoard_cat(); // Fetch category info
        String postSort = pVO.getPostSort(); // Fetch sort option

        return UriUtil.makeSearch(page, searchType, keyword, category, postSort);
    }

    @GetMapping({"/board/free", "/board/notice", "/board/inquiries"})
    public ModelAndView board(HttpServletRequest request, PagingVO pVO) {
        //System.out.println("before : "+ pVO);
        ModelAndView mav = new ModelAndView();
        var boardCat = parseCategory(request.getRequestURI());
        //board category setting
        pVO.setBoard_cat(boardCat);
        //총레코드 수
        pVO.setTotalRecord(boardService.totalRecord(pVO));
        //DB선택(page, 검색)
        List<BoardVO> list = boardService.boardPageList(pVO);
        mav.addObject("list", list);
        mav.addObject("pVO", pVO);
        mav.setViewName("board/board_list");
        return mav;
    }

    @GetMapping({"/board/free/write", "/board/notice/write", "/board/inquiries/write"})
    public ModelAndView write(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        var boardCat = parseCategory(request.getRequestURI());
        mav.setViewName("board/board_write");
        mav.addObject("category", boardCat);
        return mav;
    }

    @PostMapping({"/board/free/writeOk", "/board/notice/writeOk", "/board/inquiries/writeOk"})
    public String writeOk(HttpServletRequest request, HttpSession session, BoardVO bVO) {
        var boardCat = parseCategory(request.getRequestURI());
        bVO.setBoard_cat(boardCat);
        //특수문자 처리용 escape
        String content = bVO.getContent();
        var replaced = content.replace("\n", "<br>");
        bVO.setTitle(HtmlUtils.htmlEscape(bVO.getTitle()));
        bVO.setContent(HtmlUtils.htmlEscape(replaced));
        bVO.setUser_id((String) session.getAttribute("logId"));
        int result = boardService.boardInsert(bVO);
        //System.out.println("result : " + result);
        return "redirect:/board/" + boardCat;

    }


    @GetMapping({"/board/free/view", "board/notice/view", "board/inquiries/view"})
    public ModelAndView view(int no, String searchKey, String searchWord, HttpServletRequest request) {
        var cat = parseCategory(request.getRequestURI());
        String listUrl;
        if (searchKey != null && !searchKey.isEmpty()) {
            listUrl = "/board/" + cat + "?searchKey=" + searchKey + "&searchWord=" + searchWord;
        } else {
            listUrl = "/board/" + cat;
        }
        ModelAndView mav = new ModelAndView();
        try {
            //조회수 증가
            boardService.viewCount(no);

            //게시글 데이터
            var bVO = boardService.boardSelect(no);
            bVO.setTitle(HtmlUtils.htmlUnescape(bVO.getTitle()));
            bVO.setContent(HtmlUtils.htmlUnescape(bVO.getContent()));
            mav.setViewName("/board/board_view");
            mav.addObject("bVO", bVO);
            mav.addObject("listUrl", listUrl);

            return mav;
        }
        catch (NullPointerException ex) {
            mav.setViewName("redirect:/board/notice");
            return mav;
        }
    }


    @GetMapping({"/board/free/edit", "/board/notice/edit", "/board/inquiries/edit"})
    public ModelAndView edit(int no, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        var vo = boardService.boardSelect(no);
        //작성자 맞는지 체크
        if (vo.getUser_id().equals(session.getAttribute("logId"))) {
            vo.setTitle(HtmlUtils.htmlUnescape(vo.getTitle()));
            vo.setContent(HtmlUtils.htmlUnescape(vo.getContent()));
            mav.addObject("vo", vo);
            mav.setViewName("board/board_edit");
            //System.out.println();
            return mav;
        }
        return null;

    }

    @PostMapping({"/board/free/editOk", "/board/notice/editOk", "/board/inquiries/editOk"})
    public ModelAndView editOk(HttpServletRequest request, BoardVO bVO) {
        ModelAndView mav = new ModelAndView();
        var cat = parseCategory(request.getRequestURI());

        var result = boardService.boardUpdate(bVO);

        if (result > 0) {
            mav.setViewName("redirect:/board/" + cat + "/view?no=" + bVO.getPost_id());
        }
        return mav;
    }

    @GetMapping({"/board/free/delete", "/board/notice/delete", "/board/inquiries/delete"})
    @ResponseBody
    public ModelAndView delete(HttpSession session, HttpServletRequest request, int no) {
        var cat = parseCategory(request.getRequestURI());

        var mav = new ModelAndView();
        var id = (String) session.getAttribute("logId");

        //작성자 일치하면
        if (id.equals(boardService.boardSelect(no).getUser_id())) {
            //삭제성공
            boardService.boardDelete(no);
            mav.setViewName("redirect:/board/" + cat);
            return mav;
        }
        //삭제실패
        return null;

    }

    @GetMapping("/board/like/get")
    @ResponseBody
    public int getLike(int no) {
        return boardService.getLike(no);
    }

    @PostMapping("/board/like/increase")
    @ResponseBody
    public Map<String, Object> increaseLike(int no, String user_id) {
        var map = new HashMap<String, Object>();
        int result = boardService.getLikeStatus(no, user_id);
        if (result > 0) {
            map.put("result", false);
            map.put("msg", "이미 추천한 글입니다.");
            return map;
        }
        try {
            result = boardService.increaseLike(no, user_id);
            if (result > 0) {
                map.put("result", true);
                return map;
            }
            map.put("result", false);
            map.put("msg", "db 오류");
            return map;
        } catch (Exception e) {
            map.put("result", false);
            map.put("msg", "로그인 이후에 이용해주세요!");
            return map;
        }


    }
    @PostMapping("/board/report")
    @ResponseBody
    public Map<String, Object> report(@RequestParam("no") int no, @RequestParam("user_id") String user_id) {
        var map = new HashMap<String, Object>();
        try {
            if (boardService.getReport(no, user_id) != 0) {
                map.put("result", false);
                map.put("msg", "이미 신고되었습니다!");
                return map;
            }
            int result = boardService.report(no, user_id);
            if (result > 0) {
                map.put("result", true);
                map.put("msg", "신고하였습니다.");
                return map;
            }
        }catch(Exception e){
            e.printStackTrace();
            map.put("result", false);
            map.put("msg", "로그인 이후에 이용해주세요!");
            return map;
        }
        map.put("result", false);
        map.put("msg", "오류");
        return map;
    }


    public String parseCategory(String requestUri) {
        String[] params = requestUri.split("/");
        return params[2];
    }




}
