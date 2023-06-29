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

a:hover{
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

#passwordConfirmationForm input[type="submit"] {
  padding: 8px 16px;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

#passwordConfirmationForm input[type="submit"]:hover {
  background-color: #45a049;
}
</style>

</head>
<body>


<%@include file="../include/top.jsp" %>

	<div id="contents">
	<h1 style="font-size: 50px;">회원탈퇴</h1>
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
      <h3>비밀번호 확인</h3>
      <p>고객님의 개인정보 보호를 위해 본인확인을 진행합니다. 비밀번호를 입력해주세요.</p>
      <form action="${path}/member/pass_check3.do/${userid}" method="post">
        <div>
          <input type="password" id="passwd" name="passwd" required>
          <div style="color: red;">${message}</div>
        </div>
        <div>
          <input type="submit" value="확인">
        </div>
      </form>
    </div>
  </div>
</div>


	

<%@include file="../include/footer.jsp" %>


</body>
</html>