<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FIND ID</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            margin: 0 auto;
        }

        main {
            display: flex;
            height: auto;
            align-items: center;
            justify-content: center;
            padding: 50px;
            box-sizing: border-box;
            margin-top: 50px;
        }

        .box {
            display: flex;
            width: 1000px;
            height: 564px;
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

        .submitBtn:hover {
            background-color: #F29727;
        }

        .input-container input:focus ~ label,
        .input-container input:valid ~ label {
            top: -20px;
            left: 0;
            font-size: 12px;
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
        }

        .input-container input:focus {
            border: none;
            outline: none;
            border-bottom: 1px solid #e74c3c;
        }

        .input-container input:focus ~ label,
        .input-container input:valid ~ label {
            top: -12px;
            font-size: 12px;

        }

        #finded {
            width: 100%;
            display: none;
            text-align: center;
            margin-top: 20px;
        }

        #finded > p {
            margin-bottom: 20px;
        }

        #result {
            font-weight: bold;
        }
    </style>
    <script>
        $(function () {
            $("#find_pwd").on('click', function () {
                location.href = "/login/findpwd";
            });
            $("#back").on('click', function () {
                location.href = "/login";
            });
            $("#find").click(function () {
                event.preventDefault();
                var username = $("#username").val();
                var email = $("#email").val();
                $.ajax({
                    type: "POST",
                    url: "/login/findidOk",
                    data: {username: username, email: email},
                    success: function (r) {
                        console.log(r);
                        if (r == "") {
                            $("#finded").css('display', 'block');
                            $("#find_pwd").css('display', 'none');
                            $("#result").text("ID not found.");
                        } else {
                            $("#finded").css('display', 'block');
                            $("#find_pwd").css('display', 'block');
                            $("#result").text("Your ID is " + r + " .");

                        }


                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                });

            });


        });
    </script>
</head>

<body>
<main>
    <div class="box">
        <img src="${pageContext.servletContext.contextPath}/image/img_main_3.jpg" alt="Login Image">
        <div class="form-container">
            <h2 style="text-align: center">
                FIND ID
            </h2>
            <br>
            <form method="post" id="find_id_form">
                <div class="input-container">
                    <input type="text" name="username" id="username" required=""/>
                    <label>USER NAME</label>
                </div>
                <div class="input-container">
                    <input type="text" name="email" id="email" required=""/>
                    <label>USER EMAIL</label>
                </div>
                <button type="submit" name="find" id="find" class="submitBtn">FIND ID</button>
            </form>
            <div id="finded">
                <hr/>
                <p id="result"></p>
                <input type="button" value="GO TO LOGIN PAGE" class="submitBtn" id="back"/>
                <input type="button" value="FIND PASSWORD" class="submitBtn" id="find_pwd"/>
            </div>
        </div>
    </div>
</main>
</body>

</html>