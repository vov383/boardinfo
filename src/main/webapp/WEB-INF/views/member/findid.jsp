<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/member.css">
<meta charset="UTF-8">
<title>아이디 찾기</title>
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
footer{
	position : fixed;
	bottom : 0
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

	function searchId() {
		let name = $("#inputName_1").val();
		let hp = $("#inputPhone_1").val();
		$.ajax({
			type : "post",
			url : "${path}/member/userSearch",
			data : {
				"name" : name,
				"hp" : hp
			},
			success : function(data) {
				// debugger
				if (data == 0) {
					alert('회원정보를 확인하세요!');
				} else {
					var idv = data;
					alert(data);
					location.href = "${path}/member/member_login.do";
				}
			}
		});
	}

	function btncheck() {
		if (window.event.keyCode === 13) {
			$("#findidbtn").click();
		}
	}
</script>

</head>
	<header>
     
    </header>
<body>
	<div class="body">
		<h2>
			<a href="${path}/"><img alt="로고"
				src="../resources/uploaded_image/boardinfo_logo.png"></a>
		</h2>
		<div class="input_section">
			<form method="post" name="searchFormI">
				<fieldset>
					<legend>아이디 찾기</legend>
					<table>
						<tr>
							<td>이름</td>
							<td><input type="text" name="name" id="inputName_1"
								placeholder="ex)홍길동"></td>
						</tr>
						<tr>
							<td>휴대폰번호</td>
							<td><input type="text" name="hp" id="inputPhone_1"
								placeholder="ex)01012345678" onkeyup="btncheck()"></td>
						</tr>
						<tr>
							<td colspan="3"><button type="button" name="findidbtn"
									id="findidbtn" onclick="searchId()">확인</button> <a
								href="${path}/"><button type="button">메인으로</button></a></td>
						</tr>
					</table>
				</fieldset>
			</form>
		</div>
		<a href="${path}/member/member_join.do">회원가입</a> |
		<a href="${path}/member/member_login.do">로그인</a> | 
		<a href="${path}/member/findpwmove.do">비밀번호 찾기</a> 
	</div>
	
</body>
	
</html>
