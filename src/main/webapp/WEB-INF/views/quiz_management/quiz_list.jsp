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
            height: 1000px;
            margin: 50px auto;

        }

        #quiz_list_title {
            text-align: center;
            margin-bottom: 30px;
        }

        /*#quiz_grade{
            display: flex;
            flex-direction: column;
              justify-content: space-around;
              margin: 10px auto;
        }*/

        .quiz_list {
            display: flex;
            justify-content: space-around;
        }

        #quiz_list_title {
            text-align: center;
            border-bottom: 4px solid #000;
        }

        .qqlist {
            width: 300px;
            height: 500px;
            border: 3px solid #000;
            margin: 0 5px;
            overflow-y: scroll;
        }

        .list_head {
            border-bottom: 3px solid #000;
            background-color: rgba(255, 255, 255, 0);
            text-align: center;
        }

        .management_list {
            border-bottom: 1px solid #000000;
            text-align: center;
        }

        .list_content {
            border-bottom: 1px solid #000000;

        }

        .quiz_content {
            width: 50%;
        }

        h1 {
            padding-bottom: 20px;
        }

        #side_menu li a.active{
            background-color: #333333;
            color: white;
        }

    </style>
    <script>
        function EditDelBtn() {
            location.href = "${pageContext.servletContext.contextPath}/admin/quiz_edit";
        }
    </script>
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
        <h1 id="quiz_list_title">퀴즈 관리</h1>
        <div class="quiz_list">
            <!-- 쉬움 -->
            <div class="qqlist" id="quiz_easy">
                <h4 style="text-align: center">쉬움</h4>
                <table class="display" style="width:100%">
                    <thead class="list_head">
                    <tr class="management_list">
                        <th class="lise_number">NO</th>
                        <th class="quiz_content">단어</th>
                        <th class="edit_button">수정</th>
                    </tr>
                    </thead>
                    <tbody class="list_content">
                    <c:forEach var="qVO1" items="${quizlist1}" varStatus="status">
                        <tr class="management_list">
                            <td class="lise_number">${status.count}</td>
                            <td class="quiz_content">${qVO1.quiz_content}</td>
                            <td class="edit_button">
                                <a href="${pageContext.servletContext.contextPath}/admin/quiz_edit?quiz_id=${qVO1.quiz_id}">
                                    <input type="button" value="수정/삭제" class="btn btn-dark">
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 중간 -->
            <div class="qqlist" id="quiz_medium">
                <h4 style="text-align: center">중간</h4>
                <table class="display" style="width:100%">
                    <thead class="list_head">
                    <tr class="management_list">
                        <th class="lise_number">NO</th>
                        <th class="quiz_content">단어</th>
                        <th class="edit_button">수정</th>
                    </tr>
                    </thead>
                    <tbody class="list_content">
                    <c:forEach var="qVO2" items="${quizlist2}" varStatus="status">
                        <tr class="management_list">
                            <td class="lise_number">${status.count}</td>
                            <td class="quiz_content">${qVO2.quiz_content}</td>
                            <td class="edit_button">
                                <a href="${pageContext.servletContext.contextPath}/admin/quiz_edit?quiz_id=${qVO2.quiz_id}">
                                    <input type="button" value="수정/삭제" class="btn btn-dark">
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- 어려움 -->
            <div class="qqlist" id="quiz_hard">
                <h4 style="text-align: center">어려움</h4>
                <table class="display" style="width:100%">
                    <thead class="list_head">
                    <tr class="management_list">
                        <th class="lise_number">NO</th>
                        <th class="quiz_content">단어</th>
                        <th class="edit_button">수정</th>
                    </tr>
                    </thead>
                    <tbody class="list_content">
                    <c:forEach var="qVO3" items="${quizlist3}" varStatus="status">
                        <tr class="management_list">
                            <td class="lise_number">${status.count}</td>
                            <td class="quiz_content">${qVO3.quiz_content}</td>
                            <td class="edit_button">
                                <a href="${pageContext.servletContext.contextPath}/admin/quiz_edit?quiz_id=${qVO3.quiz_id}">
                                    <input type="button" value="수정/삭제" class="btn btn-dark">
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
