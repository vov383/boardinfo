<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<!-- 세션사용여부 -->
<link rel="stylesheet" href="${path}/include/js/style_game.css">

<div class="game_detail_filter_div">
    <ul>
        <li><a id="btnHidden">숨기기</a></li>
        <li><a id="btnExParent">확장(원본)</a></li>
        <li><a id="btnExChild">확장</a></li>
        <li><a id="btnReParent">재구현(원본)</a></li>
        <li><a id="btnReChild">재구현</a></li>
    </ul>
</div>




<div class="tableDiv" style="display: none; width: 100%;">
    <table>

        <colgroup>
            <col width="9%"/>
            <col width="15%"/>
            <col width="35%"/>
            <col width="9%"/>
            <col width="9%"/>
            <col width="9%"/>
            <col width="9%"/>
        </colgroup>

        <thead>

        <tr>

            <th>주간랭킹</th><%--주간조회수랭킹--%>
            <th>게임</th>
            <th></th>
            <th>테마</th>
            <th>평점</th>
            <th>난이도</th>
            <th>조회수</th>

        </tr>

        </thead>

        <tbody>

        </tbody>

    </table>
</div>


<script>
    $(function() {
        var gnum = ${param.gnum};
        var exParentCount = 0, exChildCount = 0, reParentCount = 0, reChildCount = 0;

        // AJAX 요청 함수
        function getExRe(param, successCallback) {
            $.ajax({
                url: "${path}/game/getExReAjax",
                type: "POST",
                data: JSON.stringify(param),
                contentType: "application/json",
                success: successCallback,
                error: function() {
                    console.log("에러...");
                }
            });
        }

        // 카운트 숫자를 버튼 태그에 업데이트하는 함수
        function updateButtonTags() {
            $("#btnExParent").text("확장[원본] (" + exParentCount + ")");
            $("#btnExChild").text("확장 (" + exChildCount + ")");
            $("#btnReParent").text("재구현[원본] (" + reParentCount + ")");
            $("#btnReChild").text("재구현 (" + reChildCount + ")");
        }


        function updateTableWithParam(param) {
            // 테이블 표시 및 업데이트하는 코드...
            $(".tableDiv").show(); // 테이블 보이도록 설정
            // 테이블의 tbody 선택
            var tbody = $('.tableDiv table tbody');

            // tbody 초기화
            tbody.empty();

            // 필요한 데이터 가져오기 (비동기 작업을 동기적으로 처리하는 예시)
            getExRe(param, function(map) {
                if (map.list.length < 1) {
                    var tableempty = '<tr>';
                    tableempty += '<td colspan="7"><strong>';
                    tableempty += '해당 조건에 만족하는 게임이 존재하지 않습니다.';
                    tableempty += '</strong></td>'
                    tableempty += '</tr>';

                    tbody.append(tableempty);
                } else {
                    // result 값으로 행을 추가
                    for (var i = 0; i < map.list.length; i++) {
                        var row = map.list[i];
                        var rate = Number(row.rate).toFixed(1);
                        var weight = Number(row.weight).toFixed(1);
                        var tableRow = '<tr>';
                        tableRow += '<td><p>' + row.game_rank + '</p></td>';
                        tableRow += '<td id="imgTd">';
                        // 게임 이미지 로직 추가
                        if (row.gamephoto_url != null) {
                            tableRow += '<img src="${path}/resources/updated_game' + row.gamephoto_url + '" onerror="this.src=\'${path}/images/game/no-image-icon.png\'" width="70px" height="70px">';
                        } else {
                            if (row.bgg_thumbnail != null) {
                                tableRow += '<img src="' + row.bgg_thumbnail + '" onerror="this.src=\'${path}/images/game/no-image-icon.png\'" width="70px" height="70px"';
                            } else {
                                tableRow += '<img src="${path}/images/game/no-image-icon.png" width="70px" height="70px">';
                            }
                        }
                        tableRow += '</td>';
                        tableRow += '<td><a href="${path}/game/view.do?gnum=' + row.gnum + '">' + row.gametitle + '<br>(' + row.gametitle_eng + ')</a></td>';
                        tableRow += '<td>' + row.category + '</td>';
                        if (row.rate != null && row.rate != "") {

                            tableRow += '<td><strong>'+ rate +'</strong>(' + row.tot + ')</td>';
                        } else {
                            tableRow += '<td><strong>-</strong></td>';
                        }
                        if (row.weight != null && row.weight != "") {
                            tableRow += '<td><strong>'+ weight +'</strong>(' + row.tot + ')</td>';
                        } else {
                            tableRow += '<td><strong>-</strong></td>';
                        }
                        tableRow += '<td>' + row.totalviewcount + '</td>';
                        tableRow += '</tr>';

                        tbody.append(tableRow);
                    }
                }
            });
        }

        // 초기 로딩 시 카운트 숫자를 가져오는 AJAX 요청
        getExRe({ "num": gnum, "filter": "ex", "origin": "parent" }, function(map) {
            exParentCount = map.list.length;
            updateButtonTags(); // 버튼 태그 업데이트
        });

        getExRe({ "num": gnum, "filter": "ex", "origin": "child" }, function(map) {
            exChildCount = map.list.length;
            updateButtonTags(); // 버튼 태그 업데이트
        });

        getExRe({ "num": gnum, "filter": "re", "origin": "parent" }, function(map) {
            reParentCount = map.list.length;
            updateButtonTags(); // 버튼 태그 업데이트
        });

        getExRe({ "num": gnum, "filter": "re", "origin": "child" }, function(map) {
            reChildCount = map.list.length;
            updateButtonTags(); // 버튼 태그 업데이트
        });

        $("#btnHidden").click(function() {
            //
            $(".tableDiv").hide();
        });

        // 클릭 이벤트 핸들러 등록
        $("#btnExParent").click(function() {
            var param = {
                "num": gnum,
                "filter": "ex",
                "origin": "parent"
            };
            updateTableWithParam(param);
        });

        $("#btnExChild").click(function() {
            var param = {
                "num": gnum,
                "filter": "ex",
                "origin": "child"
            };
            updateTableWithParam(param);
        });

        $("#btnReParent").click(function() {
            var param = {
                "num": gnum,
                "filter": "re",
                "origin": "parent"
            };
            updateTableWithParam(param);
        });

        $("#btnReChild").click(function() {
            var param = {
                "num": gnum,
                "filter": "re",
                "origin": "child"
            };
            updateTableWithParam(param);
        });

        // 초기 테이블 숨김 처리
        $(".tableDiv").hide();

        $('.game_detail_filter_div ul li').click(function() {
            // 다른 요소의 스타일 초기화
            $('.game_detail_filter_div ul li').removeClass('active');

            // 현재 클릭된 요소에 대한 스타일 변경
            $(this).addClass('active');
        });
    });
</script>