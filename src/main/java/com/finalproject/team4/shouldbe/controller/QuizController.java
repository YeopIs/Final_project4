package com.finalproject.team4.shouldbe.controller;

import com.finalproject.team4.shouldbe.service.QuizService;
import com.finalproject.team4.shouldbe.util.TtsUtil;
import com.finalproject.team4.shouldbe.vo.QuizVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Arrays;


@Controller
public class QuizController {
    @Autowired
    private QuizService quizService;

    @GetMapping("/quiz/main")
    public String quiz_list(HttpSession session) {
        if (!"Y".equals(session.getAttribute("logStatus"))) {
            return "redirect:/login";
        }
        return "/quiz/quiz_main";
    }

    @GetMapping("/quiz/create")
    public String quiz_create(HttpSession session) {
        if (!"Y".equals(session.getAttribute("logStatus"))) {
            return "redirect:/login";
        }
        return "/quiz/quiz_create";
    }

    @PostMapping("/quiz/createOk")
    @ResponseStatus(HttpStatus.CREATED)
    public void quizCreateOk(@RequestBody QuizVO quizVO) {
        quizService.createQuiz(quizVO);
    }

    @GetMapping("/quiz/easy")
    public ModelAndView quiz_easy(HttpServletRequest request, HttpSession session) {
        if (!"Y".equals(request.getSession().getAttribute("logStatus"))) {
            ModelAndView modelAndView = new ModelAndView("redirect:/login");
            return modelAndView;
        }
        String userId = (String) session.getAttribute("userId");
        QuizVO quiz = quizService.selectRandomQuiz(userId, 1);
        String path=TtsUtil.APITTS(quiz.getQuiz_content(),quiz.getQuiz_lang());
        quiz.setQuiz_sound(path);
        System.out.println(quiz);
        ModelAndView modelAndView = new ModelAndView("/quiz/quiz_easy");
        modelAndView.addObject("quiz", quiz);
        return modelAndView;
    }

    @PostMapping("/quiz/checkAnswer")
    public ModelAndView checkAnswer(@RequestParam("quiz_content") String quiz_content,
                                    @RequestParam("user_answer") String user_answer,
                                    @RequestParam("level") int level,
                                    @RequestParam("quiz_lang") String quiz_lang,
                                    @RequestParam("quiz_id") int quiz_id,
                                    HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/quiz/quiz_answer");
        QuizVO quizVO = new QuizVO();
        quizVO.setQuiz_id(quiz_id);
        quizVO.setLevel(level);
        quizVO.setQuiz_lang(quiz_lang);
        quizVO.setQuiz_content(quiz_content);
        quizVO.setUser_answer(user_answer);
        String correctAnswers = quizService.getCorrectAnswers(quiz_id);
        String[] answersArray = correctAnswers.split(",\\s*"); // 쉼표와 공백으로 구분
        boolean isCorrect = Arrays.asList(answersArray).contains(user_answer);
        String result = isCorrect ? "correct" : "incorrect";
        quizVO.setAnswer(correctAnswers);

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("logId");
        quizService.saveQuizAnswer(quiz_id, userId, result);

        mav.addObject("user_answer", user_answer);
        mav.addObject("quizVO", quizVO);
        mav.addObject("result", result);
        return mav;
    }


    @GetMapping("/quiz/medium")
    public ModelAndView quiz_medium(HttpServletRequest request, HttpSession session) {
        if (!"Y".equals(request.getSession().getAttribute("logStatus"))) {
            ModelAndView modelAndView = new ModelAndView("redirect:/login");
            return modelAndView;
        }
        String userId = (String) session.getAttribute("userId");
        QuizVO quiz = quizService.selectRandomQuiz(userId, 2);
        String path=TtsUtil.APITTS(quiz.getQuiz_content(),quiz.getQuiz_lang());
        quiz.setQuiz_sound(path);
        System.out.println(quiz);
        ModelAndView modelAndView = new ModelAndView("/quiz/quiz_medium");
        modelAndView.addObject("quiz", quiz);
        return modelAndView;
    }

    @GetMapping("/quiz/hard")
    public ModelAndView quiz_hard(HttpServletRequest request, HttpSession session) {
        if (!"Y".equals(request.getSession().getAttribute("logStatus"))) {
            ModelAndView modelAndView = new ModelAndView("redirect:/login");
            return modelAndView;
        }
        String userId = (String) session.getAttribute("userId");
        QuizVO quiz = quizService.selectRandomQuiz(userId, 3);
        String path=TtsUtil.APITTS(quiz.getQuiz_content(),quiz.getQuiz_lang());
        quiz.setQuiz_sound(path);
        System.out.println(quiz);
        ModelAndView modelAndView = new ModelAndView("/quiz/quiz_hard");
        modelAndView.addObject("quiz", quiz);
        return modelAndView;
    }

    @PostMapping("/quiz/save")
    public ResponseEntity<?> saveQuiz(@RequestParam("quizId") int quizId, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("logId");
        if (userId == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User is not logged in");
        }
        boolean saved = quizService.saveQuiz(quizId, userId);
        if (saved) {
            return new ResponseEntity<>(HttpStatus.CREATED); // Quiz saved successfully
        } else {
            return new ResponseEntity<>("Quiz already exists", HttpStatus.CONFLICT); // Or any other appropriate status
        }
    }
}