<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>New Chat Partners</title>
    <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border-radius: 10px;
        }

        .container h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        .user-list {
            list-style-type: none;
            padding: 0;
        }

        .user-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }

        .user-list li {
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }
        .user-details {
            display: flex;
            align-items: center;
        }
        .user-image {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px;
        }
        .user-info h3 {
            margin: 0;
            margin-bottom: 5px;
        }

        .user-info p {
            margin: 2px 0;
        }

        .start-chat-btn {
            text-decoration: none;
            color: black;
            padding: 5px 10px;
            border: 1px solid black;
            border-radius: 4px;
            white-space: nowrap;
        }

        .start-chat-btn:hover {
            background-color: #ffe3a0;
            color: black;
        }

        .pagination {
            justify-content: center;
        }

        .pagination .page-link {
            color: black;
            text-decoration: none;
            background-color: transparent;
        }

        .pagination .page-link.active {
            background-color: #ffe3a0;
            color: black;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Find New Chat Partners</h2>
    <ul class="user-list">
        <c:forEach var="user" items="${partner}">
            <li class="user-item">
                <div class="user-details">
                    <img src="${pageContext.servletContext.contextPath}/image/profile/${user.profile_img}" alt="${user.username}" class="user-image" />
                    <div class="user-info">
                        <h3>${user.userid}</h3>
                        <p>EMAIL: ${user.email}</p>
                        <p>NATION :
                            <c:choose>
                                <c:when test="${user.nation == 'ko'}">KOREA</c:when>
                                <c:when test="${user.nation == 'en'}">USA</c:when>
                                <c:when test="${user.nation == 'ja'}">JAPAN</c:when>
                                <c:when test="${user.nation == 'zn-CN'}">CHINA</c:when>
                                <c:when test="${user.nation == 'vi'}">VIETNAM</c:when>
                                <c:when test="${user.nation == 'th'}">THAILAND</c:when>
                                <c:when test="${user.nation == 'id'}">INDONESIA</c:when>
                                <c:when test="${user.nation == 'fr'}">FRANCE</c:when>
                                <c:when test="${user.nation == 'es'}">SPAIN</c:when>
                                <c:when test="${user.nation == 'ru'}">RUSSIA</c:when>
                                <c:when test="${user.nation == 'de'}">GERMANY</c:when>
                                <c:when test="${user.nation == 'it'}">ITALY</c:when>
                                <c:otherwise>${user.nation}</c:otherwise>
                            </c:choose>
                        </p>
                        <p>USE LANGUAGE :
                            <c:forEach var="langCode" items="${fn:split(user.lang, '/')}" varStatus="status">
                                <c:choose>
                                    <c:when test="${langCode == 'ko'}">한국어</c:when>
                                    <c:when test="${langCode == 'en'}">English</c:when>
                                    <c:when test="${langCode == 'ja'}">日本語</c:when>
                                    <c:when test="${langCode == 'zn-CN'}">中國語-简体</c:when>
                                    <c:when test="${langCode == 'zn-TW'}">中國語-繁体</c:when>
                                    <c:when test="${langCode == 'vi'}">Tiếng Việt</c:when>
                                    <c:when test="${langCode == 'th'}">แบบไทย</c:when>
                                    <c:when test="${langCode == 'id'}">Indonésia</c:when>
                                    <c:when test="${langCode == 'fr'}">Français</c:when>
                                    <c:when test="${langCode == 'es'}">Español</c:when>
                                    <c:when test="${langCode == 'ru'}">Русский</c:when>
                                    <c:when test="${langCode == 'de'}">Deutsch</c:when>
                                    <c:when test="${langCode == 'it'}">Italiano</c:when>
                                    <c:otherwise>${langCode}</c:otherwise>
                                </c:choose>
                                <c:if test="${!status.last}">, </c:if>
                            </c:forEach>
                        </p>
                        <p>ABOUT ME : ${user.profile_content}</p>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/chat/start?userId=${user.userid}" class="start-chat-btn">Start Chat</a>
            </li>
        </c:forEach>
    </ul>

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
</body>
</html>
