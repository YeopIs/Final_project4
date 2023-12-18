<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <meta charset="UTF-8">
    <title>Chating</title>
    <style>
        * {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        html, body {
            height: 100%;
        }

        body {
            margin: 0;
            padding: 0;
            font-weight: 400;
            font-size: 1rem;
            height: 100%;
        }

        .clearfix:after {
            display: block;
            content: "";
            clear: both;
        }

        .hidden {
            display: none;
        }

        .form-control {
            width: 100%;
            min-height: 38px;
            font-size: 15px;
            border: 1px solid #c8c8c8;
        }

        .form-group {
            margin-bottom: 15px;
        }

        input {
            padding-left: 10px;
            outline: none;
        }

        h1, h2, h3, h4, h5, h6 {
            margin-top: 20px;
            margin-bottom: 20px;
        }

        h1 {
            font-size: 1.7em;
        }

        button {
            box-shadow: none;
            border: 1px solid transparent;
            font-size: 14px;
            outline: none;
            line-height: 100%;
            white-space: nowrap;
            vertical-align: middle;
            padding: 0.6rem 1rem;
            border-radius: 2px;
            transition: all 0.2s ease-in-out;
            cursor: pointer;
            min-height: 38px;
        }

        #chat-page {
            position: relative;
            height: 100%;
        }

        .chat-container {
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            background-color: #fff;
            margin-top: 30px;
            height: calc(100% - 60px);
            max-height: 600px;
            position: relative;
        }

        #chat-page ul {
            list-style-type: none;
            background-color: #FFF;
            margin: 0;
            overflow: auto;
            overflow-y: scroll;
            padding: 0 20px 0 20px;
            height: calc(100% - 150px);
        }

        #chat-page #messageForm {
            padding: 20px;
        }

        #chat-page ul li {
            line-height: 1.5rem;
            padding: 10px 20px;
            margin: 0;
            border-bottom: 1px solid #f4f4f4;
        }

        #chat-page ul li p {
            margin: 0;
        }

        #chat-page .event-message {
            width: 100%;
            text-align: center;
            clear: both;
        }

        #chat-page .event-message p {
            color: #777;
            font-size: 14px;
            word-wrap: break-word;
        }

        #chat-page .chat-message {
            padding-left: 68px;
            padding-right: 68px;
            position: relative;
        }

        #chat-page .message-others img {
            position: absolute;
            width: 42px;
            height: 42px;
            overflow: hidden;
            left: 10px;
            display: inline-block;
            vertical-align: middle;
            font-size: 18px;
            line-height: 42px;
            color: #fff;
            text-align: center;
            border-radius: 50%;
            font-style: normal;
            text-transform: uppercase;
        }

        #chat-page .message-mine img {
            position: absolute;
            width: 42px;
            height: 42px;
            overflow: hidden;
            right: 10px;
            display: inline-block;
            vertical-align: middle;
            font-size: 18px;
            line-height: 42px;
            color: #fff;
            text-align: center;
            border-radius: 50%;
            font-style: normal;
            text-transform: uppercase;
        }

        #chat-page .chat-message span {
            color: #333;
            font-weight: 600;
        }

        #chat-page .chat-message p {
            color: #43464b;
        }

        .message-mine {
            text-align: right;
        }

        .message-mine > i {
            float: right;
        }


        #messageForm .input-group input {
            float: left;
            width: calc(100% - 85px);
        }

        #messageForm .input-group button {
            float: left;
            width: 80px;
            height: 38px;
            margin-left: 5px;
        }

        .chat-header {
            text-align: center;
            padding: 15px;
            border-bottom: 1px solid #ececec;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .follow-btn, .report-leave-btn {
            border: 1px solid black;
            border-radius: 4px;
            padding: 8px 15px;
            margin: 0 10px;
            cursor: pointer;
            background-color: #ffffff;
        }

        .follow-btn:hover, .report-leave-btn:hover {
            background-color: #ffe3a0;
        }
        .chat-header h2 {
            margin: 0;
            font-weight: 500;
        }

        .message-actions {
            position: absolute;
            top: 0;
            left: 0;
        }

        .report-button, .save-button {
            margin-right: 5px;
            font-size: 12px;
            color: #444444;
            cursor: pointer;
            text-decoration: none;
        }
        .message-actions-other {
            position: absolute;
            top: 0;
            right: 0;
        }
        .report-button-other, .save-button-other {
            margin-left: 5px;
            font-size: 12px;
            color: #444444;
            cursor: pointer;
            text-decoration: none;
        }
    </style>
