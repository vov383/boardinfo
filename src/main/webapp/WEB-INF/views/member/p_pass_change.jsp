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
	width: 600px;
	padding: 20px;
	border: 1px solid #D9D9D9;
	border-radius: 18px;
	text-align: center;
	margin-top: 52px;
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
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

#passwordConfirmationForm input[type="button"]:hover {
	background-color: #45a049;
}

  #passwordConfirmationForm div {
    display: flex;
    align-items: center;
  }
#passwordConfirmationForm {
    display: flex;
    flex-direction: column;
    align-items: center;
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

  #passwordConfirmationForm input[type="password"] {
    width: 100%;
    box-sizing: border-box;
  }

  .center {
    display: flex;
    justify-content: center;
  }
</style>

<script type="text/javascript">
function check() {
	//비밀번호 체크

	var current_pw = $("#current_pw").val();
		var passwd = $("#new_pw").val();
		var passwd2 = $("#new_pw2").val();

		if (current_pw === passwd) {
			alert("현재 비밀번호와 새 비밀번호가 동일합니다.");
			$("#current_pw").focus();
			return;
		}
		if (passwd == "") {
			alert("비밀번호는 필수 입력입니다.");
			$("#new_pw").focus();
			return;
		}
		//비밀번호 정규식
		var exp2 = /^[a-zA-Z0-9]{8,15}$/;
		if (!exp2.test(passwd)) {
			alert("비밀번호는 영문 숫자 조합으로 8자 이상 입력하세요.");
			$("#new_pw").focus();
			return;
		}
		if (passwd != passwd2) {
			alert("비밀번호 불일치");
			$("#new_pw2").focus();
			return;
		}

		document.form1.action = "${path}/member/pass_change/${userid}";
		document.form1.submit();
		alert("새로운 비밀번호로 다시 로그인 해주세요.")
	}
	function login_check() {
		if (window.event.keyCode === 13) {
			$("#btnJoin").click();
		}
	}
</script>
</head>
<body>


<%@include file="../include/top.jsp" %>

	<div id="contents">
	<h1 style="font-size: 50px;">비밀번호 변경</h1>
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
          <li class="sub5"><a href="" title="회원탈퇴">회원탈퇴</a></li>
        </ul>
      </div>
    </div>
			<div id="passwordConfirmationForm">
				<h3>비밀번호 변경</h3>
				<form action="${path}/member/pass_check.do/${userid}" method="post"
					id="form1" name="form1" >
					<div class="input-container">
						<label for="current_pw">현재 비밀번호</label> <input type="password"
							id="current_pw" name="current_pw" required>
					</div>
					<div class="input-container">
						<label for="new_pw">새 비밀번호</label> <input type="password"
							id="new_pw" name="new_pw" required>
					</div>
					<div class="input-container">
						<label for="new_pw2">새 비밀번호 확인</label> <input type="password"
							id="new_pw2" name="new_pw2" required onkeyup="pass_check()">
					</div>
					<div class="center">
						<input type="button" onclick="check()" value="확인" name="btnJoin"
							id="btnJoin">
					</div>
				</form>
			</div>
		</div>
</div>


	

<%@include file="../include/footer.jsp" %>


</body>
</html>