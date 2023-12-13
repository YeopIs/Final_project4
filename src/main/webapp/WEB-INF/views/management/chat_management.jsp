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
            margin-top:50px;
            width: 1200px;
            height: auto;
            display: flex;
            flex-direction: row;
            background-color: rgba(255, 255, 255, 0);
            box-shadow: inset 0 0 10px rgba(0, 0, 0, 0);
        }
        .container {
            width: 1200px;
            display: flex;
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

        #member_management {
            width: 900px;
            height: auto;
            margin: 50px auto;
            display: flex;
            flex-direction: column;

        }

        #quiz_list_title {
            text-align: center;
        }

        /*#quiz_grade{
            display: flex;
            flex-direction: column;
              justify-content: space-around;
              margin: 10px auto;
        }*/

        /*리스트 내용*/
        #list_head {
            border-top: 4px solid #000;
            border-bottom: 4px solid #000;
        }

        a:link,
        a:visited,
        a:hover,
        a:active {
            color: black;
            text-decoration: none;
        }

        .management_list th {
            height: 50px;
            line-height: 50px;
            text-align: center;
        }

        .management_list td {
            padding: 0 10px;
            height: 75px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: center;
        }

        #list_content {
            border-bottom: 1px solid #000000;
        }

        .management_list .chat_content {
            width: 40%;
            text-align: center;
        }

        #side_menu li a.active{
            background-color: #000000;
            color: white;
        }

        .pagination {
            justify-content: center;
        }

        .pagination .page-link {
            color: black;
            text-decoration: none;
            background-color: transparent;
        }

        /* Style for the active page link */
        .pagination .page-link.active {
            background-color: #ffe3a0;
            color: black;
        }
        .tr_list>td{
            border-bottom: 1px solid #000000;
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
            <li><a href="${pageContext.servletContext.contextPath}/admin/quiz/list">퀴즈관리</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/admin/chat/management" class="active">채팅관리</a></li>

        </ul>
    </div>
    <div id="member_management">
        <h1 id="quiz_list_title">채팅 관리</h1>
        <div class="col-sm-12">
            <table id="example" class="display" style="width:100%">
                <thead id="list_head">
                <tr class="management_list">
                    <th class="reported_id">신고받은 ID</th>
                    <th class="chat_content">채팅 내용</th>
                    <th class="report_count">신고일</th>
                    <th class="suspend_button">계정 정지</th>
                    <th class="delete_button">신고 취소</th>
                </tr>
                </thead>
                <tbody id="list_content">
                <c:forEach var="acVO" items="${aclist}">
                    <tr class="tr_list" style="text-align: center;">
                        <td class="reported_id">${acVO.user_id}</td>
                        <td class="chat_content">
                            <div class="origin">
                                    ${acVO.content}
                            </div>

                        </td>
                        <td class="report_count">${acVO.report_time}</td>
                        <td class="suspend_button">
                            <a href="#layer-popup" class="btn-open" title="">
                                <input id="msg_report_id" name="report_id" type="hidden" value="${acVO.message_report_id}">
                                <input id="btn_userid" name="user_id" type="hidden" value="${acVO.user_id}">
                                <input type="button" value="계정정지" class="btn btn-dark suspend_btn">
                            </a>
                        </td>
                        <td class="delete_button">
                            <a href="${pageContext.servletContext.contextPath}/chatDelete?message_report_id=${acVO.message_report_id}">
                                <input type="button" value="신고 취소" class="btn btn-dark">
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <div>
            <div class="pagination-container" style="margin: 0 auto; margin-top: 20px; width: fit-content">
                <div class="pagination" style="display: flex">
                    <div class="paging">
                        <ul class="pagination justify-content-center d-flex">
                            <c:if test="${pVO.nowPage > 1}">
                                <li class="page-item"><a class="page-link" href="?page=${pVO.nowPage - 1}"><
                                </a></li>
                            </c:if>
                            <c:forEach var="i" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount - 1}">
                                <c:if test="${i <= pVO.totalPage}">
                                    <c:choose>
                                        <c:when test="${i != pVO.nowPage}">
                                            <li class="page-item"><a class="page-link" href='?page=${i}'>${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item"><a class="page-link active" href="">${i}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                            <c:if test="${pVO.nowPage < pVO.totalPage}">
                                <li class="page-item"><a class="page-link" href="?page=${pVO.nowPage + 1}">>
                                </a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="layer-popup" id="layer-popup">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="${pageContext.servletContext.contextPath}/suspend/chat">
                <div class="mb-3 mt-3">
                    <input type="hidden" id="form_reportid" name="report_id" value="">
                    <input type="hidden" id="form_userid" name="user_id" value="">
                    <label class="form-label">정지 시간:</label>
                    <!--<input type="text" value="" class="form-control" name="time" id="time" placeholder="Enter email">-->
                    <select id="time" name="time">
                        <option value="1">1일</option>
                        <option value="3">3일</option>
                        <option value="7">7일</option>
                        <option value="15">15일</option>
                        <option value="30">30일</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">정지 사유:</label>
                    <input type="text" class="form-control"name="reason" id="form_reason" placeholder="사유를 입력해주세요" >
                </div>
                <button type="submit" class="btn btn-primary">정지</button>
                <button type="button" class="btn btn-primary" onclick="dialogCancel()">취소</button>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).on("click", ".btn-open", function (e){
        var target = $(this).attr("href");
        var rid=$(this).children("#msg_report_id").val();
        var uid=$(this).children("#btn_userid").val();
        $(target).addClass("show");
        $("#form_userid").attr("value",uid);
        $("#form_reportid").attr("value",rid);
    });

    // 외부영역 클릭 시 팝업 닫기
    $(document).mouseup(function (e){
        var LayerPopup = $(".layer-popup");
        if(LayerPopup.has(e.target).length === 0){
            LayerPopup.removeClass("show");
        }
    });

    function dialogCancel(){
        var LayerPopup = $(".layer-popup");
        LayerPopup.removeClass("show");
    }
</script>
<style>
    .layer-popup {
        display: none;
        position: fixed;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 100;
    }

    .layer-popup.show {
        display: block;
    }

    .modal-dialog {
        width: 500px;
        margin: 40px auto;
        background-color: #fff;
    }

    .modal-content {
        padding:10px 15px;
        text-align: center;
    }
</style>


</body>
</html>