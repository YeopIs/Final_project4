package com.finalproject.team4.shouldbe.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginVO {
    private String salt;
    private String password;
    private String user_name;
    private int withdraw;
    private Date suspended_time;
    private int suspended_period;
}
