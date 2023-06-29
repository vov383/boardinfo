<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!-- 세션사용여부 -->

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>BOARDINFO</title>
<%@ include file="../include/js/header.jsp"%>
<link rel="stylesheet" href="${path}/include/js/style_game.css">
	<script src="${path}/include/js/common.js"></script>
	<style>
		#fileDrop {
			float: right;
			width: 80px;
			height: 80px;
			border: 1px solid black;
			margin-right: 50px;
			text-align: center;
		}
	</style>
</head>

<body>

	<header>
		<%@include file="../include/top.jsp" %>
	</header>

	<main>
		<div id="contents">
			<div id="contentsHeader">
				<h2>관리자</h2>
			</div>
			<div id="contentsLocation">
				홈&gt 관리자&gt 게임등록
			</div>
			<div id="contentsMain">



	<div align="center">
	
	<form name="gameform" id="gameform" method="post" action="${path}/admin/allowGame.do">
		<input type="hidden" name="gnum" value="${dto.gnum}">
		<table>

		<colgroup>
			<col width="28%" />
			<col width="68%" />
		</colgroup>

		<thead>

			<tr>

				<th colspan="2">게임 등록</th>

			</tr>

		</thead>

		<tbody>

		<tr>

			<td>
				<div style="float: left;">사진</div>
				<%--파일을 업로드할 영역--%>
				<div class="fileDrop" id="fileDrop"><p>Drop Images!!</p></div>
			</td>
			<td>
				<%--파일을 출력할 영역--%>
				<span id="uploadedList">
					<c:forEach var="row" items="${attachlist}">
						<div>
						<br>
						<img src='${path}/resources/uploaded_game${row}'>
						<span data-src="+data+">[삭제]</span>
						<input type='hidden' class='file' value='"+fileInfo.fullName+"'>
					</div>
					</c:forEach>


				</span>
			</td>

		</tr>

			<tr>

			  	<td>게임 이름</td>
				<td>
					<input name="gametitle" id="gametitle" class="input_game" value="${dto.gametitle}" maxlength="100">
					<div>
						<label for="gametitle">콤마(,)를 제외한 게임명을 입력해주세요</label>
					</div>
				</td>

			</tr>

			<tr>

				<td>게임 이름(영문)</td>
				<td>
					<input name="gametitle_eng" id="gametitle_eng" class="input_game" value="${dto.gametitle_eng}" maxlength="100">
					<div>
						<label for="gametitle_eng">콤마(,)를 제외한 게임의 영문명을 입력해주세요</label>
					</div>
				</td>

			</tr>

			<tr>

				<td>보드게임긱 아이디</td>
				<td>
					<input type="number" name="bggnum" id="bggnum" class="input_game" value="${dto.bggnum}" oninput='numberInput(this, 8)'>
					<div>
						<label for="bggnum">(선택)보드게임긱의 게임번호를 입력하세요</label>
					</div>
				</td>

			</tr>

			<tr>

				<td>
					<h4>디자이너</h4>
					<input type="button" id="btnAddDesigner" value="추가">
				</td>
				<td>
					<div id="selectedDesigner"></div>

					<input type="hidden" name="designer" id="designer" value="${dto.designer}">
					<input id="inputDesigner" class="input_game" autocomplete="off">
					<div>
						<label for="inputDesigner">디자이너명을 입력하세요</label>
					</div>

					<div id="designerSuggestions"></div>
				</td>

			</tr>
			
			<tr>

				<td>
					<h4>카테고리</h4>
					<input type="button" id="btnAddCategory" value="추가">
				</td>
				<td>
				
					<div id="selectedCategory"></div>

					<input type="hidden" name="gamecategory" id="gamecategory" value="${dto.gamecategory}">
					<input type="checkbox" id="toggleCategory"> 
					<label for="toggleCategory" class="toggleSwitch"> 
						<span class="toggleButton"></span>
					</label>
					<label for="toggleCategory">카테고리를 선택하세요</label>

					<div id="divCategory">
						
						<table id="tableCategory">
						
						<thead>
							
							<tr>
								
								<th colspan="3">카테고리목록</th>
							
							</tr>
						
						</thead>
						
						<tbody>
						
				<c:set var="i" value="0" />
				<c:set var="j" value="3" />
				
					<c:forEach var="item" items="${clist}" >
					
						<c:if test="${i%j==0}">
      						<tr>
     					</c:if>
								
								<td class="cursor_pointer">${item.gamecategory}</td>
								
						<c:if test="${i%j==j-1}">
      						</tr>
     					</c:if>
     					
    			<c:set var="i" value="${i+1}" />
							
					</c:forEach>	
						
						</tbody>
					
						</table>
						
					</div>
					
				</td>

			</tr>

			<tr>

				<td>
					<h4>아트웍</h4>
					<input type="button" id="btnAddArtist" value="추가">
				</td>
				<td>
					<div id="selectedArtist"></div>

					<input type="hidden" name="artist" id="artist" value="${dto.artist}">
					<input id="inputArtist" class="input_game" autocomplete="off">
					<div>
						<label for="inputArtist">아티스트명을 입력하세요</label>
					</div>

					<div id="artistSuggestions"></div>
				</td>

			</tr>

			<tr>

				<td>
					<h4>메카닉</h4>
					<input type="button" id="btnAddMechanic" value="추가">
				</td>
				<td>
				
					<div id="selectedMechanic"></div>
					<input type="hidden" name="mechanic" id="mechanic" value="${dto.mechanic}">
					<input type="checkbox" id="toggleMechanic"> 
					<label for="toggleMechanic" class="toggleSwitch"> 
					 <span class="toggleButton"></span>
					</label>
					<label for="toggleMechanic">게임 메커니즘을 선택하세요</label>

					<div id="divMechanic">
						
						<table id="tableMechanic">
						
						<thead>
							
							<tr>
								
								<th colspan="3">메카닉목록</th>
							
							</tr>
						
						</thead>
						
						<tbody>
						
				<c:set var="i" value="0" />
				<c:set var="j" value="3" />
				
					<c:forEach var="item" items="${mlist}" >
					
						<c:if test="${i%j==0}">
      						<tr>
     					</c:if>
								
								<td class="cursor_pointer">${item.mechanic}</td>
								
						<c:if test="${i%j==j-1}">
      						</tr>
     					</c:if>
     					
    			<c:set var="i" value="${i+1}" />
							
					</c:forEach>	
						
						</tbody>
						
						</table>
					
					</div>
				</td>

			</tr>

			<tr>

				<td>
					<h4>제작사</h4>
					<input type="button" id="btnAddPublisher" value="추가">
				</td>
				<td>
					<div id="selectedPublisher"></div>

					<input type="hidden" name="publisher" id="publisher" value="${dto.publisher}">
					<input id="inputPublisher" class="input_game" autocomplete="off">
					<div>
						<label for="inputPublisher">제작사명을 입력하세요</label>
					</div>

					<div id="publisherSuggestions"></div>
				</td>

			</tr>

			<tr>

				<td>플레이 인원</td>
				<td>
					<input name="players" id="players" class="input_game" value="${dto.players}" maxlength="20">
					<div>
						<label for="players">게임의 권장 플레이 인원을 입력하세요</label>
					</div>
				</td>

			</tr>

			<tr>

				<td>플레이 시간</td>
				<td>
					<input name="playtime" id="playtime" class="input_game" value="${dto.playtime}" maxlength="20">
					<div>
						<label for="playtime">게임의 플레이 시간을 입력하세요</label>
					</div>
				</td>

			</tr>

			<tr>

				<td>사용연령</td>
				<td><input name="ages" id="ages" class="input_game" value="${dto.ages}" maxlength="20">
					<div>
						<label for="ages">게임의 사용 연령을 입력하세요</label>
					</div>
				</td>

			</tr>

			<tr>

				<td>발매년도</td>
				<td><input type="number" name="release_year" id="release_year" class="input_game" value="${dto.release_year}" oninput='numberInput(this, 4)'>
					<div>
						<label for="release_year">게임의 발매년도를 입력하세요</label>
					</div>
				</td>

			</tr>

			<tr>

				<td>사용언어</td>
				<td>
					<input name="language" id="language" class="input_game" value="${dto.language}" maxlength="20">
					<div>
						<label for="language">게임의 사용 언어를 입력하세요</label>
					</div>
				</td>

			</tr>

			<tr>

				<td>확장게임</td>
				<td>
					<div id="selectedEx"></div>

					<input type="hidden" name="expansion" id="expansion" value="${dto.expansion}">
					<input id="inputEx" class="input_game" autocomplete="off">
					<div>
						<label for="inputEx">게임의 원본 게임명을 입력하세요</label>
					</div>

					<div id="exSuggestions"></div>
				</td>

			</tr>

			<tr>

				<td>재구현게임</td>
				<td>
					<div id="selectedRe"></div>

					<input type="hidden" name="reimplement" id="reimplement" value="${dto.reimplement}">
					<input id="inputRe" class="input_game" autocomplete="off">
					<div>
						<label for="inputRe">게임의 원본 게임명을 입력하세요</label>
					</div>

					<div id="reSuggestions"></div>
				</td>

			</tr>

			<tr>

				<td>테마</td>
				<td>
					<select name="theme" id="theme">
						<option value="-">선택하세요(필수 아님)</option>
						<option value="가족게임">가족게임</option>
						<option value="어린이게임">어린이게임</option>
						<option value="전쟁게임">전쟁게임</option>
						<option value="전략게임">전략게임</option>
						<option value="추상게임">추상게임</option>
						<option value="컬렉터블게임">컬렉터블게임</option>
						<option value="테마게임">테마게임</option>
						<option value="파티게임">파티게임</option>
					</select>
				</td>

			</tr>

			<tr>

				<td colspan="2">
					<button type="button" id="btnGameAllow">등록하기</button>
					<button type="button" id="btnGameDeny">거부하기</button>
				</td>

			</tr>

		</tbody>

		</table>

	</form>
	
	</div>

	</div>
	</div>

	</main>

	<form name="denyform" method="post" action="${path}/admin/denyGame.do">
		<input type="hidden" name="deny_gnum" value="${dto.gnum}">
	</form>


