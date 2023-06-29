<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <%@ include file="../include/js/header.jsp" %>

    <c:if test='${"Y" eq freeFlag}'>
        <title>커뮤니티 - 자유게시판</title>
    </c:if>

    <c:if test='${"N" eq freeFlag}'>
        <title>커뮤니티 - 게임포럼</title>
    </c:if>

    <style>

        .totalSearchUl ul {
            padding-inline-start: inherit;
            border-bottom: 1px solid #d1d1d1;
        }

        .totalSearchUl ul li {
            margin-right: 2px;
            list-style: none;
            display: inline-block;
            height: 36px;
            width: calc((50%/4) - 5px);
            min-width: 100px;
            line-height: 36px;
            text-align: center;
            cursor: pointer;
            border-top: 1px solid #d1d1d1;
            border-left: 1px solid #d1d1d1;
            border-right: 1px solid #d1d1d1;
        }

        .totalSearchUl ul li.selected {
            background-color: #1432B1;
            border-top: 1px solid #1432B1;
            border-left: 1px solid #1432B1;
            border-right: 1px solid #1432B1;
            color: white;
            font-weight: bold;
        }

        .game_rank_div ul {
            margin: 0 0 40px 0;
            padding: 0;
            width: 100%;
            padding-inline-start: inherit;
        }

        .game_rank_div ul li {
            border-radius: 5px;
            background-color: #e9e9e9;
            margin-right: 6px;
            cursor: pointer;
            list-style: none;
            float: left;
            width: calc((30%/4) - 5px);
            min-width: 90px;
            height: 30px;
            line-height: 30px;
            text-align: center;
        }

        .game_rank_div .selected{
            font-weight: bold;
        }

        table{
            width: 100%;
            table-layout: fixed;
            border-collapse: collapse;
        }

        th{
            border-bottom: 2px solid #e9e9e9;
            padding: 6px 0;
        }

        th:last-of-type{
            max-width: 120px;
        }

        td{
            padding: 4px 0;
            border-bottom: 1px solid #d9d9d9;
        }

        .letLeft{
            text-align: left;
        }

        table a{
            text-decoration: none;
            color: black;
        }

        table a:hover{
            text-decoration: underline;
        }

        .reply{
            margin-left: 10px;
            color: #C53A32;
            font-size: 0.8em;
        }

        .searchBox{
            margin-top: 15px;
            display: flex;
            justify-content: center;
            height: 30px;
        }

        .searchBox input{
            width: 300px;
            padding-left: 5px;
            margin-right: 5px;
        }

        .searchBox button{
            padding: 0 20px;
        }


        #btn-write{
            margin: 10px 0;
            float: right;
        }


        #paginationArea{
            clear: both;
            display: flex;
            justify-content: center;
            margin: 20px auto 0 auto;
        }

        .pageItem{
            width: 35px;
            height: 35px;
            border-radius: 10px;
            line-height: 35px;
            text-align: center;
            margin: 0 3px;
            font-size: 1.2em;
        }

        .pageItem:hover{
            cursor: pointer;
        }

        .pageItem:not(#curPage):hover{
            background-color: #D9D9D9;
        }

        #curPage{
            border: 2px solid #1432B1;
            color: #1432B1;
            line-height: 31px;
        }

    </style>

    <script>

        /*타이틀 및 내용 검색 스크립트, 카테고리 분류(게임포럼 및 자게)*/
        function searchFu(nowPage) {
            $("#searchTitleHidden").val($("#searchTitle").val());
            $("#nowPage").val(nowPage);
            document.reviewSearch.submit();
        }

        /*리뷰 글쓰기 진입*/
        function btnReviewInsert() {
            /*alert("버튼 잘 눌리는지 테스트")*/
            document.reviewInsert.submit();
        }

        /*리뷰 디테일 진입, 조회수 증가*/
        function reviewDetail(regNum) {
            $("#reviewDetailKey").val(regNum);
            /*alert($("#reviewDetailKey").val());*/
            document.reviewDetail.submit();
        }

    </script>

</head>


<body>
<%@include file="../include/top.jsp" %>

