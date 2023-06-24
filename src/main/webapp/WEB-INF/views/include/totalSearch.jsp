<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %> <!-- 세션사용여부 -->

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>BOARDINFO</title>
    <%@ include file="js/header.jsp" %>
    <style>
        .totalSearchDiv {
            padding: 20px 0;
            max-height: 400px;
            clear: both;
            margin-bottom: 30px;
            overflow-y: hidden;
        }
        .totalSearchUl {
            margin-bottom: 10px;
            width: 100%;
        }

        .totalSearchUl ul {
            width: 100%;
            padding-inline-start: inherit;
        }

        .totalSearchUl ul li {
            list-style: none;
            float: left;
            width: calc((100%/8) - 2px);
            height: 36px;
            line-height: 36px;
            text-align: center;
            cursor: pointer;
            background-color: #F9841A;
            border-left: 1px solid gainsboro;
            border-right: 1px solid gainsboro;
        }
        .totalSearchUl ul li span {
            font-size: 13px;
        }


    </style>
</head>

<body>

<header>
    <%@include file="top.jsp" %>
</header>

<main>
    <div id="contents">
        <div id="contentsHeader">
            <h2>통합검색</h2>
        </div>

        <div id="contentsLocation">
            ${gameKeyword}에 대한 검색결과
        </div>

        <div id="contentsMain">

            <div>

                <div class="totalSearchUl">
                    <ul>
                        <li><span>통합검색</span></li>
                        <li><span>게임명</span></li>
                        <li><span>아티스트</span></li>
                        <li><span>디자이너</span></li>
                        <li><span>퍼블리셔</span></li>
                        <li><span>리뷰게시판</span></li>
                        <li><span>모임게시판</span></li>
                        <li><span>거래게시판</span></li>
                    </ul>
                </div>

                <c:if test="${not empty gameMap.glist}">
                    <div class="totalSearchDiv">
                        <c:import url="../game/game_list_moduleNP.jsp" charEncoding="UTF-8" >
                            <c:param name="filter" value="게임"></c:param>
                        </c:import>
                    </div>
                </c:if>


                <c:if test="${not empty gameMap.alist}">
                    <div class="totalSearchDiv">
                        <c:import url="../game/game_list_moduleFilter.jsp" charEncoding="UTF-8" >
                            <c:param name="filter" value="아티스트"></c:param>
                        </c:import>
                    </div>
                </c:if>


                <c:if test="${not empty gameMap.dlist}">
                    <div class="totalSearchDiv">
                        <c:import url="../game/game_list_moduleFilter.jsp" charEncoding="UTF-8" >
                            <c:param name="filter" value="디자이너"></c:param>
                        </c:import>
                    </div>
                </c:if>


                <c:if test="${not empty gameMap.plist}">
                    <div class="totalSearchDiv">
                        <c:import url="../game/game_list_moduleFilter.jsp" charEncoding="UTF-8" >
                            <c:param name="filter" value="퍼블리셔"></c:param>
                        </c:import>
                    </div>
                </c:if>


                <c:if test="${not empty reviewList}">
                <div class="totalSearchDiv">
                    <c:import url="../review/review_list_moduleNP.jsp" charEncoding="UTF-8" >
                        <c:param name="filter" value="리뷰게시판"></c:param>
                    </c:import>
                </div>
                </c:if>


                <c:if test="${not empty gatheringList}">
                <div class="totalSearchDiv">
                    <c:import url="../gathering/gathering_list_moduleNP.jsp" charEncoding="UTF-8" >
                        <c:param name="filter" value="모임게시판"></c:param>
                    </c:import>
                </div>
                </c:if>


                <c:if test="${not empty t_boardList}">
                    <div class="totalSearchDiv">
                        <c:import url="../tboard/tboard_list_moduleNP.jsp" charEncoding="UTF-8" >
                            <c:param name="filter" value="거래게시판"></c:param>
                        </c:import>
                    </div>
                </c:if>

            </div>

        </div>

    </div>
</main>

<footer>
    <%@include file="footer.jsp" %>
</footer>

<script>
    $(document).ready(function(){

    });
</script>

</body>

</html>