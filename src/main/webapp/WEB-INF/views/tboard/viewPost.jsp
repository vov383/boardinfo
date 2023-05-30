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
            listReply();

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
            $("#btnChange").on("click", function () {
                let tb_num = ${dto.tb_num};
                location.href = "${path}/tboard/change.do?tb_num=" + tb_num;
            });
            $("#btnList").on("click", function () {
                location.href = "${path}/tboard/list.do";
            });
            $("#btnMoveLogin").on("click", function () {
                location.href = "${path}/member/member_login.do?message=nologin";
            });
        });


        //댓글 목록 출력 함수
        function listReply() {

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

                            let create_user = $("<span>").text(re_list[i].create_user);
                            let content = $("<div>").text(re_list[i].content);

                            if (re_list[i].reply_parent_reg_num != null) {
                                reply.addClass("childReply");
                                create_user.html("<img width='10px' style='margin-right: 7px;'" +
								"src='${path}/images/re_reply.png'"+ ">" + create_user.text());
                                create_user.css("padding-left", (re_list[i].reply_parent_reg_num * 18) + "px");
                                content.css("padding-left", (re_list[i].reply_parent_reg_num * 18) + "px");
                            }

                            let bigDiv = $("<div>");
                            let smallDiv = $("<div>");
                            let childReplyBtnSpan = $("<span>").addClass("insertChildReply");
                            let link = $("<a>").prop("href", "javascript:showChildReplyForm(" + re_list[i].reply_reg_num + ")").text("답글");

                            let date = new Date(re_list[i].create_date);
                            let formattedDate = new Date(date + 3240 * 10000).toISOString().replace('T', ' ').replace(/\..*/, '');
                            //3240 * 10000 milliseconds === 9h

                            let dateSpan = $("<span>").text(formattedDate);
                            let childReplyBtnImg = $("<img>").attr({
                                src: "${path}/images/trade/insertChildReplyBtn.png",
                                width: "30px"
                            });

                            childReplyBtnSpan.append(childReplyBtnImg, link);
                            smallDiv.append(dateSpan, childReplyBtnSpan);
                            bigDiv.append(create_user, smallDiv);
                            reply.append(bigDiv, content);

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
            <div class="viewPostBtnContainer">
                <a role="button" href="${path}/tboard/list.do" id="btnList"><img src="${path}/images/trade/listBtn.png"
                                                                                 alt="목록버튼"></a>
                <a role="button" href="#" id="btnChange"><img src="${path}/images/trade/changeReplyBtn.png" alt=""></a>
            </div>
        </div>
        <div id="contentsMain">
            <form name="btnChange" action="" method="post">
                <input type="hidden" name="tb_num" value="${dto.tb_num}">
            </form>
            <section class="imgSection">
                <div class="imgController">
                    <div class="moveImgLeft">
                        <a href="#"><img src="${path}/images/trade/moveToLeftImgBtn.png"></a>
                    </div>
                    <div class="imgCarousel">
                        <div class="innerImg">
                            <img src="${path}/images/trade/pig_012.jpg" alt="">
                        </div>
                        <div class="innerImg">
                            <img src="${path}/images/trade/pig_029.jpg" alt="">
                        </div>
                        <div class="innerImg">
                            <img src="${path}/images/trade/pig_045.jpg" alt="">
                        </div>
                    </div>
                    <div class="moveImgRight">
                        <a href="#"><img src="${path}/images/trade/moveToRightImgBtn.png"></a>
                    </div>
                </div>
                <div class="imgSlideNav">
                    이미지 슬라이드바 영역
                </div>
            </section>
            <section class="titleSection">
                <div class="userInfo">
                    <ul>
                        <li>
                            <a href="#"><img src="${path}/images/trade/defaultProfile.png" alt="유저 프로필 사진"></a>
                        </li>
                        <li>
                            <a href="#">유저 닉네임(${dto.create_user})</a>
                        </li>
                        <li>거래 장소</li>
                    </ul>
                </div>
                <div id="titleContainer">
                    <ul>
                        <li>
                            <c:choose>
                                <c:when test="${dto.category == 's'}">
                                    <img alt="판매" v src="${path}/images/trade/sell.png">
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
                            <a href=".replyList"><img src="${path}/images/trade/uncheckedHeart.png" alt="관심등록"></a>관심 count
                        </li>
                        <li>조회수 : ${dto.view_count}</li>
                        <li>
                            댓글[<span id="countReplies">]</span>
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
                <form name="replyFrom" action="${path}/tbComment/insert.do">
                    <input type="hidden" name="tb_num" value="${dto.tb_num}">
                    <textarea name="content" id="replyContent" cols="30" rows="10"></textarea>
                    <button type="button" id="replyInsert"><img src="${path}/images/trade/insertReplyBtn.png"></button>
                </form>
                <div id="replyList"></div>

                <form name="childReplyForm" action="${path}/tbComment/insertChild.do">
                    <input type="hidden" name="parent_reply_reg_num" value="">
                    <textarea name="content" id="ChildReplyContent" cols="30" rows="10"></textarea>
                    <button type="button" id="ChildReplyInsert"><img src="${path}/images/trade/insertChildReplyBtn.png"></button>
                </form>
                <a href="#" role="button" onclick="showChildForm()"><img
                        src="${path}/images/trade/insertChildReplyBtn.png" alt="대댓글 등록버튼"></a>
            </section>
        </div>
    </main>
</div>

<footer>
    <%@ include file="../include/footer.jsp" %>
</footer>
</body>
</html>