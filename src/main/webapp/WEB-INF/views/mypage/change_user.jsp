<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>USER INFO CHANGE</title>
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

        .row {
            display: flex;
            justify-content: center;
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

        #userEditForm {
            width: 700px;
        }

        .btn-outline-secondary{
            width: 130px;
            margin-right: 10px;
        }

        .btn-outline-secondary{
            margin-bottom: 10px;
        }
    </style>
    <script>
        $(document).ready(function() {
            $("#changeimg").click(function() {
                $("#imgUpload").click();
            });
            $("#imgUpload").change(function() {
                var formData = new FormData();
                formData.append('filename', this.files[0]);

                $.ajax({
                    url: "${pageContext.servletContext.contextPath}/mypage/profileimgChangeOk",
                    type: "post",
                    data: formData,
                    async: false,
                    processData: false, // 필수 옵션
                    contentType: false, // 필수 옵션
                    success: function(result) {
                        console.log(result);
                        location.reload();
                    },
                    error: function(error) {
                        console.log(error.responseText);
                        document.location.reload();
                    }
                });
            });
        });

        $(function () {
            $("#userEditForm").submit(function(){
                if($("#pwd").val() == ""){
                    alert("비밀번호를 입력해주세요.");
                    return false;
                }
                if($("#pwd").val() != $("#pwd-confirm").val()){
                    alert("비밀번호가 일치하지 않습니다.");
                    return false;
                }
            });


            var user_id = $("#userid").val();
            $(document).on('click', '#basicimg',function () {
                event.preventDefault();
                $.ajax({
                    url: "${pageContext.servletContext.contextPath}/mypage/basicimg",
                    type: "post",
                    data: {
                        user_id: user_id
                    },
                    async: false,
                    processData: false,
                    contentType: false,
                    success: function(result){
                        document.location.reload();
                    },
                    error : function(error){
                        console.log(error.responseText);
                    }
                });
            });
        });

        document.addEventListener('DOMContentLoaded', function() {
            var selectedLanguages = '${myvo.lang}'.split('/');
            selectedLanguages.forEach(function(lang) {
                var checkbox = document.getElementById('lang-' + lang);
                if (checkbox) {
                    checkbox.checked = true;
                }
            });

        });

    </script>
</head>

<body>
<div id="wrapper" class="container-fluid">
    <div id="sidebar">
        <br/>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.servletContext.contextPath}/mypage/">USER INFO</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/change_user" class="active">INFO EDIT</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/post_user">POST LIST</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/friend_user">FRIENDS</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/save_chat">STORE</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/mypage/withdraw_user">WITHDRAW</a></li>
        </ul>
    </div>
    <div id="content" class="col-10">

        <div class="text-center mb-3">
            <img src="${pageContext.servletContext.contextPath}/image/profile/${myvo.profile_img}" id="profile_img" name="profile_img"
                 class="rounded-circle" alt="Profile Image" style="width: 150px; height: 150px; object-fit: cover;"
                 >
        </div>

        <div class="text-center">
            <button type="button" class="btn btn-warning me-2" id="changeimg" onclick="changeImg()">CHANGE IMAGE</button>
            <input type="file" id="imgUpload" style="display: none">
            <button type="button" class="btn btn-secondary" id="basicimg">DEFAULT</button>
        </div>

        <form method="post" action="${pageContext.servletContext.contextPath}/mypage/editProfileOk" id="userEditForm">
            <div class="row mb-3 mt-3">
                <label for="userid" class="col-sm-2 col-form-label">ID</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="userid" name="user_id" value="${myvo.user_id}">
                </div>
            </div>
            <div class="row mb-3">
                <label for="pwd" class="col-sm-2 col-form-label">NOW PWD</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" placeholder="Enter password" name="now_password">
                </div>
            </div>
            <div class="row mb-3">
                <label for="pwd" class="col-sm-2 col-form-label">NEW PWD</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password">
                </div>
            </div>
            <div class="row mb-3">
                <label for="pwd-confirm" class="col-sm-2 col-form-label">NEW PWD CHECK</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="pwd-confirm" placeholder="Confirm password"
                           name="pwd-confirm">
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label">LANGUAGE AVAILABLE</label>
                <div class="col-sm-10">
                    <input type="checkbox" class="btn-check" name="lang" id="lang-ko" value="ko" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-ko">한국어</label>

                    <input type="checkbox" class="btn-check" name="lang" id="lang-en" value="en" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-en">English</label>

                    <input type="checkbox" class="btn-check" name="lang" id="lang-ja" value="ja" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-ja">日本語</label>

                    <input type="checkbox" class="btn-check" name="lang" id="lang-zn-CN" value="zn-CN" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-zn-CN">中國語-简体</label>

                    <input type="checkbox" class="btn-check" name="lang" id="lang-zn-TW" value="zn-TW" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-zn-TW">中國語-繁体</label>

                    <input type="checkbox" class="btn-check" name="lang" id="lang-vi" value="vi" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-vi">Tiếng Việt</label>

                    <input type="checkbox" class="btn-check" name="lang" id="lang-th" value="th" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-th">แบบไทย</label>

                    <input type="checkbox" class="btn-check" name="lang" id="lang-id" value="id" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-id">Indonésia</label>

                    <input type="checkbox" class="btn-check" name="lang" id="lang-fr" value="fr" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-fr">Français</label>

                    <input type="checkbox" class="btn-check" name="lang" id="lang-es" value="es" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-es">Español</label>

                    <input type="checkbox" class="btn-check" name="lang" id="lang-ru" value="ru" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-ru">Русский</label>

                    <input type="checkbox" class="btn-check" name="lang" id="lang-de" value="de" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-de">Deutsch</label>

                    <input type="checkbox" class="btn-check" name="lang" id="lang-it" value="it" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-it">Italiano</label>
                </div>


            </div>
            <div class="row mb-3">
                <label for="intro" class="col-sm-2 col-form-label">ABOUT ME</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="intro" placeholder="Write introduction"
                           name="profile_content" value="${myvo.profile_content}">
                </div>
            </div>
            <div class="row">
                <button type="submit" id="edit" class="btn btn-warning" style="width: auto">EDIT</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>