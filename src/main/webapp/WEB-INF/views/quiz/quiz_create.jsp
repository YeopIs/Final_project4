<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>QUIZ : CREATE</title>
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
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            align-items: center;

        }

        #quiz_reg_content{
            width: 1000px;
            height: auto;
            padding: 40px;
            margin: 20px auto;
            border: 5px solid #69491a;
        }
        #select_box{
            width: 100%;
            margin: 0 auto;
        }
        #quiz_lang{
            margin-right: 30px;
        }
        .form-group{

        }
        .form-group-box {
            width: 430px;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-content: space-around;

            margin: 0 auto;
        }


        #quiz_submit:hover {
            background-color:#69491a;
            color: #fff;
        }

        select, input[type="text"] {
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .submit-group{
            display: block;
            width: 71%;
            margin: 0 auto;
            text-align: center;
        }
        #quiz_content{
            width: 70%;
            height: 90px;
            margin: 20px auto;
            font-size: 60px;
        }
        #answer{
            width: 70%;
            height: 90px;
            margin: 0 auto;
            font-size: 60px;
        }
        #quiz_submit_box{
            margin: 20px auto 0;
            border-radius: 4px;

        }
        #quiz_submit{
            width: 300px;
            height: 100px;
            margin: 0 auto;
            font-size: 60px;
            border-radius: 4px;
            background-color: #FFD954;
        }

    </style>
    <script>
        $(document).ready(function () {
            $('#quiz_lang').change(function () {
                var selectedLanguage = $(this).val();
                $('#quiz_content').val(''); // 언어가 변경될 때마다 내용 초기화
                $('#answer').val('');
                $('#warning-message').hide(); // 메시지 숨기기

                $('#quiz_content').on('input', function () {
                    var value = $(this).val();
                    var isValid = true;

                    if (selectedLanguage === 'ko' && /[^ㄱ-ㅎㅏ-ㅣ가-힣\s]/.test(value)) {
                        isValid = false;
                    } else if (selectedLanguage === 'en' && /[^a-zA-Z\s]/.test(value)) {
                        isValid = false;
                    } else if (selectedLanguage === 'jp' && /[^ぁ-ゔゞァ-ヺー龰\s]/.test(value)) {
                        isValid = false;
                    } else if (selectedLanguage === 'zh-CN' && /[^一-龥\s]/.test(value)) {
                        isValid = false;
                    } else if (selectedLanguage === 'zh-TW' && /[^一-龥\s]/.test(value)) {
                        isValid = false;
                    } else if (selectedLanguage === 'vi' && /[^a-zA-Zàảãáạăằẳẵắặâầẩẫấậđèẻẽéẹêềểễếệìỉĩíịòỏõóọôồổỗốộơờởỡớợùủũúụưừửữứựỳỷỹýỵ\s]/.test(value)) {
                        isValid = false;
                    } else if (selectedLanguage === 'th' && /[^ก-๙\s]/.test(value)) {
                        isValid = false;
                    } else if (selectedLanguage === 'id' && /[^a-zA-Z\s]/.test(value)) {
                        isValid = false;
                    } else if (selectedLanguage === 'fr' && /[^a-zA-Zàâçéèêëîïôûùüÿœ\s]/.test(value)) {
                        isValid = false;
                    } else if (selectedLanguage === 'es' && /[^a-zA-ZáéíñóúüÁÉÍÑÓÚÜ\s]/.test(value)) {
                        isValid = false;
                    } else if (selectedLanguage === 'ru' && /[^а-яА-ЯёЁ\s]/.test(value)) {
                        isValid = false;
                    } else if (selectedLanguage === 'de' && /[^a-zA-ZäöüßÄÖÜ\s]/.test(value)) {
                        isValid = false;
                    } else if (selectedLanguage === 'it' && /[^a-zA-Zàèéìîòóù\s]/.test(value)) {
                        isValid = false;
                    }
                    if (!isValid) {
                        $('#warning-message').show();
                    } else {
                        $('#warning-message').hide();
                    }
                });
            });

            $('#submitButton').prop('disabled', true);
            function getLanguageType(value) {
                if (/^[ㄱ-ㅎㅏ-ㅣ가-힣\s]+$/.test(value)) {
                    return 'ko';
                } else if (/^[a-zA-Z\s]+$/.test(value)) {
                    return 'en';
                } else if (/^[ぁ-ゔゞァ-ヺー龰\s]+$/.test(value)) {
                    return 'jp';
                } else if (/^[一-龥\s]+$/.test(value)) {
                    return 'zh';
                } else if (/^[a-zA-Zàảãáạăằẳẵắặâầẩẫấậđèẻẽéẹêềểễếệìỉĩíịòỏõóọôồổỗốộơờởỡớợùủũúụưừửữứựỳỷỹýỵ\s]+$/.test(value)) {
                    return 'vi';
                } else if (/^[ก-๙\s]+$/.test(value)) {
                    return 'th';
                } else if (/^[a-zA-Z\s]+$/.test(value)) {
                    return 'id';
                } else if (/^[a-zA-Zàâçéèêëîïôûùüÿœ\s]+$/.test(value)) {
                    return 'fr';
                } else if (/^[a-zA-ZáéíñóúüÁÉÍÑÓÚÜ\s]+$/.test(value)) {
                    return 'es';
                } else if (/^[а-яА-ЯёЁ\s]+$/.test(value)) {
                    return 'ru';
                } else if (/^[a-zA-ZäöüßÄÖÜ\s]+$/.test(value)) {
                    return 'de';
                } else if (/^[a-zA-Zàèéìîòóù\s]+$/.test(value)) {
                    return 'it';
                }
                return 'other';
            }

            function validateLanguages() {
                var quizContent = $('#quiz_content').val();
                var answer = $('#answer').val();
                var quizLangType = getLanguageType(quizContent);
                var answerLangType = getLanguageType(answer);

                if (quizLangType === answerLangType) {
                    $('#warning-message').show();
                } else {
                    $('#warning-message').hide();
                }
            }

            $('#quiz_content, #answer').on('input', function () {
                validateLanguages();
            });

            $('#answer, #quiz_content').on('input', function () {
                var isAnswerFilled = $('#answer').val().trim() !== '';
                var isContentFilled = $('#quiz_content').val().trim() !== '';
                $('#submitButton').prop('disabled', !(isAnswerFilled && isContentFilled));
            });

            $('#quiz_createForm').on('submit', function (e) {
                e.preventDefault();
                var formData = {
                    quiz_lang: $('#quiz_lang').val(),
                    answer_create_lang:$('#answer_lang').val(),
                    level: $('#level').val(),
                    answer: $('#answer').val(),
                    quiz_content: $('#quiz_content').val()
                };

                $.ajax({
                    url: '/quiz/createOk',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function () {
                        // 성공 처리
                        $('#answer').val('');
                        $('#quiz_content').val('');
                        $('#quiz_lang').val('ko');
                        $('#level').val('1');
                        alert("SUCCESS");
                    },
                    error: function () {
                        alert("FAIL");
                    }
                });
            });
        });

        function toggleSubmitButton() {
            var content = document.getElementById('quiz_content').value;
            var answer = document.getElementById('answer').value;
            var submitButton = document.getElementById('quiz_submit');

            // Check if both inputs have values
            if (content && answer) {
                submitButton.disabled = false;
            } else {
                submitButton.disabled = true;
            }
        }
        document.getElementById('quiz_content').addEventListener('input', toggleSubmitButton);
        document.getElementById('answer').addEventListener('input', toggleSubmitButton);
    </script>