<%--검색 폼--%>
<form name="reviewSearch" method="post" action="${path}/review/reviewlist.do">
    <input type="hidden" name="searchTitle" id="searchTitleHidden">
    <input type="hidden" name="freeFlag" id="boardListHidden" value="${freeFlag}">
    <%--페이징--%>
    <input type="hidden" name="nowPage" id="nowPage" value="1">
    <input type="hidden" name="cntPage" id="cntPage" value="10">
    <input type="hidden" name="cntPerPage" id="cntPerPage" value="10">
</form>

<%--디테일 진입 폼--%>
<form name="reviewDetail" method="post" action="${path}/review/reviewdetail.do">
    <input type="hidden" name="reviewDetailKey" id="reviewDetailKey">
    <input type="hidden" name="freeFlag" value="${freeFlag}">
</form>

<form name="reviewInsert" method="post" action="${path}/review/reviewInsert.do">
    <input type="hidden" name="freeFlag" value="${freeFlag}">
</form>


<div id="contents">
    <div id="contentsHeader">
        <h2>커뮤니티</h2>
    </div>


    <c:if test='${"Y" eq freeFlag}'>
        <div id="contentsLocation">
            홈 &gt 커뮤니티 &gt 자유게시판
        </div>
    </c:if>

    <c:if test='${"N" eq freeFlag}'>
        <div id="contentsLocation">
            홈 &gt 커뮤니티 &gt 게임포럼
        </div>
    </c:if>

    <c:if test='${"A" eq freeFlag}'>
        <div id="contentsLocation">
            홈 &gt 커뮤니티
        </div>
    </c:if>

    <c:if test='${"H" eq freeFlag}'>
        <div id="contentsLocation">
            홈 &gt 커뮤니티 &gt 인기글
        </div>
    </c:if>

    <%--목록상단 조건별 정렬--%>
    <div class="totalSearchUl">
        <ul>
            <li onclick="location.href='${path}/review/reviewlist.do'"
            <c:if test="${freeFlag eq 'A'}"> class="selected" </c:if>>
                전체
            </li>
            <li onclick="location.href='${path}/review/reviewlist.do?freeFlag=H'"
                    <c:if test="${freeFlag eq 'H'}"> class="selected" </c:if>>
                인기
            </li>
            <li onclick="location.href='${path}/review/reviewlist.do?freeFlag=N&detail=A'" <c:if test="${freeFlag eq 'N'}"> class="selected" </c:if>>
               게임포럼
            </li>
            <li onclick="location.href='${path}/review/reviewlist.do?freeFlag=Y'" <c:if test="${freeFlag eq 'Y'}"> class="selected" </c:if>>
                자유게시판
            </li>
        </ul>
    </div>

    <%--게임포럼인 경우 세부 갈래별 정렬--%>
    <c:if test="${freeFlag eq 'N'}">

    <div class="game_rank_div">
        <ul>
            <li <c:if test="${detail eq 'A'}"> class="selected"</c:if>
                    onclick="location.href='${path}/review/reviewlist.do?freeFlag=N'">
               전체
            </li>
            <li <c:if test="${detail eq 'Q'}"> class="selected" </c:if>
                    onclick="location.href='${path}/review/reviewlist.do?freeFlag=N&detail=Q'">
                질문
            </li>
            <li <c:if test="${detail eq 'K'}"> class="selected" </c:if>
                    onclick="location.href='${path}/review/reviewlist.do?freeFlag=N&detail=K'">
                노하우
            </li>
            <li <c:if test="${detail eq 'R'}"> class="selected" </c:if>
                    onclick="location.href='${path}/review/reviewlist.do?freeFlag=N&detail=R'">
                게임후기
            </li>
        </ul>
    </div>

    </c:if>

    <div id="contentsMain">

        <%--본문--%>
        <form name="reviewlist" method="post" action="${path}/review/reviewlist.do">
            <table>
                <tr>
                    <th style="width: 50px;">No.</th>
                    <th style="width: 120px;">카테고리</th>
                    <th class='letLeft' style="width: 300px;">제목</th>
                    <c:if test="${freeFlag!='Y'}">
                        <th class="letLeft" style="width: 200px;">게임</th>
                    </c:if>
                    <th class="letLeft" style="width: 150px;">작성자</th>
                    <th style="width: 50px;">조회수</th>
                    <th style="width: 50px;"><img src="${path}/images/game/pink_heart.png" width="15px"></th>
                    <th style="width: 80px;">작성일</th>
                </tr>

                <c:forEach items="${list}" var="vo">
                    <tr>
                        <td style="text-align: center;">${vo.rnum}</td>
                        <td style="text-align: center;">${vo.category}</td>
                        <td class="letLeft"><a href="javascript:reviewDetail('${vo.regNum}')">${vo.title}
                                <c:if test="${vo.recnt>0}"><span class="reply">${vo.recnt}</span></c:if></a></td>
                        <c:if test="${freeFlag!='Y'}">
                        <td class="letLeft">${vo.gametitle}</td>
                        </c:if>
                        <td class="letLeft">${vo.nickName}</td>
                        <td style="text-align: center;">${vo.views}</td>
                        <td style="text-align: center;">
                                <c:if test="${vo.good>0}">
                                    ${vo.good}
                                </c:if>
                        </td>
                        <c:set var="originalValue" value="${vo.createDate}" />
                        <td style="text-align: center;">
                            <c:out value="${fn:substringBefore(originalValue, ' ')}" />
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </form>

            <%--검색 버튼--%>
            <div class="searchBox">
                <input type="text" id="searchTitle" placeholder="제목 및 내용을 검색하세요.">
                <button type="button" id="search" onclick="searchFu('1')">검색</button>
            </div>


            <c:if test="${freeFlag!='H'}">
                <button type="button" onclick="btnReviewInsert()" id="btn-write">글쓰기</button>
            </c:if>

        <%--
              private int nowPage;                 // 현재 페이지
              private int cntPage;                 // 화면 페이지 개수 (가로)
              private int cntPerPage;              // 쿼리 리스트 개수 (세로)
              private int total;                   // 쿼리 리스트 총 개수
              private int lastPage;                // 마지막 번호 (시작번호는 1로고정)
              private int startPage;               // 화면 페이지 가로 시작 번호
              private int endPage;                 // 화면 페이지 가로 마지막 번호
              private int start;                   // 쿼리 리스트 변수
              private int end;                     // 쿼리 리스트 변수

        nowPage;   <c:out value="${page.nowPage   }"></c:out>
        cntPage;   <c:out value="${page.cntPage   }"></c:out>
        lastPage;  <c:out value="${page.lastPage  }"></c:out>
        startPage; <c:out value="${page.startPage }"></c:out>
        endPage;   <c:out value="${page.endPage   }"></c:out>
