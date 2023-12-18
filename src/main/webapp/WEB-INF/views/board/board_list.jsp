<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>BOARD : LIST</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        #wrapper {
            max-width: 1200px;
            margin: auto;
            display: flex;
        }

        .container {
            width: 1200px;
            display: flex;
            flex-direction: row;
        }

        main {
            width: 80%;
            padding: 20px;
        }

        /* 초기화 */
        body,
        ul,
        li {
            margin: 0;
            padding: 0;
            list-style-type: none;
        }

        /* link초기화 */
        a:link,
        a:visited,
        a:hover,
        a:active {
            color: black;
            text-decoration: none;
        }

        #boardTop {
            height: 20px;
            text-align: right;
        }

        .page > ul {
            padding-top: 5px;
            display: table;
            text-align: center;
            margin: 0 auto;
        }

        .page li {
            float: left;
            padding: 5px;
            line-height: 20px;
        }
        .page-link.active{
            background-color: #ffc107;
            border-color: #ffc107;
        }
        .page-link{
            color: #ddd;
        }
        .search {
            text-align: center;
        }

        #sidebar {
            padding: 20px;
            width: 20%;
            height: 100vh;
            border-right: 1px solid #ccc;
        }

        .sidebar-menu {
            list-style-type: none;
            padding: 0;
        }

        .sidebar-menu > li a {
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

        select::-ms-expand{
            display: none;
        }
        .select{
            -o-appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            width: 115px;
            background: url("../../../image/select.png")no-repeat center right;
            padding: 5px 30px 5px 20px;
            border-radius: 4px;
            outline: 0 none;
            border: 1px solid #dee2e6;
            cursor: pointer;
        }
        .select option{
            background: #FFD954;
            padding: 3px 0;
        }
        .mb-3{
            margin-bottom: 0rem!important;
            margin-left: 5px;
        }
        .searchForm{
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }

        #boardList {
            width: 900px;
            border-collapse: collapse;
            margin: 20px auto;
        }

        #boardList th, #boardList td {
            padding: 10px 0;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        #boardList td.title {
            max-width: 200px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        #boardList tbody tr:hover {
            background-color: rgba(255, 227, 160, 0.3); /* 마우스 오버 시 행 배경색 변경 */
        }

    </style>
</head>

