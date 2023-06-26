<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <%@ include file="../include/js/header.jsp" %>
    <link rel="stylesheet" href="${path}/include/css/trade/updatePost.css">
    <!-- ckeditor의 라이브러리 -->
    <script src="${path}/ckeditor/ckeditor.js"></script>

    <!-- 카카오 지도 api -->
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaa4a3ee6e039439424a544717323d1a&libraries=services">

    </script>

    <script type="text/javascript">
        $(function () { //자동으로 실행되는 코드
            // debugger
            //목록 버튼
            $("#btnList").click(function () {
                location.href = "${path}/tboard/list.do";
            });

            //삭제 버튼
            $("#btnDelete").click(function () {
                if (confirm("삭제하시겠습니까?")) {
                    document.mainForm.action = "${path}/tboard/delete.do";
                    document.mainForm.submit();
                }
            });
            /*라디오 버튼 checked 구현*/
            let categoryValue = ${map.dto.category};

            function changeCheckedValue(categoryValue) {
                var radios = document.getElementsByName("category");

                for (var i = 0; i < radios.length; i++) {
                    if (radios[i].value === categoryValue) {
                        radios[i].checked = true;
                    } else {
                        radios[i].checked = false;
                    }
                }
            }

            /*나눔 카테고리 누르면 input[name=price] 안보이게*/
            let priceVisible = true;
            $('input[name=category]').change(function () {
                if ($("input[name=category]:checked").val() == "n") {
                    $("#price").css("visibility", "hidden");
                    $("#price").val(0);
                    priceVisible = false;
                } else {
                    if (!priceVisible) {
                        $("#price").css("visibility", "visible");
                        $("#price").val("");
                        priceVisible = true;
                    }
                }
            });

        });

        /* dom요소가 다 실행되고 나면 실행되는 함수 */
        window.onload = function () {
            /* 이미지 목록 출력 */
            let tb_num = ${map.dto.tb_num};
            /* 비동기 방식으로 첨부파일 가져옴... */
            $.ajax({
                url: "${path}/tboard/getAttach",
                method: "get",
                data: {"tb_num": tb_num},
                dataType: "json",
                success: function (result) {
                    /* 이미지 fullName으로 반복 */
                    $.each(result, function (index, fullName) {
                        /* img element 생성하고 src 설정하기
                        * src에 대한 설명 => DB에는 이미지 파일이 경로와 s_가 더해져서 썸네일 파일명이 저장됨.
                        * fullName.substring(0, 12)는 디렉토리
                        * fullName.substring(14)는 s_를 뺀 나머지 uuid가 적용된 파일명 */
                        var image = $("<img>").attr('src', '${path}/resources/uploaded_image' + fullName.substr(0, 12) + fullName.substr(14));

                        /* imgSection에 image를 append */
                        $(".imgSection").append(image);
                    });
                },
                error: function (xhr, status, error) {
                    alert("AJax Fail");
                }
            }); //이미지 목록 ajax End

        };

        function formSubmit() {
            // debugger
            let title = $("#title").val().trim();
            $("#title").val(title);
            if (title == '') {
                alert('제목을 입력하세요');
                $("#title").focus();
                window.scrollTo(0, 0);
                return;
            }

            if (CKEDITOR.instances.description.getData().length < 1) {
                alert("상품 설명을 입력해 주세요.");
                return;
            }

            document.mainForm.action = "${path}/tboard/insert.do";
            document.mainForm.submit();
        }

        /*지도 검색*/
        function locationSearch() {

            let top = screen.availHeight / 2 - 290;
            if (top < 0) top = 0;

            let left = screen.availWidth / 2 - 410;
            if (left < 0) left = 0

            window.open("${path}/gathering/locationSearch.do", "날짜검색 - 모임모집", "left=" + left + ", top=" + top + ", width=820, height=580");
        }

        /* 주소 리셋 */
        function locationReset() {
            let locations = ["locationFull", "address1", "address2", "address3", "place_name", "lat", "lng", "centerAddr"];
            for (let i = 0; i < locations.length; i++) {
                document.getElementById(locations[i]).value = null;
            }
        }

    </script>
