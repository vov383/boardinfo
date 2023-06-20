<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" >
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

	$(function(){
		$("#btnPwChange").click(function(){
			var new_pw=$("#new_pw").val();
			var new_pw2=$("#new_pw2").val();
			//비밀번호 정규식 
			var exp2 = /^[a-zA-Z0-9]{8,15}$/;
			if(!exp2.test(new_pw)){
				alert("비밀번호는 영문 숫자 조합으로 8자 이상 입력하세요.");
				$("#new_pw").focus();
				return;
			}
			if(new_pw != new_pw2){
				alert("비밀번호 불일치");
				$("#new_pw2").focus();
				return;
			}
			if(new_pw==""){
				alert("비밀번호를 입력하세요.");
				$("#new_pw").focus();
				return;
			}
			if(new_pw2==""){
				alert("비밀번호를 입력하세요.");
				$("#new_pw2").focus();
				return;
			}
			$("#new_pw2").keyup(function(event){
			      if(window.event.keyCode === 13){
					$("#pass_check").click();
				}
			      
			});
			
			document.form1.action="${path}/member/pass_change/${email}";
			document.form1.submit();
			alert("변경되었습니다. 새 비밀번호로 로그인 해주세요.")
		});
	});


</script>

</head>
<body>
	<div class="body">
		<h2>
			<a href="${path}/"><img alt="로고" src="${path}/resources/uploaded_image/boardinfo_logo.png"></a>
		</h2>
		<div class="input_section">
			<form method="post" name="form1">
				<fieldset>
					<legend>비밀번호 변경</legend>
					<table>
						<tr>
							<td>변경할 비밀번호</td>
							<td><input type="password" name="new_pw" id="new_pw"
								placeholder="비밀번호 입력"></td>
						</tr>
						<tr>
							<td>비밀번화 재확인</td>
							<td><input type="password" name="new_pw2" id="new_pw2"
								placeholder="비밀번호 확인"></td>
						</tr>
						<tr>
							<td colspan="3" align="center">
							<button type="button" name="btnPwChange" id="btnPwChange">비밀번호 변경</button> 
							</td>
						</tr>
					</table>
				</fieldset>
			</form>
		</div>
	</div>

</body>
</html>