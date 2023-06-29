<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%@ include file="../include/js/header.jsp" %>

    <c:if test='${"Y" eq freeFlag}'>
        <title>커뮤니티 - 자유게시판</title>
    </c:if>

    <c:if test='${"N" eq freeFlag}'>
        <title>커뮤니티 - 게임포럼</title>
    </c:if>


    <style>


        #contentsMain{
            margin-top: 10px;
            border-top: 2px solid black;
        }


        #postDetail{
            float: right;
            margin-bottom: 10px;
        }

        #postDetail span{
            margin-left: 20px;
        }


        #choiceGameList{
            display: flex;
            margin-bottom: 20px;
        }

        .choiceGameItem{
            padding: 20px 10px;
            box-shadow: 2px 2px 5px 2px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            cursor: pointer;
            margin-right: 10px;
        }

        .choiceGameItem > div:first-of-type{
            font-weight: bold;
            font-size: 1.1em;
            margin-bottom: 4px;
        }

        .choiceGameItem > div{
            text-align: center;
        }


        .category{
            color: #1432B1;
            padding: 0 14px;
            margin-right: 10px;
            border-right: 2px solid #d9d9d9;
        }

        #buttonSet{
            text-align: right;
        }

        h1{
            font-size: 1.2em;
        }

        #likeItArea{
            display: flex;
            justify-content: center;
        }

        #likeItDiv{
            text-align: center;
            cursor: pointer;
            padding: 15px 10px;
            border: 1px solid black;
            border-radius: 10px;
        }

        #replyArea{
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #d9d9d9;
            border-bottom: 1px solid #d9d9d9;
            padding: 12px 0 10px 5px;
            margin: 10px 0;
            font-weight: bold;
        }

        table{
            width: 100%;
        }

        textarea{
            width: 100%;
            min-height: 80px;
            resize: none;
        }

        button[id*="btn-"]{
            cursor: pointer;
            width: 82px;
            height: 34px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 0;

            border: 1px solid black;
            background-color: white;

        }


    </style>

    <script type="text/javascript">

        // 리뷰 리스트로 이동
        function btnList(){
            location.href="${path}/review/reviewlist.do?freeFlag=${freeFlag}";
        }

        // 수정 화면(편집화면)으로 이동
        function reviewEdit(regNum){
            $("#reviewDetailKey").val(regNum);
            document.formReviewEdit.submit();

        }

        // 삭제
        function reviewDel(regNum){
            $("#reviewDelKey").val(regNum);
            document.formreviewdel.submit();
        }

        // 댓글
        function btnReply(){
            //if(confirm('저장하시겠습니까?')){
            $("#reviewReplyKey").val($('input[name=regNumHidden]').val());
            document.formreviewreply.submit();

        /*}else{
                return;
            }
         */
        }

        // 댓글 수정
        function btnReplyEdit(replyRegNum, regNum){
            $("#replyRegNumEdit").val(replyRegNum);
            $("#regNumEdit").val(regNum);
            $("#commentDetailEdit").val($("#"+replyRegNum+regNum).val());
            document.formreviewreplyedit.submit();
        }

        // 댓글 수정 변환 → 버튼 보이기, 안보이기
        function btnReplyEditMode(replyRegNum, regNum){
            if ($("td[name=reply_show_"+replyRegNum+regNum+"]").attr("style") == "display: none") {
                $("td[name=reply_edit_"+replyRegNum+regNum+"]").attr("style","display: none");
                $("td[name=reply_show_"+replyRegNum+regNum+"]").attr("style","");
            } else {
                $("td[name=reply_show_"+replyRegNum+regNum+"]").attr("style","display: none");
                $("td[name=reply_edit_"+replyRegNum+regNum+"]").attr("style","");
            }
        }

        // 댓글 삭제
        function btnReplyDel(replyRegNum, regNum) {
            $("#replyRegNumDel").val(replyRegNum);
            $("#regNumDel").val(regNum);

            document.formreviewreplydel.submit();
        }

        // 답글 입력
        function btnTopReplySave(topReply){
            $("#topRegNum").val($('input[name=regNumHidden]').val());
            $("#topReplyRegNum").val(topReply);
            $("form[name=formreviewtopreply_"+topReply+"]").submit();
        }

        /*대댓글 입력창 보이기 안보이기*/
        function btnTopReply(replyRegNum, regNum, topReplyRegNum){
            if ($("td[name=topReplyInset"+replyRegNum+regNum+topReplyRegNum+"]").attr("style") == "display: none") {
                $("td[name=topReplyInset"+replyRegNum+regNum+topReplyRegNum+"]").attr("style","display: none");
                $("td[name=topReplyInsetSave"+replyRegNum+regNum+topReplyRegNum+"]").attr("style","");
            } else {
                $("td[name=topReplyInset"+replyRegNum+regNum+topReplyRegNum+"]").attr("style","display: none");
                $("td[name=topReplyInsetSave"+replyRegNum+regNum+topReplyRegNum+"]").attr("style","");
            }
        }

        //신고하기 → $("폼아이디).val()
        function waring(regNum){
            $("#formWringReport").val(regNum);
            /*alert($("#reviewDetailGoodKey").val());*/
            /*alert("클릭 테스트");*/
            document.formWringReport.submit();
        }

        //좋아요 → $("폼아이디).val()
        function good(regNum){
            $("#reviewDetailGoodKey").val(regNum);
            /*alert($("#reviewDetailGoodKey").val());*/
            /*alert("클릭 테스트");*/
            document.formReviewGood.submit();
        }

    </script>

