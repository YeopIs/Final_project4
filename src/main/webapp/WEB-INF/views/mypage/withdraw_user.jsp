<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WITHDRAW</title>
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
            margin-top: 20px;
            width: 80%;
            display: flex;
            flex-direction: column;
            align-items: center;
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

        .account-deletion-form {
            width: 100%;
        }

        #withdraw-div {
            margin-top: 100px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .submitBtn {
            background-color: #FFB300;
            border: none;
            color: white;
        }

        .input-container {
            position: relative;
            margin-bottom: 25px;
        }

        .input-container label {
            position: absolute;
            top: 0;
            left: 0;
            font-size: 16px;
            pointer-event: none;
            transition: all 0.5s ease-in-out;
        }

        .input-container input {
            border: 0;
            border-bottom: 1px solid #555;
            background: transparent;
            width: 100%;
            padding: 8px 0 5px 0;
            font-size: 16px;
            margin: 5px 0;
        }

        .input-container input:focus {
            border: none;
            outline: none;
            border-bottom: 1px solid #e74c3c;
        }

        .btn {
            color: #fff;
            outline: none;
            border: 0;
            padding: 10px 20px;
            text-transform: uppercase;
            margin-top: 30px;
            border-radius: 2px;
            cursor: pointer;
            position: relative;
        }

        .input-container input:focus ~ label,
        .input-container input:valid ~ label {
            top: -12px;
            font-size: 12px;

        }

        .box {
            display: flex;
            flex-direction: column;
            width: 400px;
        }

        .withdraw-box {
            width: 100%;
            display: flex;
            align-items: center;
            flex-direction: column;
            margin-top: 170px;
        }
    </style>
    <script>
        function confirmDeletion() {
            var password = $('#password').val();
            var password_confirm = $('#password-confirm').val();
            var userConfirmed;
            if (password != password_confirm) {
                alert("Passwords do not match. Please enter again.");
                return false;
            } else if (password == "") {
                alert("Please enter a password.");
                return false;
            } else {
                userConfirmed = confirm("Are you sure you want to withdraw?");
            }

            if (!userConfirmed) {
                return false;
            }
        }
    </script>
</head>

<body>
<div id="wrapper" class="container-fluid">
    <div id="sidebar">
        <br>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.servletContext.contextPath}/mypage/">USER INFO</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/change_user">INFO EDIT</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/post_user">POST LIST</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/friend_user">FRIENDS</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/save_chat">STORE</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/withdraw_user" class="active">WITHDRAW</a></li>
        </ul>
    </div>
    <div id="content">
        <div class="withdraw-box">
            <form method="get" action="${pageContext.servletContext.contextPath}/mypage/withdrawOk">
                <input type="hidden" name="user_id" id="user_id" value="${logId}"/>
                <div class="box">
                    <div class="input-container">
                        <input type="password" name="password" id="password" required=""/>
                        <label for="password" class="form-label">PASSWORD</label>
                    </div>
                    <div class="input-container">
                        <input type="password" name="password-confirm" id="password-confirm" required=""/>
                        <label for="password" class="form-label">PASSWORD CONFIRM</label>
                    </div>
                    <button type="submit" class="btn btn-warning submitBtn" onclick="confirmDeletion()">WITHDRAW</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>