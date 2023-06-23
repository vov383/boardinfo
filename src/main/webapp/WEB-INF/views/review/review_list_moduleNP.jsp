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
            <col style="width: 160px"><!-- 지역 -->
            <col><!-- 제목 -->
            <col style="width: 100px"><!-- 가격 -->
            <col style="width: 140px"><!-- 조회수 -->
            <col style="width: 160px"><!-- 날짜 -->
        </colgroup>


        <thead>

        <tr>
            <th scope="col">
                <div class="wrap t_center">카테고리</div>
            </th>
            <th scope="col">
                <div class="wrap t_center">지역</div>
            </th>
            <th scope="col">
                <div class="wrap pd_l_12">제목</div>
            </th>
            <th scope="col">
                <div class="wrap t_center">가격</div>
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


        <c:forEach var="row" items="${t_boardList}">

            <tr>

                <td><div class="wrap t_center"><span class="rank">${row.category}</span></div></td>


                <td><div class="wrap t_center">
                    <div class="ellipsis rank03">
                            ${row.address1} / ${row.address2}
                    </div>
                </div></td>

                <td><div class="wrap">
                    <div class="wrap_song_info">
                        <div class="ellipsis rank01"><span>
					<a href="${path}/tboard/view/${row.tb_num}">${row.title}(${row.re_count})</a>
											</span></div>
                    </div>
                </div></td>

                <td><div class="wrap t_center">
                    <div class="ellipsis rank03">
                            ${row.price}
                    </div>
                </div></td>

                <td><div class="wrap t_center">
                    <div class="ellipsis rank03">
                            ${row.view_count}
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

    <a href="#" style="display: inline-block; float: right;">더보기</a>
</div>