--%>

        <div class="paging-btn">

            <%--페이징--%>
                <div id="paginationArea">
                    <c:if test="${1 ne page.nowPage}">
                        <div class="pageItem" onclick="searchFu('1')">&lt&lt</div>
                    </c:if>

                    <c:if test="${1 < page.nowPage}">
                        <div class="pageItem" onclick="searchFu('${page.nowPage-1}')">&lt</div>
                    </c:if>

                    <%--현재 페이지--%>
                    <c:forEach var="num" begin="${page.startPage}" end="${page.endPage}">
                        <c:choose>
                            <c:when test="${num == page.nowPage}">
                                <div id="curPage" class="pageItem" onclick="searchFu(${num})">${num}</div>
                            </c:when>
                            <c:otherwise>
                                <div class="pageItem" onclick="searchFu(${num})">${num}</div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${page.lastPage > page.nowPage}">
                        <div class="pageItem" onclick="searchFu('${page.nowPage+1}')">&gt</div>
                    </c:if>
                    <c:if test="${page.lastPage ne page.nowPage && page.lastPage > 1}">
                        <div class="pageItem" onclick="searchFu('${page.lastPage}')">&gt&gt</div>
                    </c:if>

                </div>



        </div>

    </div>
</div>

<%@include file="../include/footer.jsp" %>

</body>

</html>




