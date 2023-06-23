<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <%@ include file="../include/js/header.jsp" %>
    <link rel="stylesheet" href="${path}/include/css/trade/write.css">
    <script src="${path}/include/js/common.js"></script>

    <script src="${path}/include/js/jquery-3.6.3.min.js"></script>
    <script src="${path}/include/js/imgDragNdrop.js"></script>
    <!-- ckeditor의 라이브러리 -->
    <script src="${path}/ckeditor/ckeditor.js"></script>

    <!-- 카카오 지도 api -->
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaa4a3ee6e039439424a544717323d1a&libraries=services">

    </script>

    <style type="text/css">
        .fileDrop {
            width: 100%;
            height: 100px;
            border: 1px dotted gray;
            background-color: #f0f0f0;
        }

        .map_wrap {
            position: relative;
        }

        .title {
            font-weight: bold;
            display: block;
        }

        .hAddr {
            /*position:absolute;*/
            right: 10px;
            bottom: 10px;
            border-radius: 2px;
            background: #fff;
            background: rgba(255, 255, 255, 0.8);
            z-index: 1;
            padding: 5px;
        }

        #centerAddr {
            display: block;
            margin-top: 2px;
            font-weight: normal;
        }

        #infoWindow {
            background-color: white;
            border: 1px solid black;
            border-radius: 6px;
            padding: 10px 10px;
        }

        #infoWindow > span {
            display: block;
            line-height: 16px;
            max-width: 300px;
            word-break: break-all;
        }

        #postInfo {
            text-align: right;
            padding-bottom: 5px;
        }

        #postInfo > span {
            padding: 0 10px;
            border-right: 1px solid black;
        }

        #postUpper {
            display: flex;
            border-top: 2px solid black;
        }

        #postUpper > div:first-of-type {
            padding: 30px 0;
        }

        #map {
            width: 400px;
            height: 280px;
            border: 1px solid black;
            text-align: center;
            line-height: 257px;
            overflow: hidden;
            position: relative;
        }

        .status {
            width: 85px;
            border: 1px solid black;
            border-radius: 10px;
            padding: 0 10px;
            margin-right: 6px;
        }
    </style>
    <script>

        $(function () {
            //목록 버튼
            $("#btnList").on("click", function () {
                location.href = "${path}/tboard/list.do";
            });

            // //파일을 마우스로 드래그해서 업로드 영역에 올릴 때 파일이 열리는 기본효과 막는 처리
            $(".fileDrop").on("dragenter dragover", function (e) {
                e.preventDefault(); //얘가 막는 처리
            });

            //마우스로 파일을 드롭할 때 파일이 열리는 기본효과 막음.. 이건 따로 처리 need
            $(".fileDrop").on("drop", function (e) {
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
                    success: function (data) {
                        //data : 업로드한 파일 정보와 Http
                        let fileInfo = getFileInfo(data);
                        console.log(fileInfo);

                        let html = "<div><a href='" + fileInfo.getLink + "'>"
                            + fileInfo.fileName + "</a><br>"
                            + "<img src='" + fileInfo.getLink + "'>";
                        html += "<input type='hidden' class='file' value='"
                            + fileInfo.fullName + "'>";
                        html += "<a href='#' class='file_del' data-src='"
                            + this + "'>[삭제]</a></div>";
                        $("#uploadedList").append(html);
                    }
                });
            });

            //첨부파일 삭제
            //id가 uploadedList인 태그의 class가 file_del인 태그 클릭
            $("#uploadedList").on("click", ".file_del", function (e) {
                let that = $(this); //this는 현재 클릭한 태그
                //data: {fileName: $(this).attr("data-src") },
                $.ajax({
                    type: "post",
                    url: "${path}/upload/deleteFile",
                    data: "fileName=" + $(this).attr("data-src"),
                    dataType: "text",
                    success: function (result) {
                        if (result == "deleted") {
                            //화면에서 태그 제거
                            that.parent("div").remove();
                        }
                    }
                });
            });

            /*카테고리 나눔 누르면 가격 사라지는 버튼*/
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


        function insert() {
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

            document.insertForm.action = "${path}/tboard/insert.do";
            document.insertForm.submit();
        }

        function locationSearch() {

            let top = screen.availHeight / 2 - 290;
            if (top < 0) top = 0;

            let left = screen.availWidth / 2 - 410;
            if (left < 0) left = 0

            window.open("${path}/gathering/locationSearch.do", "날짜검색 - 모임모집", "left=" + left + ", top=" + top + ", width=820, height=580");
        }
        function locationReset() {
            let locations = ["locationFull", "address1", "address2", "address3", "place_name", "lat", "lng", "centerAddr"];
            for(let i=0; i<locations.length; i++) {
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
            글쓰기
        </span>
        <div class="btnContainer">
            <button type="button" id="btnList">목록</button>
        </div>
    </div>
    <div id="contentsMain">
        <form id="insertForm" name="insertForm" method="post" enctype="multipart/form-data">
            <div class="postUpper">
                <div id="categoryContainer">
                    <span>카테고리</span>
                    <input type="radio" id="s" name="category" value="s" checked="checked">
                    <label for="s">
                        <div class="category">판매</div>
                    </label>
                    <div class="dot"></div>
                    <input type="radio" id="b" name="category" value="b">
                    <label for="b">
                        <div class="category">구매</div>
                    </label>
                    <div class="dot"></div>
                    <input type="radio" id="n" name="category" value="n">
                    <label for="n">
                        <div class="category">나눔</div>
                    </label>
                </div>
                <div class="inputContainer">
                    <input name="title" id="title" placeholder="제목" maxlength="100">
                    <input name="price" id="price" placeholder="가격" maxlength="100">
                </div>
            </div>

            <section class="imageContainer">
                <label class="label" id="label" for="input">
                    <div class="inner" id="inner">드래그하거나 클릭해서 업로드</div>
                </label>
                <input id="input" class="input" accept="image/*" type="file" name="files" multiple="true" hidden="true">
                <p class="preview-title">미리보기</p>
                <div class="preview" id="preview"></div>
            </section>

            <div id="postMain">
                <textarea id="description" name="description" placeholder="상품설명을 자유롭게 적어보세요"></textarea>
                <script>
                    CKEDITOR.replace("description", {
                        filebrowserUploadUrl: "${path}/tupload/imageUpload.do"
                    });
                </script>
            </div>
            <%--거래 희망 장소--%>
            <div class="placeContainer">
                <div class="map_wrap">
                    <div id="tmpDiv"><span>직거래를 원하시면 장소를 입력하세요.</span></div>
                    <div id="map"></div>
                    <div class="hAddr">
                        <span class="title">주소정보</span>
                        <span id="centerAddr"></span>
                    </div>
                </div>
                <script>

                    let mapContainer = document.getElementById('map'); // 지도를 표시할 div

                    let mapOption =
                        {
                            center: new kakao.maps.LatLng(37.4989347355231, 127.032854329609), // 지도의 중심좌표
                            level: 1 // 지도의 확대 레벨
                        };

                    // 지도를 생성합니다
                    let map = new kakao.maps.Map(mapContainer, mapOption);

                    // 주소-좌표 변환 객체를 생성합니다
                    let geocoder = new kakao.maps.services.Geocoder();

                    let imageSrc = 'https://img.freepik.com/icones-gratuites/espace-reserve_318-556820.jpg?w=360', // 마커이미지의 주소입니다
                        imageSize = new kakao.maps.Size(44, 48); // 마커이미지의 크기입니다

                    // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
                    let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                    let mainMarker;

                    let infoDiv = document.getElementById('centerAddr');

                    let lat, lng;


                    function makeMap(getLat, getLng) {

                        lat = getLat;
                        lng = getLng;
                        mapOption =
                            {
                                center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
                                level: 4 // 지도의 확대 레벨
                            };

                        // 지도를 생성합니다
                        map = new kakao.maps.Map(mapContainer, mapOption);

                        //마커 생성
                        let markerPosition = new window.kakao.maps.LatLng(lat, lng);

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

                    /*
                    function searchAddrFromCoords(coords, callback) {
                      // 좌표로 행정동 주소 정보를 요청합니다
                      geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
                    }
                    */

                    function searchDetailAddrFromCoords(coords, callback) {
                        // 좌표로 법정동 상세 주소 정보를 요청합니다
                        geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
                    }

                    //지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
                    function displayCenterInfo(result, status) {
                        if (status === kakao.maps.services.Status.OK) {
                            infoDiv.innerHTML = result[0].address.address_name;

                            var content = "";

                            if ($("#place_name").val() != "") {
                                content = '<div id="infoWindow"><span>' + $("#place_name").val() + '</span></div>';
                            } else {
                                content = '<div id="infoWindow"><span>' + result[0].address.address_name +
                                    ' ' + $("#place_name").val() + '</span></div>';
                            }

                            var position = new kakao.maps.LatLng(lat, lng);
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
                <div>
                    <div class="labelAndItem"><span>장소</span>
                        <input class="flex" disabled id="locationFull">
                        <div class="dot"></div>
                        <input type="hidden" name="address1" id="address1">
                        <input type="hidden" name="address2" id="address2">
                        <input type="hidden" name="address3" id="address3">
                        <input type="hidden" name="place_name" id="place_name">
                        <input type="hidden" name="lat" id="lat">
                        <input type="hidden" name="lng" id="lng">
                        <button type="button" id="locationSearchBtn" onclick="locationSearch()">검색</button>
                        <div class="dot"></div>
                        <button type="button" id="locationResetBtn" onclick="locationReset()">초기화</button>
                    </div>
                </div>
                <div class="btnContainer" style="display: flex; justify-content: center">
                    <button type="button" id="btn-submit" onclick="insert()">등록</button>
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
<script>

</script>
</body>
<script src="${path}/include/js/imgDragNdrop.js"></script>
</html>