<script type="text/javascript">
	//type=number 인 input 태그의 길이제한 메서드
	function numberInput(num, maxlength){
		if(num.value.length > maxlength)  {
			num.value
					= num.value.substr(0, maxlength);
		}
	}

	$(document).ready(function () {
		//게임테마 기존 값 유지
		$("#theme").val("${dto.theme}").attr("selected","selected");

		//게임 수정 버튼클릭
		$("#btnGameAllow").click(function() {
			//null값확인, 자료형확인필요함 -> 정규식응용

			//gametitle 체크
			var gametitle = $("#gametitle").val();
			if(gametitle==""){
				alert("게임제목을 입력하세요.");
				$("#gametitle").focus();
				return;
			}
			//gametitle 정규식
			var exp_gametitle = /^[가-힣a-zA-Z0-9\{\}\[\]\/?.;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"\s]{1,}$/;

			if(!exp_gametitle.test(gametitle)){
				alert("잘못 입력했습니다.");
				$("#gametitle").focus();
				return;
			}

			//gametitle_eng 체크
			var gametitle_eng = $("#gametitle_eng").val();
			if(gametitle_eng==""){
				alert("게임제목(영문)을 입력하세요.");
				$("#gametitle_eng").focus();
				return;
			}
			//gametitle_eng 정규식
			var exp_gametitle_eng = /^[a-zA-Z0-9\{\}\[\]\/?.;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"\s]{1,}$/;

			if(!exp_gametitle_eng.test(gametitle_eng)){
				alert("잘못 입력했습니다.");
				$("#gametitle_eng").focus();
				return;
			}

			//players 체크
			var players = $("#players").val();
			if(players==""){
				alert("게임인원을 입력하세요.");
				$("#players").focus();
				return;
			}
			//players 정규식
			var exp_players = /^[가-힣a-zA-Z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"\s]{1,}$/;

			if(!exp_players.test(players)){
				alert("잘못 입력했습니다.");
				$("#players").focus();
				return;
			}

			//playtime 체크
			var playtime = $("#playtime").val();
			if(playtime==""){
				alert("게임시간을 입력하세요.");
				$("#playtime").focus();
				return;
			}
			//playtime 정규식
			var exp_playtime = /^[가-힣a-zA-Z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"\s]{1,}$/;

			if(!exp_playtime.test(playtime)){
				alert("잘못 입력했습니다.");
				$("#playtime").focus();
				return;
			}

			//ages 체크
			var ages = $("#ages").val();
			if(ages==""){
				alert("적정연령을 입력하세요.");
				$("#ages").focus();
				return;
			}
			//ages 정규식
			var exp_ages = /^[가-힣a-zA-Z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"\s]{1,}$/;

			if(!exp_ages.test(ages)){
				alert("잘못 입력했습니다.");
				$("#ages").focus();
				return;
			}

			//release_year 체크
			var release_year = $("#release_year").val();
			if(release_year==""){
				alert("발매년도를 입력하세요.");
				$("#release_year").focus();
				return;
			}

			//language 체크
			var language = $("#language").val();
			if(language==""){
				alert("사용언어를 입력하세요.");
				$("#language").focus();
				return;
			}
			//language 정규식
			var exp_language = /^[가-힣a-zA-Z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"\s]{1,}$/;

			if(!exp_language.test(ages)){
				alert("잘못 입력했습니다.");
				$("#language").focus();
				return;
			}

			document.gameform.submit();
		});

		//게임 등록거부 버튼 클릭
		$("#btnGameDeny").click(function(){
			document.denyform.submit();
		});
	});


</script>

<script type="text/javascript">

	$(document).ready(function() {


		//파일을 마우스로 드래그해서 업로드 영역에 올릴때 파일이 열리는 기본효과 막는 처리
		$(".fileDrop").on("dragenter dragover", function(e) {
			e.preventDefault();
		});
		//마우스로 파일을 드롭할 때 파일이 열리는 기본 효과 막음
		$(".fileDrop").on("drop", function(e){
			e.preventDefault();
			//첫번째 첨부 파일
			var files=e.originalEvent.dataTransfer.files;
			var file=files[0];
			//폼 데이터에 첨부파일 추가
			var formData=new FormData();
			formData.append("file",file);
			$.ajax({
				url: "${path}/uploadgame/uploadAjax",
				data: formData,
				dataType: "text",
				processData: false,
				contentType: false,
				type: "post",
				success: function(data){
					//data: 업로드한 파일 정보와 Http 상태 코드
					var fileInfo=getFileInfo(data);
					console.log(fileInfo);
					var html="<div><a href='"+fileInfo.getLink+"'>"+fileInfo.fileName+"</a><br>";
					html += "<img src='${path}/uploadgame/displayFile?fileName="+data+"'>";
					html += "<span data-src="+data+">[삭제]</span>";
					html += "<input type='hidden' class='file' value='"+fileInfo.fullName+"'></div>";
					$("#uploadedList").append(html);
				}
			});
		});

		//첨부파일 삭제 함수
		$("#uploadedList").on("click","span",
				function(event){//내부적으로 span태그가 클릭되면 삭제
					var that=$(this);//this는 현재 클릭한 태그, 즉 span태그
					$.ajax({
						url: "${path}/uploadgame/deleteFile",
						type: "post",
						data: {fileName: $(this).attr("data-src")},
						dataType: "text",
						success: function(result){
							if(result=="deleted"){
								that.parent("div").remove();//파일삭제되면 행전체<div>를 삭제 처리
								//that은 span태그를 의미하는데 그 부모인 div태그를 지운다는 뜻

							}
						}
					});
		});


		//category항목 리스트에서 선택할수 있게하는 기능
		var selectedCategories = [];

		//이미 가지고있는 category 보여주는 함수
		var gamecategoryValue = $("#gamecategory").val();
		if (gamecategoryValue) {
			selectedCategories = gamecategoryValue.split(",");
			selectedCategories.forEach(function(category) {
				$("#selectedCategory").append("<div class='selected-value cursor_pointer'>" + category + "</div>");
				$("#tableCategory td").filter(function() {
					return $(this).text() === category;
				}).addClass("selected");
			});
		}

		//서버로 보낼 카테고리의 배열에 값을 넣는 함수
		function updateGameCategoryInput() {
	 		var gameCategoryInput = $("#gamecategory");
			gameCategoryInput.val(selectedCategories.join(","));
		}

		//새로운 카테고리명을 추가
		$("#btnAddCategory").click(function(){
			var newCategory = prompt("추가할 카테고리명을 적어주세요.");
			if(newCategory != null){
				var check = confirm(newCategory+" 맞습니까?");
				if(check == true){
					if (selectedCategories.indexOf(newCategory) === -1) {
						selectedCategories.push(newCategory);

						// 선택된 값 표시
						$("#selectedCategory").append("<div class='selected-value cursor_pointer'>" + newCategory + "</div>");
					}
					updateGameCategoryInput();
				}
			}
		});

		// 테이블 셀 클릭 이벤트 처리
		$("#tableCategory").on("click", "td", function() {

			//중복클릭을 막음
			if ($(this).hasClass("selected")) {
				return;
			}
			
		    var selectedcategory = $(this).text();
		    
		 	// selectedcategory가 배열에 존재하지 않을 때만 값을 추가
		    if (selectedCategories.indexOf(selectedcategory) === -1) {
		    	
		    	selectedCategories.push(selectedcategory);

		      	// 선택된 값 표시
		  	    $("#selectedCategory").append("<div class='selected-value cursor_pointer'>" + selectedcategory + "</div>");

		      	// 선택된 <td> 태그에 'selected' 클래스 추가하여 클릭 불가능하게 만듦
		 	    $(this).addClass("selected");
		    }
		    updateGameCategoryInput();
		});
		  
		// 선택된 값 클릭 이벤트 처리
		$("#selectedCategory").on("click", ".selected-value", function() {
			
			var value = $(this).text();
			var filter = "category"

		    // 선택된 값 db에 존재할 경우 삭제되도록 처리
			$.ajax({
				type: "POST",
				url: "${path}/game/autoUpdate_delete.do/"+value+"/${dto.gnum}/"+filter,
			});
			
			// 선택된 값 배열에서 해당 값을 제거
			selectedCategories = selectedCategories.filter(function(selected) {
				return selected !== value;
			});

			// 선택된 값 표시가 삭제되도록 처리
			$(this).remove();

		    updateGameCategoryInput();
		  });
		
		
		//mechanic항목 리스트에서 선택할수 있게하는 기능
		var selectedMechanics = [];

		//이미 가지고있는 mechanic 보여주는 함수
		var mechanicValue = $("#mechanic").val();
		if (mechanicValue) {
			selectedMechanics = mechanicValue.split(",");
			selectedMechanics.forEach(function(mechanic) {
				$("#selectedMechanic").append("<div class='selected-value cursor_pointer'>" + mechanic + "</div>");
				$("#tableMechanic td").filter(function() {
					return $(this).text() === mechanic;
				}).addClass("selected");
			});
		}
	
		function updateGameMechanicInput() {
	 		var mechanicInput = $("#mechanic");
	 		mechanicInput.val(selectedMechanics.join(","));
		}

		//새로운 메카닉명을 추가
		$("#btnAddMechanic").click(function(){
			var newMechanic = prompt("추가할 메카닉명을 적어주세요.");
			if(newMechanic != null){
				var check = confirm(newMechanic+" 맞습니까?");
				if(check == true){
					if (selectedMechanics.indexOf(newMechanic) === -1) {
						selectedMechanics.push(newMechanic);

						// 선택된 값 표시
						$("#selectedMechanic").append("<div class='selected-value cursor_pointer'>" + newMechanic + "</div>");
					}
					updateGameMechanicInput();
				}
			}

		});

		// 테이블 셀 클릭 이벤트 처리
		$("#tableMechanic").on("click", "td", function() {
			
			//중복클릭을 막음
			if ($(this).hasClass("selected")) {
				return;
			}
			
		    var selectedMechanic = $(this).text();
		    
		 	// selectedMechanic이 배열에 존재하지 않을 때만 값을 추가
		    if (selectedMechanics.indexOf(selectedMechanic) === -1) {
		    	
		    	selectedMechanics.push(selectedMechanic);

		      	// 선택된 값 표시
		  	    $("#selectedMechanic").append("<div class='selected-value cursor_pointer'>" + selectedMechanic + "</div>");

		      	// 선택된 <td> 태그에 'selected' 클래스 추가하여 클릭 불가능하게 만듦
		 	    $(this).addClass("selected");
		    }
		 	
		    updateGameMechanicInput()
		   
		});
		  
		// 선택된 값 클릭 이벤트 처리
		$("#selectedMechanic").on("click", ".selected-value", function() {
			
			var value = $(this).text();

		    // 선택된 값 배열에서 해당 값을 제거
		    selectedMechanics = selectedMechanics.filter(function(selected) {
		      	return selected !== value;
		    });

		    // 선택된 값 표시가 삭제되도록 처리
		    $(this).remove();
		    
		    updateGameMechanicInput()
		  });



		
		
		//	artist 검색 자동완성 쿼리 
		$('#inputArtist').keyup(function() {
	        var input = $(this).val();
	        $.ajax({
				type: "post",
	        	url: "${path}/game/autoArtist.do/"+input,
	            success: function(result) {
					var suggestionsDiv = $('#artistSuggestions');
					suggestionsDiv.empty(); // 기존 내용 비우기

					if (result.length > 0) {
						suggestionsDiv.css('max-height', '150px').show(); // 값이 있을 경우 높이 설정하고 보이기
						$(result).each(function(index, item) {
							var artist = item.artist;
							suggestionsDiv.append("<div class='searched cursor_pointer'>" + artist + "</div>");
						});
					} else {
						suggestionsDiv.hide(); // 값이 없을 경우 숨기기
					}
	            },
				error: function() {
					console.log("에러..");
				}
	        });
	        if(input=="")	$('#artistSuggestions').empty();
	    });//검색창 검색

		var selectedArtists = [];


		//이미 가지고있는 artist 보여주는 함수
		var artistValue = $("#artist").val();
		if (artistValue) {
			selectedArtists = artistValue.split(",");
			selectedArtists.forEach(function(artist) {
				$("#selectedArtist").append("<div class='selected cursor_pointer'>" + artist + "</div>");
			});
		}

		function updateArtistInput() {
			var artistInput = $("#artist");
			artistInput.val(selectedArtists.join(","));
		}

		//새로운 아티스트명을 추가
		$("#btnAddArtist").click(function(){
			var newArtist = prompt("추가할 아티스트명을 적어주세요.");
			if(newArtist != null){
				var check = confirm(newArtist+" 맞습니까?");
				if(check == true){
					if (selectedArtists.indexOf(newArtist) === -1) {
						selectedArtists.push(newArtist);

						// 선택된 값 표시
						$("#selectedArtist").append("<div class='selected-value'>" + newArtist + "</div>");
					}
					updateArtistInput();
				}
			}

		});

		//아티스트 검색값 클릭시 배열에 추가
		$('#artistSuggestions').on('click', '.searched', function() {
			var selectedArtist = $(this).text();
			selectedArtists.push(selectedArtist);
			$("#selectedArtist").append("<div class='selected cursor_pointer'>" + selectedArtist + "</div>");
			console.log("배열"+selectedArtists);
			$("#inputArtist").val("");
			$("#artistSuggestions").empty().hide();
			updateArtistInput();
			console.log("인풋"+$("#artist").val());
		});

		// 선택된 값 클릭 이벤트 처리
		$("#selectedArtist").on("click", ".selected", function() {

			var value = $(this).text();

			// 선택된 값 배열에서 해당 값을 제거
			selectedArtists = selectedArtists.filter(function(selected) {
				return selected !== value;
			});

			// 선택된 값 표시가 삭제되도록 처리
			$(this).remove();

			updateArtistInput();
			console.log("인풋"+$("#artist").val());
		});


		//	designer 검색 자동완성 쿼리
		$('#inputDesigner').keyup(function() {
			var input = $(this).val();
			$.ajax({
				type: "post",
				url: "${path}/game/autoDesigner.do/"+input,
				success: function(result) {
					var suggestionsDiv = $('#designerSuggestions');
					suggestionsDiv.empty(); // 기존 내용 비우기

					if (result.length > 0) {
						suggestionsDiv.css('max-height', '150px').show(); // 값이 있을 경우 높이 설정하고 보이기
						$(result).each(function(index, item) {
							var designer = item.designer;
							suggestionsDiv.append("<div class='searched cursor_pointer'>" + designer + "</div>");
						});
					} else {
						suggestionsDiv.hide(); // 값이 없을 경우 숨기기
					}
				},
				error: function() {
					console.log("에러..");
				}
			});
			if(input=="")	$('#designerSuggestions').empty();
		});

		var selectedDesigners = [];

		//이미 가지고있는 designer 보여주는 함수
		var designerValue = $("#designer").val();
		if (designerValue) {
			selectedDesigners = designerValue.split(",");
			selectedDesigners.forEach(function(designer) {
				$("#selectedDesigner").append("<div class='selected cursor_pointer'>" + designer + "</div>");
			});
		}

		function updateDesignerInput() {
			var designerInput = $("#designer");
			designerInput.val(selectedDesigners.join(","));
		}

		//새로운 디자이너명을 추가
		$("#btnAddDesigner").click(function(){
			var newDesigner = prompt("추가할 디자이너명을 적어주세요.");
			if(newDesigner != null){
				var check = confirm(newDesigner+" 맞습니까?");
				if(check == true){
					if (selectedDesigners.indexOf(newDesigner) === -1) {
						selectedDesigners.push(newDesigner);

						// 선택된 값 표시
						$("#selectedDesigner").append("<div class='selected-value'>" + newDesigner + "</div>");
					}
					updateDesignerInput();
				}
			}

		});

		//디자이너 검색값 클릭시 배열에 추가
		$('#designerSuggestions').on('click', '.searched', function() {
			var selectedDesigner = $(this).text();
			selectedDesigners.push(selectedDesigner);
			$("#selectedDesigner").append("<div class='selected cursor_pointer'>" + selectedDesigner + "</div>");
			console.log("배열"+selectedDesigners);
			$("#inputDesigner").val("");
			$("#designerSuggestions").empty().hide();
			updateDesignerInput();
			console.log("인풋"+$("#designer").val());
		});

		// 선택된 값 클릭 이벤트 처리
		$("#selectedDesigner").on("click", ".selected", function() {

			var value = $(this).text();

			// 선택된 값 배열에서 해당 값을 제거
			selectedDesigners = selectedDesigners.filter(function(selected) {
				return selected !== value;
			});

			// 선택된 값 표시가 삭제되도록 처리
			$(this).remove();

			updateDesignerInput();
			console.log("인풋"+$("#designer").val());
		});


		//	publisher 검색 자동완성 쿼리
		$('#inputPublisher').keyup(function() {
			var input = $(this).val();
			$.ajax({
				type: "post",
				url: "${path}/game/autoPublisher.do/"+input,
				success: function(result) {
					var suggestionsDiv = $('#publisherSuggestions');
					suggestionsDiv.empty(); // 기존 내용 비우기

					if (result.length > 0) {
						suggestionsDiv.css('max-height', '150px').show(); // 값이 있을 경우 높이 설정하고 보이기
						$(result).each(function(index, item) {
							var publisher = item.publisher;
							suggestionsDiv.append("<div class='searched cursor_pointer'>" + publisher + "</div>");
						});
					} else {
						suggestionsDiv.hide(); // 값이 없을 경우 숨기기
					}
				},
				error: function() {
					console.log("에러..");
				}
			});
			if(input=="")	$('#publisherSuggestions').empty();
		});

		var selectedPublishers = [];

		//이미 가지고있는 publisher 보여주는 함수
		var publisherValue = $("#publisher").val();
		if (publisherValue) {
			selectedPublishers = publisherValue.split(",");
			selectedPublishers.forEach(function(publisher) {
				$("#selectedPublisher").append("<div class='selected cursor_pointer'>" + publisher + "</div>");
			});
		}

		function updatePublisherInput() {
			var publisherInput = $("#publisher");
			publisherInput.val(selectedPublishers.join(","));
		}

		//새로운 퍼블리셔명을 추가
		$("#btnAddPublisher").click(function(){
			var newPublisher = prompt("추가할 퍼블리셔명을 적어주세요.");
			if(newPublisher != null){
				var check = confirm(newPublisher+" 맞습니까?");
				if(check == true){
					if (selectedPublishers.indexOf(newPublisher) === -1) {
						selectedPublishers.push(newPublisher);

						// 선택된 값 표시
						$("#selectedPublisher").append("<div class='selected-value'>" + newPublisher + "</div>");
					}
					updatePublisherInput();
				}
			}

		});

		//퍼블리셔 검색값 클릭시 배열에 추가
		$('#publisherSuggestions').on('click', '.searched', function() {
			var selectedPublisher = $(this).text();
			selectedPublishers.push(selectedPublisher);
			$("#selectedPublisher").append("<div class='selected cursor_pointer'>" + selectedPublisher + "</div>");
			console.log("배열"+selectedPublishers);
			$("#inputPublisher").val("");
			$("#publisherSuggestions").empty().hide();
			updatePublisherInput();
			console.log("인풋"+$("#publisher").val());
		});

		// 선택된 값 클릭 이벤트 처리
		$("#selectedPublisher").on("click", ".selected", function() {

			var value = $(this).text();

			// 선택된 값 배열에서 해당 값을 제거
			selectedPublishers = selectedPublishers.filter(function(selected) {
				return selected !== value;
			});

			// 선택된 값 표시가 삭제되도록 처리
			$(this).remove();

			updatePublisherInput();
			console.log("인풋"+$("#publisher").val());
		});










		//	ex확장게임 검색 자동완성 쿼리
		$('#inputEx').keyup(function() {
			var input = $(this).val();
			$.ajax({
				type: "post",
				url: "${path}/game/autoGame.do/"+input,
				success: function(result) {
					var suggestionsDiv = $('#exSuggestions');
					suggestionsDiv.empty(); // 기존 내용 비우기

					if (result.length > 0) {
						suggestionsDiv.css('max-height', '150px').show(); // 값이 있을 경우 높이 설정하고 보이기
						$(result).each(function(index, item) {
							var gametitle = item.gametitle;
							suggestionsDiv.append("<div class='searched cursor_pointer'>" + gametitle + "</div>");
						});
					} else {
						suggestionsDiv.hide(); // 값이 없을 경우 숨기기
					}
				},
				error: function() {
					console.log("에러..");
				}
			});
			if(input=="")	$('#exSuggestions').empty();
		});

		var selectedExs = [];

		//이미 가지고있는 확장게임 보여주는 함수
		var expansionValue = $("#expansion").val();
		if (expansionValue) {
			selectedExs = expansionValue.split(",");
			selectedExs.forEach(function(expansion) {
				$("#selectedEx").append("<div class='selected cursor_pointer'>" + expansion + "</div>");
			});
		}

		function updateExInput() {
			var exInput = $("#expansion");
			exInput.val(selectedExs.join(","));
		}


		//ex확장게임 검색값 클릭시 배열에 추가
		$('#exSuggestions').on('click', '.searched', function() {
			var selectedEx = $(this).text();
			console.log(selectedEx);
			selectedExs.push(selectedEx);
			$("#selectedEx").append("<div class='selected-value cursor_pointer'>" + selectedEx + "</div>");
			console.log("배열"+selectedExs);
			$("#inputEx").val("");
			$("#exSuggestions").empty().hide();
			updateExInput();
			console.log("인풋"+$("#expansion").val());
		});

		// 선택된 값 클릭 이벤트 처리
		$("#selectedEx").on("click", ".selected-value", function() {

			var value = $(this).text();

			// 선택된 값 배열에서 해당 값을 제거
			selectedExs = selectedExs.filter(function(selected) {
				return selected !== value;
			});

			// 선택된 값 표시가 삭제되도록 처리
			$(this).remove();

			updateExInput();
			console.log("인풋"+$("#expansion").val());
		});



		//	re재구현게임 검색 자동완성 쿼리
		$('#inputRe').keyup(function() {
			var input = $(this).val();
			$.ajax({
				type: "post",
				url: "${path}/game/autoGame.do/"+input,
				success: function(result) {
					var suggestionsDiv = $('#reSuggestions');
					suggestionsDiv.empty(); // 기존 내용 비우기

					if (result.length > 0) {
						suggestionsDiv.css('max-height', '150px').show(); // 값이 있을 경우 높이 설정하고 보이기
						$(result).each(function(index, item) {
							var gametitle = item.gametitle;
							suggestionsDiv.append("<div class='searched cursor_pointer'>" + gametitle + "</div>");
						});
					} else {
						suggestionsDiv.hide(); // 값이 없을 경우 숨기기
					}
				},
				error: function() {
					console.log("에러..");
				}
			});
			if(input=="")	$('#reSuggestions').empty();
		});

		var selectedRes = [];

		//이미 가지고있는 재구현게임 보여주는 함수
		var reimplementValue = $("#reimplement").val();
		if (reimplementValue) {
			selectedRes = reimplementValue.split(",");
			selectedRes.forEach(function(reimplement) {
				$("#selectedRe").append("<div class='selected cursor_pointer'>" + reimplement + "</div>");
			});
		}

		function updateReInput() {
			var reInput = $("#reimplement");
			reInput.val(selectedRes.join(","));
		}


		//재구현게임 검색값 클릭시 배열에 추가
		$('#reSuggestions').on('click', '.searched', function() {
			var selectedRe = $(this).text();
			console.log(selectedRe);
			selectedRes.push(selectedRe);
			$("#selectedRe").append("<div class='selected-value cursor_pointer'>" + selectedRe + "</div>");
			console.log("배열"+selectedRes);
			$("#inputRe").val("");
			$("#reSuggestions").empty().hide();
			updateReInput();
			console.log("인풋"+$("#reimplement").val());
		});

		// 선택된 값 클릭 이벤트 처리
		$("#selectedRe").on("click", ".selected-value", function() {

			var value = $(this).text();

			// 선택된 값 배열에서 해당 값을 제거
			selectedRes = selectedRes.filter(function(selected) {
				return selected !== value;
			});

			// 선택된 값 표시가 삭제되도록 처리
			$(this).remove();

			updateReInput();
			console.log("인풋"+$("#reimplement").val());
		});

	});

</script>

	<footer>
		<%@include file="../include/footer.jsp" %>
	</footer>

</body>

</html>