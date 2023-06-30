<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<!-- 세션사용여부 -->
<link rel="stylesheet" href="${path}/include/css/pagenation.css">
<style>

	.totalSearchUl ul li {
		margin-bottom: 10px;
		width: calc((100% / 2) - 2px);
		font-weight: bold;
	}

	.totalSearchUl li:not([class='selected']){
		font-weight: normal;;
		background-color: #d9d9d9;
	}



</style>

<div id="moduleDiv">

	<div class="totalSearchUl">
		<ul>
			<li<c:if test="${sort eq 'like'}"> class="selected" </c:if> class="btnMoreViewReply">
				<span>좋아요순</span>
			</li>
			<li<c:if test="${sort eq 'date'}"> class="selected" </c:if> class="btnMoreViewReplyDate">
				<span>최신등록순</span>
			</li>
		</ul>
	</div>

<div style="text-align: right;">

	<span>총 평가 수 ${map.count}개</span>

</div>

	<c:forEach var="row" items="${map.list}">

		<c:set var="participant1" value="${row.participant1}" />
		<c:set var="participant2" value="${row.participant2}" />
		<c:set var="participant3" value="${row.participant3}" />
		<c:set var="participant4" value="${row.participant4}" />
		<c:set var="participant5" value="${row.participant5}" />

		<c:set var="bestPeople" value="" />
		<c:set var="goodPeople" value="" />
		<c:set var="badPeople" value="" />

		<c:if test="${participant1 eq 1}">
			<c:set var="bestPeople" value="${bestPeople}${fn:escapeXml(item.index+1)}, " />
		</c:if>
		<c:if test="${participant2 eq 1}">
			<c:set var="bestPeople" value="${bestPeople}${fn:escapeXml(item.index+2)}, " />
		</c:if>
		<c:if test="${participant3 eq 1}">
			<c:set var="bestPeople" value="${bestPeople}${fn:escapeXml(item.index+3)}, " />
		</c:if>
		<c:if test="${participant4 eq 1}">
			<c:set var="bestPeople" value="${bestPeople}${fn:escapeXml(item.index+4)}, " />
		</c:if>
		<c:if test="${participant5 eq 1}">
			<c:set var="bestPeople" value="${bestPeople}5↑, " />
		</c:if>

		<c:if test="${participant1 eq 2}">
			<c:set var="goodPeople" value="${goodPeople}${fn:escapeXml(item.index+1)}, " />
		</c:if>
		<c:if test="${participant2 eq 2}">
			<c:set var="goodPeople" value="${goodPeople}${fn:escapeXml(item.index+2)}, " />
		</c:if>
		<c:if test="${participant3 eq 2}">
			<c:set var="goodPeople" value="${goodPeople}${fn:escapeXml(item.index+3)}, " />
		</c:if>
		<c:if test="${participant4 eq 2}">
			<c:set var="goodPeople" value="${goodPeople}${fn:escapeXml(item.index+4)}, " />
		</c:if>
		<c:if test="${participant5 eq 2}">
			<c:set var="goodPeople" value="${goodPeople}5↑, " />
		</c:if>

		<c:if test="${participant1 eq 3}">
			<c:set var="badPeople" value="${badPeople}${fn:escapeXml(item.index+1)}, " />
		</c:if>
		<c:if test="${participant2 eq 3}">
			<c:set var="badPeople" value="${badPeople}${fn:escapeXml(item.index+2)}, " />
		</c:if>
		<c:if test="${participant3 eq 3}">
			<c:set var="badPeople" value="${badPeople}${fn:escapeXml(item.index+3)}, " />
		</c:if>
		<c:if test="${participant4 eq 3}">
			<c:set var="badPeople" value="${badPeople}${fn:escapeXml(item.index+4)}, " />
		</c:if>
		<c:if test="${participant5 eq 3}">
			<c:set var="badPeople" value="${badPeople}5↑, " />
		</c:if>

	<div class="topReview" data-writer="${row.userid}">
	<span class="reviewStar">
		<span> ${row.rating} </span>
        <img src="${path}/images/game/yellow_star.png" width="90px" height="85px" style="vertical-align: middle">
	</span>
	<div>
		<div> ${row.nickname} &nbsp;&nbsp;&nbsp;&nbsp; ${row.create_date}</div>
			<div>${row.rating_comment}</div>

		<div>
			<div class="reviewDetail">
				<span>난이도&nbsp; ${row.weight}</span>
				<c:if test="${not empty bestPeople}">
					<span>베스트인원 ${fn:substring(bestPeople, 0, fn:length(bestPeople)-2)}</span>
				</c:if>
				<c:if test="${not empty goodPeople}">
					<span>추천인원 ${fn:substring(goodPeople, 0, fn:length(goodPeople)-2)}</span>
				</c:if>
				<c:if test="${not empty badPeople}">
					<span>비추천인원 ${fn:substring(badPeople, 0, fn:length(badPeople)-2)}</span>
				</c:if>
			</div>

			<c:choose>
				<c:when test="${row.myLike>0}">
					<div data-like='y' class='likeItDiv' onclick="likeIt('${row.userid}')">
						<img src="${path}/images/game/pink_heart.png" width="20px">
						<span class='likeCount'>${row.likeCount}</span>
					</div>
				</c:when>
				<c:otherwise>
					<div data-like="n" class="likeItDiv" onclick="likeIt('${row.userid}')">
					<img src="${path}/images/game/empty_heart.png" width="20px">
					<span class="likeCount">${row.likeCount}</span>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

