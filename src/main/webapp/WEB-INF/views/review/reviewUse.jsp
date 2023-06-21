<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.bundle.min.js"></script>
<title>K-SIGHT</title>
<%--<%@ include file="/semi_project/include/headForSemi.jsp" %>--%>
<style type="text/css">
body {
	 font-family: 'Open Sans' ,'sans-serif';
 	 background:#f0f0f0;
}
/* 별점포함 세부페이지안에 들어갈 것 */
.btn-grey{
    background-color:#D8D8D8;
	color:#FFF;
}
.rating-block{
	background-color:#FAFAFA;
	border:1px solid #EFEFEF;
	padding:15px 15px 20px 15px;
	border-radius:3px;
}
.bold{
	font-weight:700;
}
.padding-bottom-7{
	padding-bottom:7px;
}
.review-block{
	background-color:#FAFAFA;
	border:1px solid #EFEFEF;
	padding:15px;
	border-radius:3px;
	margin-bottom:15px;
}
.review-block-name{
	font-size:12px;
	margin:10px 0;
}
.review-block-date{
	font-size:12px;
}
.review-block-rate{
	font-size:13px;
	margin-bottom:15px;
}
.review-block-title{
	font-size:15px;
	font-weight:700;
	margin-bottom:10px;
}
.review-block-description{
	font-size:13px;
}

.starR{
  display: inline-block;
  width: 30px;
  height: 30px;
  color: transparent;
  text-shadow: 0 0 0 #f0f0f0;
  font-size: 1.8em;
  box-sizing: border-box;
  cursor: pointer;
}

/* 별 이모지에 마우스 오버 시 */
.starR:hover {
  text-shadow: 0 0 0 #ccc;
}

/* 별 이모지를 클릭 후 class="on"이 되었을 경우 */
.starR.on{
  text-shadow: 0 0 0 #ffbc00;
}
</style>
<script type="text/javascript">
$(function(){
	$('.starRev span').click(function(){
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');
		  $('#rate').val($(this).attr('id'));
		  return false;
	});
	$("#btnSendR").click(function(){
		<%if(session == null || session.getAttribute("email") == null || session.getAttribute("email").equals("")){%>
			alert("로그인후 이용가능합니다.");
		<%}else{%>
			document.sendform.action = "${path}/SP_ksight_review/insert.do";
			document.sendform.submit();
		<%}%>
	});
});
function deleteR(num){
	if(confirm("정말 삭제하시겠습니까?")){
		$("#rnum").val(num);
		document.deleteReview.submit();
	}
	
}

