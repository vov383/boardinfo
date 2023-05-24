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
function checkImageType(fileName) {
	var pattern=/jpg|png|gif/i; //정규표현식(i는 대소문자 무시)
	return fileName.match(pattern); //규칙에 맞으면 true가 리턴
}
function getOriginalName(fileName) {
	if(checkImageType(fileName)){ //이미지 파일이면 skip
		return;
	}
	var idx=fileName.indexOf("_")+1;//uuid를 제외한 파일이름만 뽑음
	return fileName.substr(idx);
}
function getImageLink(fileName){
	if(!checkImageType(fileName)){
		return;
	}
	//2023\04\18/855bc706-94a2-49aa-b952-529afe83d695
	var front=fileName.substr(0,12);//연월일 경로(0~11번째까지 자르고)
	var end=fileName.substr(14);//14번째 문자열앞의 s_제거 (s_는 썸네일 파일에 붙은 것)
	//2023\04\18/s_855bc706-94a2-49aa-b952-529afe83d695_grape.jpg
	return front+end;
}

$(function() {
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
			url: "${path}/tbFiles/attachAjax",
			data: formData,
			dataType: "text",
			processData: false,
			contentType: false,
			type: "post",
			success: function(data) {

				//data : 업로드한 파일 정보와 Http 상태 코드
				var fileInfo = getFileInfo(data);
				console.log(fileInfo);

				var html="<a href='" + fileInfo.getLink + "'>"
						+ fileInfo.fileName + "</a><br>"
						+ "<img src='"+fileInfo.getLink+"'>";
				html += "<input type='hidden' class='file' value='"
						+ fileInfo.fullName +"'>";

				$("#uploadedList").append(html);
			}
		});
	});
	//목록 버튼
	$("#btnList").click(function(){
		location.href="${path}/tboard/list.do";
	});

	//저장 버튼
	$("#btnSave").click(function() {
		var title = $("#title").val();
		var description = $("#description").val();
		if (title == "") {
			alert("제목을 입력하세요.");
			$("#title").focus();
			return;
		}
		var category = document.getElementsByName("category").values();
		if(category =="n"){
			document.getElementById("price").innerHTML = 0;
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

	//첨부파일 삭제
	//id가 uploadedList인 태그의 class가 file_del인 태그 클릭
	$("#uploadedList").on("click",".file_del",function(e){
		var that=$(this); //this는  클릭한 태그
//data: {fileName: $(this).attr("data-src") },
		$.ajax({
			type: "post",
			url: "${path}/tbFiles/deleteFile",
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
//첨부파일 리스트를 출력하는 함수
function listAttach(){
	$.ajax({
		type: "post",
		url: "${path}/tbaord/getAttach/${dto.tb_num}",
		success: function(list){
// Controller에서 List<String>타입으로 넘어온 값을 처리하기 위해 json으로 처리
			// list : json
			//console.log(list);
			$(list).each(function(){
				var fileInfo=getFileInfo(this);
				//console.log(fileInfo);
				var html="<div><a href='"+fileInfo.getLink+"'>"
					+fileInfo.fileName+"</a>&nbsp;&nbsp;";
				<c:if test="${sessionScope.seurid == dto.create_user}">
				</c:if>
				html+="<a href='#' class='file_del' data-src='"
						+this+"'>[삭제]</a></div>";
				$("#uploadedList").append(html);
			});
		}
	});
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
			<input type="radio" id="n" name="category" value="n">
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
    filebrowserUploadUrl: "${path}/ckeditor/fileAttach.do", // Specify the upload URL
//    filebrowserUploadMethod: "form", // Use the form-based upload method
  }

  CKEDITOR.replace("description", editConfig);
  </script>

	<!-- 지도 -->

</body>
</html>