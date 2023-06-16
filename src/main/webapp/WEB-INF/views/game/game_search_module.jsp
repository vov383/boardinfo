<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<!-- 세션사용여부 -->

<%--검색기능 모듈--%>

<div align="left" style="border: 1px solid goldenrod;">
    <h4>게임검색</h4>
    <div id="selectedGame"></div>
    <input type="hidden" name="gametitle" id="gametitle">
    <input id="inputGame" class="input_game" autocomplete="off">
    <div>
        <label for="inputGame">게임명을 입력하세요</label>
    </div>
    <div id="gametitleSuggestions" style="width: 300px;	background-color: white; overflow-y: auto;"></div>
</div>

<script>
    //	gametitle 검색 자동완성 쿼리
    $('#inputGame').keyup(function() {
        var input = $(this).val();
        $.ajax({
            type: "POST",
            url: "${path}/game/autoGame.do/"+input,
            success: function(result) {
                var suggestionsDiv = $('#gametitleSuggestions');
                suggestionsDiv.empty(); // 기존 내용 비우기
                if (result.length > 0) {
                    suggestionsDiv.css('max-height', '150px').show(); // 값이 있을 경우 높이 설정하고 보이기
                    $(result).each(function(index, item) {
                        var gametitle = item.gametitle;
                        var gamephoto_url = item.gamephoto_url;
                        var bgg_thumbnail = item.bgg_thumbnail;
                        var bggnum = item.bggnum;
                        //var str => #gameSearchDiv 안에 들어갈 태그 입력
                        var str = "<div class='searched_top'><div class='imageDiv'>";

                        if(gamephoto_url != null) { //db에 입력된 사진 주소값이 없으면
                            str += '<img src="${path}/resources/uploaded_game' + gamephoto_url + '"';
                            str += 'onerror="this.src=\'${path}/images/game/no-image-icon.png\'">';
                        } else {
                            if(bggnum != null){ //보드게임긱 아이디가 존재하면
                                str += '<img class="img_photo" src="' + bgg_thumbnail + '"';
                                str += 'onerror="this.src=\'${path}/images/game/no-image-icon.png\'">';
                            }else {
                                str += '<img src="${path}/images/game/no-image-icon.png">';
                            }
                        }
                        str += "</div><div class='searched cursor_pointer'>" + gametitle + "</div></div>";

                        suggestionsDiv.append(str);
                    });
                } else {
                    suggestionsDiv.hide(); // 값이 없을 경우 숨기기
                }
            },
            error: function() {
                console.log("에러..");
            }
        });
        if(input=="")	$('#gametitleSuggestions').empty();
    });

    var selectedGames = [];
    function updateGameInput() {
        var gameInput = $("#gametitle");
        gameInput.val(selectedGames.join(","));
    }
    //게임 검색값 클릭시 배열에 추가
    $('#gametitleSuggestions').on('click', '.searched', function() {
        var selectedGame = $(this).text();
        selectedGames.push(selectedGame);

        $("#selectedGame").append("<div class='selected-value cursor_pointer'>" + selectedGame + "</div>");
        console.log("배열"+selectedGames);
        $("#inputGame").val("");
        $("#gametitleSuggestions").empty().hide();
        updategameInput();
        console.log("인풋"+$("#gametitle").val());
    });
    // 선택된 값 클릭 이벤트 처리
    $("#selectedGame").on("click", ".selected-value", function() {
        var value = $(this).text();
        // 선택된 값 배열에서 해당 값을 제거
        selectedGames = selectedGames.filter(function(selected) {
            return selected !== value;
        });
        // 선택된 값 표시가 삭제되도록 처리
        $(this).remove();
        updategameInput();
        console.log("인풋"+$("#gametitle").val());
    });
</script>
