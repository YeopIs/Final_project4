<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>BOARD : EDIT</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        main {
            width: 1000px;
            margin: 0 auto;
        }

        #replyList > li {
            border-bottom: 1px solid #ddd;

        }

        /* 초기화 */
        body,
        ul,
        li {
            margin: 0;
            padding: 0;
            list-style-type: none;
        }

        /* link초기화 */
        a:link,
        a:visited,
        a:hover,
        a:active {
            color: black;
            text-decoration: none;
        }

        #writeButton {
            text-align: center;
        }
    </style>
    <script>
        window.onload = function () {
            document.getElementById("cancelBtn").onclick = function () {
                window.history.back();
            }
        }
    </script>

<body>
<main>
    <br>
    <h2> 게시글 수정 :
        <c:if test="${vo.board_cat=='free'}">FREE</c:if>
        <c:if test="${vo.board_cat=='notice'}">NOTICE</c:if>
        <c:if test="${vo.board_cat=='inquiries'}">INQUIRE</c:if>
    </h2>
    <br>
    <form method="post"
          action="${pageContext.servletContext.contextPath}/board/${vo.board_cat}/editOk">
        <div class="mb-3">
            <!-- todo: 제목에 ",'등 처리 하는법, 내용 엔터처리 -->
            <label for="exampleFormControlInput1" class="form-label">TITLE</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" name="title" value='${vo.title}'>
            <input type="hidden" name="post_id" value="${vo.post_id}"/>
        </div>
        <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label">CONTENT</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" rows="10" name="content">${vo.content}</textarea>
        </div>
        <div id="writeButton">
            <button type="button" class="btn btn-secondary" id="cancelBtn">CANCEL</button>
            <button type="submit" class="btn btn-warning">WRITE</button>
        </div>
    </form>


</main>
</body>

</html>