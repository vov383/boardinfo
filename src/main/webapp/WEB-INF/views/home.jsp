<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %> <!-- 세션사용여부 -->

<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>BOARDINFO</title>
        <%@ include file="include/js/header.jsp" %>
   </head>

   <body>
       
	<div align="center">
		<h1><a href="${path}/sample/sample.do" style="color: black;">SAMPLE CLICK</a></h1>
        <br>
        <h1><a href="${path}/game/gamelist.do" style="color: black;">gamelist</a></h1>
        <br>
        <h1><a href="${path}/tboard/list.do" style="color: black;">중고거래 게시판</a></h1>
        <br>
        <h1><a href="${path}/chat/goChat.do" style="color: black;">sjTest</a></h1>
        <h1><a href="${path}/gathering/list.do" style="color: black;">모임리스트</a></h1>
        <h1><a href="${path}/gathering/add.do" style="color: black;">모임만들기</a></h1>
        <h1><a href="${path}/gathering/view.do" style="color: black;">모임게시글</a></h1>
        <h1><a href="${path}/gathering/setLocation.do" style="color: black;">위치검색</a></h1>
        
        <br>
        <h1><a href="${path}/review/reviewlist.do" style="color: black;">Review List</a></h1>
        <h1><a href="${path}/review/reviewInTest.do" style="color: black;">Review In Test</a></h1>

    </div>
  <div>
  	<!-- 실제로 서비스되는 디렉토리(배포 디렉토리) 값 가져오기 -->
		<%= application.getRealPath("/resources/ckimg/") %>
		<%= application.getRealPath("/resources/uploaded_images/") %>
  </div>      
  
  
    </body>
    
</html>