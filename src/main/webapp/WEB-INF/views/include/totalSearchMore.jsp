<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!-- 세션사용여부 -->

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>BOARDINFO</title>
    <%@ include file="../include/js/header.jsp"%>
    <link rel="stylesheet" href="${path}/include/css/style_search.css">
    <link rel="stylesheet" href="${path}/include/css/pagenation.css">
</head>

<header>
    <%@include file="../include/top.jsp" %>
</header>

<main>
    <div id="contents">
        <div id="contentsHeader">
            <h2>${map.filter}검색</h2>
        </div>

        <div id="contentsLocation">
            <strong>${map.gameKeyword}</strong>에 대한 검색결과
        </div>

        <div id="contentsMain">
            <div>

                    <div class="totalSearchUl">
                        <ul>
                            <li><a href="${path}/search/searchAll.do?gameKeyword=${gameKeyword}">통합검색</a></li>
                            <li<c:if test="${map.filter eq '게임'}"> class="selected" </c:if>>
                                <a href="${path}/search/totalSearchMore/게임/${gameKeyword}">게임명</a>
                            </li>
                            <li<c:if test="${map.filter eq '아티스트'}"> class="selected" </c:if>>
                                <a href="${path}/search/totalSearchMore/아티스트/${gameKeyword}">아티스트</a>
                            </li>
                            <li<c:if test="${map.filter eq '디자이너'}"> class="selected" </c:if>>
                                <a href="${path}/search/totalSearchMore/디자이너/${gameKeyword}">디자이너</a>
                            </li>
                            <li<c:if test="${map.filter eq '퍼블리셔'}"> class="selected" </c:if>>
                                <a href="${path}/search/totalSearchMore/퍼블리셔/${gameKeyword}">퍼블리셔</a>
                            </li>
                            <li<c:if test="${map.filter eq '자유게시판'}"> class="selected" </c:if>>
                                <a href="${path}/search/totalSearchMore/자유게시판/${gameKeyword}">자유게시판</a>
                            </li>
                            <li<c:if test="${map.filter eq '게임포럼'}"> class="selected" </c:if>>
                                <a href="${path}/search/totalSearchMore/게임포럼/${gameKeyword}">게임포럼</a>
                            </li>
                            <li<c:if test="${map.filter eq '모임게시판'}"> class="selected" </c:if>>
                                <a href="${path}/search/totalSearchMore/모임게시판/${gameKeyword}">모임게시판</a>
                            </li>
                            <li<c:if test="${map.filter eq '거래게시판'}"> class="selected" </c:if>>
                                <a href="${path}/search/totalSearchMore/거래게시판/${gameKeyword}">거래게시판</a>
                            </li>
                        </ul>
                    </div>

                <br>

                <c:choose>
                    <c:when test="${not empty map.list or not empty map.alist or not empty map.dlist or not empty map.plist}">
                        <c:if test="${map.filter eq '게임'}">
                            <c:import url="../game/game_list_module.jsp" charEncoding="UTF-8" />
                        </c:if>
                        <c:if test="${map.filter eq '아티스트' or map.filter eq '디자이너' or map.filter eq '퍼블리셔'}">
                            <c:import url="../game/game_list_moduleFilter.jsp" charEncoding="UTF-8" />
                        </c:if>
                        <c:if test="${map.filter eq '자유게시판'}">
                            <c:import url="../review/review_list_moduleNP.jsp" charEncoding="UTF-8" />
                        </c:if>
                        <c:if test="${map.filter eq '게임포럼'}">
                            <c:import url="../review/review_list_moduleNP.jsp" charEncoding="UTF-8" />
                        </c:if>
                        <c:if test="${map.filter eq '모임게시판'}">
                            <c:import url="../gathering/gathering_list_moduleNP.jsp" charEncoding="UTF-8" />
                        </c:if>
                        <c:if test="${map.filter eq '거래게시판'}">
                            <c:import url="../tboard/tboard_list_moduleNP.jsp" charEncoding="UTF-8" />
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        검색 결과가 없습니다.
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

    </div>


</main>

<footer>
    <%@include file="footer.jsp" %>
</footer>


</body>

</html>