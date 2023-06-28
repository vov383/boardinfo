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
			width: calc((100% / 4) - 2px);
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
			<h2>관리자</h2>
		</div>
		<div id="contentsLocation">
			<span>홈</span>&gt
			<span>관리자</span>&gt

			<c:choose>
				<c:when test="${sort != null and 'insert'.equalsIgnoreCase(sort)}">
					<span>등록 대기중 게임</span>
				</c:when>
				<c:when test="${map.sort != null and 'deny'.equalsIgnoreCase(sort)}">
					<span>등록 거부 게임</span>
				</c:when>
				<c:when test="${map.sort != null and 'delete'.equalsIgnoreCase(sort)}">
					<span>삭제 게임</span>
				</c:when>
				<c:when test="${map.sort != null and 'mia'.equalsIgnoreCase(sort)}">
					<span>관련 게임 없는 정보</span>
				</c:when>
			</c:choose>

		</div>
		<div id="contentsMain">

		<div class="totalSearchUl">
			<ul>
				<li<c:if test="${sort eq 'insert'}"> class="selected" </c:if>>
					<a href="${path}/admin/confirmList/insert">대기중 게임</a>
				</li>
				<li<c:if test="${sort eq 'deny'}"> class="selected" </c:if>>
					<a href="${path}/admin/confirmList/deny">등록거부 게임</a>
				</li>
				<li<c:if test="${sort eq 'delete'}"> class="selected" </c:if>>
					<a href="${path}/admin/confirmList/delete">삭제 게임</a>
				</li>
				<li<c:if test="${sort eq 'mia'}"> class="selected" </c:if>>
					<a href="${path}/admin/confirmList/mia">관련 게임 없는 정보</a>
				</li>
			</ul>
		</div>


<c:choose>
	<c:when test="${sort eq 'mia'}">

		<c:if test="${not empty map.alist}">
			<div>
				<c:import url="admin_game_list_moduleFilter.jsp" charEncoding="UTF-8" >
					<c:param name="filter" value="artist"></c:param>
				</c:import>
			</div>
		</c:if>


		<c:if test="${not empty map.clist}">
			<div>
				<c:import url="admin_game_list_moduleFilter.jsp" charEncoding="UTF-8" >
					<c:param name="filter" value="gamecategory"></c:param>
				</c:import>
			</div>
		</c:if>


		<c:if test="${not empty map.dlist}">
			<div>
				<c:import url="admin_game_list_moduleFilter.jsp" charEncoding="UTF-8" >
					<c:param name="filter" value="designer"></c:param>
				</c:import>
			</div>
		</c:if>


		<c:if test="${not empty map.mlist}">
			<div>
				<c:import url="admin_game_list_moduleFilter.jsp" charEncoding="UTF-8" >
					<c:param name="filter" value="mechanic"></c:param>
				</c:import>
			</div>
		</c:if>


		<c:if test="${not empty map.plist}">
			<div>
				<c:import url="admin_game_list_moduleFilter.jsp" charEncoding="UTF-8" >
					<c:param name="filter" value="publisher"></c:param>
				</c:import>
			</div>
		</c:if>

		<c:if test="${empty map.alist && empty map.clist && empty map.dlist && empty map.mlist && empty map.plist }">
			<div>해당 조건에 만족하는 항목이 없습니다.</div>
		</c:if>
	</c:when>

	<c:otherwise>
		<c:choose>
			<c:when test="${empty map.list}">
				<div>해당 조건에 만족하는 항목이 없습니다.</div>
			</c:when>
			<c:otherwise>
				<c:import url="admin_game_list_module.jsp" charEncoding="UTF-8" />
			</c:otherwise>
		</c:choose>
	</c:otherwise>
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