</head>

<body>
<main>
    <h1>CREATE QUIZ</h1>

    <div id="quiz_reg_content">
        <form method="post" action="/quiz_createOk" id="quiz_createForm">
            <div id="select_box">
                <div class="form-group-box">
                    <div class="form-group">
                        <label for="quiz_lang">QUIZ LANG</label>
                        <select id="quiz_lang">
                            <option value="ko">한국어</option>
                            <option value="en">English</option>
                            <option value="jp">日本語</option>
                            <option value="zh-CN">中國語-简体</option>
                            <option value="zh-TW">中國語-繁体</option>
                            <option value="vi">Tiếng Việt</option>
                            <option value="th">แบบไทย</option>
                            <option value="id">Indonésia</option>
                            <option value="fr">Français</option>
                            <option value="es">Español</option>
                            <option value="ru">Русский</option>
                            <option value="de">Deutsch</option>
                            <option value="it">Italiano</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="answer_lang">ANSWER LANG</label>
                        <select id="answer_lang">
                            <option value="ko">한국어</option>
                            <option value="en">English</option>
                            <option value="jp">日本語</option>
                            <option value="zh-CN">中國語-简体</option>
                            <option value="zh-TW">中國語-繁体</option>
                            <option value="vi">Tiếng Việt</option>
                            <option value="th">แบบไทย</option>
                            <option value="id">Indonésia</option>
                            <option value="fr">Français</option>
                            <option value="es">Español</option>
                            <option value="ru">Русский</option>
                            <option value="de">Deutsch</option>
                            <option value="it">Italiano</option>
                        </select>
                    </div>       
                    <div class="form-group">
                        <label for="level">LEVEL</label>
                        <select id="level">
                            <option value="1">EASY</option>
                            <option value="2">MEDIUM</option>
                            <option value="3">HARD</option>
                        </select>
                    </div>
                </div>
            </div>
            <div id="warning-message" style="display: none; color: red;">Invalid input. Please enter the characters appropriate for your language.</div>
            <div class="submit-group">
                <input type="text" id="quiz_content" placeholder="QUIZ CONTENT"/>
                <input type="text" id="answer" placeholder="ANSWER"/>
                <div id="quiz_submit_box"><input id="quiz_submit" type="submit" value="SUBMIT"/></div>
            </div>
        </form>
    </div>

</main>
</body>

</html>