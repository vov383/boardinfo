<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<!-- 세션사용여부 -->
<link rel="stylesheet" href="${path}/include/css/style_table.css">

<div class="service_list_song">
    <h3>${param.filter}</h3>
    <table border="1" style="width:100%">

        <colgroup>
            <col style="width: 62px"><!-- 카테고리 -->
            <col style="width: 160px"><!-- 좋아요 -->
            <col><!-- 제목 -->
            <col style="width: 100px"><!-- 게임 -->
            <col style="width: 140px"><!-- 조회수 -->
            <col style="width: 160px"><!-- 날짜 -->
        </colgroup>


        <thead>

        <tr>
            <th scope="col">
                <div class="wrap t_center">카테고리</div>
            </th>
            <th scope="col">
                <div class="wrap t_center">좋아요</div>
            </th>
            <th scope="col">
                <div class="wrap pd_l_12">제목</div>
            </th>
            <th scope="col">
                <div class="wrap t_center">게임</div>
            </th>
            <th scope="col">
                <div class="wrap t_center">조회수</div>
            </th>
            <th scope="col">
                <div class="wrap t_center">날짜</div>
            </th>
        </tr>

        </thead>

        <tbody>


        <c:forEach var="row" items="${reviewList}">

            <tr>

                <td><div class="wrap t_center"><span class="rank">${row.category}</span></div></td>


                <td><div class="wrap t_center">
                    <div class="ellipsis rank03">
                            ${row.good}
                    </div>
                </div></td>

                <td><div class="wrap">
                    <div class="wrap_song_info">
                        <div class="ellipsis rank01"><span>
					<a href="javascript:reviewDetail('${row.regNum}')"">${row.title}(${row.recnt}</a>
											</span></div>
                    </div>
                </div></td>

                <td><div class="wrap t_center">
                    <div class="ellipsis rank03">
                            ${row.gametitle}
                    </div>
                </div></td>

                <td><div class="wrap t_center">
                    <div class="ellipsis rank03">
                            ${row.views}
                    </div>
                </div></td>

                <td><div class="wrap t_center">
                    <div class="ellipsis rank03">
                            ${row.createDate}
                    </div>
                </div></td>

            </tr>

        </c:forEach>
        </tbody>
    </table>

    <a href="#" style="display: inline-block; float: right;">더보기</a>
</div>

<%--디테일 진입 폼--%>
<form name="reviewDetail" method="post" action="${path}/review/reviewdetail.do">
    <input type="hidden" name="reviewDetailKey" id="reviewDetailKey">
</form>


<script>
    /*리뷰 디테일 진입, 조회수 증가*/
    function reviewDetail(regNum) {
        $("#reviewDetailKey").val(regNum);
        document.reviewDetail.submit();
    }
</script>