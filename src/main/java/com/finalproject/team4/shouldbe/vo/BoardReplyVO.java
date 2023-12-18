package com.finalproject.team4.shouldbe.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardReplyVO {
    private int comment_id;
    private String writer;
    private int post_id;
    private String content;
    private int like;
    private String write_date;
    private String email;
    private int is_deleted;
    private String board_cat;
    private String title;
    private int depth;
    private int target_parent;
    private int myLike;

    /*
    private int comment_report_id;
    private String user_id;
    private int comment_id;
    private String report_time;

    //comment에서
    private String content;
    private String board_cat;
    private String title;
     */
}
