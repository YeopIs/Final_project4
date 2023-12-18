<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>QUIZ ANSWER</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            margin: 0 auto;
        }

        main {
            width: 1200px;
            margin: 100px auto;
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        .quiz-container {
            width: 100%;
            max-width: 1200px;
            margin: auto;
            padding: 50px 15px;
            border-radius: 5px;
        }

        .quiz-lang , .quiz-content, .user-answer, .correct-answer, .result{
            margin-bottom: 20px;
        }

        .quiz-lang label, .quiz-content label, .user-answer label, .correct-answer label, .result label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .correct-answer {
            max-width: 350px;
            word-wrap: break-word;
        }

        .buttons {
            display: flex;
            justify-content: center;
        }

        .buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }

        .buttons button:hover {
            background-color: #48270c;
            color: #f9f9f9;
        }
    </style>
    <script>
        $(document).ready(function () {
            var level = ${quizVO.level};
            var levelDescription = "";
            switch (level) {
                case 1:
                    levelDescription = "EASY";
                    break;
                case 2:
                    levelDescription = "MEDIUM";
                    break;
                case 3:
                    levelDescription = "HARD";
                    break;
                default:
                    levelDescription = "알 수 없음";
            }
            $('#level').text(levelDescription);
        });

        function saveQuiz() {
            var quizId =${quizVO.quiz_id};
            $.ajax({
                url: '/quiz/save',
                type: 'POST',
                data: {
                    quizId: quizId,
                },
                success: function () {
                    alert('Your information has been saved successfully.');
                },
                error: function () {
                    alert("It's already been saved!");
                }
            });
        }

        function nextQuiz() {
            var level = '${quizVO.level}'; // JSP 변수에서 레벨 가져오기
            console.log(level)
            var url;
            if (level === '1') {
                url = '/quiz/easy';
            } else if (level === '2') {
                url = '/quiz/medium';
            } else if (level === '3') {
                url = '/quiz/hard';
            } else {
                url = '/quiz';
            }
            window.location.href = url;
        }
        function displayLanguage() {
            var quizLang = "${quizVO.quiz_lang}";
            var languageName = "";
            switch(quizLang) {
                case "ko":
                    languageName = "한국어";
                    break;
                case "en":
                    languageName = "English";
                    break;
                case "jp":
                    languageName = "日本語";
                    break;
                case "zh-CN":
                    languageName = "中國語-简体";
                    break;
                case "zh-TW":
                    languageName = "中國語-繁体";
                    break;
                case "vi":
                    languageName = "Tiếng Việt";
                    break;
                case "th":
                    languageName = "แบบไทย";
                    break;
                case "id":
                    languageName = "Indonésia";
                    break;
                case "fr":
                    languageName = "Français";
                    break;
                case "es":
                    languageName = "Español";
                    break;
                case "ru":
                    languageName = "Русский";
                    break;
                case "de":
                    languageName = "Deutsch";
                    break;
                case "it":
                    languageName = "Italiano";
                    break;
                default:
                    languageName = "알 수 없는 언어";
            }
            document.getElementById("language").innerText = languageName;
        }
        window.onload = displayLanguage;
    </script>


</head>

<body>
<main class="quiz-container">
    <h1 id="level" class="quiz-level">${quizVO.level}</h1>
    <hr/>
    <div class="quiz-lang">
        <label>QUIZ LANGUAGE</label>
        <p id="quizLang"><span id="language"></span></p>
    </div>
    <div class="quiz-content">
        <label>QUIZ CONTENT</label>
        <p id="quizContent">${quizVO.quiz_content}</p>
    </div>
    <div class="user-answer">
        <label>USER ANSWER</label>
        <p id="userAnswer">${user_answer}</p>
    </div>
    <div class="correct-answer">
        <label>ANSWER</label>
        <p id="correctAnswer">${quizVO.answer}</p>
    </div>
    <div class="result">
        <label>RESULT</label>
        <p id="result">${result == 'correct' ? 'SUCESS!' : 'WRONG.'}</p>
    </div>
</main>
<div class="buttons">
    <button type="button" onclick="saveQuiz()">STORE</button>
    <hr/>
    <button type="button" onclick="nextQuiz()">NEXT</button>
</div>
</body>


</html>