</script>
</head>
<body>
<div style="margin-top: 80px;">
   	<form method="post" name="sendform">
   		<input type="hidden" value="<%= request.getParameter("rsightname")%>" name="rsightname">
   		<h2>Sight정보에 대한 댓글과 별점</h2><br>
		
		<div class="row" align="center">
			<div class="col-md-6">
				<div class="rating-block">
					<h4>Sight의 정보 평점</h4>
					<h2 class="bold padding-bottom-7"> ${ratedto.c_avg} <small>/ 5</small></h2> 
			
			<!-- 별 버튼 값 구현 -->
					<div class="starRev">
  						<span class="starR on" id="starR1">⭐</span>
  						<span class="starR" id="starR2">⭐</span>
  						<span class="starR" id="starR3">⭐</span>
  						<span class="starR" id="starR4">⭐</span>
  						<span class="starR" id="starR5">⭐</span>
  						<input type="hidden" value="starR1" name="rate" id="rate">
					</div>
				</div>
			</div>
			
			<div class="col-md-6">
				<h4>총 (${ratedto.c_all})명 참가</h4>
				
				<div class="pull-left">
					<div class="pull-left" style="width:35px; line-height:1;">
						<div style="height:9px; margin:5px 0;">5 <span class="glyphicon glyphicon-star"></span></div>
					</div>
					
					<div class="pull-left" style="width:180px;">
						<div class="progress" style="height:9px; margin:8px 0;">
						  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${ratedto.c_5/ratedto.c_all*100}" aria-valuemin="0" aria-valuemax="100" style="width: ${ratedto.c_5/ratedto.c_all*100}%">
							<span class="sr-only">80% Complete (danger)</span>
						  </div>
						</div>
					</div>
					
					<div class="pull-right" style="margin-left:10px;">5점 (${ratedto.c_5})</div>
				</div>
				
				<div class="pull-left">
					<div class="pull-left" style="width:35px; line-height:1;">
						<div style="height:9px; margin:5px 0;">4 <span class="glyphicon glyphicon-star"></span></div>
					</div>
					
					<div class="pull-left" style="width:180px;">
						<div class="progress" style="height:9px; margin:8px 0;">
						  <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${ratedto.c_4/ratedto.c_all*100}" aria-valuemin="0" aria-valuemax="100" style="width: ${ratedto.c_4/ratedto.c_all*100}%">
							<span class="sr-only">80% Complete (danger)</span>
						  </div>
						</div>
					</div>
					
					<div class="pull-right" style="margin-left:10px;">4점 (${ratedto.c_4})</div>
				</div>
				
				<div class="pull-left">
					<div class="pull-left" style="width:35px; line-height:1;">
						<div style="height:9px; margin:5px 0;">3 <span class="glyphicon glyphicon-star"></span></div>
					</div>
					
					<div class="pull-left" style="width:180px;">
						<div class="progress" style="height:9px; margin:8px 0;">
						  <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="${ratedto.c_3/ratedto.c_all*100}" aria-valuemin="0" aria-valuemax="100" style="width: ${ratedto.c_3/ratedto.c_all*100}%">
							<span class="sr-only">80% Complete (danger)</span>
						  </div>
						</div>
					</div>
					
					<div class="pull-right" style="margin-left:10px;">3점 (${ratedto.c_3})</div>
				</div>
				
				<div class="pull-left">
					<div class="pull-left" style="width:35px; line-height:1;">
						<div style="height:9px; margin:5px 0;">2 <span class="glyphicon glyphicon-star"></span></div>
					</div>
					
					<div class="pull-left" style="width:180px;">
						<div class="progress" style="height:9px; margin:8px 0;">
						  <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="${ratedto.c_2/ratedto.c_all*100}" aria-valuemin="0" aria-valuemax="100" style="width: ${ratedto.c_2/ratedto.c_all*100}%">
							<span class="sr-only">80% Complete (danger)</span>
						  </div>
						</div>
					</div>
					
					<div class="pull-right" style="margin-left:10px;">2점 (${ratedto.c_2})</div>
				</div>
				
				<div class="pull-left">
					<div class="pull-left" style="width:35px; line-height:1;">
						<div style="height:9px; margin:5px 0;">1 <span class="glyphicon glyphicon-star"></span></div>
					</div>
					
					<div class="pull-left" style="width:180px;">
						<div class="progress" style="height:9px; margin:8px 0;">
						  <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="${ratedto.c_1/ratedto.c_all*100}" aria-valuemin="0" aria-valuemax="100" style="width: ${ratedto.c_1/ratedto.c_all*100}%">
							<span class="sr-only">80% Complete (danger)</span>
						  </div>
						</div>
					</div>
					
					<div class="pull-right" style="margin-left:10px;">1점 (${ratedto.c_1})</div>
				</div>
			
			</div>			
		</div>			
		
		
		
		<div>        
        <br style="clear:both">
            <div class="form-group col-md-11 ">                                
                <%--@declare id="message"--%><label id="messageLabel" for="message">comment</label>
                <textarea class="form-control input-sm " type="textarea" name="content" id="content" placeholder="별점 평가해주세요." maxlength="140" rows="7"></textarea>
                <button class="form-control input-sm btn btn-success" id="btnSendR" name="btnSendR" type="button" style="height:35px"> Send</button>
                <span class="help-block"><p id="characterLeft" class="help-block">댓글은 최대 200글자까지 입력가능합니다.</p></span>                    
            </div>
       
        <br style="clear:both">
		</div>
	</form>
		
		
	<div class="row">
	
	<c:forEach var="rlist" items="${rlist}">
		<div class="col-md-11">
		<hr/>
			<div class="review-block">
				<div class="row">
					
					<div class="col-sm-3">
						<img src="${path}/semi_project/images/person-square.svg" class="img-rounded" style="width: 100px;">
						<div class="review-block-name"><b>${rlist.id}</b></div>
						<div class="review-block-date">
							 ${rlist.write_date}
						</div>
					</div>
						
					<div class="col-sm-9">
						<div class="review-block-rate">
						<c:forEach var="ratecnt" begin="1" end="${rlist.rate}">
							<span class="starR on">⭐</span>
						</c:forEach>
						
					<c:if test="${rlist.rate < 5}">
						<c:forEach var="ratecntd" begin="1" end="${5-rlist.rate}">
							<span class="starR">⭐</span>
						</c:forEach>
					</c:if>
								
					<c:if test="${rlist.email eq sessionScope.email}">
							<a href="#" style="float: right;" onclick="deleteR('${rlist.rnum}')">삭제</a>
					</c:if>
						</div>
					<div class="review-block-description">${rlist.content}</div>
				</div>
			</div>
			<hr/>
		</div>
	</div>
	</c:forEach>
	</div>
		
	<form method="post" name="deleteReview" action="${path}/SP_ksight_review/delete.do">
		 <input type="hidden" id="rnum" name="rnum" value="">
		 <input type="hidden" value="<%= request.getParameter("rsightname")%>" name="rsightname">
	</form>
		
		
</div>

</body>
</html>