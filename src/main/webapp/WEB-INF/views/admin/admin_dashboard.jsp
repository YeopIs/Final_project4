<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>관리자 페이지 : 대시보드</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
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
            border-right: 1px solid #ddd;
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
        #side_menu li a.active{
            background-color: #333333;
            color: white;
        }
        section {
            height: auto;
            margin: 20px;
            position: relative;
        }

        section > h2 {
            text-align: center;
        }

        main {
            height: auto;
            margin: 50px auto;
        }

        #dashboard {
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            align-content: space-around;
            margin-left: 20px;
        }

        #boardList > a li,
        #replyList > a li,
        #boardList > li,
        #replyList > li  {
            float: left;
            height: 30px;
            line-height: 30px;
            border-bottom: 1px solid #ddd;
            width: 100px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        #boardList > a li:nth-child(3n+2),
        #boardList > li:nth-child(3n+2){
            width: 200px;
        }

        #replyList > a li:nth-child(3n+1),
        #replyList > li:nth-child(3n+1)
        {
            width: 130px;
        }

        #replyList > a li:nth-child(3n+2),
        #replyList > li:nth-child(3n+2)
        {
            width: 175px;
        }


        #boardList > li:nth-child(-n+3),
        #replyList > li:nth-child(-n+3)
        {
            font-weight: bold;
            font-size: 17px;
        }

        #chart, #dashboardTitle {
            text-align: center;
        }

        #dashboardTitle {
            margin-bottom: 50px;
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
    <nav>
        <ul id="side_menu">
            <li><a href="${pageContext.servletContext.contextPath}/admin" class="active">대시보드</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/member/management">현재회원관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/suspended/management">정지회원관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/withdrawn/management">탈퇴회원관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/board">게시글관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/reply">댓글관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/quiz/list">퀴즈관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/chat/management">채팅관리</a></li>
        </ul>
    </nav>
    <main>
        <h1 id="dashboardTitle">대시보드</h1>
        <div id="dashboard">
            <section id="preferred">
                <h2>가입자 국적 통계
                </h2>
                <div id="">
                    <canvas id="bar-chart-horizontal" width="900" height="400"></canvas>
                </div>
            </section>
            <section id="visitor">
                <h2>월별 방문자수</h2>
                <div id="chart">
                    <canvas id="line-chart" width="900" height="400"></canvas>
                </div>
            </section>
            <section id="recent-board" style="width: 450px">
                <h2>최신게시글</h2>
                <ul id="boardList">
                    <li>게시판</li>
                    <li>글제목</li>
                    <li>작성자</li>
                    <c:forEach var="board" items="${latestBoards}">
                        <a href="/board/notice/view?no=${board.post_id}" style="color: black; text-decoration: none;">
                            <li>${board.board_cat}</li>
                            <li>${board.title}</li>
                            <li>${board.user_id}</li>
                        </a>
                    </c:forEach>
                </ul>
            </section>
            <section id="recent-reply"style="width: 450px">
                <h2>최신댓글</h2>
                <ul id="replyList">
                    <li>글제목</li>
                    <li>댓글내용</li>
                    <li>작성자</li>
                    <c:forEach var="reply" items="${latestReplies}">
                        <a href="/board/notice/view?no=${reply.post_id}" style="color: black; text-decoration: none;">
                            <li>${reply.title}</li>
                            <li>${reply.content}</li>
                            <li>${reply.writer}</li>
                        </a>
                    </c:forEach>
                </ul>
            </section>
        </div>
    </main>
</div>
<script>
    var visitorStats = JSON.parse('${visitorStats}');

    function getNationName(nationCode) {
        switch (nationCode) {
            case "ko":
                return "한국";
            case "en":
                return "미국";
            case "jp":
                return "일본";
            case "zh-CN":
                return "중국";
            case "vi":
                return "베트남";
            case "th":
                return "태국";
            case "id":
                return "인도네시아";
            case "fr":
                return "프랑스";
            case "es":
                return "스페인";
            case "ru":
                return "러시아";
            case "de":
                return "독일";
            case "it":
                return "이탈리아";
            default:
                return nationCode;
        }
    }

    var dataByNation = {};
    visitorStats.forEach(function (stat) {
        var nationName = getNationName(stat.nation);
        if (!dataByNation[nationName]) {
            dataByNation[nationName] = Array(12).fill(0);
        }
        dataByNation[nationName][stat.month - 1] = stat.visitCount;
    });

    var datasets = [];
    for (var nation in dataByNation) {
        var color = getRandomColor();
        datasets.push({
            label: nation,
            data: dataByNation[nation],
            borderColor: color,
            fill: false
        });
    }

    function getRandomColor() {
        var letters = '0123456789ABCDEF';
        var color = '#';
        for (var i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }

    var nationStats = JSON.parse('${nationStats}');

    var labels = [];
    var data = [];
    var backgroundColors = [];

    nationStats.forEach(function (stat) {
        labels.push(stat.nation);
        data.push(stat.visitCount);
        backgroundColors.push(getRandomColor());
    });

    new Chart(document.getElementById("bar-chart-horizontal"), {
        type: 'horizontalBar',
        data: {
            labels: labels,
            datasets: [
                {
                    label: "User Count by Nation",
                    backgroundColor: backgroundColors,
                    data: data
                }
            ]
        },
        options: {
            legend: {display: false},
            title: {
                display: false,
                text: 'User Count by Nation'
            }
        }
    });

    new Chart(document.getElementById("line-chart"), {
        type: 'line',
        data: {
            labels: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], // 월별 레이블
            datasets: datasets
        },
        options: {
            title: {
                display: false,
                text: 'visitor'
            }
        }
    });

</script>
</body>

</html>