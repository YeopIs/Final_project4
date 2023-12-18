package com.finalproject.team4.shouldbe.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QuizVO {
    private int quiz_id;
    private int level;
    private String quiz_lang;
    private String quiz_content;
    private String answer;
    private String user_answer;
    private List<String> answer_lang;
    private String answer_create_lang;
    private String quiz_sound;
}
