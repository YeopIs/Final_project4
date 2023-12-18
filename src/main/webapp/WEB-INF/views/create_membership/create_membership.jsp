<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>REGISTER</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            margin: 0 auto;
        }

        main {
            width: 1200px;
            margin: 30px auto;
            display: flex;
            justify-content: space-evenly;
            align-items: center;
            flex-direction: column;
        }

        .box {
            width: 700px;
            display: flex;
            flex-direction: column;
            margin-top: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        #username, #userid, #userpwd, #userpwdCheck, #email, #authenticate {
            width: 470px;
            height: 40px;
            margin: 5px auto;
        }

        #join, #cancel {
            width: 100px;
            height: 40px;
            margin: 40px auto;
        }

        #create_Form {
            margin-left: 50px;
        }

        #checkcode, #idcheck, #sendcode {
            margin: 0 20px;
            width: 100px;
        }


        .lang {
            margin: 10px auto;
        }

        .input-container {
            position: relative;
            margin-top: 25px;
        }

        .input-container:nth-child(1) {
            margin-top: 0;
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
            border-bottom: 1px solid #332913;
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

        input[type=checkbox], input[type=radio] {
            margin: 0 0 0 20px;
            padding: 0;
        }

        select::-ms-expand {
            display: none;
        }

        .select {
            -o-appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            width: 130px;
            height: 38px;
            background: url("../../../image/select.png") no-repeat center right;
            padding: 5px 30px 5px 20px;
            border-radius: 4px;
            outline: 0 none;
            border: 2px solid #332913;
            cursor: pointer;
        }

        .select option {
            background: white;
            padding: 3px 0;
        }

        #termsCheck {
            margin-top: 30px;
        }

        .col-sm-10 {
            margin-left: 20px;
        }

        .btn-outline-secondary {
            width: 130px;
            margin: 5px 10px 0 0;
            color: black;
            background-color: white;
            border-width: 2px;
            border-color: #332913;
        }

        .btn-check:checked + .btn-outline-secondary {
            color: black;
            background-color: #FFE3A1;
        }
        .terms-content {
            width: 600px;
            height: 200px;
            overflow-y: scroll;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 10px;
        }
    </style>
    <script>
        $(document).ready(function () {
            var result = "${result}";
            if (result != "") {
                alert(result);
            }
        })
        var emailAuth = false;

        function checkpwd() {
            if (document.getElementById("userpwd").value != "" && document.getElementById("userpwdCheck").value != "") {
                if (document.getElementById("userpwd").value == document.getElementById("userpwdCheck").value) {
                    document.getElementById("passwordCheckOk").innerHTML = "The passwords match.";
                    document.getElementById("passwordCheckOk").style.color = "blue";
                    return true;
                } else {
                    document.getElementById("passwordCheckOk").innerHTML = "Passwords do not match!";
                    document.getElementById("passwordCheckOk").style.color = "red";
                    return false;
                }
            }
        }

        function isCheckedId() {
            if (document.getElementById("isIdChecked").value == "Y") {
                return true;
            }
            return false;
        }

        function isCheckedEmail() {
            if (emailAuth) {
                return true;
            }
            return false;

        }

        function isCheckedCaptcha(){
            if(document.getElementById("isCaptchaChecked").value=="Y"){
                return true;
            }
            return false;
        }

        $(function () {

            //아이디 변경시 다시 중복검사
            $("#userid").keyup(function () {
                $("#isIdChecked").val("N");
            });

            $("#sendcode").on('click', function () {

                var email = $("#email").val();
                $.ajax({
                    type: "POST",
                    url: "/create/sendcode",
                    data: {email: email},
                    success: function (r) {
                        if (r.result == true) {
                            alert("Email send!");
                            $("#emailCheckDiv").css('display', '');
                            // $("#authenticate").css('display', '');
                            // $("#checkcode").css('display', '');
                        } else {
                            alert(r.msg);
                        }
                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                });
            });

            $("#checkcode").click(function () {
                var code = $("#authenticate").val();
                $.ajax({
                    type: "POST",
                    url: "/create/verify",
                    data: {code: code},
                    success: function (r) {
                        if (r) {
                            alert("Your Email is Verified!");
                            emailAuth = true;

                            //$("#authenticate").css('', '');
                            //$("#checkcode").css('display', '');
                        } else {
                            alert("The authentication code does not match!");
                        }
                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                });
            });

            $("#idcheck").click(function () {
                var userid = $("#userid").val();
                if (userid == "") {
                    alert("Please enter your ID!")
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "/idcheck",
                    data: {userid: userid},
                    success: function (r) {
                        if (r) {
                            alert("This Username is available.");
                            $("#isIdChecked").val("Y");
                        } else {
                            alert("This username is not vailable!");
                            $("#isIdChecked").val("N");
                        }
                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                });
            });

            $("#create_Form").submit(function () {
                if (!isCheckedId()) {
                    event.preventDefault();
                    alert("Please run ID duplication check!");
                    return false;
                }
                if (!checkpwd()) {//여러가지 체크들
                    event.preventDefault();
                    alert("Passwords do not match!");
                    return false;
                }
                if (!isCheckedEmail()) {
                    event.preventDefault();
                    alert("Please proceed with email verification!");
                    return false;
                }
                var terms1Checked = document.getElementById('terms1').checked;
                var terms2Checked = document.getElementById('terms2').checked;
                if (!terms1Checked || !terms2Checked) {
                    event.preventDefault();
                    alert("Agree to the Terms of Use!");
                    return false;
                }
                return true;

            })


        });
    </script>
</head>
<body>
<main>
    <div class="box">
        <h2 style="text-align: center; padding: 30px 0;">
            REGISTER
        </h2>
        <form method="post" action="/createOk" id="create_Form">
            <div class="input-container">
                <input type="text" name="username" id="username" required=""/>
                <label>NAME</label>
            </div>
            <div class="input-container">
                <input type="text" name="userid" id="userid" required=""/>
                <label>ID</label>
                <input type="hidden" id="isIdChecked" value="N">
                <input type="button" value="ID CHECK" id="idcheck" class="btn btn-warning submitBtn"
                       style="border-bottom: none"/>
            </div>
            <div class="input-container">
                <input type="password" name="userpwd" id="userpwd" onchange="checkpwd()" required=""/>
                <label>PASSWORD</label>
            </div>
            <div class="input-container">
                <input type="password" name="userpwdCheck" id="userpwdCheck" onchange="checkpwd()" required=""/>
                <label>CHECK PASSWORD</label>
            </div>
            <div><span id="passwordCheckOk"></span></div>
            <div class="input-container">
                <input type="text" name="email" id="email" required=""/>
                <label>USER EMAIL</label>
                <input type="button" value="SEND" id="sendcode" class="btn btn-warning submitBtn"
                       style="border-bottom: none"/>
            </div>
            <div class="input-container" id="emailCheckDiv" style="display: none;">
                <input type="text" id="authenticate" name="authenticate" required=""/>
                <label>AUTHENTICATION CODE</label>
                <input type="button" value="CHECK" id="checkcode" class="btn btn-warning submitBtn"
                       style="border-bottom: none"/>
            </div>
            <div id="checkbox-div">
                <div>
                    <label style="margin: 20px 0 5px 0">AVAILABLE LANGUAGES</label>
                </div>
                <div style="display: flex; width: 600px; flex-wrap: wrap; margin-left: 20px;">
                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-ko" value="ko" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-ko">한국어</label>

                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-en" value="en" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-en">English</label>

                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-ja" value="ja" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-ja">日本語</label><br>

                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-zn-CN" value="zn-CN" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-zn-CN">中國語-简体</label>

                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-zn-TW" value="zn-TW" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-zn-TW">中國語-繁体</label>

                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-vi" value="vi" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-vi">Tiếng Việt</label><br>

                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-th" value="th" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-th">แบบไทย</label>

                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-id" value="id" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-id">Indonésia</label>

                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-fr" value="fr" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-fr">Français</label><br>

                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-es" value="es" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-es">Español</label>

                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-ru" value="ru" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-ru">Русский</label>

                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-de" value="de" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-de">Deutsch</label><br>

                    <input type="checkbox" class="btn-check lang" name="langArr" id="lang-it" value="it" autocomplete="off">
                    <label class="btn btn-outline-secondary" for="lang-it">Italiano</label>
                </div>
            </div>
            <div>
                <div style="margin:17px 0 5px">
                    <label>국적</label>
                </div>
                <select name="nation" id="nation" class="select" style="margin-left: 20px">
                    <option disabled selected>국적</option>
                    <option value="ko">KOREA</option>
                    <option value="en">USA</option>
                    <option value="ja">JAPAN</option>
                    <option value="zh-CN">CHINA</option>
                    <option value="vi">VIETNAM</option>
                    <option value="th">THAILAND</option>
                    <option value="id">INDONESIA</option>
                    <option value="fr">FRANCE</option>
                    <option value="es">SPAIN</option>
                    <option value="ru">RUSSIA</option>
                    <option value="de">GERMANY</option>
                    <option value="it">ITALY</option>
                </select>
            </div>
            <div>
                <div style="margin-top: 17px">
                    <label>GENDER</label>
                </div>
                <div class="col-sm-10">
                    <input type="radio" class="btn-check sex" name="options-outlined sex" id="secondary-outlined-0"
                           autocomplete="off" checked>
                    <label class="btn btn-outline-secondary" for="secondary-outlined-0" value="0">MAN</label>

                    <input type="radio" class="btn-check sex" name="options-outlined sex" id="secondary-outlined-1"
                           autocomplete="off">
                    <label class="btn btn-outline-secondary" for="secondary-outlined-1" value="1">WOMAN</label>
                </div>
            </div>
            <div id="termsCheck">
                <div> <br> Terms of Use: </div>
                <div class="terms-content">
                    <h2>Membership Terms and Conditions</h2>
                    <br>
                    <h3>Article 1 (Purpose)</h3>
                    <p>The purpose of these terms and conditions is to regulate members’ rights, obligations and responsibilities in relation to the use of online services provided by [Company Name] (hereinafter “Company” or “Service Provider”).</p>
                    <br>
                    <h3>Article 2 (Definitions)</h3>
                    <ol>
                        <li>“Service” means all online services provided by the Company.</li>
                        <li>“Member” means a person who has provided personal information to the Company and entered into a service agreement with the Company in accordance with these Terms and Conditions.</li>
                    </ol>
                    <br>
                    <h3>Article 3 (Effectiveness and Change of Terms of Use)</h3>
                    <ol>
                        <li>These terms and conditions take effect when you agree to them when registering as a member.</li>
                        <li>The company reserves the right to change these terms and conditions, and the changed terms and conditions will become effective upon notification within the service or via email. If members do not agree to the changed terms and conditions, they may stop using the service.</li>
                    </ol>
                </div>
                <div>
                    <label style="cursor: pointer"><input type="checkbox" id="terms1"
                                                          style="margin-right: 5px; cursor: pointer"/>Agree to Terms of Use<strong>(essential)</strong></label>
                </div>
                <div>
                    <label style="cursor: pointer"><input type="checkbox" id="terms2"
                                                          style="margin-right: 5px; cursor: pointer"/>Consent to collection of personal information<strong>(essential)</strong></label>
                </div>
            </div>
            <div style="display: flex; align-items: center;">
                <input type="submit" value="JOIN" id="join" class="btn btn-warning submitBtn"/>
                <input type="button" value="CANCEL" id="cancel" class="btn btn-warning submitBtn"/>
            </div>
        </form>
    </div>
</main>
</body>
</html>