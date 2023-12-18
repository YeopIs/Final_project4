package com.finalproject.team4.shouldbe.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardVO {
    private int post_id; //posts
    private String user_id; //posts
    private String title; //posts
    private String content; //posts
    private int views; //posts
    private String board_cat;//posts
    private String write_date;//posts
    private int likes;
    private int myLike;
}