</head>


<body>
<%@include file="../include/top.jsp" %>

<%--리뷰 수정--%>
<form name="formReviewEdit" method="post" action="${path}/review/reviewInsert.do">
    <input type="hidden" name="reviewDetailKey" id="reviewDetailKey">
    <input type="hidden" name="freeFlag" value="${freeFlag}">
</form>

<%--리뷰 삭제--%>
<form name="formreviewdel" method="post" action="${path}/review/reviewdelsave.do">
    <input type="hidden" name="reviewDetailKey" id="reviewDelKey">
    <input type="hidden" name="freeFlag" value="${freeFlag}">
</form>

<%--신고하기--%>
<form name="formWringReport" method="post" action="${path}/review/reviewdetailGood.do">
    <input type="hidden" name="reviewDetailKey" id="reviewDetailWringReport">
</form>

<%--좋아요--%>
<form name="formReviewGood" method="post" action="${path}/review/reviewdetailGood.do">
    <input type="hidden" name="reviewDetailKey" id="reviewDetailGoodKey">
</form>

<%--댓글 수정--%>
<form name="formreviewreplyedit" method="post" action="${path}/review/reviewreplyedit.do">
    <input type="hidden" name="replyRegNum" id="replyRegNumEdit">
    <input type="hidden" name="regNum" id="regNumEdit">
    <input type="hidden" name="commentDetail" id="commentDetailEdit">
</form>

<%--댓글 삭제--%>
<form name="formreviewreplydel" method="post" action="${path}/review/reviewreplydel.do">
    <input type="hidden" name="replyRegNum" id="replyRegNumDel">
    <input type="hidden" name="regNum" id="regNumDel">
</form>

<div id="contents">
    <div id="contentsHeader">
        <h2>커뮤니티</h2>

<%--
        <h2>admin : ${adminid}</h2>
        <h2>user : ${userid}</h2>
--%>


    </div>

    <c:if test='${"Y" eq freeFlag}'>
        <div id="contentsLocation">
            홈&gt 커뮤니티&gt 자유게시판
        </div>
    </c:if>

    <c:if test='${"N" eq freeFlag}'>
        <div id="contentsLocation">
            홈&gt 커뮤니티&gt 게임포럼
        </div>
    </c:if>

    <div id="contentsMain">

        <form name="reviewdetail" method="post" action="${path}/review/reviewdetail.do">

<%--
                    <script>
                        console.log(<c:out value="${list}"></c:out>)
                        console.log(<c:out value="${vo.title}"></c:out>)
                        console.log(<c:out value="${vo.nickName}"></c:out>)
                        console.log(<c:out value="${vo.good}"></c:out>)
                        console.log(<c:out value="${vo.views}"></c:out>)
                        console.log(<c:out value="${vo.createDate}"></c:out>)
                        console.log(<c:out value="${vo.gametitle}"></c:out>)
                        console.log(<c:out value="${vo.reviewDetail}"></c:out>)
                    </script>
