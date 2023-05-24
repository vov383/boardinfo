<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../include/js/header.jsp" %>
<script src="${path}/include/js/common.js"></script>
<script src="${path}/include/js/jquery-3.6.3.min.js"></script>

<!-- ckeditor의 라이브러리 -->
<script src="${path}/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
$(function(){ //자동으로 실행되는 코드
	listAttach();
	$(".fileDrop").on("dragenter dragover",function(e){
		//기본 효과 막음
		e.preventDefault();
	});
	$(".fileDrop").on("drop",function(e){
		e.preventDefault();
		//첫번째 첨부파일
		var files=e.originalEvent.dataTransfer.files;
		var file=files[0];
		//폼 데이터에 첨부파일 추가
		var formData=new FormData();
		formData.append("file",file);
		$.ajax({
			url: "${path}/upload/uploadAjax",
			data: formData,
			dataType: "text",
			processData: false,
			contentType: false,
			type: "post",
			success: function(data){
				//console.log(data);
				//data : 업로드한 파일 정보와 Http 상태 코드
				var fileInfo=getFileInfo(data);
				//console.log(fileInfo);
				var html="<a href='"+fileInfo.getLink+"'>"+
					fileInfo.fileName+"</a><br>";
				html += "<input type='hidden' class='file' value='"
					+fileInfo.fullName+"'>";
				$("#uploadedList").append(html);
			}
		});
	});
	
	//목록 버튼
	$("#btnList").click(function(){
		location.href="${path}/tboard/list.do";
	});
		
	//첨부파일 삭제
	//id가 uploadedList인 태그의 class가 file_del인 태그 클릭
	$("#uploadedList").on("click",".file_del",function(e){
		var that=$(this); //클릭한 태그
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
	
	listAttach();
	
	//수정 완료 버튼
	$("#btnUpdate").click(function(){
		var title = $("#title").val();												
		var description = $("#description").val();
		if (title == "") {
			alert("제목을 입력하세요.");
			$("#title").focus();
			return;
		}
		if (description == "") {
			alert("설명을 입력하세요.");
			$("#description").focus();
			return;
		}
		
		//첨부파일 이름들을 폼에 추가
		var str="";
		// uploadedList 내부의 .file 태그 각각 반복
		$("#uploadedList .file").each(function(i){
			//#id이름(공백).클래스이름 : id가 uploadeList인 태그의 자식태그 중에서 class가 file인 태그들
			console.log(i);
			//hidden 태그 구성
			str+=
				"<input type='hidden' name='files["+i+"]' value='"
					+$(this).val()+"'>";
		});
		//폼에 hidden 태그들을 붙임
		$("#form1").append(str);
		document.form1.action="${path}/board/update.do";
		document.form1.submit();
	});
	
	//삭제 버튼
	$("#btnDelete").click(function() {
		if(confirm("삭제하시겠습니까?")){
			document.form1.action="${path}/tboard/delete.do";
			document.form1.submit();
		}
	});
});
//첨부파일 리스트를 출력하는 함수
function listAttach(){
	$.ajax({
		type: "post",
		url: "${path}/tboard/getAttach/${dto.tb_num}",
		success: function(list){
// Controller에서 List<String>타입으로 넘어온 값을 처리하기 위해 json으로 처리
			// list : json
			//console.log(list);
			$(list).each(function(){
				var fileInfo=getFileInfo(this);
				//console.log(fileInfo);
				var html="<div><a href='"+fileInfo.getLink+"'>"
					+fileInfo.fileName+"</a>&nbsp;&nbsp;";
				<c:if test="${sessionScope.userid == dto.create_user}">
					html+="<a href='#' class='file_del' data-src='"
						+this+"'>[삭제]</a></div>";
				</c:if>
				$("#uploadedList").append(html);
			});
		}
	});
}
</script>
</head>
<body>
<h2>게시물 수정 페이지</h2>
	<button type="button" id="btnList">목록</button>
	
	<form name="form1" method="post" enctype="multipart/form-data">
		<input type="hidden" name="tb_num" id="tb_num" value="${dto.tb_num}">
		<div id="category">
			말머리를 선택하세요 <br>
				<c:if test= "${dto.category == s}">
					<input type="radio" id="s" name="category" value="s" checked>
				</c:if>
				  <input type="radio" id="s" name="category" value="s">
				<label for="s">판매</label> <br>
				<c:if test= "${dto.category == b}">
					<input type="radio" id="b" name="category" value="b" checked>
				</c:if> 
				<input type="radio" id="b" name="category" value="b">
				<label for="b">구매</label> <br>
				<c:if test= "${dto.category == n}">
					<input type="radio" id="n" name="category" value="n" checked>
				</c:if>
				<input type="radio" id="n" name="category" value="n">
				<label for="n">나눔</label> <br>
				<c:if test= "${dto.category == f}">
					<input type="radio" id="f" name="category" value="f" checked>
				</c:if>
				<input type="radio" id="f" name="category" value="f">
				<label for="f">거래완료</label> <br>
		</div>
		제목 : <input type="text" id="title" name="title" value="${dto.title}"> <br> 
		가격 : <input type="text" id="price" name="price" value="${dto.price}"> <br>
		<div> 제품의 사진을 등록해주세요
		<input type="file" id="attach_pic" name="attach_pic">
			<div class="fileDrop"></div>
			<div id="uploadedList"></div>
		</div>
		<div style="width: 500px; text-align: center;">
		</div>
		<br>
		<input type="hidden" name="description" id="description">
		<button type="button" id="btnUpdate">수정완료</button>
		<br>
		<button type="button" id="btnDelete">삭제</button>
		<div>
		내용 <br>
		<textarea id="editor" name="editor">${dto.description }</textarea>
		</div>	
	</form>
	<script>
  var editConfig = {
    filebrowserUploadUrl: "${path}/ckeditor/fileAttach.do", // Specify the upload URL
//    filebrowserUploadMethod: "form", // Use the form-based upload method
  }
  CKEDITOR.replace("editor", editConfig);
  
</script>
</body>
</html>