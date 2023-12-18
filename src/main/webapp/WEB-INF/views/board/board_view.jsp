<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>BOARD : VIEW</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        main {
            width: 1200px;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            text-align: left;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        #viewArea {
            width: 1000px;
            height: auto;
            display: flex;
            flex-direction: column;
            margin-bottom: 30px;
        }

        #viewArea ul {
            padding: 15px;
            border-radius: 5px;
        }

        #viewArea li {
            margin-bottom: 10px;
            line-height: 1.6;
        }

        #viewArea li:first-child {
            font-size: 0.9em;
            color: #555;
        }

        #viewArea li:nth-child(3) {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
        }

        #viewArea li:last-child {
            font-size: 1em;
            padding: 10px 0;
        }

        .replyArea {
            width: 1000px;
            margin: 20px 0;
            padding: 15px;
            border-radius: 5px;
        }


        .replyArea #replyList {
            list-style-type: none;
            padding: 0;
        }

        .replyArea #replyList li {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            margin-bottom: 10px;
        }

        .replyArea #replyList b {
            font-weight: bold;
            text-align: left;
        }

        .replyArea #replyList p {
            text-align: left;
            margin-bottom: 0;
        }

        #replyForm, #replyFormEdit, #replyFormReply {
            width: 970px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        #replyForm > div, #replyFormEdit > div, #replyFormReply > div {
            display: flex;
            justify-content: flex-end;
        }

        button {
            width: 120px;
            height: 40px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        hr {
            width: 100%;
        }

        body,
        ul,
        li {
            margin: 0;
            padding: 0;
            list-style-type: none;
        }

        a:link,
        a:visited,
        a:hover,
        a:active {
            color: black;
            text-decoration: none;
        }

        .util > a {
            display: inline-block;
            color: #333;
            padding: 10px 15px;
            margin: 5px;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
            transition: border-color 0.3s ease, color 0.3s ease;
        }

        .util {
            text-align: center;
            margin: 20px;
        }

        .btn btn-warning {
            font-size: 13px;
        }

        .comment-section {
            display: flex;
            flex-direction: column;
        }

        .comment-section-re {
            display: flex;
            flex-direction: column;
            margin-left: 50px;
        }

        .content-and-buttons {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .button-container {
            display: flex;
        }

        #replyReport, #replyEdit {
            margin-right: 20px;
            padding-left: 5px;
            padding-right: 5px;
            background-color: white;
            color: black;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .likeButton {
            font-size: 24px;
            padding: 5px 10px;
            border: none;
            background-color: transparent;
            cursor: pointer;
            border-radius: 10px;
            background-color: rgba(255, 227, 160, 0.4);
        }

        #replyReport:hover, #replyEdit:hover, #replyDelete:hover {
            color: #555555;
        }

        #replyDelete {
            padding-left: 5px;
            padding-right: 5px;
            background-color: white;
            color: black;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .active {
            background-color: rgba(255, 227, 160);
        }

        .reply-button {
            padding-left: 5px;
            padding-right: 5px;
            background-color: white;
            color: black;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .reply-button.active {
            background-color: rgba(255, 227, 160);
        }

        .reply-comment-id{
            padding-right: 5px;
        }

    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            try {
                var myLike = '${bVO.myLike}';
                if (myLike === '1') {
                    var likeButton = document.getElementById('likeButton');
                    if (likeButton) {
                        likeButton.classList.add('active');
                    }
                }
            } catch (error) {
                console.error('Error:', error);
            }
        });
        var currentCommentId = null;
        $(function () {
            $("#toList").click(function () {
                location.href = "${listUrl}";
            })
            $("#editPost").on('click', function () {
                location.href = "${pageContext.servletContext.contextPath}/board/${bVO.board_cat}/edit?no=${bVO.post_id}"
            })
            $("#deletePost").on('click', function () {
                if (!confirm("Are you sure you want to delete?")) {
                    alert("It has been cancelled.");
                } else {
                    location.href = "/board/${bVO.board_cat}/delete?no=${bVO.post_id}";

                }
            })

            //댓글목록 불러오기
            function getReply() {
                $.ajax({
                    url: '${pageContext.servletContext.contextPath}/boardReply/list',
                    data: {no: ${bVO.post_id}},
                    type: 'GET',
                    success: function (result) {
                        //console.log(result);
                        var tag = ''; //댓글목록 태그(수정, 삭제);
                        $(result).each(function (i, rVO) {
                            if (rVO.depth == 0) {
                                tag += "<li><div class='comment-section'>";
                            } else {
                                tag += "<li><div class='comment-section-re'>";
                            }
                            if(rVO.is_deleted==1){
                                tag += "<div><b>삭제된 메세지</b></div>";
                                tag += "<div class='content-and-buttons'>";
                                tag += "<p class='comment-content'>삭제된 메세지 내용입니다.</p>";
                            }else{
                                tag += "<div><b>" + rVO.writer + "</b>(" + rVO.write_date + ")</div>";
                                tag += "<div class='content-and-buttons'>";
                                tag += "<p class='comment-content'>" + rVO.content + "</p>";

                                if ('${logId}' == rVO.writer) {
                                    tag += "<div class='button-container'>";
                                    tag += "<input type='hidden' class='reply-button comment-id reply-comment-id' value='" + rVO.comment_id + "'/>";
                                    if (rVO.depth == 0) {
                                        tag += "<input type='button' class='reply-button reply' id='reply' value='Reply'/>";
                                    }
                                    tag += "<input type='button' class='reply-button replyEdit' id='replyEdit' value='Edit'/>";
                                    tag += "<input type='button' class='reply-button' id='replyDelete' value='Del'/>";
                                } else {
                                    tag += "<div class='button-container'>";
                                    tag += "<input type='hidden' class='reply-button comment-id reply-comment-id' value='" + rVO.comment_id + "'/>";
                                    if (rVO.depth == 0) {
                                        tag += "<input type='button' class='reply-button reply' id='reply' value='Reply'/>";
                                    }
                                    tag += "<input type='hidden' class='reply-button reply-writer' value='" + rVO.writer + "'/>";
                                    tag += "<input type='button' class='reply-button' id='replyReport' value='Report'/>";
                                    if (rVO.myLike == 1) {
                                        tag += "<input type='button' class='reply-button active' id='replyLike' value='Like'/>";
                                    } else {
                                        tag += "<input type='button' class='reply-button' id='replyLike' value='Like'/>";
                                    }
                                }
                                tag += "<div>&nbsp LIKE: " + rVO.like + "</div>"
                            }

                            tag += "</div>";
                            tag += "</div>";
                            tag += "</li>";
                        });
                        $("#replyList").html(tag);

                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                })
            }

            function getLike() {
                $.ajax({
                    url: '${pageContext.servletContext.contextPath}/board/like/get',
                    data: {no: ${bVO.post_id}},
                    type: 'GET',
                    success: function (result) {
                        $("#liked").html("LIKE " + result);
                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                })
            }

            $(document).on('click', '.reply', function () {
                var commentId = $(this).siblings('.comment-id').val();
                console.log("Comment ID:", commentId);
                currentCommentId = commentId;
                var parentLi = $(this).closest('li');
                $('#replyFormReply').insertAfter(parentLi).show();
                $('#replyFormEdit').hide();
            });

            $(document).on('click', '.replyEdit', function () {
                var currentContent = $(this).closest('.comment-section').find('.comment-content').text();
                var commentId = $(this).siblings('.comment-id').val();
                console.log("Comment ID:", commentId);
                currentCommentId = commentId;
                var parentLi = $(this).closest('li');
                $('#content_Edit').val(currentContent);
                $('#replyFormEdit').insertAfter(parentLi).show();
                $('#replyFormReply').hide();
            });

            $('#EditReply').click(function (e) {
                e.preventDefault();
                var postId = $('input[name="post_id_Edit"]').val();
                var updatedContent = $('#content_Edit').val();
                var commentId = currentCommentId;
                console.log(postId, updatedContent, commentId);
                $.ajax({
                    url: '/boardReply/edit',
                    type: 'POST',
                    data: {
                        post_id: postId,
                        comment_id: commentId,
                        content: updatedContent
                    },
                    success: function (response) {
                        alert('Comment updated successfully.');
                        getReply();
                        $('#replyFormEdit').hide();
                        $('#replyForm').show();
                    },
                    error: function (err) {
                        alert('Error updating comment.');
                        console.log(err);
                    }
                });
            });

            $(document).on('click', '#ReplyReply', function (e) {
                console.log(currentCommentId);
                e.preventDefault();
                var postId = $('input[name="post_id_Reply"]').val();
                var updatedContent = $('#content_Reply').val();
                var commentId = currentCommentId;
                console.log(postId, updatedContent, commentId);
                $.ajax({
                    url: '/boardReply/reply',
                    type: 'POST',
                    data: {
                        post_id: postId,
                        comment_id: commentId,
                        content: updatedContent
                    },
                    success: function (response) {
                        e.preventDefault();
                        alert('Comment updated successfully.');
                        getReply();
                        $('#replyFormReply').hide();
                        $('#replyForm').show();
                    },
                    error: function (err) {
                        alert('Error updating comment.');
                        console.log(err.responseText);
                    }
                });
            });

            $("#replyForm").submit(function (e) {
                e.preventDefault();
                var params = $(this).serialize();
                $.ajax({
                    type: "POST",
                    url: "/boardReply/add",
                    data: params,
                    success: function (r) {
                        //console.log(r);
                        getReply();
                        $("#content").val("");

                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                })
            });
            $(document).on('click', '#replyList input[value=Del]', function () {
                if (!confirm("Are you sure you want to delete?")) {
                    return;
                }
                var replyNo = $(this).siblings('input[type="hidden"]').val();
                var postNo = ${bVO.post_id};
                $.ajax({
                    type: "POST",
                    url: "/boardReply/delete",
                    data: {replyNo: replyNo, postNo: postNo},
                    success: function (r) {
                        //console.log(r);
                        getReply();
                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                })

            });
            $(document).on('click', '#replyList input[value=Report]', function () {
                if (!confirm("Are you sure you want to report this?")) {
                    return;
                }
                var replyNo = $(this).siblings('.reply-comment-id').val();
                var commentUserId = $(this).siblings('.reply-writer').val();
                $.ajax({
                    type: "POST",
                    url: "${pageContext.servletContext.contextPath}/boardReply/report",
                    data: {
                        id: commentUserId,
                        no: replyNo
                    },
                    success: function (r) {
                        console.log(r);
                        if (r.result == true) {
                            console.log("success")
                        } else {
                            alert(r.msg);
                        }
                        getLike();

                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                })

            });
            $(document).on('click', '#replyList input[value=Like]', function () {
                var replyNo = $(this).siblings('.reply-comment-id').val();
                console.log(replyNo);
                $.ajax({
                    type: "POST",
                    url: "${pageContext.servletContext.contextPath}/boardReply/like",
                    data: {
                        no: replyNo
                    },
                    success: function (r) {
                        console.log(r);
                        if (r.result == true) {
                            console.log("success");
                            alert(r.msg);
                            getReply();
                        } else {
                            alert(r.msg);
                            getReply();
                        }
                        getLike();

                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                })

            });

            $("#likeButton").click(function () {
                $.ajax({
                    type: "POST",
                    url: "${pageContext.servletContext.contextPath}/board/like/increase",
                    data: {no: ${bVO.post_id}, user_id: '${logId}'},
                    success: function (r) {
                        console.log(r);
                        if (r.result == true) {
                            alert(r.msg);
                            console.log("success")
                        } else {
                            alert(r.msg);
                        }
                        getLike();

                    },
                    error: function (e) {
                        console.log(e.responseText);
                    }

                })
            });
            $("#report").click(function () {
                if (!confirm("Are you sure you want to report this?")) {
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "${pageContext.servletContext.contextPath}/board/report",
                    data: {no: ${bVO.post_id}, user_id: '${bVO.user_id}'},
                    success: function (r) {
                        if (r.result == true) {
                            alert("Reported.")
                        } else {
                            alert(r.msg);
                        }
                    }
                })

            });
            getReply();
            getLike();
        })
    </script>
<body>
<main>
    <div id="viewArea">
        <ul>
            <li>POST ID : ${bVO.post_id} &nbsp; 🖋️${bVO.user_id} &nbsp; 👁️${bVO.views} &nbsp; 🗓️${bVO.write_date}</li>
            <hr>
            <li><h4><b>${bVO.title}</b></h4></li>
            <hr>
            <li>${bVO.content}</li>
        </ul>
    </div>
    <div style="display: flex; flex-direction: row; justify-content: center; align-items: center; gap: 40px; background-color: rgba(255, 227, 160, 0.2); padding: 0 20px; border-radius: 10px;">
        <div style="display: flex; flex-direction: column; align-items: center; padding: 10px;">
            <div id="liked" style="margin-bottom: 10px; font-size: 16px;">0 likes</div>
            <button id="likeButton" class="likeButton">💛</button>
        </div>
        <div style="padding: 10px;">
            <div style="margin-bottom: 10px; font-size: 16px; text-align: center">REPORT IT</div>
            <button id="report"
                    style="font-size: 24px; padding: 5px 10px; border: none; background-color: transparent; cursor: pointer; border-radius: 10px; background-color: rgba(255, 227, 160, 0.4);">
                🔔
            </button>
        </div>
    </div>
    <br>
    <hr style="width: 1000px;">
    <div class="util">
        <button id="toList" class="btn btn-secondary">LIST</button>
        <c:if test="${logId==bVO.user_id}">
            <button id="editPost" class="btn btn-warning">EDIT</button>
        </c:if>

        <c:if test="${logId==bVO.user_id}">
            <button id="deletePost" class="btn btn-warning">DELETE</button>
        </c:if>
    </div>
    <hr style="width: 1000px;">
    <!-- 댓글 -->
    <div class="replyArea">
        <h5>COMMENT LIST</h5>
        <br>
        <ul id="replyList">
        </ul>
        <br>
        <c:if test="${'Y'.equals(logStatus)}">
            <h5>COMMENT</h5>
            <br>
            <form method="post" id="replyForm">
                <!--  원글 글번호 -->
                <input type="hidden" name="post_id" value="${bVO.post_id}"/>
                <textarea name="content" id="content"></textarea>
                <div>
                    <button class="btn btn-warning" id="addReply">POST</button>
                </div>
            </form>
        </c:if>

        <form method="post" id="replyFormReply" style="display: none">
            <input type="hidden" name="post_id_Reply" value="${bVO.post_id}"/>
            <textarea name="content" id="content_Reply"></textarea>
            <div>
                <button class="btn btn-warning" id="ReplyReply">REPLY</button>
            </div>
        </form>

        <form method="post" id="replyFormEdit" style="display: none">
            <input type="hidden" name="post_id_Edit" value="${bVO.post_id}"/>
            <textarea name="content" id="content_Edit"></textarea>
            <div>
                <button class="btn btn-warning" id="EditReply">EDIT</button>
            </div>
        </form>
    </div>
</main>
</body>

</html>