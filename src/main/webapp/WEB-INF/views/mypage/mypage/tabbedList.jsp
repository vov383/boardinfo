<%--
  Created by IntelliJ IDEA.
  User: dbtjr
  Date: 2023-07-03
  Time: 오후 9:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ page session="true" %>

<div id="tabbedPost">
    <div id="listCotainer" class="">
        <div>
            <thead>
            <tr>
                <c:forEach var="data" items="${response.dataList}">
                    <c:forEach items="${data}" var="property" varStatus="status">
                        <c:if test="${status.index == 0}">
                            <th>${property.key}</th>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </tr>
            </thead>
            <tbody>
                <c:forEach var="data" items="${response.dataList}">
                    <tr>
                        <c:forEach items="${data}" var="property" varStatus="status">
                            <td>
                                    ${status.index==0 ? property.key : property.value}
                            </td>
                        </c:forEach>
                    </tr>
                </c:forEach>
            </tbody>
        </div>
    </div>
</div>