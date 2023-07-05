<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
    <meta charset="UTF-8">
    <title>보드인포</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <!--
    <link rel="stylesheet" href="${path}/include/css/trade/viewPost.css">
    -->
    <%@ include file="../include/js/header.jsp" %>

    <style>
        a {
            color: #41464b;
            text-decoration: none;
        }
        button {
            font-size: .9em;
            padding: 8px 10px;
            white-space: nowrap;
            background-color: #f0f0f0;
            border: none;
            border-radius: 8px;
            height: 100%;

        }
        #contentsMain{
            border-top: 2px solid black;

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

        #map {
            width: 400px;
            height: 280px;
            border: 1px solid black;
            text-align: center;
            line-height: 257px;
            overflow: hidden;
            position: relative;
        }


        section {
            width: 100%;
        }


        #contentsMain * li {
            list-style-type: none;
        }

        .listAndEdit{
            display: flex;
            flex-direction: row;
            justify-content: center;
        }
        .button{
            font-size: .9em;
            padding: 8px 10px;
            white-space: nowrap;
            background-color: #f0f0f0;
            border-radius: 8px;
            height: 100%;
        }
        .imgSection {
            display: flex;
            flex-direction: column;
            box-sizing: border-box;
            /*position: relative;*/
            height: auto;
            /*background: #E5E5E5;*/
        }


        .imgController {
            display: flex;
            flex-direction: row;
        }

        .imgCarousel {
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            position: relative;
            width: 400vw;
            left: 40px;
            top: 0px;
            overflow: hidden;
            transition: transform 0.5s;
        }

        .innerImg {
            width: 100vw;
        }

        .moveImgLeft {
            align-items: center;
            padding: 0px;
            gap: 10px;
        }
        .moveImgRight{
            align-items: center;
            padding: 0px;
            gap: 10px;
        }
        .imgSlideNav{
            align-items: center;
        }

        .titleSection {
            display: flex;
            flex-direction: column;
            box-sizing: border-box;

            position: relative;
            height: auto;
        }

        .profileAndNickName{
            justify-content: right;
            display: flex;
            padding: 5px;
        }

        .profileAndNickName .left {
            display: flex;
            align-items: center;
            justify-content: flex-start;
        }

        .profile .userImg {
            flex: 0 0 26px;
            margin-right: 5px;
            /*background-color: var(--default-background-color);*/
            background-position: center;
            background-size: cover;
            border-radius: 50%;
        }


        .profileAndNickName .nickName {
            position: relative;
            display: flex;
            align-items: center;
            cursor: pointer;
        }

        .dot {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 14px;
            height: 100%;
        }

        .categoryAndTitle {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .categoryAndTitle .category {
            font-size: .9em;
            padding: 8px 10px;
            white-space: nowrap;
            background-color: #f0f0f0;
            border-radius: 8px;
            height: 100%;
        }

        .categoryAndTitle .category span {
            padding: 10px 0px;
            white-space: nowrap;
        }
        .categoryAndTitle .title h1 {
            display: inline;
            /*color: var(--default-font-color);*/
            word-break: break-word;
        }
        .price {
            display: flex;
            color : #ff8a3d;
        }
        .descriptionSection {
            display: flex;
            flex-direction: column;
            box-sizing: border-box;
            position: relative;
            height: auto;

        }

        #description {

        }

        .descriptionSub {
            display: flex;
            flex-direction: column;

        }

        #meeting_place {

        }

        .descriptionSub ul {
            display: flex;
            flex-direction: column;
            border: 1px solid rgb(85, 196, 115);
        }

        .viewCount svg {
            width: 12px;
            height: 12px;
            margin-right: 4px;
        }

        .fa-comment-dots:before, .fa-commenting:before {
            content: "\f4ad";
            margin-right: 4px;
        }
        .otherItemList {
            box-sizing: border-box;
            position: relative;
            height: auto;
        }

        .otherItemContainer {

        }

        .replySection {

        }

        #replyList {
            box-sizing: border-box;
            position: relative;
            height: auto;

            /*background: #E5E5E5;*/
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 2px;
        }

        .reply {
            display: flex;
            flex: 1;
            flex-direction: column;
            gap: 3px;
            align-items: baseline;
        }

        .replyUpper {
            display: flex;
        }
        .replyUpper .userInfo {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            font-size : .9em;
            white-space: nowrap;
            margin-bottom: 5px;
        }
        .userInfo > div {
            padding-right: 4px;
        }
        .replyUpper .userProfile {
            flex: 0 0 32px;
            width: 32px;
            height: 32px;
            margin-right: 3px;
            /*background-color: var(--default-background-color);*/
            background-position: center;
            background-size: cover;
            border-radius: 50%;
        }

        /*댓글 목록 안에 댓글 내용*/
        .reply .replyContent {
            flex: .9;
            margin-left: 32px;
        }

        .replySub {
            display: flex;
            flex-direction: row;
            align-items: center;
        }

        .replyContainer {
            display: flex;
            flex: 1;
            flex-direction: column;
            gap: 10px;
        }

        .contentContainer {
            display: flex;
            flex-direction: column;
            margin-top: 3px;
            border-radius: 8px;
        }

        .replyInput {
            display: flex;
            flex-direction: row;
            align-items: flex-end;
        }


        .replyInput textarea {/*background: #E5E5E5;*/
            flex: 1;
            width: 100%;
            height: 90px;
            font-size: 1em;
            /*color: var(--default-font-color);*/
            resize: none;
            background-color: #f3f7fb;
        }
        form[name=newReplyForm] .replyContent {

        }

        form[name=newReplyForm] .submit {
            flex: .2;
            font-size: .8em;
            height: 60px;
            box-sizing: border-box;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .reply form textarea[name=content] {
            flex: 1;
            width: 100%;
            height: 90px;
            font-size: 1em;
            /*color: var(--default-font-color);*/
            resize: none;
            background-color: #f3f7fb;

        }


        /*케러셀 이미지 사이즈 조정*/
        .carousel-item {
            height: 50vh; /* Adjust the desired height using viewport height */
            width: 100%; /* Take up the full width of the container */
        }
        .carousel-item img {
            max-height: 100%; /* Maintain aspect ratio and fill the carousel item */
            width: auto; /* Let the width adjust based on the image aspect ratio */
        }

        /*이미지 없다는 메시지*/
        .noImgMsg {
            height: 15vh;
        }

    </style>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <script src="${path}/include/js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript">

        $(function () {
            /* 댓글 목록 출력 */
            getReplies();

            /*좋아요 체크*/
            var likeChecked = false;

            checkLikeStatus();

            /*
            댓글 쓰기
            $(".클래스명).on("click", function(){} 로 시도했을 때는
            동적으로 생성된 Form에 이벤트가 안 넣어졌다.
            $(document).on("click", ".btnCommentInsert", function () {} 를 써서 document가 스스로 이벤트를 핸들링하도록 만들었다.
            */
            $(document).on("click", ".btnCommentInsert", function () {
                let form = $(this).closest("form");
                let content = form.find('textarea[name="content"]');
                content.val(content.val().trim());
                if (content.val() == "") {
                    return;
                }
                let queryString = form.serialize() + "&tb_num=" + "${map.dto.tb_num}";

                $.ajax({
                    type: "get",
                    url: "${path}/tbComment/insertReply.do",
                    data: queryString,
                    success: function (result) {
                        if (result) {
                            content.val("");
                            getReplies();
                        } else {
                            alert("댓글 달기 실패");
                        }
                    },
                    error: function (request, status, error) {
                        alert("댓글 달기 실패");
                    }
                });
            });
            /*댓글 수정버튼*/
            $(document).on("click", ".btnReplyEdit", function () {
                let form = $(this).closest("form");
                let content = form.find('textarea[name="content"]').val();
                let reply_reg_num = form.find('input[name="reply_reg_num"]').val();
                content = content.trim();
                if (content == "") {
                    alert("댓글 내용을 작성하세요");
                    return;
                }
                // changeReply()
                /*
                여기 ajax request 보내면 바로 error로 직행. editReply.do 에서 400에러.. data로 보낼 queryString에 있던 오타때문
                queryString 지워버리고 data를 키밸류 쌍으로 보냄
                해결 완료
                다음은 Maximum call stack size exceeded
                재귀함수 스택 초과때문
                data 를 보낼 때 val()을 보내야하는데 html element를 보내려고 하니까 없는 value를 참조하려고 빙빙 순환하면서 stackoverflow
                해결완료
                */
                $.ajax({
                    type: "get",
                    url: "${path}/tbComment/editReply.do",
                    data: {
                        "reply_reg_num": reply_reg_num,
                        "content": content
                    },
                    success: function (result) {
                        //DB에서 delete했으면 true 리턴
                        if (result) {
                            alert("댓글 수정 성공");
                            replyChangeFormVisible = false;
                            getReplies();
                        } else {
                            alert("댓글 수정 실패");
                        }
                    },
                    error: function () {
                        alert("댓글 수정 실패");
                    }
                });
            });
            /* 댓글 삭제 버튼 */
            $(document).on("click", ".btnReplyDelete", function () {
                let form = $(this).closest("form");
                let reply_reg_num = form.find('input[name="reply_reg_num"]').val();
                if (confirm("삭제하시겠습니까?")) {
                    $.ajax({
                        type: "get",
                        url: "${path}/tbComment/deleteReply.do",
                        data: {
                            "reply_reg_num": reply_reg_num
                        },
                        success: function (result) {
                            if (result) {
                                alert("삭제되었습니다.");
                                childCommentFormVisible = false;
                                getReplies();
                            } else {
                                alert("삭제실패");
                            }
                        },
                        error: function () {
                            alert("삭제실패");
                        }

                    });
                }
            });
            /*댓글 수정 취소 버튼*/
            $(document).on("click", ".btnCancel", function () {
                let form = $(this).closest("form");
                let reply_reg_num = form.find('input[name="reply_reg_num"]').val();
                changeReply(reply_reg_num);
            });

            /* 분문 수정버튼 */
            $(".btnChange").on("click", function () {
                let tb_num = ${map.dto.tb_num};
                location.href = "${path}/tboard/change.do?tb_num=" + tb_num;
            });
            /* 로그인버튼 */
            $("#btnMoveLogin").on("click", function() {
                location.href = "${path}/member/member_login.do?message=nologin";
            });

        });
        /* dom요소가 다 실행되고 나면 실행되는 함수 */
        window.addEventListener('load', function () {
            /* 이미지 목록 출력 */
            let tb_num = ${map.dto.tb_num};
            /* 비동기 방식으로 첨부파일 가져옴... */
            $.ajax({
                url: "${path}/tboard/getAttach",
                method: "get",
                data: {"tb_num": tb_num},
                dataType: "json",
                success: function (result) {
                    /*이미지 경로는 result에 ArrayList로 담겨있음.*/

                    /*이미지 경로에서 '/_s' 를 모두 '/' 로 replace*/
                    var originalFullName = result.map(function (fullName) {
                        return fullName.replace('/s_', '/');
                    });

                    /*상품 이미지가 없는 경우*/
                    if(originalFullName.length === 0){
                        var imgSection = document.getElementById('imgSection');
                        imgSection.innerHTML = '<div class="noImgMsg h4">첨부된 이미지가 없습니다.<div>'
                        return;
                    }

                    /*부스트스랩 캐러셀 인디케이터 html 태그를 동적으로 생성*/

                    var indicatorsHtml = '';
                    originalFullName.forEach(function (fullName, index) {
                        var isActive = (index === 0) ? 'active' : '';
                        indicatorsHtml += '<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="' + index + '" class="' + isActive + '" aria-current="true" aria-label="Slide ' + (index + 1) + '"></button>\n';
                    });

                    /*부트스트랩 아이템 태그 생성*/
                    var itemsHtml = '';
                    originalFullName.forEach(function (fullName, index) {
                        var isActive = (index === 0) ? 'active' : '';
                        itemsHtml += '<div class="carousel-item ' + isActive + '">\n';
                        itemsHtml += '  <img src="' + '${path}/resources/uploaded_image' + fullName + '" class="d-block w-100" alt="...">\n';
                        itemsHtml += '</div>\n';
                    });

                    // carouselHtml에 indicatorsHtml 과 itemsHtml 태그를 결합시켜.
                    var carouselHtml = '<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">\n' +
                        '  <div class="carousel-indicators">\n' +
                        indicatorsHtml +
                        '  </div>\n' +
                        '  <div class="carousel-inner">\n' +
                        itemsHtml +
                        '  </div>\n' +
                        '  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">\n' +
                        '    <span class="carousel-control-prev-icon" aria-hidden="true"></span>\n' +
                        '    <span class="visually-hidden">Previous</span>\n' +
                        '  </button>\n' +
                        '  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">\n' +
                        '    <span class="carousel-control-next-icon" aria-hidden="true"></span>\n' +
                        '    <span class="visually-hidden">Next</span>\n' +
                        '  </button>\n' +
                        '</div>';

                    // carouselHtml을 imgSection 에 결합시켜
                    var imgSection = document.getElementById('imgSection');
                    imgSection.innerHTML = carouselHtml;


                    /*이미지 경로는 result에 ArrayList로 담겨있음.*/

                    /*이미지 경로에서 '/_s' 를 모두 '/' 로 replace*/
                    var originalFullName = result.map(function (fullName) {
                        return fullName.replace('/s_', '/');
                    });

                    /*부스트스랩 캐러셀 인디케이터 html 태그를 동적으로 생성*/
                    /*부트스트랩 아이템 태그 생성*/
                    var itemsHtml = '';
                    originalFullName.forEach(function (fullName, index) {
                        var isActive = (index === 0) ? 'active' : '';
                        itemsHtml += '<div class="carousel-item ' + isActive + '">\n';
                        itemsHtml += '  <img src="' + '${path}/resources/uploaded_image' + fullName + '" class="d-block w-80" alt="...">\n';
                        itemsHtml += '</div>\n';
                    });

                },
                error: function (xhr, status, error) {
                    alert("이미지 목록 가져오기 실패");
                }
            }); //이미지 목록 ajax End
        });// window.addEventListener('load', function(){}); End

        /*댓글 목록 출력 함수*/
        function getReplies() {

            $.ajax({
                type: "get",
                url: "${path}/tbComment/replyList.do",
                data: {tb_num: "${map.dto.tb_num}"},
                success: function (result) {

                    let re_list = result.re_list;
                    if (re_list != null && re_list.length > 0) {

                        const replyList = $("#replyList");
                        replyList.empty();

                        for (let i = 0; i < re_list.length; i++) {
                            let reply = $("<div>").addClass("reply").attr("id", re_list[i].reply_reg_num);
                            let delCheck = re_list[i].del;
                            if (delCheck === 'Y') {
                                //댓글 상단
                                let replyUpperDiv = $('<div>').addClass('replyUpper');
                                //댓글 본문
                                let replyContent = $('<div>').addClass('replyContent').text('삭제된 댓글입니다.');

                                //댓글 하단
                                let replySubDiv = $('<div>').addClass('replySub');

                                //대댓글 들여쓰기
                                if (re_list[i].depth > 0) {
                                    reply.addClass("childReply");
                                    let childReplyImg = $("<img>").attr("src='${path}/images/re_reply.png'");
                                    replyUpperDiv.append(childReplyImg);

                                    replyUpperDiv.css("padding-left", (re_list[i].depth * 18) + "px");
                                    replyContent.css("padding-left", (re_list[i].depth * 18) + "px");
                                    replySubDiv.css("padding-left", (re_list[i].depth * 18) + "px");

                                }

                                reply.append(replyUpperDiv);
                                reply.append(replyContent);
                                reply.append(replySubDiv);
                            } else {
                                //일반 댓글
                                let replyUpperDiv = $('<div>').addClass('replyUpper');

                                let userInfoDiv = $("<div>").addClass("userInfo");
                                let userProfileDiv = $("<div>").addClass("userProfile");
                                let userNickNameDiv = $("<div>").addClass("userNickName");
                                let userIdDiv = $("<div>").addClass("create_user").attr("id", re_list[i].create_user).text(re_list[i].create_user);

                                //기본 프로필 이미지 추가(추후 member에 프사 가져오는 방식으로 변경
                                let userProfileImg = $("<img>").attr({
                                    src: "${path}/uploaded_image${map.re_list.profile}",
                                    width: "15px",
                                    class: "profile"
                                });
                                userProfileDiv.append(userProfileImg);

                                let date = new Date(re_list[i].create_date);
                                let formattedDate = new Date(date + 3240 * 10000).toISOString().replace('T', ' ').replace(/\..*/, '');
                                //3240 * 10000 milliseconds === 9h

                                let createDateDiv = $("<div>").addClass("create_date").text(formattedDate);

                                //userInfoDiv 완성시킴
                                userInfoDiv.append(userProfileDiv);
                                userInfoDiv.append(userNickNameDiv);
                                userInfoDiv.append(userIdDiv);
                                userInfoDiv.append(createDateDiv);

                                //댓글 본문
                                let replyContent = $('<div>').addClass('replyContent');
                                replyContent.text(re_list[i].content);
                                //댓글 내용에 index id 부여
                                replyContent.attr("id", re_list[i].reply_reg_num + "_replyContent");

                                //댓글 하단
                                let replySubDiv = $('<div>').addClass('replySub');
                                let leftDiv = $('<div>').addClass('left');
                                let leftButtonDiv = $('<div>').addClass('button');

                                //jquery에서 attr()과 prop()의 결과는 같은데 attr() 로 href=''를 정의하는 것이 일반적이라고 하네요.
                                //attribute는 속성, property는 상태라서 그런듯?
                                let childInsertLink = $('<a>').addClass('insertChildReply').attr("href", "javascript:showChildCommentForm(" + re_list[i].reply_reg_num + ")");

                                childInsertLink.html('<i class="fa-solid fa-reply"></i>대댓글');
                                leftButtonDiv.append(childInsertLink);
                                leftDiv.append(leftButtonDiv);

                                let rightDiv = $('<div>').addClass('right');
                                let rightButtonDiv = $('<div>').addClass('button');

                                let replyChangeLink = $('<a>').addClass('changeReply').prop("href", "javascript:changeReply(" + re_list[i].reply_reg_num + ")");

                                replyChangeLink.html('<i class="fa-regular fa-comment-dots"></i>수정|삭제');
                                rightButtonDiv.append(replyChangeLink);
                                rightDiv.append(rightButtonDiv);
                                replySubDiv.append(leftDiv);
                                replySubDiv.append(rightDiv);

                                //대댓글 들여쓰기
                                if (re_list[i].depth > 0) {
                                    reply.addClass("childReply");
                                    childReplyImg = $("<img>").attr("src='${path}/images/re_reply.png'");
                                    replyUpperDiv.append(childReplyImg);
                                    replyUpperDiv.append(userInfoDiv);

                                    replyUpperDiv.css("padding-left", (re_list[i].depth * 18) + "px");
                                    replyContent.css("padding-left", (re_list[i].depth * 18) + "px");
                                    replySubDiv.css("padding-left", (re_list[i].depth * 18) + "px");

                                } else {
                                    replyUpperDiv.append(userInfoDiv);
                                }

                                reply.append(replyUpperDiv);
                                reply.append(replyContent);
                                reply.append(replySubDiv);

                            }//delCheck if else End
                            /*댓글 목록에 reply 추가*/
                            replyList.append(reply);
                        }//for문 end

                    }//리스트를 뷰에 추가하는 건 끝
                    /*댓글 개수*/
                    $("#countReplies").text(re_list.length == null ? 0 : re_list.length);

                }, error: function () {
                    $("#countReplies").text(0);
                }
            });//ajax 끝

        }

        // 대댓글 form이 보이는지 여부를 체크할 변수
        let childCommentFormVisible = false;

        // 대댓글 폼 펼치고 접는 함수
        function showChildCommentForm(reply_reg_num) {
            let childCommentForm = $("form.childCommentForm");

            if (childCommentFormVisible) {
                childCommentForm.remove();
                //id선택자의 후손 선택자의 css를 조작
                alert("대댓글 입력을 취소했습니다.");
                childCommentFormVisible = false;
            } else {
                $.ajax({
                    type: "get",
                    url: "${path}/tbComment/loginCheck",
                    success: function(response){
                        if(response.status === "success"){
                            let newChildCommentForm = $("<form>")
                                .addClass("childCommentForm")
                                .attr({
                                    name: "childCommentForm",
                                    action: "${path}/tbComment/InsertReply.do"
                                });

                            let textArea = $("<textarea>").attr({
                                name: "content",
                            });

                            let input = $("<input>").attr({
                                type: "hidden",
                                name: "mother_reply",
                                value: reply_reg_num
                            });

                            let button = $("<button>")
                                .attr({
                                    type: "button",
                                    class: "btnCommentInsert"
                                }).text("대댓글 등록");

                            newChildCommentForm.append(textArea, input, button);

                            $("#" + reply_reg_num).append(newChildCommentForm);
                            childCommentFormVisible = true;
                        }else{
                            alert(response.message);
                            childCommentFormVisible = true;
                        }
                    },
                    error: function(response){
                        alert("ajax 실패");
                        childCommentFormVisible = true;
                    }
                });
            }

        }

        //댓글 수정
        let replyChangeFormVisible = false;

        function changeReply(reply_reg_num) {
            if (replyChangeFormVisible) {
                $(".replyChangeForm").remove();
                //id선택자의 후손 선택자의 css를 조작
                $("#" + reply_reg_num + "_replyContent").css({
                    display: "block"
                });
                alert("댓글 수정을 취소했습니다.");
                replyChangeFormVisible = false;
                return;
            } else {
                replyChangeFormVisible = true;

                //여기에서 ajax 요청이 실패가 나면서 form이 안 만들어짐
                //changeReply.do 에서 400 에러 -> 대부분 ajax syntax에러
                $.ajax({
                    type: "get",
                    url: "${path}/tbComment/changeReply.do",
                    data: {
                        "reply_reg_num": reply_reg_num
                    },
                    success: function (result) {
                        /*ajax get요청에 대한 결과가 성공이면*/
                        if (result.status === "success") {
                            let reply_reg_num = result.reDto.reply_reg_num;
                            let content = result.reDto.content;
                            let replyChangeForm = $("<form>").addClass("replyChangeForm").attr({
                                name: "replyChangeForm"
                            });

                            replyChangeForm.attr({
                                name: "replyChangeForm"
                            });
                            let input = $("<input>").attr({
                                type: "hidden",
                                name: "reply_reg_num"
                            }).val(reply_reg_num);

                            let textArea = $("<textarea>").attr({
                                name: "content",
                            }).val(content);
                            let editButton = $("<button>")
                                .attr({
                                    type: "button",
                                    class: "btnReplyEdit"
                                }).text("수정완료");
                            let deleteButton = $("<button>").attr({
                                type: "button",
                                class: "btnReplyDelete"
                            }).text("삭제");
                            let cancelButton = $("<button>").attr({
                                type: "button",
                                class: "btnCancel"
                            }).text("취소");
                            /*만든 form 내부 요소들 한번에 append*/
                            replyChangeForm.append(input, textArea, editButton, deleteButton, cancelButton);

                            //여기서 form을 추가하면 textArea의 value인 content 가 사라지는 에러 발생
                            //jquery로 값을 할당할 때는 .attr()에 value : 로 할당하는 것이 아니라 .val()을 사용한다.
                            $("#" + reply_reg_num).append(replyChangeForm);

                            /*기존 댓글 내용 부분은 안 보이게*/
                            $("#" + reply_reg_num + "_replyContent").css({
                                display: "none"
                            });

                        }//result.status가 success일 경우 End
                        else{
                            //result.status가 failure일 경우
                            replyChangeFormVisible = false;
                            alert(result.message);
                        }
                    },
                    /*ajax get요청 자체가 실패한 경우*/
                    error: function () {
                        replyChangeFormVisible = false;
                        alert("실패!");
                    }
                });//ajax End

            } // 대댓글 form visible if else End

        } //changeReply() End

        /*좋아요 체크하는 함수*/
        function checkLikeStatus() {
            let likeItBtn = document.getElementById("likeItBtn");
            let tb_num = ${map.dto.tb_num};
            $.ajax({
                type: "get",
                url: "${path}/tboard/likeCheck.do",
                data: {
                    "tb_num" : tb_num
                },
                success: function(result){
                    if(result === "unchecked"){
                        likeChecked = false;
                        likeItBtn.innerHTML = '<i class="fa-regular fa-heart" style="color: #eb0a0a;"></i>';
                    }else if(result === "checked"){
                        likeChecked = true;
                        likeItBtn.innerHTML = '<i class="fa-solid fa-heart" style="color: #eb0a0a;"></i>';
                    }
                },
                error: function(result){
                    alert("ajax 에러");
                }
            });
        }

        /*좋아요 함수*/
        function likeIt(tb_num) {
            let likeItBtn = document.getElementById("likeItBtn");
            let goodCountSpan = document.getElementById("good_count_container");
            /*좋아요 수*/
            let goodCount = parseInt(goodCountSpan.innerText);

            $.ajax({
                type: "get",
                url : "${path}/tboard/addLike.do",
                data: {
                    "tb_num" : tb_num
                },
                success : function(response){
                    if(response.status === "fail") {
                        alert(response.message);
                    }else if(response.status === "likeCheck"){
                        likeChecked = true;

                        likeItBtn.innerHTML = '<i class="fa-solid fa-heart" style="color: #eb0a0a;"></i>';
                        /*좋아요 수 +1*/
                        goodCount = goodCount + 1;
                        goodCountSpan.innerText = goodCount;


                    }else if(response.status === "likeDelete"){
                        likeChecked = false;
                        likeItBtn.innerHTML = '<i class="fa-regular fa-heart" style="color: #eb0a0a;"></i>';
                        /*좋아요 수 -1*/
                        goodCount = goodCount - 1;

                        goodCountSpan.innerText = goodCount;
                    }
                    checkLikeStatus(); /*좋아요 상태 체크*/
                },
                error : function(response){
                    alert(response.message);
                }
            });//ajax End

        }//좋아요 함수 end

    </script>
</head>
<body>
<header>

    <%@include file="../include/top.jsp" %>

    <div id="contents">
        <div id="contentsHeader">
            <h2>중고장터</h2>
        </div>
        <div id="contentsLocation">
            홈 &gt 중고장터 &gt ${map.dto.title}
        </div>
        <div id="contentsMain">

            <section class="titleSection">

                <div class="categoryAndTitle">
                    <div class="category">
                        <c:choose>
                            <c:when test="${map.dto.category eq '판매'}">
                                판매
                            </c:when>
                            <c:when test="${map.dto.category eq '구매'}">
                                구매
                            </c:when>
                            <c:when test="${map.dto.category eq '나눔'}">
                                나눔
                            </c:when>
                            <c:otherwise>
                                완료
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="title">${map.dto.title}</div>
                    <div class="price">
                        ${map.dto.price}<div class="dot"></div><span>원</span>
                    </div>

                </div>

                <div class="profileAndNickName">
                    <div class="left">
                        <div class="userImg"><a class="userProfile"><img src="${path}/resources/uploaded_image${map.dto.profile}"></a></div>
                        <div class="dot"></div>
                        <div class="nickName"><a class="userNickName">${map.dto.nickname}(${map.dto.create_user})</a></div>
                        <div class="dot"></div>
                        <div class="dateTime"><i class="fa-regular fa-timer"></i>
                            ${map.dto.create_date}
                        </div>
                        <div class="dot"></div>
                    </div>
                </div>

            </section>

            <section class="descriptionSection">
                <div id="description" name="description">
                    ${map.dto.description}
                </div>
                <section class="imgSection" id="imgSection">
                </section>
                <%--주소 정보가 있을 때와 없을 때--%>
                <c:choose>
                    <c:when test='${map.dto.address1 ne null}'>
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

                                <script type="text/javascript"
                                        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaa4a3ee6e039439424a544717323d1a&libraries=services"></script>
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
                                <div class="addressContainer">
                                    <ul>
                                        <li>
                                            장소:&nbsp;&nbsp;${map.dto.address1} ${map.dto.address2} ${map.dto.address3}</li>
                                        <li>${map.dto.place_name}</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="placeContainer">
                            지정된 거래 장소가 없습니다.
                        </div>
                    </c:otherwise>
                </c:choose>

                <div id="descriptionSub">
                    <div class="interestCount">
                        <a id="likeItBtn" href="#" onclick="likeIt(${map.dto.tb_num})">
                            <%-- fontawsome 하트 모양 --%>
                            <i class="fa-regular fa-heart" style="color: #eb0a0a;"></i>
                        </a>
                        <span id="good_count_container">
                            ${map.dto.good_count}
                        </span>
                    </div>

                    <div class="viewCount">
                        <%-- fontawsome 눈 모양 --%>
                        <%--<i class="fa-solid fa-eye"></i>--%>
                        ${map.dto.view_count}
                    </div>
                    <%-- fontawsome 댓글 모양 --%>
                    <i class="fa-regular fa-comment-dots"></i>
                    <%-- 댓글 개수 출력 영역 --%>
                    <span id="countReplies"></span>
                </div>
            </section>

            <section class="otherItemList">
                <p>작성자 님의 다른 상품 목록</p>
                <div class="otherItemContainer">
                    <div class="otherItemCard">

                    </div>
                </div>
                <button onclick="viewMoreItem('${map.dto.create_user}')">더보기
                </button>
                <div class="moreOtherItem"></div>
            </section>

                <div class="listAndEdit">
                    <div class="left">
                        <div class="button"><a href="${path}/tboard/list.do">목록</a></div>
                    </div>
                    <div class="dot"></div>
                    <div class="right">
                        <div class="button"><a class="btnChange">수정|삭제</a></div>
                    </div>
                </div>


                <section class="replySection">
                <div id="replyList"></div>

                <div class="replyContainer">
                    <div class="contentContainer">
                        <form name="newReplyFrom">
                            <input type="hidden" name="tb_num" value="${map.dto.tb_num}">
                            <div class="replyInput">
                                <div class="replyContent">
                                    <textarea name="content" class="replyContent" cols="30" rows="10"></textarea>
                                </div>
                                <div class="button">
                                    <a href="#" class="btnCommentInsert">댓글등록</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </section>

            <div class="listAndEdit">
                <div class="left">
                    <div class="button"><a href="${path}/tboard/list.do">목록</a></div>
                </div>
                <div class="dot"></div>
                <div class="right">
                    <div class="button"><a class="btnChange">수정|삭제</a></div>
                </div>
            </div>
        </div>
    </main>
    </div>

<footer>
    <%@ include file="../include/footer.jsp" %>
</footer>
</body>
</html>