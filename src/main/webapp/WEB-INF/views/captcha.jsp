<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Captcha</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            margin: 0 auto;
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        main {
            width: 1200px;
            margin: 30px auto;
            display: flex;
            justify-content: space-evenly;
            align-items: center;
            flex-direction: column;
        }
        .submitBtn {
            background-color: #ffe3a0;
            border: none;
            color: black;
            outline: none;
            border: 0;
            padding: 10px 20px;
            text-transform: uppercase;
            margin-top: 20px;
            border-radius: 2px;
            cursor: pointer;
            position: relative;
        }
    </style>
    <script>
        function resetRefreshData() {
            localStorage.setItem('refreshData', JSON.stringify({ count: 0, lastRefreshTime: new Date().getTime() }));
        }
        window.onload = resetRefreshData;
    </script>
</head>
<body class="no-reload-on-back">
<main class="no-reload-on-back">
    <h1 style="margin-bottom: 3px">CAPTCHA</h1>
    <div style="width: 600px; padding: 10px; display: flex; flex-direction: column; justify-content: center">
        <img src="${pageContext.servletContext.contextPath}${captchaImagePath}" alt="Captcha Image" style="width:590px; margin-bottom: 10px;">
        <audio controls style="width: 590px">
            <source src="${pageContext.servletContext.contextPath}${captchaAudioPath}" type="audio/wav">
            Your browser does not support the audio element.
        </audio>
        <br>
        <form style="display: flex; flex-direction: row; align-items: center;" action="/refresh/verifyCaptcha" method="post">
            <input type="text" name="captchaInput" id="captchaInput" placeholder="Enter Captcha" style="width: 470px; height: 40px;">
            <input type="button" value="CHECK" id="checkCaptcha" class="btn btn-warning submitBtn" style="margin-top:0; margin-left:20px; border: none" />
        </form>
    </div>
</main>
<script>
    document.getElementById("checkCaptcha").addEventListener("click", function() {
        document.querySelector("form").submit();
    });
</script>
</body>
</html>
