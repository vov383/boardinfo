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
<style>

	.input_game {
		width: 300px;
	}

</style>
</head>

<body>

	<div align="center">
	
	<form name="gameform" method="post" action="${path}/game/insert.do">

		<table>

		<thead>

			<tr>

				<th colspan="2">게임 등록</th>

			</tr>

		</thead>

		<tbody>

			<tr>

				<td>사진</td>
				<td><input type="file" name="gamephoto_url" id="gamephoto"></td>

			</tr>

			<tr>

			  	<td>게임 이름</td>
				<td><input name="gametitle" id="gametitle" class="input_game"></td>

			</tr>

			<tr>

				<td>게임 이름(영문)</td>
				<td><input name="gametitle_eng" id="gametitle_eng" class="input_game"></td>

			</tr>

			<tr>

				<td>제작자</td>
				<td><input name="designer" id="designer" class="input_game"></td>

			</tr>
			
			<tr>

				<td>카테고리</td>
				<td>
				
					<div id="selectedCategory"></div>
					<input type="hidden" name="gamecategory" id="gamecategory">
					<input type="checkbox" id="toggleCategory"> 
					<label for="toggleCategory" class="toggleSwitch"> 
						<span class="toggleButton"></span>
					</label>

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
				
					<c:forEach var="item" items="${map.clist}" >
					
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

				<td>아트웍</td>
				<td>
					<div id="selectedArtist"></div>
					<input type="hidden" name="artist" id="artist">
					<input id="inputArtist" class="input_game" autocomplete="off">
					<div id="artistSuggestions"></div>
				</td>

			</tr>

			<tr>

				<td>메카닉</td>
				<td>
				
					<div id="selectedMechanic"></div>
					<input type="hidden" name="mechanic" id="mechanic">
					<input type="checkbox" id="toggleMechanic"> 
					<label for="toggleMechanic" class="toggleSwitch"> 
					 <span class="toggleButton"></span>
					</label>

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
				
					<c:forEach var="item" items="${map.mlist}" >
					
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

				<td>제작사</td>
				<td><input name="publisher" id="publisher" class="input_game"></td>

			</tr>

			<tr>

				<td>플레이 인원</td>
				<td><input name="players" id="players" class="input_game"></td>

			</tr>

			<tr>

				<td>플레이 시간</td>
				<td><input name="playtime" id="playtime" class="input_game"></td>

			</tr>

			<tr>

				<td>사용연령</td>
				<td><input name="ages" id="ages" class="input_game"></td>

			</tr>

			<tr>

				<td>발매년도</td>
				<td><input name="release_year" id="release_year" class="input_game"></td>

			</tr>

			<tr>

				<td>사용언어</td>
				<td><input name="language" id="language" class="input_game"></td>

			</tr>

			<tr>

				<td colspan="2">
					<button type="button" id="btnGameInsert">등록</button>
				</td>

			</tr>

		</tbody>

		</table>

	</form>
	
	</div>


<script type="text/javascript">


	$(document).ready(function() {
		
	//새 게임 등록 버튼클릭
		$("#btnGameInsert").click(function() {
			//null값확인, 자료형확인필요함 -> 정규식응용
			document.gameform.submit();
		});
		
	//category항목 리스트에서 선택할수 있게하는 기능
		var selectedCategories = [];
		
		function updateGameCategoryInput() {
	 		var gameCategoryInput = $("#gamecategory");
			gameCategoryInput.val(selectedCategories.join(","));
		}
	
		  
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
		  	    $("#selectedCategory").append("<div class='selected-value'>" + selectedcategory + "</div>");

		      	// 선택된 <td> 태그에 'selected' 클래스 추가하여 클릭 불가능하게 만듦
		 	    $(this).addClass("selected");
		    }
		 	
		    updateGameCategoryInput();
		});
		  
		// 선택된 값 클릭 이벤트 처리
		$("#selectedCategory").on("click", ".selected-value", function() {
			
			var value = $(this).text();

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
	
		function updateGameMechanicInput() {
	 		var mechanicInput = $("#mechanic");
	 		mechanicInput.val(selectedMechanics.join(","));
		}
		  
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
		  	    $("#selectedMechanic").append("<div class='selected-value'>" + selectedMechanic + "</div>");

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
	        	url: "${path}/game/auto.do/"+input,
	            success: function(result) {
					var suggestionsDiv = $('#artistSuggestions');
					suggestionsDiv.empty(); // 기존 내용 비우기

					if (result.length > 0) {
						suggestionsDiv.css('height', '150px').show(); // 값이 있을 경우 높이 설정하고 보이기
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
	    });

		var selectedArtists = [];

		function updateArtistInput() {
			var artistInput = $("#artist");
			artistInput.val(selectedArtists.join(","));
		}

		$('#artistSuggestions').on('click', '.searched', function() {
			var selectedArtist = $(this).text();
			selectedArtists.push(selectedArtist);
			$("#selectedArtist").append("<div class='selected cursor_pointer'>" + selectedArtist + "</div>");
			console.log("배열"+selectedArtists);
			$("#inputArtist").val("");
			$("#artistSuggestions").empty().css('height', '0').hide();
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




	});
	
	
</script>
</body>

</html>