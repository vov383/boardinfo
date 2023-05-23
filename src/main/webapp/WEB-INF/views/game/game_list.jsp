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
<link rel="stylesheet" href="${path}/include/js/style_game.css">

</head>

<header>
	<%@include file="../include/top.jsp" %>
</header>

<main>
	<br><br><br><br><br>

	<div align="center">
		<a href="${path}/game/write.do">insert</a>
	</div>

	<div align="center">
		<table>
			
			<thead>
				
				<tr>
					
					<th>Number</th><!-- 리뷰와 연동되면 Rank -->
					<th>photo</th>
					<th>title</th>
					<th>release year</th>
					<th>review</th>
					<th>shop</th>
					<th>viewcount</th>
					
				</tr>
				
			</thead>
			
			<tbody>
			
			<c:forEach var="row" items="${list}">
				
				<tr>
					
					<td>${row.gnum}</td><!-- 리뷰와 연동되면 순위 ${row.g_rank} -->
					<td>이미지 자리</td>
					<td>
						<a href="${path}/game/view.do?gnum=${row.gnum}">${row.gametitle}(${row.gametitle_eng})</a>
					</td>
					<td>${row.release_year}</td>
					<td>리뷰목록</td><!-- 리뷰와 연동되면 그쪽으로 link -->
					<td>판매물품</td><!-- 거래와 연동되면 그쪽으로 link -->
					<td>${row.viewcount}</td>
					
				</tr>
			</c:forEach>
			
			</tbody>
		</table>
	</div>

</main>

<footer>
	<%@include file="../include/footer.jsp" %>
</footer>



</body>

</html>