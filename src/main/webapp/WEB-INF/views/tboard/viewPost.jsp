<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../include/js/header.jsp" %>
<script src="../include/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript">
$(function() {
	//댓글 목록 출력
	listReply();
	//listReply2();
	
	//댓글 쓰기
	$("#btnCommentInsert").click(function(){
		var content=$("#content").val(); //댓글 내용
//		var tb_num="${dto.tb_num}"; //게시물 번호
		var tb_num = $("#tb_num").val();
		var param={ "content": content, "tb_num": tb_num};
		//var param="content=" + content+ "&tb_num=" + tb_num;
		$.ajax({
			type: "post",
			url: "${path}/tbComment/insert.do",
			data: param,
			success: function(){
				alert("댓글이 등록되었습니다.");
				listReply();
				//listReply2(); //댓글 목록 출력
			}
		});
	});
	
	$("#btnChange").click(function() {
		document.form1.action="${path}/tboard/change.do";
		document.form1.submit();
	});
	$("#btnList").click(function() {
		location.href="${path}/tboard/list.do";
	});
});

//댓글 목록 출력 함수
function listReply(){
	$.ajax({
		type: "get",
		url: "${path}/tbComment/list.do?tb_num=${dto.tb_num}",
		success: function(result){
			//result : responseText 응답텍스트(html)
			$("#listReply").html(result);
		}
	});
}
</script>
</head>
<body>
<h2>게시물 보기 페이지</h2>
<div>
글번호 : ${dto.tb_num} <br>
<div class="itemImgArea">
</div>
<div>
	<button type="button" id="btnList">목록</button>
<%-- 	<c:if test="${sessionScope.userid == dto.create_user}">
	</c:if> --%>
		<form name="form1" method="post">
			<input type="hidden" name="tb_num" value="${dto.tb_num}">
			<button type="button" id="btnChange">수정/삭제</button>
		</form>
</div>
카테고리 : 
<span>
	<c:choose>
		<c:when test="${dto.category == 's'}">
			<img alt="판매" src="">
		</c:when>
		<c:when test="${dto.category == 'b'}">
			<img alt="구매" src="">
		</c:when>
		<c:when test="${dto.category == 'n'}">
			<img alt="나눔" src="">
		</c:when>
		<c:otherwise>
			<img alt="거래완료" src="">
		</c:otherwise>
	</c:choose>
</span>
제목 : ${dto.title} <br>
작성자 : <a href="#">${dto.create_user}</a><br>
작성일자 : <fmt:formatDate value="${dto.create_date}" 
					pattern="yyyy-MM-dd HH:mm:ss" /> <br>
가격 : ${dto.price} <br>
조회수 : ${dto.view_count} <br>
내용 : ${dto.description} <br>

<c:if test="${dto.meeting_place != null }">
약속장소 : ${dto.meeting_place}
</c:if>

</div>

<div class="commentArea">
<h4>댓글</h4>
	댓글 갯수 : ${dto.re_count}
	<div class="commentList"></div>
	<form name="commentForm" action="${path}/tbComment/commentInsert.do">
		<input type="hidden" id="tb_num" name="tb_num" value="${dto.tb_num}">
		<textarea name="content" id="content" rows="5" cols="60"></textarea> 
		<br>
		<button type="button" id="btnCommentInsert">댓글 작성 완료</button>		
		<%-- <c:choose>
			<c:when test="${sessionScope.userid != null }">
				<button type="button" id="btnCommentInsert">댓글 작성 완료</button>		
			</c:when>
			<c:otherwise>
				<div>
					로그인해서 댓글을 작성해보세요 <br>
					<button type="button" id="btnMoveLogin">로그인 페이지로 이동</button>
				</div>
			</c:otherwise>
		</c:choose> --%>
	</form>
</div>
<div id="listReply"></div>
</body>
</html>