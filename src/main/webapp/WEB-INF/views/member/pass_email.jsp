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
			<form method="post" name="searchFormI">
				<fieldset>
					<legend>인증번호 체크</legend>
					<table>
						<tr>
							<td>인증번호</td>
							<td><input type="text" name="pass_num" id="pass_num"
								placeholder="인증번호 입력"></td>
						</tr>
						<tr>
							<td colspan="3">
							<button type="button" name="pass_check" id="pass_check" onclick="">인증번호 확인</button> 
							</td>
						</tr>
					</table>
				</fieldset>
			</form>
		</div>
	</div>

</body>
</html>