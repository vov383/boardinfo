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
				<c:when test="${map.filter != null}">
					<span>${map.filter} 별</span>
				</c:when>
				<c:otherwise>
					<span>전체게임목록</span>
				</c:otherwise>
			</c:choose>

			<a href="${path}/game/write.do" style="float: right">게임등록</a>

		</div>
		<div id="contentsMain">

	<c:if test="${map.filter != null}">
		<div>
                <span>
                    <h1>
                        ${map.filter}
                    :   ${map.list[0].nameStr}
                        ( 총 ${map.count} 개의 게임 )
                    </h1>
                </span>
		</div>
	</c:if>

	<c:import url="game_list_module.jsp" charEncoding="UTF-8">
		<c:param name="map" value="${map}"/>
	</c:import>

		</div>

	</div>

</main>

<footer>
	<%@include file="../include/footer.jsp" %>
</footer>

<%--<script>--%>
<%--	function list(page) {--%>
<%--		location.href="${path}/game/gamelist.do?curPage="+page;--%>
<%--	}--%>

<%--</script>--%>


</body>

</html>