</c:forEach>

<div id="paginationArea">
	<c:if test="${map.pager.curPage > 1}">
		<div class="pageItem" onclick="list(1)">&lt&lt</div>
	</c:if>
	<c:if test="${map.pager.curPage > 1}">
		<div class="pageItem" onclick="list(${map.pager.prevPage})">&lt</div>
	</c:if>
	<c:forEach var="num" begin="${map.pager.blockStart}" end="${map.pager.blockEnd}">
		<c:choose>
			<c:when test="${num == map.pager.curPage}">
				<div id="curPage" class="pageItem" onclick="list(${num})">${num}</div>
			</c:when>
			<c:otherwise>
				<div class="pageItem" onclick="list(${num})">${num}</div>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${map.pager.curPage < map.pager.totPage}">
		<div class="pageItem" onclick="list(${map.pager.nextPage})">&gt</div>
	</c:if>
	<c:if test="${map.pager.curPage < map.pager.totPage}">
		<div class="pageItem" onclick="list(${map.pager.totPage})">&gt&gt</div>
	</c:if>
</div>

</div>

<script>

	function list(page) {
		$.ajax({
			type: "GET",
			url : "${path}/gameRating/getMoreRatings.do",
			data : {
				"gnum": "${map.gnum}",
				"sort": "date",
				"curPage": page
			},
			dataType : "html",
			async:false,
			success: function(data) {
				console.log('AJAX 요청 성공');
				$('#moduleDiv').html(data);
			},
			error: function() {
				console.log('AJAX 요청 실패');
			}
		});
	}
	//댓글 최신순 클릭시
	$(function(){
		$(".btnMoreViewReplyDate").click(function(){

			$.ajax({
				type: "GET",
				url : "${path}/gameRating/getMoreRatings.do",
				data : {
					"gnum": "${map.gnum}",
					"sort": "date"
				},
				dataType : "html",
				async:false,
				success: function(data) {
					console.log('AJAX 요청 성공');
					$('#moduleDiv').html(data);
				},
				error: function() {
					console.log('AJAX 요청 실패');
				}
			});
		});
		//댓글 더보기 클릭시 or 베스트순 정렬시
		$(".btnMoreViewReply").click(function(){

			$.ajax({
				type: "GET",
				url : "${path}/gameRating/getMoreRatings.do",
				data : {
					"gnum": "${map.gnum}",
					"sort": "like"
				},
				dataType : "html",
				async:false,
				success: function(data) {
					console.log('AJAX 요청 성공');
					$('#moduleDiv').html(data);
				},
				error: function() {
					console.log('AJAX 요청 실패');
				}
			});
		});
	});


</script>