</head>
<body>
<header>
    <%@include file="../include/top.jsp" %>
</header>
<div id="contents">
    <div id="contentsHeader">
        <span class="h2">
            글 수정
        </span>
        <div class="btnContainer">
            <button type="button" id="btnList">목록</button>
        </div>
    </div>
    <div id="contentsMain">
        <form id="mainForm" name="mainForm" method="post" enctype="multipart/form-data">
            <input type="hidden" name="tb_num" id="tb_num" value="${map.dto.tb_num}">
            <div class="postUpper">
                <div id="categoryContainer">
                    <span>카테고리</span>
                    <input type="radio" id="s" name="category" value="s"
                           <c:if test='${map.dto.category.equals("s") }'>checked</c:if>
                    >
                    <label for="s">
                        <div class="category">판매</div>
                    </label>
                    <div class="dot"></div>
                    <input type="radio" id="b" name="category" value="b" <c:if test='${map.dto.category.equals("b")}'>checked</c:if>
                    >
                    <label for="b">
                        <div class="category">구매</div>
                    </label>
                    <div class="dot"></div>
                    <input type="radio" id="n" name="category" value="n"
                           <c:if test='${map.dto.category.equals("n") }'>checked</c:if>
                    >
                    <label for="n">
                        <div class="category">나눔</div>
                    </label>
                    <div class="dot"></div>
                    <input type="radio" id="f" name="category" value="f"
                           <c:if test='${map.dto.category.equals("s") }'>checked</c:if>
                    >
                    <label for="f">
                        <div class="category">완료</div>
                    </label>
                </div>
                <div class="inputContainer">
                    <input name="title" id="title" placeholder="제목" value="${map.dto.title}" maxlength="100">
                    <input name="price" id="price" placeholder="가격" value="${map.dto.price}" maxlength="100">
                </div>
            </div>
            <section class="imgSection">
            </section>

            <section class="imageContainer">
                <label class="label" id="label" for="input">
                    <div class="inner" id="inner">드래그하거나 클릭해서 업로드</div>
                </label>
                <input id="input" class="input" accept="image/*" type="file" name="files" multiple="true" hidden="true">
                <p class="preview-title">미리보기</p>
                <div class="preview" id="preview"></div>
            </section>

            <div id="postMain">
                <textarea id="description" name="description" placeholder="상품설명을 자유롭게 적어보세요"
                >${map.dto.description}</textarea>
                <script>
                    CKEDITOR.replace("description", {
                        filebrowserUploadUrl: "${path}/tupload/imageUpload.do"
                    });
                </script>
            </div>
            <%--거래 희망 장소--%>
            <div class="placeContainer">
                <div id="placeUpper">
                    <div>
                        <div class="map_wrap">
                            <div id="map"></div>
                            <div class="hAddr">
                                <span class="title">주소정보</span>
                                <span id="centerAddr"></span>
                            </div>
                        </div>
                    </div>

                    <script>
                        var mapContainer = document.getElementById('map'); // 지도를 표시할 div

                        var mapOption =
                            {
                                center: new kakao.maps.LatLng("${map.dto.lat}", "${map.dto.lng}"), // 지도의 중심좌표
                                level: 3 // 지도의 확대 레벨
                            };

                        // 지도를 생성합니다
                        var map = new kakao.maps.Map(mapContainer, mapOption);

                        // 주소-좌표 변환 객체를 생성합니다
                        var geocoder = new kakao.maps.services.Geocoder();

                        var imageSrc = 'https://img.freepik.com/icones-gratuites/espace-reserve_318-556820.jpg?w=360', // 마커이미지의 주소입니다
                            imageSize = new kakao.maps.Size(44, 48); // 마커이미지의 크기입니다

                        // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
                        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                        let mainMarker;

                        // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
                        var infowindow = new kakao.maps.InfoWindow({
                            zIndex: 4,
                            disableAutoPan: true
                        });

                        var infoDiv = document.getElementById('centerAddr');


                        makeMap("${map.dto.lat}", "${map.dto.lng}");

                        function makeMap(lat, lan) {
                            mapOption =
                                {
                                    center: new kakao.maps.LatLng(lat, lan), // 지도의 중심좌표
                                    level: 4 // 지도의 확대 레벨
                                };

                            // 지도를 생성합니다
                            map = new kakao.maps.Map(mapContainer, mapOption);

                            //마커 생성
                            const markerPosition = new window.kakao.maps.LatLng(lat, lan);

                            //마커 생성
                            mainMarker = new window.kakao.maps.Marker({
                                position: markerPosition,
                                image: markerImage
                            });

                            mainMarker.setMap(map);
                            mainMarker.setZIndex(3);

                            // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
                            searchDetailAddrFromCoords(map.getCenter(), displayCenterInfo);
                        }

                        function searchDetailAddrFromCoords(coords, callback) {
                            // 좌표로 법정동 상세 주소 정보를 요청합니다
                            geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
                        }

                        //지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
                        function displayCenterInfo(result, status) {
                            if (status === kakao.maps.services.Status.OK) {
                                infoDiv.innerHTML = result[0].address.address_name;

                                let content = "";

                                if ("${map.dto.place_name}" != null && "${map.dto.place_name}" != "") {
                                    content = "<div id='infoWindow'><span>" + "${map.dto.place_name}" + "</span></div>";
                                } else
                                    content = '<div id="infoWindow"><span>' + result[0].address.address_name + '</span></div>';

                                var position = new kakao.maps.LatLng("${map.dto.lat}", "${map.dto.lng}");
                                var customOverlay = new kakao.maps.CustomOverlay({
                                    position: position,
                                    content: content,
                                    xAnchor: 0.5, // 커스텀 오버레이의 x축 위치입니다. 1에 가까울수록 왼쪽에 위치합니다. 기본값은 0.5 입니다
                                    yAnchor: 2.6 // 커스텀 오버레이의 y축 위치입니다. 1에 가까울수록 위쪽에 위치합니다. 기본값은 0.5 입니다
                                });

                                customOverlay.setMap(map);
                                map.setCenter(customOverlay.getPosition());
                            }
                        }
                    </script>
                </div>
            </div>
            <div class="labelAndItem"><span>장소</span>
                <input class="flex" disabled id="locationFull">
                <div class="dot"></div>
                <input type="text" name="address1" id="address1" value="${map.dto.address1}">
                <input type="text" name="address2" id="address2" value="${map.dto.address2}">
                <input type="text" name="address3" id="address3" value="${map.dto.address3}">
                <input type="text" name="place_name" id="place_name" value="${map.dto.place_name3}">
                <input type="hidden" name="lat" id="lat" value="${map.dto.lat}">
                <input type="hidden" name="lng" id="lng" value="${map.dto.lng}">
                <button type="button" id="locationSearchBtn" onclick="locationSearch()">검색</button>
                <div class="dot"></div>
                <button type="button" id="locationResetBtn" onclick="locationReset()">초기화</button>
            </div>
    </div>
    <div class="btnContainer" style="display: flex; justify-content: center">
        <button type="button" id="btn-submit" onclick="submit()">등록</button>
        <div class="dot"></div>
        <button type="button" id="btnDelete">삭제</button>
        <div class="dot"></div>
        <button type="button" id="btn-reset">돌아가기</button>
    </div>
</div>
</form>
</div>
</div>
<footer>
    <%@include file="../include/footer.jsp" %>
</footer>
</body>
<script src="${path}/include/js/imgDragNdrop.js"></script>
</html>