<body>
    <div id="wrapper" class="container">
        <nav id="sidebar">
            <br/>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.servletContext.contextPath}/board/notice"
                       <c:if test="${pVO.board_cat=='notice'}">class="current active"</c:if>>NOTICE</a></li>
                <li><a href="${pageContext.servletContext.contextPath}/board/free"
                       <c:if test="${pVO.board_cat=='free'}">class="current active"</c:if>>FREE</a></li>
                <li><a href="${pageContext.servletContext.contextPath}/board/inquiries"
                       <c:if test="${pVO.board_cat=='inquiries'}">class="current active"</c:if>>INQUIRE</a></li>
            </ul>
        </nav>
        <main>
            <div style="display: flex; flex-direction: row; justify-content: space-between; align-items: center">
                <h1>
                    <c:if test="${pVO.board_cat=='notice'}">NOTICE</c:if>
                    <c:if test="${pVO.board_cat=='free'}">FREE</c:if>
                    <c:if test="${pVO.board_cat=='inquiries'}">INQUIRE</c:if>
                </h1>
                <div id="boardTop">
                    <div>Total Record : ${pVO.totalRecord} / Today Record : ${pVO.todayRecord}</div>
                </div>
            </div>
            <table id="boardList" style="text-align: center">
                <thead>
                <tr>
                    <th>NO</th>
                    <th>POST TITLE</th>
                    <th>🖋️</th>
                    <th>👁️</th>
                    <th>💛</th>
                    <th>🗓️</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="bVO" items="${list}">
                    <tr>
                        <td>${bVO.post_id}</td>
                        <c:url var="viewUrl" value="${pageContext.servletContext.contextPath}/board/${pVO.board_cat}/view">
                            <c:param name="no" value="${bVO.post_id}"/>
                            <c:param name="searchKey" value="${pVO.searchKey}"/>
                            <c:param name="searchWord" value="${pVO.searchWord}"/>
                        </c:url>
                        <td class="title"><a href="${viewUrl}">${bVO.title}</a></td>
                        <td>${bVO.user_id}</td>
                        <td>${bVO.views}</td>
                        <td>${bVO.likes}</td>
                        <td>${bVO.write_date}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- 페이지 박스-->
            <!-- todo: 페이지 인식해서 보이게 -->
            <div style="display: flex; flex-direction: row; justify-content: space-evenly; align-items: center">
                <div class="pagination-container" style="margin: 0 auto; width: fit-content">
                    <div class="pagination" style="display: flex">
                        <div class="paging">
                            <ul class="pagination justify-content-center d-flex">
                                <!-- prev 페이지 -->
                                <c:url var="prevUrl"
                                       value="${pageContext.servletContext.contextPath}/board/${pVO.board_cat}">
                                    <c:param name="nowPage" value="${pVO.nowPage-1}"/>
                                    <c:if test="${pVO.searchWord!=null}">
                                        <c:param name="searchKey" value="${pVO.searchKey}"/>
                                        <c:param name="searchWord" value="${pVO.searchWord}"/>
                                    </c:if>
                                </c:url>
                                <c:choose>
                                    <c:when test="${pVO.nowPage == 1}">
                                        <li class="page-item"><a class="page-link"><</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item"><a class="page-link" href="${prevUrl}"><</a></li>
                                    </c:otherwise>
                                </c:choose>
                                <!-- 페이지 번호 -->
                                <c:forEach var="cnt" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
                                    <c:if test="${cnt<=pVO.totalPage}">
                                        <!-- 페이지번호가 마지막 페이지보다 작거나 같을때만 번호 출력 -->
                                        <c:if test="${cnt==pVO.nowPage }">
                                            <!-- 현재 보고있는 페이지 -->
                                            <li class="page-item"><a class="page-link active" href="">${cnt}</a></li>
                                        </c:if>
                                        <!-- 현재 보고있는 페이지가 아닐경우 -->
                                        <c:if test="${cnt!=pVO.nowPage}">
                                            <c:url var="pageUrl"
                                                   value="${pageContext.servletContext.contextPath}/board/${pVO.board_cat}/view">
                                                <c:param name="nowPage" value="${cnt}"/>
                                                <c:if test="${pVO.searchWord!=null}">
                                                    <c:param name="searchKey" value="${pVO.searchKey}"/>
                                                    <c:param name="searchWord" value="${pVO.searchWord}"/>
                                                </c:if>
                                            </c:url>
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.servletContext.contextPath}/board/${pVO.board_cat}?nowPage=${cnt}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${cnt}</a>
                                            </li>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                                <!-- next 페이지 -->
                                <c:url var="nextUrl"
                                       value="${pageContext.servletContext.contextPath}/board/${pVO.board_cat}">
                                    <c:param name="nowPage" value="${pVO.nowPage+1}"/>
                                    <c:if test="${pVO.searchWord!=null}">
                                        <c:param name="searchKey" value="${pVO.searchKey}"/>
                                        <c:param name="searchWord" value="${pVO.searchWord}"/>
                                    </c:if>
                                </c:url>
                                <c:choose>
                                    <c:when test="${pVO.nowPage == pVO.totalPage}">
                                        <li class="page-item"><a class="page-link">></a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item"><a class="page-link" href="${nextUrl}">></a></li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </div>
                <div>
                    <c:if test="${pVO.board_cat=='notice'}">
                        <c:if test="${'Y'.equals(manager)}">
                            <input type="button" value="글 작성" class="post-button btn btn-warning" id="write-button"
                                   onclick="location.href='${pageContext.servletContext.contextPath}/board/${pVO.board_cat}/write'">
                        </c:if>
                    </c:if>

                    <c:if test="${pVO.board_cat=='free' || pVO.board_cat=='inquiries'}">
                        <c:if test="${'Y'.equals(logStatus)}">
                            <input type="button" value="글 작성" class="post-button btn btn-warning" id="write-button"
                                   onclick="location.href='${pageContext.servletContext.contextPath}/board/${pVO.board_cat}/write'">
                        </c:if>
                    </c:if>

                </div>
            </div>
            <br>
            <!-- 검색박스 -->
            <div class="post-end-line">
                <div class="inboard-search-area">
                    <div class="search flex-container"> <!-- Add a class to make this a flex container -->
                        <c:choose>
                            <c:when test="${pVO.board_cat == 'notice'}">
                                <form method="get" action="${pageContext.servletContext.contextPath}/board/notice"
                                      onsubmit="return searchCheck()" class="searchForm">
                                    <select name="searchKey" class="select">
                                        <option value="title" ${pVO.searchKey=='title' ? 'selected' : '' }>TITLE</option>
                                        <option value="content" ${pVO.searchKey=='content' ? 'selected' : '' }>CONTENT</option>
                                        <option value="user_id" ${pVO.searchKey=='user_id' ? 'selected' : '' }>WRITER</option>
                                    </select>
                                    <div class="input-group mb-3" style="width: 300px;">
                                        <input type="search" class="form-control" placeholder="SEARCH WORD" name="searchWord" id="inboard-search" value="${pVO.searchWord}">
                                        <button class="btn btn-warning" type="submit" class="post-button" id="search-button">SEATCH</button>
                                    </div>
                                </form>
                            </c:when>
                            <c:when test="${pVO.board_cat == 'free'}">
                                <form method="get" action="${pageContext.servletContext.contextPath}/board/free"
                                      onsubmit="return searchCheck()" class="searchForm">
                                    <select name="searchKey" class="select">
                                        <option value="title" ${pVO.searchKey=='title' ? 'selected' : '' }>TITLE</option>
                                        <option value="content" ${pVO.searchKey=='content' ? 'selected' : '' }>CONTENT</option>
                                        <option value="user_id" ${pVO.searchKey=='user_id' ? 'selected' : '' }>WRITER</option>
                                    </select>
                                    <div class="input-group mb-3" style="width: 300px;">
                                        <input type="search" class="form-control" placeholder="SEARCH WORD" name="searchWord" id="inboard-search" value="${pVO.searchWord}">
                                        <button class="btn btn-warning" type="submit" class="post-button" id="search-button">SEATCH</button>
                                    </div>
                                </form>
                            </c:when>
                            <c:when test="${pVO.board_cat == 'inquiries'}">
                                <form method="get" action="${pageContext.servletContext.contextPath}/board/inquiries"
                                      onsubmit="return searchCheck()" class="searchForm">
                                    <select name="searchKey" class="select">
                                        <option value="title" ${pVO.searchKey=='title' ? 'selected' : '' }>TITLE</option>
                                        <option value="content" ${pVO.searchKey=='content' ? 'selected' : '' }>CONTENT</option>
                                        <option value="user_id" ${pVO.searchKey=='user_id' ? 'selected' : '' }>WRITER</option>
                                    </select>
                                    <div class="input-group mb-3" style="width: 300px;">
                                        <input type="search" class="form-control" placeholder="SEARCH WORD" name="searchWord" id="inboard-search" value="${pVO.searchWord}">
                                        <button class="btn btn-warning" type="submit" class="post-button" id="search-button">SEATCH</button>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <form method="get" action="${pageContext.servletContext.contextPath}/board/notice"
                                      onsubmit="return searchCheck()" class="searchForm">
                                    <select name="searchKey" class="select">
                                        <option value="title" ${pVO.searchKey=='title' ? 'selected' : '' }>TITLE</option>
                                        <option value="content" ${pVO.searchKey=='content' ? 'selected' : '' }>CONTENT</option>
                                        <option value="user_id" ${pVO.searchKey=='user_id' ? 'selected' : '' }>WRITER</option>
                                    </select>
                                    <div class="input-group mb-3" style="width: 300px;">
                                        <input type="search" class="form-control" placeholder="SEARCH WORD" name="searchWord" id="inboard-search" value="${pVO.searchWord}">
                                        <button class="btn btn-warning" type="submit" class="post-button" id="search-button">SEATCH</button>
                                    </div>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>

