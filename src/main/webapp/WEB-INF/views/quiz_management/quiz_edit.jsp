<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>should be</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .banner{
            display: none;
        }

        .nav{
            display: none;
        }
        hr{
            display: none;
        }

        .banner_2 {
            width: 1200px;
            margin: 0 auto;
            position: relative;
            height: 200px;
        }

        .nav_2 {
            display: flex;
            justify-content: space-around;
            align-items: center;
            text-align: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        body{
            background-image:url("/image/admin_back_2.jpg") !important;
            background-size: 100% 100% !important;
            background-position: center center !important;
            background-attachment: fixed !important;
        }

        .container {
            margin-top:30px;
            width: 1200px;
            height: auto;
            display: flex;
            flex-direction: row;
            background-color: rgba(255, 255, 255, 0.5);
            border-radius: 20px;
            backdrop-filter: blur(30px);
        }

        #side_menu {
            padding: 98px 10px 0;
            width: 150px;
            height: 1000px;
            list-style-type: none;
            border-right: 1px solid #000000;
        }

        #side_menu li a {
            text-decoration: none;
            color: black;
            display: block;
            padding: 10px;
        }

        #side_menu li a:hover {
            background-color: #ddd;
        }

        #member_management {
            width: 900px;
            height: auto;
            margin: 50px auto;

        }

        #quiz_list_title {
            text-align: center;
            border-bottom: 4px solid #000;

        }

        #quiz_content {
            width: 900px;
            height: 150px;
            line-height: 150px;
            font-size: 3em;
            text-align: center;
            margin: 0 auto;
        }

        #answerlist {
            width: 900px;
            margin: 0 auto;
            padding-bottom: 30px;
        }

        #answer {
            width: 900px;
            margin: 10px auto;
            height: 60px;
            display: flex;
            flex-direction: row;
            justify-content: space-around;
            border-bottom: 1px solid #000000;
        }

        #quiz_answer {
            width: 80%;
            height: 60px;
            font-size: 2em;

        }

        #quiz_delete {
            width: 50px;
            height: 50px;
            font-size: 2em;
        }

        h1 {
            padding-bottom: 20px;
        }

        #editDelForm {
            display: flex;
            flex-wrap: nowrap;
            align-items: center;
            justify-content: space-between;
            width: 95%;
            margin: 0;
        }

        form {
            display: flex;
            flex-wrap: nowrap;
            flex-direction: row;
            align-items: center;
        }

        #input-text {
            margin-top: 20px;
            width: 450px;
            display: flex;
            align-items: center;
        }

        label{
            margin-right: 5px;
        }

        .form-group {
            display: flex;
            align-items: center;
            margin-right: 20px;
        }

        #side_menu li a.active{
            background-color: #333333;
            color: white;
        }
    </style>
</head>
<body>
<div class="banner_2">
    <div class="logo-area">
        <a href="${pageContext.servletContext.contextPath}/"><img
                src="${pageContext.servletContext.contextPath}/image/logo_admin.png" class="logo" height="110px"></a>
        <!-- 로고 이미지 -->
    </div>
    <div class="login">
        <c:if test="${logStatus=='Y'}">
            <a href="${pageContext.servletContext.contextPath}/mypage/change_user"> <!-- 마이페이지 -->
                <img src="${pageContext.servletContext.contextPath}/image/profile/user1.jpg" class="user-icon"
                     id="user-icon" style="border-radius: 50%; width: 50px; height: auto;"/></a>
            <!--유저로고-->
            <a href="${pageContext.servletContext.contextPath}/logout" class="login-button">&nbsp&nbspLOGOUT</a>
        </c:if>
        <c:if test="${logStatus!='Y'}">
            <a href="${pageContext.servletContext.contextPath}/login" class="login-button">LOGIN&nbsp</a> | <a
                href="${pageContext.servletContext.contextPath}/create" class="login-button">&nbspREGISTER</a>
        </c:if>
    </div>
</div>

