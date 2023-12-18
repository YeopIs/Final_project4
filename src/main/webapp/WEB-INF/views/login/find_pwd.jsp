<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FIND PASSWORD</title>
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

        #find_pwd_form > h1 {
            text-align: center;
        }

        li {
            list-style-type: none;
            margin-top: 5px;
            margin-bottom: 5px;
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

        .inputs {
            width: 400px;
            height: 40px;
            line-height: 40px;
            margin: 5px 0;
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
    </style>
    <script>
        $(function () {
            $("#find").click(function () {
                event.preventDefault();

                var userid = $("#userid").val();
                var email = $("#email").val();
                $.ajax({
                    type: "POST",
                    url: "/login/sendcode",
                    data: {userid: userid, email: email},
                    success: function (r) {
                        console.log(r);
                        if (r == true) {
                            $("#verification").show();
                            $("#result").text("Your email has been sent.");

                        } else {
                            $("#verification").hide();
                            $("#result").text("This ID or email does not exist!");

                        }
                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                });
            });

            $("#verifybtn").click(function () {
                event.preventDefault();

                var userid = $("#userid").val();
                var code = $("#code").val();
                var email = $("#email").val();
                $.ajax({
                    type: "POST",
                    url: "/login/verify",
                    data: {userid: userid, code: code, email: email},
                    success: function (r) {
                        console.log(r);
                        if (r == true) {

                            alert("Your changed password has been sent to your email.");
                            location.href = '/';
                        } else {
                            alert("An error occurred!")
                        }


                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                });
            })
        });


    </script>
</head>
<body>
<main>
    <div class="box">
        <img src="${pageContext.servletContext.contextPath}/image/img_main_3.jpg" alt="Login Image">
        <div class="form-container">
            <h2 style="text-align: center">
                FIND PASSWORD
            </h2>
            <br>
            <form method="post" id=find_pwd_form>
                <div class="input-container">
                    <input type="text" name="userid" id="userid" class="inputs" required=""/>
                    <label>USER ID</label>
                </div>
                <div class="input-container">
                    <input type="text" name="email" id="email" class="inputs" required=""/>
                    <label>USER EMAIL</label>
                </div>
                <button type="submit" name="find" id="find" class="submitBtn">SEND AUTHENTICATION CODE</button>

                <div id="result" style="text-align: center; color: #332913; margin-top: 5px"></div>
                <div id="verification" style="display: none; margin-top: 30px">
                    <div class="input-container">
                        <input type="text" name="code" id="code" class="inputs" required=""/>
                        <label>ENTER AUTHENTICATION CODE</label>
                    </div>
                    <input type="submit" id="verifybtn" class="submitBtn"/>
                </div>
            </form>
        </div>
    </div>
</main>
</body>
</html>
