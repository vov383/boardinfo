<%-- 
    Created by IntelliJ IDEA
    User : dbtjr
    Date : 2023-06-12
    Time : 오후 4:18
    to change this templete use file | setting | File Templetes.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <%@ include file="../include/js/header.jsp" %>
    <script src="../include/js/jquery-3.6.3.min.js"></script>
</head>
<body>
<form action="testUpload.do" name="form1" method="post" enctype="multipart/form-data">
    <section class="imageContainer">
        <label class="label" id="label" for="input">
            <div class="inner" id="inner">드래그하거나 클릭해서 업로드</div>
        </label>
        <input id="input" class="input" accept="image/*" type="file" name="files" multiple="true" hidden="true">
        <p class="preview-title">미리보기</p>
        <div class="preview" id="preview"></div>
    </section>
    <button onclick="insert()">제출</button>
</form>
<script>
    document.form1.submit();
</script>
</body>
</html>