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
    <script>
        $(function () {
            let youtube_url = "";
            $(".youtube_link").on("click", function () {
                youtube_url = $(this).attr("id");

                $("#youtube_iframe").attr("src", youtube_url);
                console.log(youtube_url);
                $(".youtube_link").css("background-color", "#fff");
                $(this).css("background-color", "#ddd");
            });
        });
    </script>

    <style>
        body {
            margin: 0 auto;
        }

        main {
            width: 1200px;
            display: flex;
            margin: 0 auto;
            flex-direction: column;
            justify-content: space-around;
            align-items: center;
            text-align: center;
        }


        .temp-login {
            width: 1200px;
            margin: 100px auto;
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        #main_img_box {
            width: 1200px;
            height: 400px;
            border: 1px solid #ddd;
        }

        #main_img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #main_img_box figure img {
            opacity: 1;
            -webkit-transition: .3s ease-in-out;
            transition: .3s ease-in-out;
        }

        #main_img_box figure:hover img {
            opacity: .5;

        }

        /* 메인 이미지 시작*********************************************/
        .banner_img {
            display: inline-block;
            position: relative;

        }

        .banner_img:hover:after,
        .banner_img:hover > .hover_text {
            display: block;
        }

        .banner_img:after, .hover_text {
            display: none;
        }

        .banner_img:after {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background: rgba(0, 0, 0, 0.3);
            z-index: 10;
        }

        .banner_img {
            overflow: hidden;
        }

        .banner_img img {
            width: 1200px;
            height: 400px;
        }

        .banner_img:hover img {
            transform: scale(1.2);
            transition: 1s;
        }


        .hover_text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: #fff;
            z-index: 20;
            font-weight: 600;
            font-size: 40px;

        }

        /* 메인 이미지 끝*/

        /*FFD954 f2ab39*/
        /* 셀렉트 박스 시작********************************************/
        .select_box {
            width: 1200px;
            height: 400px;
            padding: 0.5em;
            background-color: #fff;
            display: flex;
            flex-direction: row;
            justify-content: space-evenly;
        }

        .box {
            margin: auto 0;
            border: 3px solid white;
            border-radius: 50px;
            width: 240px;
            height: 240px;
            padding: 1em;
            font-size: 2em;
            background-color: #FFD954; /*FFD954 f2ab39*/
            color: white;
        }

        .select_box_img {
            width: 100%;
            height: 100%;
        }

        .box {
            display: inline-block;
            position: relative;
        }

        .box:hover:after,
        .box:hover > .select_box_text {
            display: block;
        }

        .box:after, .select_box_text {
            display: none;
        }

        .box:after {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background: rgba(0, 0, 0, 0.8);
            z-index: 10;
        }

        .box {
            overflow: hidden;
        }

        .select_box_text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: #fff;
            z-index: 20;
            font-weight: 600;
            font-size: 30px;
        }

        /* 셀렉트 박스 끝*/

        /* 유튜브 박스 시작********************************************/
        .youtube_box {
            width: 1200px;
            height: 500px;
            border: 10px solid #E4B660;
            /*border-radius: 50px;*/
            display: flex;
            overflow: hidden;
        }

        .youtube_video {
            width: 67%;
            height: 100%;
        }

        .youtube_video iframe {
            /*margin: auto;*/
            width: 100%;
            height: 100%; /*780px  452px*/
            /*border-radius: 40px;*/
        }

        .youtube_link_box {
            width: 33%;
            height: 100%;

        }

        .youtube_link_list {
            width: 100%;
            height: 100%;
            padding: 0;
        }

        .youtube_link_list li {
            list-style-type: none;
            width: 100%;
            height: 14%;


            display: flex;
            justify-content: center;
            align-items: center;
        }

        .youtube_link_list li div {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            margin: auto 20px;
        }

        .youtube_link {
            cursor: pointer;
            font-size: 20px;
        }

        .youtube_link:hover {
            background-color: #ddd;

        }


        .link_title {
            font-weight: 600;
            font-size: 40px;
        }

        .jb-text {
            padding: 15px 20px;
            background-color: #444444;
            border-radius: 5px;
            color: #ffffff;
            position: absolute;
            display: none;
        }

        .youtube_link:hover + .jb-text {
            display: block;
        }

        /* 유튜브 박스 끝*/

        /* 광고 이미지 시작********************************************/
        .main_ad_box img {
            width: 1200px;
            height: 600px;
        }

        /* 광고 이미지 끝*/

        .slide {
            margin-bottom: 30px;
        }

        .intro {
            display: flex;
            flex-direction: row;
            font-size: 2em;
            font-weight: bold;
            line-height: 200px;
        }

        .intro img {
            margin: 20px 10px;
            transition: all 0.5s linear;
        }

        #intro-box {
            margin-bottom: 30px;
        }

        .intro:hover #intro_phone {
            transform: rotateY(180deg);
        }

        .intro:hover #intro_laptop {
            transform: rotateY(180deg);
        }

        .intro:hover #intro_map {
            transform: translateX(+50px);
        }

    </style>
