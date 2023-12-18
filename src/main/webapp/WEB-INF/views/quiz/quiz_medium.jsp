<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>QUIZ : MEDIUM</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
        }

        main {
            width: 1200px;
            margin: 100px auto;
            display: block;
            justify-content: space-around;
            align-items: center;
        }

        .language_box{
            width: 900px;
            margin: 5px auto;
            font-size: 1.5em;
        }
        #quiz_content{
            width: 900px;
            height: 400px;
            font-size: 7em;
            border:5px solid #000000;
            margin: 0 auto;
            text-align: center;
            border-radius: 10px;
        }

        #input_form{

            width: 900px;
            margin: 50px auto 20px;
            height: 90px;

        }
        .form-control{
            width: 700px;
            font-size: 40px;
        }
        .input-group-text{
            width: 200px;
            font-size: 40px;
            margin: 0 auto;
            background-color: #FFD954;
        }

    </style>
    <script>
        $(document).ready(function () {
            $('#submitButton').prop('disabled', true);
            console.log("quiz.answer_lang:", "${quiz.answer_lang}");
            // Enable the submit button only when user input is present
            $('#userAnswer').on('input', function () {
                if ($(this).val().trim() !== '') {
                    $('#submitButton').prop('disabled', false);
                } else {
                    $('#submitButton').prop('disabled', true);
                }
            });
            document.getElementById('sound_button').addEventListener('click', function() {
                var audioPath = '${quiz.quiz_sound}';
                if (audioPath === 'error') {
                    alert('Sound cannot be played.');
                } else {
                    var audio = new Audio(audioPath);
                    audio.play();
                }
            });

            displayLanguage();
            displayAnswerLang();
        });
        function displayLanguage() {
            var quizLang = "${quiz.quiz_lang}";
            var languageName = "";

            switch(quizLang) {
                case "ko":
                    languageName = "한국어";
                    break;
                case "en":
                    languageName = "English";
                    break;
                case "ja":
                    languageName = "日本語";
                    break;
                case "zh-CN":
                    languageName = "简体中文";
                    break;
                case "zh-TW":
                    languageName = "繁體中文";
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

        function displayAnswerLang() {
            var ansLang = "${quiz.answer_lang}".replace(/[\[\]]/g, '').split(",").map(function(lang) {
                return lang.trim(); // 공백 제거
            });
            console.log(ansLang);
            var fullNames = ansLang.map(getLanguageFullName).join(', ');
            document.getElementById('answer_lang').innerText = fullNames;
        }


        function getLanguageFullName(langCode) {
            var langNames = {
                'ko': '한국어',
                'en':'English',
                'ja': '日本語',
                'zh_TW':'繁體中文',
                'zh-CN':'简体中文',
                'vi':'Tiếng Việt',
                'th':'แบบไทย',
                'id':'Indonésia',
                'fr':'Français',
                'es':'Español',
                'ru':'Русский',
                'de':'Deutsch',
                'it':'Italiano'
            };

            return langNames[langCode] || langCode;
        }
    </script>
</head>

<body>
<main>
    <div class="language_box">MEDIUM : <span id="language"></span></div>
    <div class="language_box">ANSWER LANGUAGE : <span id="answer_lang"></span></div>
    <div id="quiz_content" style="display: flex; flex-direction: column">
        <div>
            <button id="sound_button" style="background-color: transparent; border: none; font-size: 0.5em; cursor: pointer; float: left; display: ${quiz.quiz_sound == 'error' ? 'none' : 'inline-block'};">
                🔊
            </button>
        </div>
        <div style="margin-top: 20px;">
            ${quiz.quiz_content}
        </div>
    </div>
    <form method="post" id="input_form" class="input-group mb-3" action="/quiz/checkAnswer">
        <input type="text" name="user_answer" class="form-control" placeholder="ENTER ANSWER"/>
        <input type="hidden" name="quiz_id" value="${quiz.quiz_id}"/>
        <input type="hidden" name="quiz_content" value="${quiz.quiz_content}"/>
        <input type="hidden" name="level" value="${quiz.level}"/>
        <input type="hidden" name="quiz_lang" value="${quiz.quiz_lang}"/>
        <input type="submit" class="input-group-text" value="SUBMIT"/>
    </form>
</main>
</body>

</html>