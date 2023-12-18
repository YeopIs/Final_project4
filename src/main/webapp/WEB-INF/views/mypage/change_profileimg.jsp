<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(function(){
        $(".banner").html("").css("display", "none");
        $(".nav").html("").css("display", "none");
        $("footer").html("").css("display", "none");
        $("hr").html("").css("display", "none");

        $("#close").on('click', function(){
            window.close();
        });

        $("#imgchangeForm").submit(function(){
            event.preventDefault();
            var form = $("#imgchangeForm")[0];
            var data = new FormData(form);
            if($("#filename").val() == ""){
                alert("이미지를 선택해주세요.");
                return false;
            }
            $.ajax({
                url: "${pageContext.servletContext.contextPath}/mypage/profileimgChangeOk",
                type: "post",
                data: data,
                async: false,
                processData: false,
                contentType: false,
                success: function(result){
                    console.log(result);
                    opener.parent.location.reload();
                    window.close();
                },
                error: function(error){
                    console.log(error.responseText);
                    document.location.reload();
                }
            });
        });
    });
    function readURL(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function(e) {
            document.getElementById('preview').src = e.target.result;
          };
          reader.readAsDataURL(input.files[0]);
        } else {
          document.getElementById('preview').src = "";
        }
      }
</script>
<div>
    <form id="imgchangeForm" enctype="multipart/form-data">
        <div class="text-center mb-3">
            <input type="file" id="filename" name="filename" onchange="readURL(this);"/>
            <img id="preview" class="rounded-circle" style="width: 150px; height: 150px; object-fit: cover;"/>
            <br/>
        </div>
        <div class="text-center">
            <button type="submit" class="btn btn-warning me-2" id="change">변경하기</button>
            <button type="button" class="btn btn-secondary" id="close">닫기</button>   
        </div>
    </form>
</div>
