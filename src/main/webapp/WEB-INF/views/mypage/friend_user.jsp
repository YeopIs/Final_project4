<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FRIEND LIST</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        #wrapper {
            max-width: 1200px;
            margin: auto;
            display: flex;
        }

        #sidebar {
            padding: 20px;
            width: 20%;
            height: 100vh;
            border-right: 1px solid #ccc;
        }

        #content {
            padding: 20px;
            width: 70%;
        }

        .sidebar-menu {
            list-style-type: none;
            padding: 0;
        }

        .sidebar-menu li a {
            text-decoration: none;
            color: black;
            display: block;
            padding: 10px;
            transition: all 0.3s;
        }

        .sidebar-menu li a:hover {
            background-color: rgba(255, 227, 160, 0.3);
        }

        .active {
            background-color: #ffe3a0;
            color: white;
        }

        .friend-card {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .friend-avatar {
            margin-right: 10px;
        }

        .friend-info {
            flex-grow: 1;
        }

        .btn-action {
            margin-left: 5px;
        }

        .list-inline{
            padding: 10px 0;
        }

        .list-inline li a {
            text-decoration: none;
            color: black;
            font-size: 20px;
        }

        #now{
            padding: 5px;
            border-bottom: 3px solid #ffe3a0;
            font-weight: bold;
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

        #gochat_btn{
            text-decoration: none;
        }
    </style>
    <script>
        $(function () {
            // 친구삭제
            $(document).on('click', '#deletefriend', function () {
                var following_user_id = $("#following_user_id").val();
                var followed_user_id = $(this).attr("title");
                $.ajax({
                    url: '${pageContext.servletContext.contextPath}/mypage/deletefriend',
                    type: 'GET',
                    data: {
                        following_user_id: following_user_id,
                        followed_user_id: followed_user_id
                    },
                    success: function (response) {
                        document.location.reload();
                    },
                    error: function (error) {
                        console.log("An error occurred: " + error.responseText);
                    }
                });
            })
        });
    </script>
</head>

<body>
<div id="wrapper" class="container-fluid">
    <div id="sidebar">
        <br/>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.servletContext.contextPath}/mypage/">USER INFO</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/change_user">INFO EDIT</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/post_user">POST LIST</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/friend_user" class="active">FRIENDS</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/save_chat">STORE</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/withdraw_user">WITHDRAW</a></li>
        </ul>
    </div>
    <div id="content" class="col-10">
        <ul class="list-inline">
            <li class="list-inline-item"><a href="${pageContext.servletContext.contextPath}/mypage/friend_user" id="now">FRIENDS</a></li>
            <li class="list-inline-item"><a href="${pageContext.servletContext.contextPath}/mypage/blockList">BLOCK LIST</a>
            </li>
        </ul>
        <c:forEach var="flist" items="${flist}">
            <div class="friend-card"><!--ajax 처리-->
                <div class="friend-avatar">
                    <img src="${pageContext.servletContext.contextPath}/image/profile/${flist.profile_img}" alt="Friend's Avatar"
                         class="rounded-circle"
                         style="width: 50px; height: 50px;">
                </div>
                <div class="friend-info">
                    <input type="hidden" id="following_user_id" name="following_user_id"
                           value="${flist.following_user_id}"/>
                    <strong>${flist.following_user_id}</strong>
                    <p>${flist.profile_content}</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/chat?chat_id=${flist.chat_id}&other_user_id=${
                    flist.following_user_id}&from_id=${flist.from_id}" id="gochat_btn">
                        <button type="button" class="btn btn-warning btn-action">CHAT</button>
                    </a>
                    <button type="button" class="btn btn-outline-secondary btn-action" id="deletefriend"
                            title="${flist.followed_user_id}">DELETE
                    </button>
                </div>
            </div>
        </c:forEach>
        <div>
            <div>
                <div class="pagination-container" style="margin: 0 auto; margin-top: 20px; width: fit-content">
                    <div class="pagination" style="display: flex">
                        <div class="paging">
                            <ul class="pagination justify-content-center d-flex">
                                <c:if test="${pVO.nowPage > 1}">
                                    <li class="page-item"><a class="page-link" href="?page=${pVO.nowPage - 1}"><
                                    </a></li>
                                </c:if>
                                <c:forEach var="i" begin="${pVO.startPage}"
                                           end="${pVO.startPage + pVO.onePageCount - 1}">
                                    <c:if test="${i <= pVO.totalPage}">
                                        <c:choose>
                                            <c:when test="${i != pVO.nowPage}">
                                                <li class="page-item"><a class="page-link" href='?page=${i}'>${i}</a>
                                                </li>
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
</div>
</body>
</html>