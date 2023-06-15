<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/member.css">
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<%@ include file="../include/js/header.jsp"%>

<style type="text/css">
body {
	font-size: 14px;
	width: auto;
	height: auto;
	margin: 5px;
}

.body {
	border: double black;
	text-align: center;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	margin: 20px;
	padding: 70px;
}

.input_section {
	top: 10%;
	left: 10%;
	margin: 20px;
	padding: 30px;
}

.button {
	text-align: center;
	padding: 10px;
}

.id_class {
	border: solid black;
}

.footer_col {
	text-shadow: gray;
}
</style>
<script type="text/javascript">
	$(function() {
		//input태그에 포커스를 얻을 때(focus)
		$("input").focus(function() {
			//jQuery에서는 css속성이름이 그대로 쓰인다.
			$(this).css("background-color", "black");
			$(this).css("color", "white");
			$(this).css("border", "1px solid white");
		});
		//포커스를 잃을때(blur)
		$("input").blur(function() {
			$(this).css("background-color", "white");
			$(this).css("color", "black");
			$(this).css("border", "1px solid black");
		});
	});

	function searchPw() {
		let userid = $("#inputID_1").val();
		let email = $("#inputEmail_1").val();
		$.ajax({
			type : "post",
			url : "${path}/member/findPwCheck",
			data : {
				"userid" : userid,
				"email" : email
			},
			success : function(data) {
				// debugger
				if (data == 0) {
					alert('회원정보를 확인하세요!');
				} else {
					//회정정보가 맞다면 인증번호 송출
					location.href ="${path}/member/find_pass.do"
				}
			}
		});
	}

	function btncheck() {
		if (window.event.keyCode === 13) {
			$("#findpwbtn").click();
		}
	}
</script>

</head>
<body>
	<div class="body">
		<h2>
			<a href="${path}/"><img alt="로고"
				src="../resources/uploaded_image/boardinfo_logo.png"></a>
		</h2>
		<div class="input_section">
			<form method="post" name="searchFormP">
				<fieldset>
					<legend>비밀번호 찾기</legend>
					<table>
						<tr>
							<td>ID</td>
							<td><input type="text" name="userid" id="inputID_1"
								placeholder="아이디를 입력해주세요."></td>
						</tr>
						<tr>
							<td>EMAIL</td>
							<td><input type="text" name="email" id="inputEmail_1"
								placeholder="이메일을 입력해주세요." onkeyup="btncheck()"></td>
						</tr>
						<tr>
							<td colspan="3">
							<button type="button" name="findpwbtn" id="findpwbtn" onclick="searchPw()">확인</button> 
							<a href="${path}/"><button type="button">메인으로</button></a>
							</td>
						</tr>
					</table>
				</fieldset>
			</form>
		</div>
		<a href="${path}/member/member_join.do">회원가입</a> | 
		<a href="${path}/member/member_login.do">로그인</a> | 
		<a href="${path}/member/findidmove.do">아이디 찾기</a>
	</div>

</body>
</html>