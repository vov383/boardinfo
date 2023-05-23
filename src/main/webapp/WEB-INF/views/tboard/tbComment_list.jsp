<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../include/js/header.jsp" %>
<script src="${path}/include/js/jquery-3.6.3.min.js"></script>
</head>
<body>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!-- jstl fn활용해서 특수문자 처리 -->
<table style="width: 700px">
	<c:forEach var="row" items="${re_list}">
		<c:set var="str" value="${fn:replace(row.content, '<', '&lt;')}" />
		<c:set var="str" value="${fn:replace(str, '>', '&gt;')}" />
		<c:set var="str" value="${fn:replace(str, '  ', '&nbsp;&nbsp;')}" />
		<c:set var="str" value="${fn:replace(str, newLineChar, '<br>')}" />
	
		<tr>
			<td> 
				${row.create_user }
				(<fmt:formatDate value="${row.create_date}" 
				pattern="yyyy-MM-dd a HH:mm:ss" />)<br>
				${str}
			</td>
		</tr>
	</c:forEach>
	
</table>
</body>
</html>