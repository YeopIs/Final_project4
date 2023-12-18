<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login Page</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            margin: 0;
        }

        main {
            display: flex;
            height: 500px;
            align-items: center;
            justify-content: center;
            padding: 50px;
            box-sizing: border-box;
            margin-top: 50px;
        }

        .box {
            display: flex;
            width: 1000px;
            height: auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        .box img {
            width: 50%;
            height: auto;
            object-fit: cover;
            display: block;
        }

        .form-container {
            flex-grow: 1;
            background: #fff;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;

        }

        .input-container {
            position: relative;
            margin-bottom: 15px;
        }

        .input-container input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .input-container label {
            position: absolute;
            top: 10px;
            left: 10px;
            transition: all 0.5s ease-in-out;
            background: #fff;
            padding: 0 5px;
        }

        .input-container input:focus + label,
        .input-container input:not(:placeholder-shown) + label {
            top: -10px;
            left: 10px;
            font-size: 12px;
            color: #332913;
        }

        .submitBtn {
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            border: none;
            background-color: #ffe3a0;
            color: black;
            cursor: pointer;
            margin-bottom: 20px;
        }

        .submitBtn:hover {
            background-color: #F29727;
        }

        #link ul {
            list-style-type: none;
            padding: 0;
            text-align: center;
            margin-top: 30px;
        }

        #link ul li {
            display: inline;
            margin: 0 10px;
        }

        #link ul li a {
            text-decoration: none;
            color: #332913;
        }

        #link ul li a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        $(document).ready(function () {
            var result = "${result}";
            if (result != "") {
                alert(result);
            }
        })
    </script>
</head>

<body>
<main>
    <div class="box">
        <img src="${pageContext.servletContext.contextPath}/image/img_main_3.jpg" alt="Login Image">
        <div class="form-container">
            <h2 style="text-align: center">
                WELCOME BACK!
            </h2>
            <br>
            <form method="post" action="/loginOk" id="loginForm">
                <div class="input-container">
                    <input type="text" name="userid" id="userid" required="" placeholder=" ">
                    <label for="userid">ID</label>
                </div>
                <div class="input-container">
                    <input type="password" name="userpwd" id="userpwd" required="" placeholder=" ">
                    <label for="userpwd">PW</label>
                </div>
                <button type="submit" name="login" id="login" class="btn btn-primary submitBtn">LOGIN</button>
            </form>
            <hr>
            <div id="link">
                <ul>
                    <li><a href="${pageContext.servletContext.contextPath}/captcha">REGISTER</a></li>
                    <li>|</li>
                    <li><a href="${pageContext.servletContext.contextPath}/login/findid">FIND ID</a></li>
                    <li>|</li>
                    <li><a href="${pageContext.servletContext.contextPath}/login/findpwd">FIND PW</a></li>
                </ul>
            </div>
        </div>
    </div>
</main>
</body>

</html>