</head>

<body>
<main>
    <!--메인 이미지 시작------------------------------------------------------>
    <div class="banner_img"><!--a href="#;" -->
        <img src="/image/img_main_1.jpg" alt=" 배경">
        <p class="hover_text">
            Communication and learning<br/>
            Welcome to Should be
        </p>
    </div>
    <!--메인 이미지 끝-->

    <!-- Carousel 시작 ----------------------------------------------------->
    <div id="demo" class="carousel slide" data-bs-ride="carousel">

        <!-- Indicators/dots -->
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
            <button type="button" data-bs-target="#demo" data-bs-slide-to="3"></button>
            <button type="button" data-bs-target="#demo" data-bs-slide-to="4"></button>
        </div>

        <!-- The slideshow/carousel -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src=">../../image/banner/banner1.png" alt="banner1" class="d-block" style="width:100%">
            </div>
            <div class="carousel-item">
                <img src="../../image/banner/banner2.png" alt="banner2" class="d-block" style="width:100%">
            </div>
            <div class="carousel-item">
                <img src="../../image/banner/banner3.png" alt="banner3" class="d-block" style="width:100%">
            </div>
            <div class="carousel-item active">
                <img src="../../image/banner/banner4.png" alt="banner4" class="d-block" style="width:100%">
            </div>
            <div class="carousel-item">
                <img src="../../image/banner/banner5.png" alt="banner5" class="d-block" style="width:100%">
            </div>
        </div>

        <!-- Left and right controls/icons -->
        <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>

    <!-- Carousel 끝 -->

    <!--인트로 박스 시작------------------------------------------------------>
    <div id="intro-box">
        <div class="intro">
            <img id="intro_phone" src="../../image/main/chat.png">
            <p>Talk to native speakers through real-time chat!</p>
        </div>
        <div class="intro">
            <p>Learn different languages!</p>
            <img id="intro_map" src="../../image/main/map.png">
        </div>
        <div class="intro">
            <img id="intro_laptop" src="../../image/main/community.png">
            <p>You can interact with a variety of people!</p>
        </div>
    </div>
    <!--인트로 박스 끝 -->

    <!--셀렉트 버튼 시작------------------------------------------------------>
    <div class="select_box">
        <a href="${pageContext.servletContext.contextPath}/mypage/" class="box">
            <img class="select_box_img" src="/image/img_selectbox_people.png">
            <div class="select_box_text">MY<br/>PAGE</div>
        </a>
        <a href="${pageContext.servletContext.contextPath}/board/notice" class="box">
            <img class="select_box_img" src="/image/img_selectbox_board.png">
            <div class="select_box_text">BOARD</div>
        </a>
        <a href="${pageContext.servletContext.contextPath}/quiz/main" class="box">
            <img class="select_box_img" src="/image/img_selectbox_quiz.png">
            <div class="select_box_text">QUIZ</div>
        </a>
        <a href="${pageContext.servletContext.contextPath}/chat/list" class="box">
            <img class="select_box_img" src="/image/img_selectbox_chat.png">
            <div class="select_box_text">CHAT</div>
        </a>
    </div>
    <!--셀렉트 버튼 끝-->


    <!--유튜브 박스 시작----------------------------------------------------->
    <div class="youtube_box">
        <div class="youtube_video"><!--1.7777배-->
            <iframe id="youtube_iframe" src="https://www.youtube.com/embed/IcFD_MKHa7M?si=82yNyVvjhcA24jau"
                    title="YouTube video player" frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                    allowfullscreen></iframe>
        </div>
        <div class="youtube_link_box">
            <ul class="youtube_link_list">
                <li class="link_title">추천 영상</li>
                <li class="youtube_link" id="https://www.youtube.com/embed/IcFD_MKHa7M?si=82yNyVvjhcA24jau"
                    style="background-color:#ddd">
                    <div>[프랭크쌤영어_레벨2]왕초보영어회화1강</div>
                </li>
                <div class="jb-text">[프랭크쌤영어_레벨2]왕초보영어회화1강</div>
                <li class="youtube_link" id="https://www.youtube.com/embed/WLMBviBCwIU?si=py5kV8w-moGMkQYq">
                    <div>10시간 자연스러운 영어 듣기 연습 ( 자막 있음 )</div>
                </li>
                <div class="jb-text">10시간 자연스러운 영어 듣기 연습 ( 자막 있음 )</div>
                <li class="youtube_link" id="https://www.youtube.com/embed/P42xvsj7J_U?si=v4ycUwKDDkNMKjQU">
                    <div>미드 프렌즈(Friends) 시즌1 전체 영어표현 409 문장 연속듣기 (영어회화, 영어공부)</div>
                </li>
                <div class="jb-text">미드 프렌즈(Friends) 시즌1 전체 영어표현 409 문장 연속듣기 (영어회화, 영어공부)</div>
                <li class="youtube_link" id="https://www.youtube.com/embed/_50HS70urTw?si=PeY1Qa1aaKgm_flI">
                    <div>생활영어 1000문장 그냥 틀어두십쇼 1,2,3편 몰아듣기</div>
                </li>
                <div class="jb-text">생활영어 1000문장 그냥 틀어두십쇼 1,2,3편 몰아듣기</div>
                <li class="youtube_link" id="https://www.youtube.com/embed/XtaV2XKryQI?si=z-qzKHI_t0sGnGPr">
                    <div>영어회화 300문장 켜놓고 흘려듣기 하세요 | 생활영어 | 영어공부</div>
                </li>
                <div class="jb-text">영어회화 300문장 켜놓고 흘려듣기 하세요 | 생활영어 | 영어공부</div>
                <li class="youtube_link" id="https://www.youtube.com/embed/dChiYEk7Lxc?si=nGdxrRha0jlF8B5b">
                    <div>이 영상 하나면 영어 어순 이해 끝 ! (영어 말 순서)</div>
                </li>
                <div class="jb-text">이 영상 하나면 영어 어순 이해 끝 ! (영어 말 순서)</div>
            </ul>
        </div>
    </div>
    <!--유튜브 박스 끝-->

    <!--광고 이미지 시작------------------------------------------------------>
    <a href="http://www.yanadoo.co.kr" class="main_ad_box">
        <img src="/image/img_main_ad2.jpg">
    </a>
    <a href="https://www.kyowonedu.com/KEP/Aicando.jsp" class="main_ad_box">
        <img src="/image/img_main_ad.png">
    </a>
    <!--광고 이미지 끝-->


</main>
</body>

</html>