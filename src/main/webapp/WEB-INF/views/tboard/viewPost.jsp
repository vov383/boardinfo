<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="../include/js/header.jsp" %>
    <script src="${path}/include/js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript">
        $(function () {
            //댓글 목록 출력
            getReplies();

            //댓글 쓰기
            $("#btnCommentInsert").on("click", function () {
                let form = $(this).closest("form");
                let content = form.find('textarea[name="content"]');
                content.val(content.val().trim());
                if (content.val() == "") {
                    return;
                }
                let queryString = form.serialize() + "&tb_num=" + "${dto.tb_num}";

                $.ajax({
                    type: "get",
                    url: "${path}/tbComment/insert.do",
                    data: queryString,
                    success: function (result) {
                        if (result) {
                            content.val("");
                            listReply();
                        } else {
                            alert("댓글 달기 실패");
                        }
                    },
                    error: function () {
                        alert("댓글 달기 실패");
                    }
                });
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

                            let date = new Date(re_list[i].create_date);
                            let formattedDate = new Date(date + 3240 * 10000).toISOString().replace('T', ' ').replace(/\..*/, '');
                            //3240 * 10000 milliseconds === 9h

                            let createDateDiv = $("<div>").addClass("create_date").text(formattedDate);

                            userInfoDiv.append(userProfileDiv);
                            userInfoDiv.append(userNickNameDiv);
                            userInfoDiv.append(userIdDiv);
                            userInfoDiv.append(createDateDiv);
                            replyUpperDiv.append(userInfoDiv);

                            let replyContent = $('<div>').addClass('replyContent').text(re_list[i].content);

                            let replySubDiv = $('<div>').addClass('replySub');
                            let leftDiv = $('<div>').addClass('left');
                            let leftButtonDiv = $('<div>').addClass('button');
                            //에러날 수 있는 곳
                            let childInsertLink = $('<a>').addClass('editReply').prop("href", "javascript:showChildReplyForm(" + re_list[i].reply_reg_num + ")");
                            let childReplyImg = $("<img>").attr({
                                src : "${path}/images/reply_arrow.png",
                                width : "15px"
                            });
                            childInsertLink.append(childReplyImg);
                            leftButtonDiv.append(childInsertLink);
                            leftDiv.append(leftButtonDiv);

                            let rightDiv = $('<div>').addClass('right');
                            let rightButtonDiv = $('<div>').addClass('button');
                            //에러날 수 있는 곳
                            let replyEditLink= $('<a>').addClass('insertChildReply').prop("href", "javascript:showChildReplyForm(" + re_list[i].reply_reg_num + ")");

                            let replyEditImg = $("<img>").attr({
                                src : "${path}/images/trade/changeBtn.png",
                                width : "30px"
                            });
                            replyEditLink.append(replyEditImg);
                            rightButtonDiv.append(replyEditLink);
                            rightDiv.append(rightButtonDiv);

                            replySubDiv.append(leftDiv);
                            replySubDiv.append(rightDiv);

                            reply.append(replyUpperDiv);
                            reply.append(replyContent);
                            reply.append(replySubDiv);

                            <%--//대댓글 들여쓰기--%>
                            <%--if (re_list[i].reply_parent_reg_num > 1) {--%>
                            <%--    reply.addClass("childReply");--%>
                            <%--    create_user.html("<img width='10px' style='margin-right: 7px;'" +--%>
                            <%--        "src='${path}/images/re_reply.png'" + ">" + create_user.text());--%>
                            <%--    create_user.css("padding-left", (re_list[i].reply_parent_reg_num * 18) + "px");--%>
                            <%--    content.css("padding-left", (re_list[i].reply_parent_reg_num * 18) + "px");--%>
                            <%--}--%>


                            replyList.append(reply);
                        }

                    }//리스트를 뷰에 추가하는 건 끝
                    $("#countReplies").text(re_list.length == null ? 0 : re_list.length);

                }, error: function () {
                    $("#countReplies").text(0);
                }//문제가 여기서 서 step into 하면 터져버림
            });//ajax 끝
        } //listReply() 끝

        //대댓글
        function showChildReplyForm(reply_reg_num) {
            $("form[class='childReplyForm']").remove();

            let childCommentForm = $("<form>").addClass("childCommentForm")
                .attr({
                    name: "childCommentForm",
                    action: "${path}/tbComment/childCommentInsert.do"
                });

            let textArea = $("<textarea>").attr({
                name: "content"
            });

            let input = $("<input>").attr({
                type: "hidden",
                name: "reply_parent_reg_num",
                value: reply_reg_num
            });

            let button = $("<button>").attr({
                type: "button",
                class: "btnChildCommentInsert"
            }).text("댓글쓰기");

            childCommentForm.append(textArea, input, button);
            $("#" + reply_reg_num).append(childCommentForm);
        }

        //댓글 수정
        function editChildReplyForm(reply_reg_num) {
            $("form[class='childReplyForm']").remove();

            let childCommentForm = $("<form>").addClass("childCommentForm")
                .attr({
                    name: "childCommentForm",
                    action: "${path}/tbComment/childCommentInsert.do"
                });
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
                <div class="button"><a class="btnChange"><img src="${path}/images/trade/changeBtn.png}"></a></div>
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
                        <li>거래장소</li>
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
                        <li>${dto.price}</li>
                    </ul>
                </div>
            </section>

            <section class="descriptionSection">
                <div id="description" name="description">
                    ${dto.description}
                </div>
                <div id="meeting_place" name="meeting_place">
                    약속장소 영역
                    <c:if test="${dto.meeting_place != null }">
                        약속장소 : ${dto.meeting_place}
                    </c:if>
                </div>
                <div id="descriptionSub">
                    <ul>
                        <li>
                            <a href=".replyList"><img src="${path}/images/trade/uncheckedHeart.png" alt="관심등록"></a>관심
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
                    <textarea name="content" id="replyContent" cols="30" rows="10"></textarea>
                    <div class="button"><a id="btnCommentInsert"><img src="${path}/images/trade/insertReplyBtn.png"></a>
                    </div>
                </form>

            </section>

            <div class="listAndEdit">
                <div class="left">
                    <div class="button"><a href="${path}/tboard/list.do"><img
                            src="${path}/images/trade/listBtn.png"></a></div>
                </div>
                <div class="right">
                    <div class="button"><a href="${path}/tboard/change.do"><img
                            src="${path}/images/trade/changeBtn.png}" alt=""></a></div>
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