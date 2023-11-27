<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>관리자 페이지 _ 댓글관리</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .container {
            display: flex;
            flex-direction: row;
        }
        #side_menu{
            padding:98px 0 0 0;
            width:150px;
            height:1000px;
            list-style-type: none;
        }
        #side_menu>li>a{
            text-decoration: none;
            color: black;
            display: block;
            padding: 10px;
        }
        #side_menu li a:hover{
            background-color: #ddd;
        }
        main {
            width: 1200px;
            height:1000px;
            margin: 50px auto;
            display: flex;
            flex-direction: column;
        }
        #ReplyListTitle{
            text-align: center;
        }

        #list_head{
            border-top: 4px solid #000;
            border-bottom: 4px solid #000;
        }
        .reply_list th{
            width:120px;
            height:40px;
            line-height: 40px;
            text-align: center;
        }
        .reply_list td{
            padding: 0 10px;
            max-width:120px;
            width:120px;
            height:100px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: center;
        }
        .reply_list th:nth-child(7n+3), .reply_list td:nth-child(7n+3){
            max-width: 260px;
            width: 260px;
        }
        #list_content{
            border-bottom: 1px solid #ddd;
        }
    </style>
</head>

<body>
    <div class="container">
        <nav>
            <ul id="side_menu">
                <li><a href="${pageContext.servletContext.contextPath}/admin">대시보드</a></li>
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
            <h1 id="ReplyListTitle">댓글 관리</h1>
            <div class="input-group mb-3" id="searchNickname" style="width: 250px;">
                <input type="text" class="form-control" placeholder="닉네임 검색">
                <button class="btn btn-dark" type="submit">검색</button>
            </div>

            <div class="col-sm-12" id="boardList">
                <table id="example" class="display" style="width:100%">
                    <thead id="list_head">
                        <tr class="reply_list">
                            <th class="board">게시판</th>
                            <th class="board_title">글제목</th>
                            <th class="reply_content">댓글내용</th>
                            <th class="user_id">작성자</th>
                            <th class="report_count">신고횟수</th>
                            <th class="report_reason">신고사유</th>
                            <th class="del_button"></th>
                        </tr>
                    </thead>
                    <tbody id = "list_content">
                        <tr class="reply_list">
                            <td class="board_title">자유게시판</td>
                            <td class="board_title">글제목입니다</td>
                            <td class="reply_content">댓글내용입니다</td>
                            <td class="user_id">userid</td>
                            <td class="report_count">1</td>
                            <td class="report_reason">댓글도배</td>
                            <td class="del_button"><input type="button" value="댓글삭제" class="btn btn-dark"></td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </main>
    </div>
</body>

</html>