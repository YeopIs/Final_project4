<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BOARD : POST WRITE</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        main {
            width: 1000px;
            margin: 0 auto;
        }

        /* 초기화 */
        body,
        ul,
        li {
            margin: 0;
            padding: 0;
            list-style-type: none;
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
        document.addEventListener('DOMContentLoaded', function () {
            var manager = ${manager}
            var submitBtn = document.getElementById('submitBtn');
            if (manager !== 'Y') {
                submitBtn.addEventListener('click', function (event) {
                    event.preventDefault();
                    alert('You are not an administrator!');
                });
            }
        });
    </script>
</head>

<body>
<main>
    <br>
    <h2>POST WRITE :
    <c:if test="${category=='free'}">FREE</c:if>
    <c:if test="${category=='notice'}">NOTICE</c:if>
    <c:if test="${category=='inquiries'}">INQUIRE</c:if>
    </h2>
    <br>
    <form method="post"
          action="${pageContext.servletContext.contextPath}/board/${category}/writeOk">
        <div class="mb-3">
            <label for="exampleFormControlInput1" class="form-label">TITLE</label>
            <input type="text" class="form-control" id="exampleFormControlInput1" placeholder="INSERT TITLE" name="title">
        </div>
        <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label">CONTENT</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" rows="10"
                      placeholder="INSERT CONTENT" name="content"></textarea>
        </div>
        <div id="writeButton">
            <button type="button" class="btn btn-secondary" id="cancelBtn">CANCEL</button>
            <button type="submit" class="btn btn-warning">POST</button>
        </div>
    </form>

</main>
</body>

</html>