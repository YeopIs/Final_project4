package com.finalproject.team4.shouldbe.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AdminMemberVO {
    private int suspended_id;
    private String profile_img;
    private String user_name;
    private String user_id;
    private String time;
    private int posts_count;
    private int comments_count;
    private int count_report;
    private String reason;
    private String suspended_period;
    private String withdrawn_time;
    private Date suspended_time;
}
