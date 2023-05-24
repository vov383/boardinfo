<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/js/header.jsp" %>
<script src="${path}/include/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
$(function () {
	$("#btnWrite").click(function () {
		location.href="${path}/tboard/write.do";
	});
	
	function list(page) {
		location.href="${path}/board/list.do?curPage="+page;
	}
});

function view(tb_num) {
	location.href="${path}/tboard/view/"+tb_num;
}
</script>
</head>
<body>
<%@include file="../include/top.jsp" %>

<div id="contents">
	<div id="contentsHeader">
		<h2>중고거래 게시판</h2>
		<div>총 게시물 수 : ${map.count}</div>
		<div id="searchFormArea">
			<form id="searchForm" name="searchForm" method="post"
				  action="${path}/tboard/list.do">
				<select name="select_category">
					<option value="all" selected="selected">전체</option>
					<option value="s">판매중</option>
					<option value="b">구매</option>
					<option value="d">나눔</option>
					<option value="f">완료</option>
				</select>
				<select name="search_option" id="searchType">
					<option value="all" selected="selected">제목+내용+작성자</option>
					<option value="title">제목</option>
					<option value="description">내용</option>
					<option value="writer">작성자</option>
				</select>
				<input name="keyword" id="keyword">
				<button type="submit">찾기</button>
			</form>
			<!-- 검색폼 -->
			<button type="button" id="btnWrite">글쓰기</button>
		</div>
	</div>
	<div id="contentsMain">
		<table>
			<c:forEach var="row" items="${map.list}">
				<c:choose>
					<c:when test="${row.del == 'N'}">
						<tr>
							<td>
								<span>${row.category}</span>
								<a href="#" onclick="view(${row.tb_num})">${row.title}</a>
							</td>
							<td>${row.price}</td>
						</tr>
						<tr>
							<td>
								<table border="1">
									<tr>
										<td>${row.create_user}</td>
										<td><fmt:formatDate value="${row.create_date}"
															pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td>${row.view_count}</td>
										<td>${row.re_count}</td>
									</tr>
								</table>
							</td>
						</tr>
					</c:when>
				</c:choose>
			</c:forEach>
		</table>
		<!-- 게시글 목록 -->

			<tr>
				<td colspan="6" align="center">
					<c:if test="${map.pager.curBlock > 1}">
						<a href="#" onclick="list('1')">[처음]</a>
					</c:if>
					<c:if test="${map.pager.curBlock > 1}">
						<a href="#" onclick="list('${map.pager.prevPage}')">
							[이전]</a>
					</c:if>
					<c:forEach var="num"
							   begin="${map.pager.blockBegin}"
							   end="${map.pager.blockEnd}">
						<c:choose>
							<c:when test="${num == map.pager.curPage}">
								<!-- 현재 페이지인 경우 하이퍼링크 제거 -->
								<span style="color:red;">${num}</span>
							</c:when>
							<c:otherwise>
								<a href="#" onclick="list('${num}')">${num}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${map.pager.curBlock < map.pager.totBlock}">
						<a href="#"
						   onclick="list('${map.pager.nextPage}')">[다음]</a>
					</c:if>
					<c:if test="${map.pager.curPage < map.pager.totPage}">
						<a href="#"
						   onclick="list('${map.pager.totPage}')">[끝]</a>
					</c:if>
				</td>
			</tr>
			<!-- 페이지 네비게이션 출력 -->
		</table>
	</div>>
	<%@include file="../include/footer.jsp" %>
</div>
</body>
</html>






