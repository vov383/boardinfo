<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>회원정보변경</title>
  <%@ include file="../include/js/header.jsp" %>

  <style>

#change {
	float: left;
	width: 180px;
	border: 1px solid #D9D9D9;
	border-radius: 18px;
	margin-right: 30px;
	margin-top: 52px;
}

#change h3 {
	margin: 0 0 10px 0;
	padding: 0;
}

#change>div {
	padding: 13px 20px;
	border-bottom: 1px solid #D9D9D9;
}

#change ul {
	margin: 0;
	padding: 0;
	list-style: none;
}

#change li {
	margin-bottom: 4px;
}

#change div:last-of-type {
	border-bottom: none;
}

#change div:last-of-type>div {
	display: flex;
	flex-direction: column;
	margin-top: 10px;
	padding: 0;
	align-items: center;
}

#change div:last-of-type>div {
	display: flex;
	flex-direction: row;
	justify-content: end;
	width: 100%;
}

a {
	text-decoration-line: none;
	color: black;
}

a:hover {
	color: blue;
}

#passwordConfirmationForm {
	margin: 0 auto;
	width: 800px;
	padding: 20px;
	padding-right: 80px;
	border: 1px solid #D9D9D9;
	border-radius: 18px;
	text-align: center;
	margin-top: 52px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

#passwordConfirmationForm h3 {
	margin: 0 0 10px 0;
	padding: 0;
}

#passwordConfirmationForm form {
	margin-top: 10px;
}

#passwordConfirmationForm label {
	display: block;
	margin-bottom: 5px;
}

#passwordConfirmationForm input[type="password"] {
	width: 100%;
	padding: 5px;
	border: 1px solid #D9D9D9;
	border-radius: 5px;
	margin-bottom: 10px;
}

#passwordConfirmationForm input[type="button"] {
	padding: 8px 16px;
	background-color: #ff0000;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

#passwordConfirmationForm input[type="button"]:hover {
	background-color: #45a049;
}

.input-container {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.input-container label {
	width: 150px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.center {
	display: flex;
	justify-content: center;
}

.caution {
	font-size: 12px;
	line-height: 200%;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

.num1 {
	border: 1px;
	border-style: solid;
	width: 100%;
	border-color: black white black;
}

.num2 {
	border: 1px;
	border-style: solid;
	width: 100%;
	border-color: white white black;
}

span {
	font-size: 16px;
}
</style>

<script type="text/javascript">
	
	$(function() {
		$("#btnDelete").click(function() {
			if (confirm('탈퇴하시겠습니까?')) {
				document.form1.action = "${path}/member/delete.do/${userid}";
				document.form1.submit();
				alert("회원탈퇴가 완료되었습니다.");
			}
		});
	});
</script>

<style type="text/css">
.caution {
      font-size: 12px;
      line-height: 200%;
      display: flex; /* Flexbox 적용 */
      flex-direction: row; /* 수평 정렬 */
      justify-content: space-between; /* 두 줄 사이 간격 벌리기 */
    }

li {
	list-style: none;
}

.num1 {
	border: 1px;
	border-style: solid;
	width : 100%;
	border-color: black white black;
	padding-bottom: 30px;
}
.num2 {
	border: 1px;
	border-style: solid;
	width : 100%;
	border-color: white white black;
	padding-bottom: 30px;
}

span{
	font-size: 16px;
}
</style>
</head>
<body>


<%@include file="../include/top.jsp" %>

	<div id="contents">
		<div id="contentsHeader">
			<h2>마이페이지</h2>
		</div>
		<div id="contentsLocation">홈 &gt 마이페이지 &gt 회원탈퇴</div>
		<div id="contentsMain">
    <div id="change">
      <div>
        <div>
          <label for="showAvailable">내 정보 관리</label>
        </div>
      </div>
      <div>
        <ul class="sideNav1">
          <li class="sub1"><a href="${path}/member/pass_check_u?userid=${sessionScope.userid}" title="개인정보변경">개인정보변경</a></li>
          <li class="sub3"><a href="${path}/member/pass_check_p?userid=${sessionScope.userid}" title="비밀번호변경">비밀번호변경</a></li>
          <li class="sub5"><a href="${path}/member/pass_check_d?userid=${sessionScope.userid}" title="회원탈퇴">회원탈퇴</a></li>
        </ul>
      </div>
    </div>
			<div id="passwordConfirmationForm">
				<h2 style="padding-left: 45px">회원탈퇴 주의 사항</h2>
				<div class="caution">
					<ol>
					 <li class="num1" style="float: left;">
					 	<h4>1. 탈퇴 후 제한</h4>
					 	<span>탈퇴 처리된 아이디 및 닉네임은 30일 동안 재사용이 불가능 합니다.</span>
					 </li>

					 <li class="num2" style="float: left; margin: 1px;">
					 	<h4>2. 개인 정보 보관</h4>
					 	<span>회원탈퇴 시 이용자의 개인정보는 개인정보처리방침 [4. 개인정보의 파기]에 따라 탈퇴일로부터
								30일간 보관 됩니다. 그 이후 관계법령에 따라 별도보관이 필요한 경우에는 별도 보관이 됩니다. 자세한 내용은
								개인정보처리방침을 통해 확인하실 수 있습니다.
						</span>
						</li>
						
						<li class="num2" style="float: left; margin: 1px;">
					 	<h4>3. 보드인포 로그인 및 사이트 이용 불가 , 내 활동 삭제</h4>
					 	<span>회원탈퇴 시 보드 인포에 로그인 할 수 없으며,현재 아이디로 활동한 기록들은 전부 삭제 됩니다.</span>
						</li>
					</ol>
					
				</div>
				<form name="form1" method="post" >
				<input type="button" value="탈퇴하기" name="btnDelete" id="btnDelete"  style="margin-left: 45px;">
				</form>
			</div>
		</div>
</div>


	

<%@include file="../include/footer.jsp" %>


</body>
</html>