</html>

<script>
    function searchCheck() {
        let searchWord = $("#inboard-search").val();
        if (searchWord === "") {
            alert("Please enter your search word!");
            return false;
        }
        return true;
    }

    function updateURL() {
        const selectedValue = document.getElementById("post-sort-select").value;
        const currentURL = window.location.href;
        const newURL = currentURL + (currentURL.includes("?") ? "&" : "?") + "postSort=" + selectedValue;
        window.location.href = newURL;
    }

    function constructUrl() {
        let currentParams = new URLSearchParams(window.location.search);

        let category = $("#second-cat").val();
        let postSort = $("#post-sort-select").val();
        let searchWord = $("#inboard-search").val();

        if (category || category != "0") {
            currentParams.set('category', category);
        }
        if (postSort) {
            currentParams.set('postSort', postSort);
        } else {
            currentParams.set('postSort', "1");
        }
        /*if(searchWord){
            currentParams.set('searchWord', encodeURIComponent(searchWord));
        }*/

        let url = "${pageContext.servletContext.contextPath}/AuthCommunity/list";
        url += "?" + currentParams.toString();

        return url;
    }

    // 페이지가 로드되면 현재 URL의 값을 사용하여 드롭다운 값을 설정합니다.
    $(document).ready(function () {
        let params = new URLSearchParams(window.location.search);

        if (params.has('category')) {
            $('#second-cat').val(params.get('category'));
        }
        if (params.has('postSort')) {
            $('#post-sort-select').val(params.get('postSort'));
        }
    });

    $("#second-cat, #post-sort-select").change(function () {
        window.location.href = constructUrl();
    });

</script>