<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CREATE SUCCESS</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            margin: 0 auto;
        }

        main {
            width: 1200px;
            height: 600px;
            margin: 30px auto;
            display: flex;
            justify-content: space-evenly;
            align-items: center;
            flex-direction: column;
        }

        #find_pwd_form > h1 {
            text-align: center;
        }

        li {
            list-style-type: none;
            margin-top: 5px;
            margin-bottom: 5px;
        }

        .submitbtn {
            background-color: #FFB300;
            border: none;
            color: white;
            width: 400px;
            height: 40px;
            line-height: 40px;
        }
    </style>
    <script>

    </script>
</head>
<body>
<main>
    <h1>REGISTER SUCCESS</h1>
    <ul>
        <li style="margin-bottom: 10px">
            <input type="button" value="MAIN" class="submitbtn" onclick="location.href='../../..'"/></li>
        <li style="margin-bottom: 10px"><input type="button" value="LOGIN" onclick="location.href='/login'"
                                               class="submitbtn"/></li>

    </ul>


</main>
</body>
</html>