</head>

<body>
<div id="chat-page">
    <div class="chat-container">
        <div class="chat-header">
            <button class="follow-btn">Follow ${otherId}</button>
            <h2>CHATTING WITH ${otherId}</h2>
            <button class="report-leave-btn">Block/Leave Chat</button>
        </div>
        <ul id="messageArea">
            <div class="chat-messages">
                <c:forEach var="message" items="${pastMessages}">
                    <c:choose>
                        <c:when test="${(message.is_from_id == 1 and userId == fromId)
                        or (message.is_from_id == 0 and userId != fromId)}">
                            <li class="message-mine chat-message">
                                <div class="message-actions">
                                    <a href="#" class="report-button" data-message-id="${message.msg_id}">Report</a>
                                    <a href="#" class="save-button" data-message-id="${message.msg_id}">Save</a>
                                </div>
                                <div class="text-container">
                                    <span class="username">${userId}</span>
                                    <i style="position: absolute; width: 42px; height: 42px; right: 10px;">
                                        <img src="${pageContext.servletContext.contextPath}/image/profile/${profile_img}" style="width: 100%; height: 100%; object-fit: cover;">
                                    </i>
                                    <p>${message.content}</p>
                                    <p>${message.trans_content}</p>
                                </div>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="message-others chat-message">
                                <div class="message-actions-other">
                                    <a href="#" class="report-button" data-message-id="${message.msg_id}">Report</a>
                                    <a href="#" class="save-button" data-message-id="${message.msg_id}">Save</a>
                                </div>
                                <div class="text-container">
                                    <span class="username">${otherId}</span>
                                    <i style="position: absolute; width: 42px; height: 42px; left: 10px;">
                                        <img src="${pageContext.servletContext.contextPath}/image/profile/${other_profile_img}"
                                             style="width: 100%; height: 100%; object-fit: cover;">
                                    </i>
                                    <p>${message.content}</p>
                                    <p>${message.trans_content}</p>
                                </div>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </ul>
        <form id="messageForm" name="messageForm">
            <div class="form-group">
                <div class="input-group clearfix">
                    <input type="text" id="message" placeholder="Type a message..." autocomplete="off"
                           class="form-control"/>
                    <button type="submit" class="primary">Send</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
    var chatPage = document.querySelector('#chat-page');
    var messageForm = document.querySelector('#messageForm');
    var messageInput = document.querySelector('#message');
    var messageArea = document.querySelector('#messageArea');
    var connectingElement = document.querySelector('.connecting');
    const fromId = "${fromId}";
    const otherId = "${otherId}";
    const chatId = ${chatId};
    var username = "${userId}";
    var stompClient = null;
    const userProfileImage = "${pageContext.servletContext.contextPath}/image/profile/${profile_img}";
    const otherUserProfileImage = "${pageContext.servletContext.contextPath}/image/profile/${other_profile_img}";

    function connect() {
        console.log("Connect");
        console.log("Username:", username);
        if (username) {
            chatPage.classList.remove('hidden');

            var socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);
            console.log("Connect");
            stompClient.connect({}, onConnected, onError);
        }
    }

    function onConnected() {
        console.log("Connected to WebSocket");
        stompClient.subscribe('/topic/public/${chatId}', onMessageReceived);
    }

    function onError(error) {
        console.error("WebSocket Error", error);
        connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
        connectingElement.style.color = 'red';
    }

    function sendMessage(event) {
        var messageContent = messageInput.value.trim();
        if (messageContent && stompClient) {
            var chatMessage = {
                chat_id: chatId,
                sender: username,
                content: messageInput.value,
                from_id: fromId,
                other_id : otherId
            };
            stompClient.send('/app/chat.sendMessage/${chatId}', {}, JSON.stringify(chatMessage));
            messageInput.value = '';
        }
        event.preventDefault();
    }

    function onMessageReceived(payload) {
        const message = JSON.parse(payload.body);
        const messageElement = document.createElement('li');
        const avatarElement = document.createElement('img');
        avatarElement.src = message.sender === username ? userProfileImage : otherUserProfileImage;
        avatarElement.style.width = '42px';
        avatarElement.style.height = '42px';
        avatarElement.style.borderRadius = '50%';
        avatarElement.style.objectFit = 'cover';
        messageElement.classList.add('chat-message');
        const messageActions = document.createElement('div');
        messageActions.classList.add(message.sender === username ? 'message-actions':'message-actions-other');

        const reportButton = document.createElement('a');
        reportButton.href = "#";
        reportButton.classList.add(message.sender === username ? 'report-button' : 'report-button-other');
        reportButton.textContent = "Report";
        reportButton.dataset.messageId = message.msg_id;
        reportButton.onclick = function(event) {
            event.preventDefault();
            reportMessage(this.dataset.messageId);
        };

        const saveButton = document.createElement('a');
        saveButton.href = "#";
        saveButton.classList.add(message.sender === username ? 'save-button' : 'save-button-other');
        saveButton.textContent = "Save";
        saveButton.dataset.messageId = message.msg_id; // Assuming msg_id is part of the payload
        saveButton.onclick = function(event) {
            event.preventDefault();
            saveMessage(this.dataset.messageId);
        };

        messageActions.appendChild(reportButton);
        messageActions.appendChild(saveButton);

        messageElement.appendChild(messageActions);
        const textContainer = document.createElement('div');
        textContainer.classList.add('text-container');
        const usernameElement = document.createElement('span');
        const usernameText = document.createTextNode(message.sender);
        usernameElement.appendChild(usernameText);
        messageElement.appendChild(usernameElement);
        messageElement.classList.add(message.sender === username ? 'message-mine' : 'message-others');
        messageElement.appendChild(avatarElement);

        const textElement = document.createElement('p');
        const messageText = document.createTextNode(message.content);
        textElement.appendChild(messageText);
        const transTextElement = document.createElement('p');
        transTextElement.classList.add('translated-text');
        const transMessageText = document.createTextNode(message.trans_content);
        transTextElement.appendChild(transMessageText);
        textElement.appendChild(transTextElement);
        messageElement.appendChild(textElement);
        messageArea.appendChild(messageElement);
        messageArea.scrollTop = messageArea.scrollHeight;
    }

    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.report-button, .report-button-other').forEach(function(button) {
            button.addEventListener('click', function(event) {
                event.preventDefault();
                var messageId = this.getAttribute('data-message-id');
                reportMessage(messageId);
            });
        });

        document.querySelectorAll('.save-button, .save-button-other').forEach(function(button) {
            button.addEventListener('click', function(event) {
                event.preventDefault();
                var messageId = this.getAttribute('data-message-id');
                // AJAX call to save message
                saveMessage(messageId);
            });
        });
    });

    function reportMessage(messageId) {
        console.log(messageId);
        $.ajax({
            url: '/chat/reportMessage',
            method: 'POST',
            data: { msg_id: messageId },
            success: function() {
                alert("Message reported successfully!");
            },
            error: function(error) {
                alert("Error saving message: " + error);
            }
        });
    }

    function saveMessage(messageId) {
        console.log(messageId);
        $.ajax({
            url: '/chat/saveMessage',
            method: 'POST',
            data: { msg_id: messageId },
            success: function() {
                alert("Message saved successfully!");
            },
            error: function(error) {
                alert("Error saving message: " + error);
            }
        });
    }

    connect();
    messageForm.addEventListener('submit', sendMessage, true)
    messageArea.scrollTop = messageArea.scrollHeight;

    $('.follow-btn').click(function() {
        $.ajax({
            url: '/follow', // Replace with your server endpoint
            type: 'POST',
            data: {
                userId: username,
                otherId: otherId
            },
            success: function(response) {
                alert('팔로우 했습니다!');
            },
            error: function() {
                alert('오류가 발생했습니다.');
            }
        });
    });
    $('.report-leave-btn').click(function() {
        var reportReason = prompt("차단하는 이유를 입력해주세요:");
        if (reportReason) {
            $.ajax({
                url: '/block',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    chatId: chatId,
                    userId: username,
                    otherId: otherId,
                    reason: reportReason
                }),
                success: function(response) {
                    alert('차단되었습니다!');
                    window.location.href = '/chat/list';
                },
                error: function() {
                    alert('오류가 발생했습니다.');
                }
            });
        }
    });

</script>
</body>
</html>