--%>
            <c:forEach items="${list}" var="vo">
                <h1>
                    <span class="category">${vo.category}</span>
                        ${vo.title}
                </h1>
            <div id="postDetail">
                <div>
                    <span>${vo.nickName}</span>
                    <span>조회 ${vo.views}</span>
                    <span>
                        <img src="${path}/images/game/pink_heart.png" width="15px">
                            ${vo.good}
                    </span>
                    <span>${vo.createDate}</span>
                </div>
            </div>
                <br>
                <div>

                </div>
                    <c:if test="${gameList.size() > 0}">
                    <div id="choiceGameList">
                        <c:forEach items="${gameList}" var="gl" varStatus="status">
                            <div class="choiceGameItem" onclick="location.href='${path}/game/view.do?gnum=${gl.gnum}'">
                                <div>
                                   ${gl.gametitle} (${gl.RELEASE_YEAR})
                                </div>
                                <div>
                                    주간순위:
                                    <c:choose>
                                        <c:when test="${gl.game_rank!=null && gl.game_rank > 0}">
                                                ${gl.game_rank}
                                        </c:when>
                                        <c:otherwise>
                                            -
                                        </c:otherwise>
                                    </c:choose>
                                    /
                                    월간순위:
                                    <c:choose>
                                        <c:when test="${gl.game_rank_month!=null && gl.game_rank_month > 0}">
                                            ${gl.game_rank_month}
                                        </c:when>
                                        <c:otherwise>
                                            -
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    인원: ${gl.PLAYERS} / 시간: ${gl.PLAYTIME}
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    </c:if>
                <tr>
                    <td><pre>${vo.reviewDetail}</pre></td>
                </tr>
            </table>

                <!--신고하기, 좋아요-->
                <c:if test="${userid ne vo.createUser}">
                    <%--                    <button type="button" onclick ="waring('${vo.regNum}')">&#9940;	신고하기</button>--%>
                    <div id="likeItArea">
                        <div onclick="good('${vo.regNum}')" id="likeItDiv">
                            <img src="${path}/images/game/pink_heart.png" width="15px">
                            좋아요
                        </div>
                    </div>
                </c:if>

                <%--댓글 보여주기--%>
                <div id="replyArea">
                    <div>댓글</div>

                    <div id="buttonSet">
                        <input type="hidden" name="regNumHidden" value="${vo.regNum}">
                        <button type="button" onclick="btnList()" id="btn-list">목록</button>

                        <c:if test="${userid eq vo.createUser || adminid ne null}">
                            <button id="btn-delete" type="button" onclick ="reviewDel('${vo.regNum}')">삭제</button>
                            <button id="btn-edit" type="button" onclick ="reviewEdit('${vo.regNum}')">수정</button>
                        </c:if>
                    </div>
                </div>

            </c:forEach>
        </form>


        <c:forEach items="${commentList}" var="vo">
            <table style="table-layout:fixed;">
                    <%--댓글 답글 나누기, topReplyRegNum == null이면 댓글--%>

                <c:if test="${null eq vo.topReplyRegNum}">
                <tr>
                    <td><b>${vo.nickname}</b></td>
                    <td>${vo.createDate}</td>
                    <td style="display: none">${vo.replyRegNum}</td>
                    <td style="display: none">${vo.del}</td>


                        <%--삭제하지 않은 상태에서만 버튼 보이기--%>
                    <c:choose>
                        <c:when test="${vo.del eq 'N'}">
                            <%--로그인 id와 작성자가 같으면 수정, 삭제 버튼 보이기--%>
                            <c:if test="${userid eq vo.createUser || adminid ne null}">
                                <td name="reply_show_${vo.replyRegNum}${vo.regNum}">
                                    <button type="button" onclick="btnReplyEditMode('${vo.replyRegNum}','${vo.regNum}')">
                                        수정
                                    </button>
                                    <button type="button" onclick="btnReplyDel('${vo.replyRegNum}','${vo.regNum}')">
                                        삭제
                                    </button>
                                </td>
                                <td name="reply_edit_${vo.replyRegNum}${vo.regNum}" style="display: none">
                                    <button type="button" onclick="btnReplyEditMode('${vo.replyRegNum}','${vo.regNum}')">
                                        취소
                                    </button>
                                    <button type="button" onclick="btnReplyEdit('${vo.replyRegNum}','${vo.regNum}')">
                                        저장
                                    </button>
                                </td>
                            </c:if>
                        </c:when>
                    </c:choose>
                </tr>


                <tr>   <%--댓글 보여주기, 수정시 입력창 활성화 style="display: none"--%>
                    <c:choose>
                    <c:when test="${vo.del eq 'Y'}">
                    <td>[삭제된 댓글 입니다]</td>
                    </c:when>
                    <c:when test="${vo.del eq 'N'}">
                    <td colspan="4" name="reply_show_${vo.replyRegNum}${vo.regNum}">
                        <pre>${vo.commentDetail}</pre>
                    </td>
                    <td colspan="4" name="reply_edit_${vo.replyRegNum}${vo.regNum}" style="display: none">
                    <textarea id="${vo.replyRegNum}${vo.regNum}" rows="2">
                            ${vo.commentDetail}
                    </textarea></td>
                    </c:when>
                    </c:choose>

                    </c:if>

                        <%--댓글 답글 나누기, topReplyRegNum != null이 아니면 답글--%>
                    <c:if test="${null ne vo.topReplyRegNum}">
                <tr>
                    <td style="padding-left:50px"><b>└ ${vo.nickname}</b></td>
                    <td>${vo.createDate}</td>
                    <td style="display: none">${vo.replyRegNum}</td>


                    <c:choose>
                        <c:when test="${vo.del eq 'Y'}">
                        </c:when>
                        <c:when test="${vo.del eq 'N'}">
                            <%--로그인 id와 작성자가 같으면 수정, 삭제 버튼 보이기--%>
                            <c:if test="${userid eq vo.createUser || adminid ne null}">
                                <td name="reply_show_${vo.replyRegNum}${vo.regNum}">
                                    <button type="button"
                                            onclick="btnReplyEditMode('${vo.replyRegNum}','${vo.regNum}')">수정
                                    </button>
                                    <button type="button" onclick="btnReplyDel('${vo.replyRegNum}','${vo.regNum}')">삭제
                                    </button>
                                </td>
                                <td name="reply_edit_${vo.replyRegNum}${vo.regNum}" style="display: none">
                                    <button type="button"
                                            onclick="btnReplyEditMode('${vo.replyRegNum}','${vo.regNum}')">취소
                                    </button>
                                    <button type="button" onclick="btnReplyEdit('${vo.replyRegNum}','${vo.regNum}')">
                                        저장
                                    </button>
                                </td>
                            </c:if>
                        </c:when>
                    </c:choose>


                </tr>
                <tr>
                    <c:choose>
                    <c:when test="${vo.del eq 'Y'}">
                        <td colspan="4" style="padding-left:70px">[삭제된 대댓글 입니다]</td>
                    </c:when>

                    <c:when test="${vo.del eq 'N'}">
                    <td colspan="4" name="reply_show_${vo.replyRegNum}${vo.regNum}" style="padding-left:70px">
                        <pre>${vo.commentDetail}</pre>
                    </td>
                    <td colspan="4" name="reply_edit_${vo.replyRegNum}${vo.regNum}" style="display: none">
                    <textarea id="${vo.replyRegNum}${vo.regNum}" rows="2" cols="20">
                            ${vo.commentDetail}
                    </textarea></td>
                    </c:when>
                    </c:choose>


                    </c:if>
                </tr>

                        <%--답글 입력창 보이기--%>
                    <c:if test="${null eq vo.topReplyRegNum}">
                        <%--답글 입력--%>
                    <form name="formreviewtopreply_${vo.replyRegNum}" method="post"
                          action="${path}/review/topreplyinsetsave.do">
                        <input type="hidden" name="topReplyRegNum" id="topReplyRegNum" value="${vo.replyRegNum}">
                        <input type="hidden" name="regNum" id="topRegNum" value="${vo.regNum}">
                        <input type="hidden" name="freeFlag" value="${freeFlag}">
                <tr>
                    <td colspan="4">
                        <textarea name="commentDetail" id="topreplyinset" rows="2" cols="80"></textarea>
                        <button type="button" onclick="btnTopReplySave('${vo.replyRegNum}')">답글 저장</button>
                    </td>
                </tr>
                </form>

                </c:if>

                </tr>
                <p></p>
            </table>
            <hr/> <%--구분선--%>

        </c:forEach>

        <%--댓글 입력--%>
        <form name="formreviewreply" method="post" action="${path}/review/reviewreplysave.do">
            <input type="hidden" name="regNum" id="reviewReplyKey">
            <input type="hidden" name="freeFlag" value="${freeFlag}">
            <div>
                <textarea name = "commentDetail" id="reviewReplyInsert" rows = "5" cols = "80"></textarea>
                <button type="button" onclick="btnReply()">댓글 저장</button>
            </div>
        </form>



    </div>
</div>
<%--!!!F;O;O;T;E;R 첨부해주세요--%>
<%@include file="../include/footer.jsp" %>
</body>

</html>