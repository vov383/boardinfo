<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/member.css">
<meta charset="UTF-8">
<title>회원가입</title>
<%@ include file="../include/js/header.jsp" %>

<style type="text/css"> 
  body {
	font-size: 14px;
	width: auto;
	height: auto;
	margin: 5px;
  }
  .body{	
   border: double black;
   text-align: center; position: absolute; top: 50%;
   left: 50%; transform: translate(-50%,-50%); 
   margin: 20px; padding: 70px; 
  }
  .login_section{
   top: 10%;
   left: 10%; margin: 20px; padding: 30px;
  }
  .button{
   text-align: center; padding:10px; 
  }
  .id_class{
   border: solid black;
  }
  .footer_col{
   text-shadow: gray;
  }
  


</style>
<script type="text/javascript">

$(function() {
	//input태그에 포커스를 얻을 때(focus)
	$("input").focus(function() {
		//jQuery에서는 css속성이름이 그대로 쓰인다.
		$(this).css("background-color","black");
		$(this).css("color","white");
		$(this).css("border","1px solid white");
	});
	//포커스를 잃을때(blur)
	$("input").blur(function() {
		$(this).css("background-color","white");
		$(this).css("color","black");
		$(this).css("border","1px solid black");
	});
});

$(function(){
	$("#findidbtn").click(function(){
		var name=$("#name").val();
		var email=$("#email").val();
		if(name==""){
			alert("아이디를 입력하세요.");
			$("#name").focus();
			return;
		}
		if(email==""){
			alert("비밀번호를 입력하세요.");
			$("#email").focus();
			return;
		}
		$("#email").keyup(function(event){
		      if(window.event.keyCode === 13){
				$("#findidbtn").click();
			}
		});
		
		document.form1.action="${path}/member/findid.do";
		document.form1.submit();
	});
});

function btncheck() {
    if (window.event.keyCode === 13) {
      $("#findidbtn").click();
    }
  }

</script>

</head>
<body>
 <div class="body">
  <h2><a href="${path}/"><img alt="로고" src="../resources/uploaded_image/boardinfo_logo.png"></a></h2>
  <div class="login_section">
    <form method="post" name="form1">
 	 <fieldset>
  	  <legend>아이디 찾기</legend>
  		<table >
		   <tr>
		    <td>Name</td>
		    <td><input type="text" name="name" id="name" placeholder="이름"></td>
		   </tr>
		   <tr>
		    <td>Email</td>
		    <td><input type="text" name="email" id="email" placeholder="이메일" onkeyup="btncheck()" ></td>
		   </tr>
		   <tr >
		    <td colspan="3"><button type="button" name="findidbtn" id="findidbtn" onclick="check()">확인</button>
		   				 	<a href="${path}/"><button type="button">메인으로</button></a>
		    </td>
		   </tr>
		  </table>
		 </fieldset> 
		</form>
  	 </div>
 </div>

</body>
</html>