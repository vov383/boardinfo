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
    <link rel="stylesheet" href="${path}/include/css/style_search.css">
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
            <strong>${gameKeyword}</strong>에 대한 검색결과
        </div>

        <div id="contentsMain">

            <div>

                <div class="totalSearchUl">
                    <ul>
                        <li style="background-color: white;"><a href="${path}/search/searchAll.do?gameKeyword=${gameKeyword}">통합검색</a></li>
                        <li><a href="${path}/search/totalSearchMore/게임/${gameKeyword}">게임명</a></li>
                        <li><a href="${path}/search/totalSearchMore/아티스트/${gameKeyword}">아티스트</a></li>
                        <li><a href="${path}/search/totalSearchMore/디자이너/${gameKeyword}">디자이너</a></li>
                        <li><a href="${path}/search/totalSearchMore/퍼블리셔/${gameKeyword}">퍼블리셔</a></li>
                        <li><a href="${path}/search/totalSearchMore/자유게시판/${gameKeyword}">자유게시판</a></li>
                        <li><a href="${path}/search/totalSearchMore/게임포럼/${gameKeyword}">게임포럼</a></li>
                        <li><a href="${path}/search/totalSearchMore/모임게시판/${gameKeyword}">모임게시판</a></li>
                        <li><a href="${path}/search/totalSearchMore/거래게시판/${gameKeyword}">거래게시판</a></li>
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
                        <c:import url="../game/game_list_moduleFilterNP.jsp" charEncoding="UTF-8" >
                            <c:param name="filter" value="아티스트"></c:param>
                        </c:import>
                    </div>
                </c:if>


                <c:if test="${not empty gameMap.dlist}">
                    <div class="totalSearchDiv">
                        <c:import url="../game/game_list_moduleFilterNP.jsp" charEncoding="UTF-8" >
                            <c:param name="filter" value="디자이너"></c:param>
                        </c:import>
                    </div>
                </c:if>


                <c:if test="${not empty gameMap.plist}">
                    <div class="totalSearchDiv">
                        <c:import url="../game/game_list_moduleFilterNP.jsp" charEncoding="UTF-8" >
                            <c:param name="filter" value="퍼블리셔"></c:param>
                        </c:import>
                    </div>
                </c:if>


                <c:if test="${not empty reviewMap.list1}">
                <div class="totalSearchDiv">
                    <c:import url="../review/review_list_moduleNP.jsp" charEncoding="UTF-8" >
                        <c:param name="filter" value="자유게시판"></c:param>
                    </c:import>
                </div>
                </c:if>

                <c:if test="${not empty reviewMap.list2}">
                    <div class="totalSearchDiv">
                        <c:import url="../review/review_list_moduleNP.jsp" charEncoding="UTF-8" >
                            <c:param name="filter" value="게임포럼"></c:param>
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