<div class="nav_2">
    <div class="category">
        <!-- 마이페이지 Dropdown -->
        <div class="dropdown">
            <a href="${pageContext.servletContext.contextPath}/mypage" class="dropbtn">MY PAGE</a>
            <c:if test="${logStatus=='Y'}">
                <div class="dropdown-content">
                    <a href="${pageContext.servletContext.contextPath}/mypage/change_user">INFO EDIT</a>
                    <a href="${pageContext.servletContext.contextPath}/mypage/post_user">POST LIST</a>
                    <a href="${pageContext.servletContext.contextPath}/mypage/friend_user">FRIENDS</a>
                    <a href="${pageContext.servletContext.contextPath}/mypage/save_chat">STORE</a>
                    <a href="${pageContext.servletContext.contextPath}/mypage/withdraw_user">WITHDRAW</a>
                </div>
            </c:if>
        </div>

        <!-- 게시판 Dropdown -->
        <div class="dropdown">
            <a href="${pageContext.servletContext.contextPath}/board/notice" class="dropbtn">BOARD</a>
            <div class="dropdown-content">
                <a href="${pageContext.servletContext.contextPath}/board/notice">NOTICE</a>
                <a href="${pageContext.servletContext.contextPath}/board/free">FREE</a>
                <a href="${pageContext.servletContext.contextPath}/board/inquiries">INQUIRE</a>
            </div>
        </div>

        <!-- 퀴즈 Dropdown -->
        <div class="dropdown">
            <a href="${pageContext.servletContext.contextPath}/quiz/main" class="dropbtn">QUIZ</a>
            <div class="dropdown-content">
                <a href="${pageContext.servletContext.contextPath}/quiz/main">SOLVE QUIZ</a>
                <a href="${pageContext.servletContext.contextPath}/quiz/create">CREATE QUIZ</a>
            </div>
        </div>

        <!-- 채팅 Dropdown -->
        <div class="dropdown">
            <a href="${pageContext.servletContext.contextPath}/chat/list" class="dropbtn">CHAT</a>
            <div class="dropdown-content">
                <a href="${pageContext.servletContext.contextPath}/chat/list">MY CHAT LIST</a>
                <a href="${pageContext.servletContext.contextPath}/chat/partners">NEW PARTNER</a>
            </div>
        </div>
        <div class="dropdown">
            <a href="${pageContext.servletContext.contextPath}/admin" class="dropbtn">ADMIN</a>
            <div class="dropdown-content">
                <a href="${pageContext.servletContext.contextPath}/admin">DASH BOARD</a>
                <a href="${pageContext.servletContext.contextPath}/admin/member/management">NOW USER</a>
                <a href="${pageContext.servletContext.contextPath}/admin/suspended/management">SUSPENDED</a>
                <a href="${pageContext.servletContext.contextPath}/admin/withdrawn/management">WITHDRAWN</a>
                <a href="${pageContext.servletContext.contextPath}/admin/board">POST</a>
                <a href="${pageContext.servletContext.contextPath}/admin/reply">COMMENT</a>
                <a href="${pageContext.servletContext.contextPath}/admin/quiz/list">QUIZ</a>
                <a href="${pageContext.servletContext.contextPath}/admin/chat/management">CHAT</a>
            </div>
        </div>
    </div>
</div>

<hr style="margin-bottom: 0;">
<div class="container">
    <div id="side_bar">
        <ul id="side_menu">
            <li><a href="${pageContext.servletContext.contextPath}/admin">대시보드</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/member/management">현재회원관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/suspended/management">정지회원관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/withdrawn/management">탈퇴회원관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/board">게시글관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/reply">댓글관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/quiz/list" class="active">퀴즈관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/chat/management">채팅관리</a></li>

        </ul>
    </div>
    <div id="member_management">
        <h1 id="quiz_list_title">퀴즈 수정/삭제</h1>
        <div id="quiz_content">
            <p>${qVO.quiz_content}</p>
        </div>
        <div id="answerlist">
            <c:forEach var="eVO1" items="${editlist}" varStatus="status">
                <div id="answer">
                    <div id="quiz_answer">${eVO1.answer}</div>
                    <a href="${pageContext.servletContext.contextPath}/answerDelete?answer=${eVO1.answer}&quiz_id=${eVO1.quiz_id}"><button id="quiz_delete"> -</button></a>
                </div>
            </c:forEach>
        </div>
        <div id="editDelForm">
            <form method="post" action="${pageContext.servletContext.contextPath}/quiz/answer_insert">
                <div class="form-group">
                    <label for="answer_lang">정답 언어:</label>
                    <select id="answer_lang" name="answer_lang">
                        <option value="ko">한국어</option>
                        <option value="en">영어</option>
                        <option value="ja">일본어</option>
                        <option value="zh-CN">중국어 간체</option>
                        <option value="zh-TW">중국어 번체</option>
                        <option value="vi">베트남어</option>
                        <option value="th">태국어</option>
                        <option value="id">인도네시아어</option>
                        <option value="fr">프랑스어</option>
                        <option value="es">스페인어</option>
                        <option value="ru">러시아어</option>
                        <option value="de">독일어</option>
                        <option value="it">이탈리아어</option>
                    </select>
                </div>
                <div class="input-group mb-3" id="input-text">
                    <input type="text" name="answer" class="form-control" placeholder="추가할 뜻 작성">
                    <input type="hidden" name="quiz_id" value="${qVO.quiz_id}">
                    <button class="btn btn-dark">추가</button>
                </div>
            </form>
            <div>
                <a href="${pageContext.servletContext.contextPath}/quizDelete?quiz_id=${qVO.quiz_id}">
                    <button class="btn btn-dark">단어 삭제</button>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>