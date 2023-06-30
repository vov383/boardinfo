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
  
    #passwordConfirmationForm table {
    width: 100%;
    table-layout: fixed;
  }
  
  #passwordConfirmationForm td {
    padding: 10px;
  }
  
  #passwordConfirmationForm input[type="text"],
  #passwordConfirmationForm input[type="password"],
  #passwordConfirmationForm input[type="file"] {
    width: 100%;
    box-sizing: border-box;
    padding: 5px;
    border: 1px solid #D9D9D9;
    border-radius: 5px;
    margin-bottom: 10px;
  }
  
  #passwordConfirmationForm input[type="button"],
  #passwordConfirmationForm button[type="button"] {
    width: auto;
    padding: 8px 16px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }
  
  #passwordConfirmationForm .input-container label {
    width: 150px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
  
    #passwordConfirmationForm .input-container {
    position: relative;
    display: flex;
    margin-bottom: 10px;
  }
  
  #passwordConfirmationForm .input-container input[type="text"],
  #passwordConfirmationForm .input-container input[type="password"]{
   width: calc(100% - 200px);
    padding: 5px;
    border: 1px solid #D9D9D9;
    border-radius: 5px;
  }
  
 
</style>

<script type="text/javascript">
var oldNickName;
$(document).ready(function () {
	oldNickName= $("#nickname").val();
});

$(function() {
	
    $("#btnNickCheck").click(function() {
      var nickname = $("#nickname").val();
      if (nickname == "") {
        alert("닉네임을 입력하세요.");
        $("#nickname").focus();
        return;
      }
      $.ajax({
        url: "${path}/member/check_nick.do",
        type: "POST",
        data: {
          nickname: nickname
        },
        success: function(result) {
          if (oldNickName == $("#nickname").val() ){
          	alert("현재 닉네임과 동일합니다.");
        	isNickChecked = true;	
          } else if (result == "duplicate") {
            alert("이미 사용 중인 닉네임입니다.");
            $("#nickname").val("");
            $("#nickname").focus();
            isNickChecked = false;
          } else if (result == "available") {
            alert("사용 가능한 닉네임입니다.");
            isNickChecked = true;
            document.form1.nickname.readOnly = true;
          }
        },
        error: function() {
          alert("서버와의 통신에 실패했습니다.");
        }
      });
    });
  });

function check() {
	//이름 체크
	var name = $("#name").val();
	if(name==""){
		alert("이름은 필수 입력입니다.");
		$("#name").focus();
		return;
	}	

	//이름 정규식
	var exp3 = /^[가-힣]+$/;
	if(!exp3.test(name)){
		alert("이름은 한글로 입력하세요.");
		$("#name").focus();
		return;
	}
	
	//이메일 체크
	var email = $("#email").val();
	if(email==""){
		alert("이메일은 필수 입력입니다.");
		$("#email").focus();
		return;
	}
	//이메일 정규식
	var exp4 = /^[a-z0-9]{2,15}@[a-z0-9]{2,9}\.[a-z]{2,}$/;
	if(!exp4.test(email)){
		alert("이메일 형식이 잘못되었습니다. ex)abc@abc.com");
		$("#email").focus();
		return;
	}
	//핸드폰번호 정규식
	var hp = $("#hp").val();
	var exp5 = /^[\d]{11,12}$/;
	if(!exp5.test(hp)){
		alert("11~12자리를 숫자로 입력해주세요.");
		$("#hp").focus();
		return;
	}
		document.form1.action="${path}/member/update.do";
		document.form1.submit();
			alert("수정되었습니다.");
	
}


</script>
</head>
<body>


	<%@include file="../include/top.jsp"%>

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
						<li class="sub1"><a
							href="${path}/member/pass_check_u?userid=${sessionScope.userid}"
							title="개인정보변경">개인정보변경</a></li>
						<li class="sub3"><a
							href="${path}/member/pass_check_p?userid=${sessionScope.userid}"
							title="비밀번호변경">비밀번호변경</a></li>
						<li class="sub5"><a
							href="${path}/member/pass_check_d?userid=${sessionScope.userid}"
							title="회원탈퇴">회원탈퇴</a></li>
					</ul>
				</div>
			</div>
			<div id="passwordConfirmationForm">
				<h3 style="font-size: 16px;">회원 정보 수정</h3>
				<form name="form1" method="post" enctype="multipart/form-data">
					<table style="width: 100%" class="input-container">
						<tr>
							<td>프로필</td>
							<td><input name="profile_img" id="profile" type="file"></td>
						</tr>
						<tr>
							<td>이름</td>
							<td><input value="${dto.name}" id="name" name="name"></td>
						</tr>
						<tr>
							<td>아이디</td>
							<td><input value="${dto.userid}" id="userid" name="userid"
								readonly></td>
						</tr>
						<tr>
							<td>닉네임</td>
							<td><input value="${dto.nickname}" id="nickname"
								name="nickname"></td>
							<td><button type="button" id="btnNickCheck">중복확인</button></td>

						</tr>
						<tr>
							<td>이메일</td>
							<td><input value="${dto.email}" id="email" name="email"></td>
						</tr>
						<tr>
							<td>핸드폰</td>
							<td><input value="${dto.hp}" id="hp" name="hp"></td>
						</tr>
						<tr>
							<td>회원가입일자</td>
							<td><fmt:formatDate value="${dto.join_date}"
									pattern="yyyy-MM-dd" /></td>
						</tr>
						<tr>
							<td colspan="3" align="center"><input type="button"
								value="수정하기" name="btnUpdate" id="btnUpdate" onclick="check()">
								<a href="${path}/"><button type="button">메인으로</button></a></td>
						</tr>



					</table>
				</form>
			</div>

		</div>
	</div>





	<%@include file="../include/footer.jsp" %>


</body>
</html>