<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/js/header.jsp"%>
<script src="${path}/include/js/common.js"></script>

<script src="${path}/include/js/jquery-3.6.3.min.js"></script>

<!-- ckeditor의 라이브러리 -->
<script src="${path}/ckeditor/ckeditor.js"></script>

<!-- 카카오 지도 api -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f3f4e2f575e10d4aa2065b836299303b">
</script>

<script type="text/javascript">
$(function() {
	//목록 버튼
	$("#btnList").click(function(){
		location.href="${path}/tboard/list.do";
	});
	//저장 버튼
	$("#btnSave").click(function() {
		var title = $("#title").val();
		if (title == "") {
			alert("제목을 입력하세요.");
			$("#title").focus();
			return;
		}
		var str = "";
		//uploadedList 영역에 클래스 이름이 file인 히든 타입의 태그를 각각 반복시켜 (each함수)
		$("#uploadedList .file").each(function(i) {
			console.log(i);
			//hidden태그 구성
			str += "<input type='hidden' name='files["+i+"]' value='"
					+ $(this).val() + "'>";
		});
		//폼에 hidden 태그를 붙임
		$("#form1").append(str);
		document.form1.action="${path}/tboard/insert.do";
		document.form1.submit();
	});

	//파일을 마우스로 드래그해서 업로드 영역에 올릴 때 파일이 열리는 기본효과 막는 처리
	$(".fileDrop").on("dragenter dragover", function(e) {
		e.preventDefault(); //얘가 막는 처리
	});

	//마우스로 파일을 드롭할 때 파일이 열리는 기본효과 막음.. 이건 따로 처리 need
	$(".fileDrop").on("drop", function(e) {
		e.preventDefault();
		//첫번째 첨부파일
		var files = e.originalEvent.dataTransfer.files;
		var file = files[0];
		//폼 데이터에 첨부파일 추가
		var formData = new FormData();
		formData.append("file", file);
		$.ajax({
			url: "${path}/upload/uploadAjax",
			data: formData,
			dataType: "text",
			processData: false,
			contentType: false,
			type: "post",
			success: function(data) {
				//data : 업로드한 파일 정보와 Http
				var fileInfo = getFileInfo(data);
				console.log(fileInfo);

				var html="<div><a href='" + fileInfo.getLink + "'>"
						+ fileInfo.fileName + "</a><br>"
						+ "<img src='"+fileInfo.getLink+"'>";
				html += "<input type='hidden' class='file' value='"
						+ fileInfo.fullName +"'>";
				html+="<a href='#' class='file_del' data-src='"
						+this+"'>[삭제]</a></div>";

				$("#uploadedList").append(html);
			}
		});
	});

	//첨부파일 삭제
	//id가 uploadedList인 태그의 class가 file_del인 태그 클릭
	$("#uploadedList").on("click",".file_del",function(e){
		var that=$(this); //this는 현재 클릭한 태그
//data: {fileName: $(this).attr("data-src") },
		$.ajax({
			type: "post",
			url: "${path}/upload/deleteFile",
			data: "fileName="+	$(this).attr("data-src"),
			dataType: "text",
			success: function(result){
				if(result=="deleted"){
					//화면에서 태그 제거
					that.parent("div").remove();
				}
			}
		});
	});
});

function nanumSelected() {
	$("#price").innerText = "0";
}
</script>
<style type="text/css">
.fileDrop {
	width: 600px;
	height: 100px;
	border: 1px dotted gray;
	background-color: gray;
}
</style>
</head>
<body>
	<h2>글쓰기 페이지</h2>
	<button type="button" id="btnList">목록</button>

	<form name="form1" method="post" enctype="multipart/form-data">
		<div id="category">
			말머리를 선택하세요 <br>
			<input type="radio" id="s" name="category" value="s" checked="checked">
			<label for="s">판매</label> <br>
			<input type="radio" id="b" name="category" value="b">
			<label for="b">구매</label> <br>
			<input type="radio" id="n" name="category" value="n" onclick="nanumSelected()">
			<label for="n">나눔</label> <br>
		</div>
		제목 : <input type="text" id="title" name="title"> <br>
		가격 : <input type="text" id="price" name="price"> <br>

		<input type="file" id="attach_pic" name="attach_pic">
			<div class="fileDrop"></div>
			<div id="uploadedList"></div>
		</div>
		<div style="width: 500px; text-align: center;">
			<button type="button" id="btnSave">작성완료</button>
		</div>
		<br>
		<div>
			내용 <br>
			<textarea id="description" name="description"></textarea>
		</div>
	</form>
	<script>
  var editConfig = {
    filebrowserUploadUrl: "${path}/ckeditor/imageUpload.do", // Specify the upload URL
//    filebrowserUploadMethod: "form", // Use the form-based upload method
  }

  CKEDITOR.replace("description", editConfig);
  </script>

	<!-- 지도 -->

</body>
</html>