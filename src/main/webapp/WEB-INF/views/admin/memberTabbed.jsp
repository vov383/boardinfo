<%-- 
    Created by IntelliJ IDEA
    User : dbtjr
    Date : 2023-07-05
    Time : 오후 2:10
    to change this templete use file | setting | File Templetes.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ page session="true" %>
    <div id="tabbedPost">
        <div id="listContainer">
            <p class="h3">회원 목록</p>
            <div class="tableDiv">
                <table border="1" style="width: 100%">
                    <tr>
                        <th>프로필</th>
                        <th>이름</th>
                        <th>아이디</th>
                        <th>비번</th>
                        <th>닉네임</th>
                        <th>이메일</th>
                        <th>핸드폰</th>
                        <th>가입일자</th>
                    </tr>
                    <c:forEach var="row" items="${list}">
                        <tr>
                            <td><img src="${path}/images/${row.profile}" width="100px" height="100px"></td>
                            <td>${row.name}</td>
                            <td>${row.userid}</td>
                            <td>${row.passwd}</td>
                            <td><a href="${path}/admin/UserPostList?userid=${row.userid}">${row.nickname}</a></td>
                            <td>${row.email}</td>
                            <td>${row.hp}</td>
                            <td><fmt:formatDate value="${row.join_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        </tr>
                    </c:forEach>
                </table>

            </div>
        </div>
    </div>
