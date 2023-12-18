<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>QUIZ : MAIN</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            margin: 0 auto;
        }

        main {
            width: 1200px;
            height: 600px;
            margin: 30px auto;
            display: flex;
            justify-content: space-evenly;
            align-items: center;
            flex-direction: column;
        }

        ul > li {
            list-style-type: none;
        }

        .difficulty {
            float: left;
            width: 330px;
            height: 200px;
            margin: 10px;
            font-size: 4em;
            border: 3px solid #000000;
            border-radius: 10px;
        }

        #quiz_easy {
            background: #FFF2D4;
        }

        #quiz_medium {
            background-color: #FFE3A0;
        }

        #quiz_hard {
            background-color: #FFB300;
        }

        #quiz_exp_box{
            width: 1100px;
            margin: 0 auto;
            border: 1px solid #000000;
            background-color: #f1f3f5;
        }
        #quiz_exp{
            margin: 20px;
            font-size: 2em;

        }
    </style>
    <script>
        $(function () {
            $("#quiz_easy").on('click', function () {
                location.href = "${pageContext.servletContext.contextPath}/quiz/easy";
            });
            $("#quiz_medium").on('click', function () {
                location.href = "${pageContext.servletContext.contextPath}/quiz/medium";
            });
            $("#quiz_hard").on('click', function () {
                location.href = "${pageContext.servletContext.contextPath}/quiz/hard";
            });
        });
    </script>
</head>
<body>
<main>
    <h1>퀴즈</h1>
    <div id="difficulty">
        <ul>
            <li>
                <button type="button" id="quiz_easy" class="difficulty">EASY</button>
                    <button type="button" id="quiz_medium" class="difficulty">MEDIUM</button>
                <button type="button" id="quiz_hard" class="difficulty">HARD</button>
            </li>
        </ul>
    </div>
    <div id="quiz_exp_box">
        <ol id="quiz_exp">
            <li><span>난이도를 선택하세요.</span></li>
            <li><span>단어를 보고 정답을 입력해 주세요.</span></li>
            <li><span>틀린 단어를 저장소에 저장해 보세요.</span></li>
        </ol>
    </div>
</main>
</body>
</html>