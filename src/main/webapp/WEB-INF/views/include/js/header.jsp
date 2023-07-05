<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script src="https://kit.fontawesome.com/bde109fc2f.js" crossorigin="anonymous"></script>
<script src="${path}/include/js/jquery-3.6.3.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<link href="${path}/include/style.css" type="text/css" rel="stylesheet">

<link rel="shortcut icon" href="${path}/resources/favi/favicon.ico">
<link rel="apple-touch-icon" sizes="57x57" href="${path}/resources/favi/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="${path}/resources/favi/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="${path}/resources/favi/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="${path}/resources/favi/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="${path}/resources/favi/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="${path}/resources/favi/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="${path}/resources/favi/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="${path}/resources/favi/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="${path}/resources/favi/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192" href="${path}/resources/favi/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="${path}/resources/favi/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="${path}/resources/favi/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="${path}/resources/favi/favicon-16x16.png">
<link rel="manifest" href="${path}/resources/favi/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="${path}/resources/favi/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">
