<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CKEditor File Upload Example</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../include/js/header.jsp" %>
<script src="${path }/ckeditor/ckeditor.js"></script>
</head>
<body>
<body>
<h1>CKEditor File Upload Example</h1>
<form method="post" enctype="multipart/form-data" action="/upload">
    <div>
        <label for="editor">Enter text:</label>
        <textarea id="editor" name="editor"></textarea>
    </div>
    <div>
        <label for="file">Upload file:</label>
        <input type="file" id="file" name="file">
    </div>
    <button type="submit">Submit</button>
</form>
<script>
   ClassicEditor.create(document.querySelector('#editor'));
</script>
</body>
</html>
