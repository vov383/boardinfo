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

		<style>

			#td_photo {
				position: relative;
			}
			.img_photo {
				position: absolute;
				top: 0;
			}

		</style>

   </head>

   <body>

   <header>
	   <%@include file="../include/top.jsp" %>
   </header>

   <main>

	   <div id="contents">
		   <div id="contentsHeader">
			   <h2>게임정보</h2>
		   </div>
		   <div id="contentsLocation">
			   홈&gt 게임정보&gt gametitle
		   </div>
		   <div id="contentsMain">


	<div class="tableDiv">

		<table>

			<colgroup>
				<col width="26%"/>
				<col width="18%"/>
				<col width="18%"/>
				<col width="18%"/>
				<col width="18%"/>
			</colgroup>

			<thead>

			<tr>
				<th>랭킹자리(예정)</th>
				<th>평점자리(예정)</th>
				<th>난이도자리(예정)</th>
				<th>보드게임긱링크</th>
				<th>수정하기버튼</th>
			</tr>

			</thead>

			<tbody>

			<tr>
				<td rowspan="10" id="td_photo">
					<c:choose>
						<c:when test="${map.dto.gamephoto_url != null}">
							<img class="img_photo" src="${path}/resources/uploaded_game${map.dto.gamephoto_url}" width="250px" height="250px" border="1px">
							<div>
								<a href="#">등록된 이미지 보기</a>
							</div>
						</c:when>
						<c:otherwise>
							<img class="img_photo" src="${map.bgg_thumbnail}" width="250px" height="250px" border="1px">
							<div>
								<p>사진출처 : boardgamegeek</p>
							</div>
						</c:otherwise>
					</c:choose>

				</td>
				<td colspan="4"><h2>${map.dto.gametitle}</h2></td>
			</tr>

			<tr>
				<td colspan="4">${map.dto.gametitle_eng}</td>
			</tr>

			<tr>
				<td>인원 : <h4>${map.dto.players}</h4></td>
				<td>시간 : <h4>${map.dto.playtime}</h4></td>
				<td>연령 : <h4>${map.dto.ages}</h4></td>
				<td>제작연도 : <h4>${map.dto.release_year}</h4></td>
			</tr>

			<tr>
				<td>bgg평점 : <h4>${map.bgg_rate}</h4></td>
				<td>bgg랭크 : <h4>${map.dto.bggrank} // ${map.bgg_rank}</h4></td>
				<td>bgg게임난이도 : <h4>${map.dto.bgg_game_score} // ${map.bgg_weight}</h4></td>
				<td>조회수 : <h4>${map.dto.viewcount}</h4></td>
			</tr>

			<tr>
				<td colspan="4">
					아티스트명 :
					<c:forEach var="artist" items="${map.alist}">
						<a href="${path}/game/search.do?filter=artist&num=${artist.anum}">${artist.artist}</a>
					</c:forEach>
				</td>
			</tr>

			<tr>
				<td colspan="4">
					카테고리 :
					<c:forEach var="category" items="${map.clist}">
						<a href="${path}/game/search.do?filter=gamecategory&num=${category.cnum}">${category.gamecategory}</a>
					</c:forEach>
				</td>
			</tr>

			<tr>
				<td colspan="4">
					디자이너 :
					<c:forEach var="designer" items="${map.dlist}">
						<a href="${path}/game/search.do?filter=designer&num=${designer.dnum}">${designer.designer}</a>
					</c:forEach>
				</td>
			</tr>

			<tr>
				<td colspan="4">
					메카닉 :
					<c:forEach var="mechanic" items="${map.mlist}">
						<a href="${path}/game/search.do?filter=mechanic&num=${mechanic.mnum}">${mechanic.mechanic}</a>
					</c:forEach>
				</td>
			</tr>

			<tr>
				<td colspan="4">
					퍼블리셔 :
					<c:forEach var="publisher" items="${map.plist}">
						<a href="${path}/game/search.do?filter=publisher&num=${publisher.pnum}">${publisher.publisher}</a>
					</c:forEach>
				</td>
			</tr>

			<tr>
				<td>후기게시판과 연결</td>
				<td>모임게시판과 연결</td>
				<td>상품게시판과 연결</td>
				<td>컬렉션과 연결</td>
			</tr>

			</tbody>

		</table>

	</div>

		   </div>
	   </div>


   </main>

   <footer>
	   <%@include file="../include/footer.jsp" %>
   </footer>

    </body>
    
</html>