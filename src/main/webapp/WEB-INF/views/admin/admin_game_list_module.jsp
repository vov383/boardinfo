<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<!-- 세션사용여부 -->
<link rel="stylesheet" href="${path}/include/css/style_table.css">
<link rel="stylesheet" href="${path}/include/css/pagenation.css">

<div class="service_list_song">

    <table border="1" style="width:100%">

        <colgroup>
            <col style="width: 130px"><!-- 상태 -->
            <col style="width: 50px"><!-- 빈칸 -->
            <col style="width: 80px"><!-- 이미지 -->
            <col><!-- 게임제목정보 -->
            <col style="width: 100px"><!-- 제작연도 -->
            <col style="width: 100px"><!-- 테마 -->
            <col style="width: 100px"><!-- 등록인원 -->
            <col style="width: 100px"><!-- 등록일 -->
        </colgroup>


        <thead>

        <tr>
            <th scope="col" colspan="2">
                <div class="wrap t_center">상태</div>
            </th>
            <th scope="col">
                <div class="wrap none">이미지</div>
            </th>
            <th scope="col">
                <div class="wrap pd_l_12">게임명</div>
            </th>
            <th scope="col">
                <div class="wrap t_center">제작연도</div>
            </th>
            <th scope="col">
                <div class="wrap t_center">테마</div>
            </th>
            <th scope="col">
                <div class="wrap t_center">등록자</div>
            </th>
            <th scope="col">
                <div class="wrap t_center">등록일</div>
            </th>
        </tr>

        </thead>


        <tfoot>

        <tr>

            <td colspan="8" align="center">

                <div id="paginationArea">
                    <c:if test="${map.pager.curPage > 1}">
                        <div class="pageItem" onclick="list(1)">&lt&lt</div>
                    </c:if>
                    <c:if test="${map.pager.curPage > 1}">
                        <div class="pageItem" onclick="list(${map.pager.prevPage})">&lt</div>
                    </c:if>
                    <c:forEach var="num" begin="${map.pager.blockStart}" end="${map.pager.blockEnd}">
                        <c:choose>
                            <c:when test="${num == map.pager.curPage}">
                                <div id="curPage" class="pageItem" onclick="list(${num})">${num}</div>
                            </c:when>
                            <c:otherwise>
                                <div class="pageItem" onclick="list(${num})">${num}</div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${map.pager.curPage < map.pager.totPage}">
                        <div class="pageItem" onclick="list(${map.pager.nextPage})">&gt</div>
                    </c:if>
                    <c:if test="${map.pager.curPage < map.pager.totPage}">
                        <div class="pageItem" onclick="list(${map.pager.totPage})">&gt&gt</div>
                    </c:if>
                </div>

            </td>

        </tr>

        </tfoot>


        <tbody>

        <c:forEach var="row" items="${map.list}">

            <tr>

                <td><div class="wrap t_center">
                        <c:choose>
                            <c:when test="${sort eq 'insert'}">
                                등록대기
                            </c:when>
                            <c:when test="${sort eq 'deny'}">
                                등록거부
                            </c:when>
                            <c:when test="${sort eq 'delete'}">
                                삭제대기
                            </c:when>
                        </c:choose>
                </div></td>

                <!-- 차트순위 추가 -->
                <td><div class="wrap">

			<span class="rank_wrap">
				<span class="none">순위 비교 기능 구현가능할지..</span>
				<span class="none">0</span>
			</span>

                </div></td>

                <td><div class="wrap">
                    <c:choose>
                        <c:when test="${row.gamephoto_url != null}">
                            <img src="${path}/resources/uploaded_game${row.gamephoto_url}"  onerror="this.src='${path}/images/game/no-image-icon.png'" width="70px" height="70px">
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${row.bgg_thumbnail != null}">
                                    <img class="img_photo" src="${row.bgg_thumbnail}" onerror="this.src='${path}/images/game/no-image-icon.png'" width="70px" height="70px" border="1px">
                                </c:when>
                                <c:otherwise>
                                    <img src="${path}/images/game/no-image-icon.png" width="70px" height="70px">
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </div></td>

                <td><div class="wrap">
                    <div class="wrap_song_info">
                        <div class="ellipsis rank01"><span>
					<a href="${path}/admin/updateGame/${sort}/${row.gnum}">${row.gametitle}</a>
											</span></div><br>
                        <div class="ellipsis rank02">
                            <a href="${path}/admin/updateGame/${sort}/${row.gnum}">${row.gametitle_eng}</a>
                        </div>
                    </div>
                </div></td>

                <td><div class="wrap t_center">
                    <div class="ellipsis rank03">
                        ${row.release_year}
                    </div>
                </div></td>

                <td><div class="wrap t_center">
                    <div class="ellipsis rank03">
                            ${row.theme}
                    </div>
                </div></td>

                <td><div class="wrap t_center">
                    <div class="ellipsis rank03">
                        ${row.create_user}
                    </div>
                </div></td>

                <td><div class="wrap t_center">
                    <div class="ellipsis rank03">
                        ${row.create_date}
                    </div>
                </div></td>

            </tr>

        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    function list(page) {
        location.href="${path}/admin/confirmList/${sort}?curPage="+page;
    }

</script>