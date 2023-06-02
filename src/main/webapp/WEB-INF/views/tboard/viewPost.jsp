<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="../include/js/header.jsp" %>
    <link rel="stylesheet" href="${path}/include/css/trade/viewPost.css">
    <script src="${path}/include/js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript">
        $(function () {
            //댓글 목록 출력
            getReplies();

            //댓글 쓰기
            //$(".클래스명).on("click", function(){} 로 시도했을 때는
            //동적으로 생성된 Form에 이벤트가 안 넣어졌다.
            //$(document).on("click", ".btnCommentInsert", function () {} 를 써서 document가 스스로 이벤트를 핸들링하도록 만들었다.
            $(document).on("click", ".btnCommentInsert", function () {
                let form = $(this).closest("form");
                let content = form.find('textarea[name="content"]');
                content.val(content.val().trim());
                if (content.val() == "") {
                    return;
                }
                let queryString = form.serialize() + "&tb_num=" + "${dto.tb_num}";

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
                    error: function () {
                        alert("댓글 달기 실패");
                    }
                });
            });
            //댓글 수정버튼
            $(document).on("click", ".btnReplyEdit", function () {
                let form = $(this).closest("form");
                let content = form.find('textarea[name="content"]').val();
                let reply_reg_num = form.find('input[name="reply_reg_num"]').val();
                content = content.trim();
                if (content == "") {
                    return;
                }
                //여기 ajax request 보내면 바로 error로 직행. editReply.do 에서 400에러.. data로 보낼 queryString에 있던 오타때문
                //queryString 지워버리고 data를 키밸류 쌍으로 보냄
                //해결 완료
                //다음은 Maximum call stack size exceeded
                //재귀함수 스택 초과때문
                //data 를 보낼 때 val()을 보내야하는데 html element를 보내려고 하니까 없는 value를 참조하려고 빙빙 순환하면서 stackoverflow
                //해결완료
                $.ajax({
                    type: "get",
                    url: "${path}/tbComment/editReply.do",
                    data: {
                        "reply_reg_num" : reply_reg_num,
                        "content" : content
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
            //댓글 삭제 버튼
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

            //수정버튼
            $(".btnChange").on("click", function () {
                let tb_num = ${dto.tb_num};
                location.href = "${path}/tboard/change.do?tb_num=" + tb_num;
            });
            //로그인버튼
            $("#btnMoveLogin").on("click", function () {
                location.href = "${path}/member/member_login.do?message=nologin";
            });
        });


        //댓글 목록 출력 함수
        function getReplies() {

            $.ajax({
                type: "get",
                url: "${path}/tbComment/replyList.do",
                data: {tb_num: "${dto.tb_num}"},
                success: function (result) {

                    let re_list = result.re_list;
                    if (re_list != null && re_list.length > 0) {

                        const replyList = $("#replyList");
                        replyList.empty();

                        for (let i = 0; i < re_list.length; i++) {
                            let reply = $("<div>").addClass("reply").attr("id", re_list[i].reply_reg_num);

                            let replyUpperDiv = $('<div>').addClass('replyUpper');

                            let userInfoDiv = $("<div>").addClass("userInfo");
                            let userProfileDiv = $("<div>").addClass("userProfile");
                            let userNickNameDiv = $("<div>").addClass("userNickName");
                            let userIdDiv = $("<div>").addClass("create_user").attr("id", re_list[i].create_user).text(re_list[i].create_user);

                            //기본 프로필 이미지 추가(추후 member에 프사 가져오는 방식으로 변경
                            let userProfileImg = $("<img>").attr({
                                src: "${path}/images/trade/defaultProfile.png",
                                width: "15px"
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
                            let replyContent = $('<div>').addClass('replyContent').text(re_list[i].content);

                            //댓글 하단
                            let replySubDiv = $('<div>').addClass('replySub');
                            let leftDiv = $('<div>').addClass('left');
                            let leftButtonDiv = $('<div>').addClass('button');

                            //jquery에서 attr()과 prop()의 결과는 같은데 attr() 로 href=''를 정의하는 것이 일반적이라고 하네요.
                            //attribute는 속성, property는 상태라서 그런듯?
                            let childInsertLink = $('<a>').addClass('insertChildReply').attr("href", "javascript:showChildCommentForm(" + re_list[i].reply_reg_num + ")");

                            let childReplyImg = $("<img>").attr({
                                src: "${path}/images/reply_arrow.png",
                                width: "15px"
                            });
                            childInsertLink.append(childReplyImg);
                            leftButtonDiv.append(childInsertLink);
                            leftDiv.append(leftButtonDiv);

                            let rightDiv = $('<div>').addClass('right');
                            let rightButtonDiv = $('<div>').addClass('button');

                            let replyChangeLink = $('<a>').addClass('changeReply').prop("href", "javascript:changeReply(" + re_list[i].reply_reg_num + ")");

                            let replyChangeImg = $("<img>").attr({
                                src: "${path}/images/trade/changeBtn.png",
                                width: "30px"
                            });
                            replyChangeLink.append(replyChangeImg);
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

                            replyList.append(reply);
                        }

                    }//리스트를 뷰에 추가하는 건 끝
                    $("#countReplies").text(re_list.length == null ? 0 : re_list.length);

                }, error: function () {
                    $("#countReplies").text(0);
                }
            });//ajax 끝
        }

        // Initialize the flag variable
        let childCommentFormVisible = false;

        // Show or hide the child comment form based on its visibility
        function showChildCommentForm(reply_reg_num) {
            let childCommentForm = $("form.childCommentForm");

            if (childCommentFormVisible) {
                childCommentForm.remove();
                childCommentFormVisible = false;
            } else {
                childCommentFormVisible = true;

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
                    }).text("댓글쓰기");

                newChildCommentForm.append(textArea, input, button);

                $("#" + reply_reg_num).append(newChildCommentForm);
            }

        }

        //댓글 수정
        let replyChangeFormVisible = false;

        function changeReply(reply_reg_num) {

            if (replyChangeFormVisible) {
                $(".replyChangeForm").remove();
                //id선택자의 후손 선택자의 css를 조작
                $("#" + reply_reg_num + ".replyContent").css({
                    display: "block"
                });
                alert("댓글 수정을 취소했습니다.");
                replyChangeFormVisible = false;
                return;
            } else {
                replyChangeFormVisible = true;
                $("#" + reply_reg_num + ".replyContent").css({
                    display: "none"
                });

                //여기에서 ajax 요청이 실패가 나면서 form이 안 만들어짐
                //changeReply.do 에서 400 에러 -> 대부분 ajax syntax에러
                $.ajax({
                    type: "get",
                    url: "${path}/tbComment/changeReply.do",
                    data: {
                        "reply_reg_num": reply_reg_num
                    },
                    success: function (result) {

                        let reply_reg_num = result.reply_reg_num;
                        let content = result.content;
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

                        replyChangeForm.append(input, textArea, editButton, deleteButton);

                        //여기서 form을 추가하면 textArea의 value인 content 가 사라지는 에러 발생
                        //jquery로 값을 할당할 때는 .attr()에 value : 로 할당하는 것이 아니라 .val()을 사용한다.
                        $("#" + reply_reg_num).append(replyChangeForm);
                    },
                    error: function () {
                        replyChangeFormVisible = false;
                        alert("실패!");
                    }
                });
            }
        }
    </script>
</head>
<body>
<header>
    <%@include file="../include/top.jsp" %>
</header>
<div id="contents">
    <main>
        <div id="contentsHeader">
            <h2>게시물 보기</h2>
        </div>
        <div class="listAndEdit">
            <div class="left">
                <div class="button"><a href="${path}/tboard/list.do"><img src="${path}/images/trade/listBtn.png"></a>
                </div>
            </div>
            <div class="right">
                <div class="button"><a class="btnChange"><img src="${path}/images/trade/changeBtn.png"></a></div>
            </div>
        </div>
        <div id="contentsMain">
            <section class="imgSection">
                <div class="imgController">
                    <div class="moveImgLeft">
                        <a id="slideLeftBtn"><img src="${path}/images/trade/moveToLeftImgBtn.png"></a>
                    </div>
                    <div class="imgCarousel">
                        <div class="innerImg">
                        </div>
                    </div>
                    <div class="moveImgRight">
                        <a id="slideRightBtn"><img src="${path}/images/trade/moveToRightImgBtn.png"></a>
                    </div>
                </div>
                <nav class="imgSlideNav">
                    <ul>
                        <li class="imgList"></li>
                    </ul>
                </nav>
            </section>
            <section class="titleSection">
                <div class="userInfo">
                    <ul>
                        <li>
                            <a class="userProfile"><img src="${path}/images/trade/defaultProfile.png" alt="유저 프로필 사진"></a>
                        </li>
                        <li>
                            <a class="userNickName">유저 닉네임(${dto.create_user})</a>
                        </li>
                        <li>
                            <div class="meeting_place">ㅁㅁ구 ㅇㅇ동</div>
                        </li>
                    </ul>
                </div>
                <div id="titleContainer">
                    <ul>
                        <li>
                            <c:choose>
                                <c:when test="${dto.category == 's'}">
                                    <img alt="판매" src="${path}/images/trade/sell.png">
                                </c:when>
                                <c:when test="${dto.category == 'b'}">
                                    <img alt="구매" src="${path}/images/trade/buy.png">
                                </c:when>
                                <c:when test="${dto.category == 'n'}">
                                    <img alt="나눔" src="${path}/images/trade/nanum.png">
                                </c:when>
                                <c:otherwise>
                                    <img alt="거래완료" src="${path}/images/trade/trade_fin.png">
                                </c:otherwise>
                            </c:choose>
                        </li>
                        <li>${dto.title}</li>
                        <li><fmt:formatDate value="${dto.create_date}" pattern="yyyy-MM-dd hh:mm:ss"/>
                        </li>
                        <li>${dto.price}원</li>
                    </ul>
                </div>
            </section>

            <section class="descriptionSection">
                <div id="description" name="description">
                    ${dto.description}
                </div>
                <div id="meeting_place" name="meeting_place">
                    <c:if test="${dto.meeting_place != null }">
                        약속장소 : ${dto.meeting_place}
                    </c:if>
                </div>
                <div id="descriptionSub">
                    <ul>
                        <li>
                            <a href="#"><img src="${path}/images/trade/uncheckedHeart.png" alt="관심등록"></a>
                            관심
                            count
                        </li>
                        <li>조회수 : ${dto.view_count}</li>
                        <li>
                            댓글[<span id="countReplies"></span>]
                        </li>
                    </ul>
                </div>
            </section>

            <section class="otherItemList">
                <p>작성자 님의 다른 상품 목록</p>
                <div class="otherItemContainer">
                </div>
                <button onclick="viewMoreItem('${dto.create_user}')"><img src="${path}/images/trade/moreBtn.png">
                </button>
                <div class="moreOtherItem"></div>
            </section>
            <section class="replySection">
                <div id="replyList"></div>

                <form name="replyFrom">
                    <input type="hidden" name="tb_num" value="${dto.tb_num}">
                    <textarea name="content" class="replyContent" cols="30" rows="10"></textarea>
                    <div class="button"><a class="btnCommentInsert"><img src="${path}/images/trade/insertReplyBtn.png"></a>
                    </div>
                </form>

            </section>

            <%-- 댓글 구조 설명하려고 만든 곳 이따 지워야함 --%>
            <div class="reply" id="${re_dto.reply_reg_num}">
                <div class="replyUpper">
                    <div class="userInfo">
                        <div class="userProfile">
                            <img src="" alt="">
                        </div>
                    </div>
                    <div class="userNickName"></div>
                    <div class="create_date"></div>
                </div>
                <div class="replyMain">
                    <div class="replyContent"></div>
                </div>
                <div class="replySub">
                    <div class="left">
                        <div class="button">
                            <a href="">
                                <img src="" alt="">
                            </a>
                        </div>
                    </div>
                    <div class="right">
                        <div class="button">
                            <a href="">
                                <img src="" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="listAndEdit">
                <div class="left">
                    <div class="button"><a href="${path}/tboard/list.do"><img
                            src="${path}/images/trade/listBtn.png"></a></div>
                </div>
                <div class="right">
                    <div class="button"><a class="btnChange"><img
                            src="${path}/images/trade/changeBtn.png" alt=""></a></div>
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