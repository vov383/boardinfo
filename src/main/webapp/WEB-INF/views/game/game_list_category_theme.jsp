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
	<style>
		.totalSearchUl ul li {
			width: calc((100% / 9) - 2px);
		}
		.hover_span{
			cursor: pointer;
		}

		.hover_span:hover {
			background-color: rgba(0,0,0,.1);
		}
	</style>
</head>

<header>
	<%@include file="../include/top.jsp" %>

</header>

<main>
	<div id="contents">
		<div id="contentsHeader">
			<h2>게임정보</h2>
		</div>
		<div id="contentsLocation">
			<span>홈</span>&gt
			<span>게임정보</span>&gt
			<span>장르목록</span>&gt

			<c:choose>
				<c:when test="${filter != null and 'category'.equalsIgnoreCase(filter)}">
					<span>카테고리</span>
				</c:when>
				<c:when test="${filter != null and 'theme'.equalsIgnoreCase(filter)}">
					<span>테마</span>&gt
					<c:if test="${sort eq '-'}">미정</c:if>
					<c:if test="${sort eq '가족게임'}">가족게임</c:if>
					<c:if test="${sort eq '어린이게임'}">어린이게임</c:if>
					<c:if test="${sort eq '전쟁게임'}">전쟁게임</c:if>
					<c:if test="${sort eq '전략게임'}">전략게임</c:if>
					<c:if test="${sort eq '추상게임'}">추상게임</c:if>
					<c:if test="${sort eq '컬렉터블게임'}">컬렉터블게임</c:if>
					<c:if test="${sort eq '테마게임'}">테마게임</c:if>
					<c:if test="${sort eq '파티게임'}">파티게임</c:if>
				</c:when>
			</c:choose>


		</div>
		<div id="contentsMain">

			<c:if test="${filter eq 'theme'}">

		<div class="totalSearchUl">
			<ul>
				<li<c:if test="${sort eq '-'}"> class="selected" </c:if>>
					<a href="${path}/game/themeList/-">미정</a>
				</li>
				<li<c:if test="${sort eq '가족게임'}"> class="selected" </c:if>>
					<a href="${path}/game/themeList/가족게임">가족게임</a>
				</li>
				<li<c:if test="${sort eq '어린이게임'}"> class="selected" </c:if>>
					<a href="${path}/game/themeList/어린이게임">어린이게임</a>
				</li>
				<li<c:if test="${sort eq '전쟁게임'}"> class="selected" </c:if>>
					<a href="${path}/game/themeList/전쟁게임">전쟁게임</a>
				</li>
				<li<c:if test="${sort eq '전략게임'}"> class="selected" </c:if>>
					<a href="${path}/game/themeList/전략게임">전략게임</a>
				</li>
				<li<c:if test="${sort eq '추상게임'}"> class="selected" </c:if>>
					<a href="${path}/game/themeList/추상게임">추상게임</a>
				</li>
				<li<c:if test="${sort eq '컬렉터블게임'}"> class="selected" </c:if>>
					<a href="${path}/game/themeList/컬렉터블게임">컬렉터블게임</a>
				</li>
				<li<c:if test="${sort eq '테마게임'}"> class="selected" </c:if>>
					<a href="${path}/game/themeList/테마게임">테마게임</a>
				</li>
				<li<c:if test="${sort eq '파티게임'}"> class="selected" </c:if>>
					<a href="${path}/game/themeList/파티게임">파티게임</a>
				</li>
			</ul>
		</div>
			</c:if>

			<c:choose>
				<c:when test="${filter != null and 'category'.equalsIgnoreCase(filter)}">
					<c:import url="game_list_moduleFilter_category.jsp" charEncoding="UTF-8" />
				</c:when>
				<c:when test="${filter != null and 'theme'.equalsIgnoreCase(filter)}">
					<c:import url="game_list_module.jsp" charEncoding="UTF-8" />
				</c:when>
			</c:choose>

		</div>

	</div>


</main>

<footer>
	<%@include file="../include/footer.jsp" %>
</footer>

<script>
	function goInsert() {
		if("${sessionScope.userid}" == ""){
			if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
				location.href= "${path}/member/member_login.do";
				return;
			}
		}else{
			location.href= "${path}/game/write.do";
		}
	}
</script>


</body>

</html>