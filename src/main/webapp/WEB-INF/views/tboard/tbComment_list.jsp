<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="../include/js/header.jsp" %>
	<script src="${path}/include/js/jquery-3.6.3.min.js"></script>
	<style>
		.childReplyInputArea{
			display: none;
		}
	</style>
</head>
<body>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!-- jstl fn활용해서 특수문자 처리 -->
<br>
<br>
<br>
<table style="width: 700px">
	<c:forEach var="row" items="${re_list}">
		<c:set var="str" value="${fn:replace(row.content, '<', '&lt;')}" />
		<c:set var="str" value="${fn:replace(str, '>', '&gt;')}" />
		<c:set var="str" value="${fn:replace(str, '  ', '&nbsp;&nbsp;')}" />
		<c:set var="str" value="${fn:replace(str, newLineChar, '<br>')}" />

		<tr>
			<c:choose>
				<c:when test="${row.del != 'Y'}">
					<td>
						<div>
							${row.create_user }
							(<fmt:formatDate value="${row.create_date}" pattern="yyyy-MM-dd a HH:mm:ss" />)<br>
						</div>
						<div class="comment_content">
							<c:choose>
								<c:when test="${sessionScope.userid != null && sessionScope.userid == row.create_user}">
									<form name="commentChangeForm" method="post">
										<input type="hidden" id="reply_reg_num" name="reply_reg_num" value="${row.reply_reg_num}">
										<input type="hidden" id="tb_num" name="tb_num" value="${row.tb_num}">
										<input type="text" id="content" name="content" value="${str}">
									</form>
								</c:when>
								<c:otherwise>
									${str}
								</c:otherwise>
							</c:choose>
						</div>
						<div class="childReplyInputArea">
							<form method="post" name="childReplyForm" action="${path}/tbComment/">
								<textarea name="childComment" id="childComment" cols="3" rows="60"></textarea>
								<button type="submit">작성 완료</button>

							</form>
						</div>
					</td>
					<c:if test="${sessionScope.userid != null && sessionScope.userid == row.create_user}">
						<td>
							<button type="button" onclick="replyUpdate(${row.tb_num})">수정</button>
						</td>
						<td>
							<button type="button" onclick="replyDelete(${row.tb_num})">삭제</button>
						</td>
					</c:if>
					<td>
						<button type="button" onclick="childReplyInsert(${row.tb_num})">대댓글 달기</button>
					</td>
				</c:when>
				<c:otherwise>
					<div class="comment_content">
						삭제된 댓글 입니다.<br>
						(<fmt:formatDate value="${row.create_date}" pattern="yyyy-MM-dd a HH:mm:ss" />)
					</div>
				</c:otherwise>
			</c:choose>
		</tr>
	</c:forEach>
</table>
<script>
	function replyUpdate(tb_num){
		document.commentChangeForm.action = "${path}/tbComment/update/"+tb_num;
		document.commentChangeForm.submit();
	}
	function replyDelete(tb_num) {
		document.commentChangeForm.action = "${path}/tbComment/delete/"+tb_num;
		document.commentChangeForm.submit();
	}
	function childReplyInsert(tb_num) {
		const childReplyElement = document.getElementsByClassName("childReplyInputArea");
		childReplyElement.style.display = "block";
	}
</script>
</body>
</html>