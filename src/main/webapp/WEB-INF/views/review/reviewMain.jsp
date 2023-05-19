<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BOARD INFO REVIEW</title>
    <style>
        /* 탭 메뉴 스타일 */
        .tab {
            overflow: hidden;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
        }

        /* 탭 버튼 스타일 */
        .tab button {
            background-color: inherit;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 14px 16px;
            transition: 0.3s;
            font-size: 17px;
        }

        /* 선택된 탭 버튼 스타일 */
        .tab button.active {
            background-color: #ccc;
        }

        /* 탭 내용 스타일 */
        .tabcontent {
            display: none;
            padding: 6px 12px;
            border: 1px solid #ccc;
            border-top: none;
        }
    </style>
</head>
<body>

<h1>
    <a href="/review/reviewlist.do">Review</a>
</h1>

<!-- 탭 버튼 -->
<div class="tab">
    <button class="tablinks" onclick="openTab(event, 'Tab1')" id="defaultOpen">게임 리뷰</button>
    <button class="tablinks" onclick="openTab(event, 'Tab2')">모임 리뷰</button>
</div>


<!-- 탭 내용 -->
<div id="Tab1" class="tabcontent">
    <table style="table-layout:fixed;">
        <tr><!-- 첫번째 줄 시작 -->
            <h5>첫번째 탭 내용 : Game Review</h5>
            <th>카테고리</th>
            <th>&#x1f495</th> <%--하트--%>
            <th>제목</th>
            <th>닉네임</th>
            <th>등록일자</th>
            <th>조회수</th>
            <th>댓글</th>
            <th>게임</th>
        </tr>
        <c:forEach items="${list}" var="vo">
        <tr>
            <td>${vo.category}</td>
            <td>${vo.good}</td>
            <td>${vo.title}</td>
            <td>regNum : ${vo.regNum}</td>
            <td>${vo.nickName}</td>
            <td>${vo.createDate}</td>
            <td>${vo.views}</td>
            <td>댓글 연결 예정</td>
            <td>게임 연결 예정</td>
        </tr>
        </c:forEach>
    </table>

</div>

<div id="Tab2" class="tabcontent">
    <table style="table-layout:fixed;">
        <tr><!-- 첫번째 줄 시작 -->
            <h1>두번째 탭 내용 : Gathering Review</h1>
            <th>카테고리</th>
            <th>&#x1f495</th> <%--하트--%>
            <th>제목</th>
            <th>닉네임</th>
            <th>등록일자</th>
            <th>조회수</th>
            <th>댓글</th>
            <th>게임</th>
            <c:forEach items="${list}" var="vo">
        <tr>
            <td>${vo.category}</td>
            <td>${vo.good}</td>
            <td>${vo.title}</td>
            <td>regNum : ${vo.regNum}</td>
            <td>${vo.nickName}</td>
            <td>${vo.createDate}</td>
            <td>${vo.views}</td>
            <td>댓글 연결 예정</td>
            <td>게임 연결 예정</td>
        </tr>
        </c:forEach>

    </table>
</div>

</form>


<%
    String[] itemList = request.getParameterValues("itemForm");
    if (itemList != null) {
        for (int i = 0; i < itemList.length; i++) {
            out.println(itemList[i] + "<br>");
        }
    }
%>




<!-- 탭 스크립트 -->
<script>
    function openTab(evt, tabName) {
        // 탭 내용을 숨김
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }

        // 탭 버튼 활성화/비활성화
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }

        // 선택한 탭 내용 표시 및 버튼 활성화
        document.getElementById(tabName).style.display = "block";
        evt.currentTarget.className += " active";
    }

    // 기본 탭 설정
    document.getElementById("defaultOpen").click();
</script>
</body>
</html>