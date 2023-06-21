<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!-- 세션사용여부 -->

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>BOARD INFO REVIEW</title>
<%@ include file="../include/js/header.jsp"%>
<style type="text/css">
body {
	color: #666;
	font: 14px/24px "Open Sans", "HelveticaNeue-Light",
		"Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial,
		"Lucida Grande", Sans-Serif;
}

table {
	border-collapse: separate;
	border-spacing: 0;
	width: 100%;
}

th, td {
	padding: 6px 15px;
}

th {
	background: #42444e;
	color: #fff;
	text-align: left;
}

tr:first-child th:first-child {
	border-top-left-radius: 6px;
}

tr:first-child th:last-child {
	border-top-right-radius: 6px;
}

td {
	border-right: 1px solid #c6c9cc;
	border-bottom: 1px solid #c6c9cc;
}

td:first-child {
	border-left: 1px solid #c6c9cc;
}

tr:nth-child(even) td {
	background: #eaeaed;
}

tr:last-child td:first-child {
	border-bottom-left-radius: 6px;
}

tr:last-child td:last-child {
	border-bottom-right-radius: 6px;
}
</style>
</head>

<body>

	<div align="center">
		<table>
			<thead>
				<tr>
					<th>카테고리</th>
					<th>&#x1f495</th>
					<th>제목</th>
					<th>닉네임</th>
					<th>등록일자</th>
					<th>조회수</th>
					<th>댓글</th>
					<th>게임</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="row" items="${list}">
				<tr>
					<td>${row.gnum}</td><!-- 리뷰와 연동되면 순위 ${row.g_rank} -->
					<td>이미지 자리</td>
					<td>${row.gametitle}</td>
					<td>게임평점</td>
					<td>난이도</td>
					<td>판매물품</td><!-- 거래와 연동되면 그쪽으로 link -->
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>

</body>

</html>