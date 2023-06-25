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
</head>

<header>
	<%@include file="../include/top.jsp" %>
	<link rel="stylesheet" href="${path}/include/css/style_table.css">
</header>

<main>
	<div id="contents">
		<div id="contentsHeader">
			<h2>게임목록</h2>
		</div>
		<div id="contentsLocation">
			<span>홈</span>&gt
			<span>게임목록</span>&gt

			<c:choose>
				<c:when test="${map.sort != null and 'week'.equalsIgnoreCase(sort)}">
					<span>보드인포 랭킹</span>
				</c:when>
				<c:when test="${map.sort != null and 'newbie'.equalsIgnoreCase(sort)}">
					<span>신규등록</span>
				</c:when>
				<c:when test="${map.sort != null and 'rate'.equalsIgnoreCase(sort)}">
					<span>평점 랭킹</span>
				</c:when>
				<c:when test="${map.sort != null and 'vcnt'.equalsIgnoreCase(sort)}">
					<span>조회수 랭킹</span>
				</c:when>
			</c:choose>
			<span>(${map.count})개</span>

			<a href="${path}/game/write.do" style="float: right">게임등록</a>

		</div>
		<div id="contentsMain">

		<div class="game_rank_div">
			<ul>
				<li><a href="${path}/game/gamerank/week">주간</a></li>
				<li><a href="${path}/game/gamerank/rate">평점</a></li>
				<li><a href="${path}/game/gamerank/newbie">신규</a></li>
				<li><a href="${path}/game/gamerank/vcnt">조회수</a></li>
			</ul>
		</div>


	<c:import url="game_list_module.jsp" charEncoding="UTF-8" />

		</div>

	</div>


</main>

<footer>
	<%@include file="../include/footer.jsp" %>
</footer>


</body>

</html>