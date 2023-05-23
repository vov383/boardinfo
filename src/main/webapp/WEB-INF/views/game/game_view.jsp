<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %> <!-- 세션사용여부 -->

<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>BOARDINFO</title>
        <%@ include file="../include/js/header.jsp" %>
        <link rel="stylesheet" href="${path}/include/js/style_game.css">
   </head>

   <body>

   <header>
	   <%@include file="../include/top.jsp" %>
   </header>

   <main>

	<div align="center">
		
		<table>
			
			<tr>
				<td rowspan="10">사진자리</td>
				<td colspan="3">${dto.gnum}. ${dto.gametitle}</td>
			</tr>
			
			<tr>
				<td colspan="3">${dto.gametitle_eng}</td>
			</tr>
			
			<tr>
				<td>인원<br>${dto.players}</td>
				<td>시간<br>${dto.playtime}</td>
				<td>연령<br>${dto.ages}</td>
			</tr>
			
			<tr>
				<td>제작연도<br>${dto.release_year}</td>
				<td>bgg랭크<br>${dto.bggrank}</td>
				<td>게임난이도<br>${dto.bgg_game_score}</td>
			</tr>
			
			<tr>
				<td colspan="3">아티스트:추가요망</td>
			</tr>
			
			<tr>
				<td colspan="3">카테고리:추가요망</td>
			</tr>
			
			<tr>
				<td colspan="3">디자이너:추가요망</td>
			</tr>
			
			<tr>
				<td colspan="3">메카닉:추가요망</td>
			</tr>
			
			<tr>
				<td colspan="3">퍼블리셔:추가요망</td>
			</tr>
			
			<tr>
				<td>후기게시판과 연결되면 연결</td>
				<td>상품게시판과 연결되면 연결</td>
				<td>컬렉션과 연결되면 연결</td>
			</tr>
			
		</table>
		
	</div>

   </main>

   <footer>
	   <%@include file="../include/footer.jsp" %>
   </footer>

    </body>
    
</html>