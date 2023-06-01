<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>커뮤니티 - 게임리뷰</title>
    <%@ include file="../include/js/header.jsp" %>

    <style>

        @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 100;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.otf) format('opentype');}

        @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 300;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.otf) format('opentype');}

        @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 400;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.otf) format('opentype');}

        @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 500;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.otf) format('opentype');}

        @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 700;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.otf) format('opentype');}

        @font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 900;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.otf) format('opentype');}

        * {
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 15px;
        }

        html, body{
            margin: 0 0;
            padding: 0 0;
            min-height: 100%;
        }

        div, input, span{
            box-sizing: border-box;
        }

        #header-upper-box > div{
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 77px;
            flex-basis: 1120px;
            max-width: 1120px;
        }

        form[name="gameSearch"] > div:first-of-type{
            background-color: white;
            position: relative;
            width: 320px;
            height: 34px;
            padding: 2px 10px;
            border: 2px black solid;
            border-radius: 20px;
        }

        form[name="gameSearch"] img{
            width: 20px;
            position: absolute;
            top: 5px;
            right: 12px;
            margin: 0;
            -webkit-user-drag: none;
        }

        #header-right input:first-of-type{
            width: 270px;
            height: 25px;
            padding-left: 20px;
            border: none;
            font-size: 16px;
            background-color: rgba(255, 255, 255, 0.5);
        }

        .menu li {
            display: inline-block;
            flex: 0 0 25%;
            max-width: 25%;
            height: 100%;
            line-height: 45px;
        }

        .toMenu > img{
            margin-left: -4px;
            -webkit-user-drag: none;
        }

        #contents{
            display: flex;
            flex-direction: column;
            margin: auto;
            max-width: 1120px;
            min-height: 100%;
            padding: 129px 0 0 0;
            font-size: 16px;
        }

        #contentsHeader{
            margin: 0;
            padding-top: 32px;
            padding-bottom: 5px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        #contentsHeader h2{
            font-size: 1.9em;
            margin-top: 0;
            margin-bottom: 5px;
        }

        #contentsLocation{
            margin-bottom: 30px;
        }

        #contentsMain{
            border-top: 2px solid black;
            margin-bottom: 80px;
            flex-grow: 1;
            min-height: 420px;
        }

        #postUpper > div:first-of-type{
            padding: 30px 0;
        }

        #postUpper > div:nth-of-type(2){
            padding: 30px 0 30px 0;
            flex-grow: 1;
            display: flex;
            justify-content: space-between;
            flex-direction: column;
        }

        .labelAndItem > span:first-of-type{
            width: 90px;
            text-align: right;
            margin-right: 25px;
        }

        .labelAndItem input{
            padding-left: 8px;
        }

        .labelAndItem input[type="date"]{
            width: 190px;
        }

        .labelAndItem input[type="number"]{
            width:100px;
            margin-right: 5px;
        }


        input[name="question"]{
            width: 100%;
        }

        #postMain > div:last-of-type{
            text-align: center;
        }

        #postMain ul{
            list-style-position: inside;
            margin: 0;
            padding: 20px 10px 30px 10px;
        }

        button[id*="btn-"]{
            cursor: pointer;
            width: 82px;
            height: 34px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 0;
        }

        footer{
            font-size: 15px;
            color: #DFDFDF;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 190px;
            background-color: #3D3D43;
            bottom: 0;
            clear: both;
        }


        footer > div{
            width: 100%;
            max-width: 1120px;
        }


    </style>

    <script type="text/javascript">

        // 리뷰 리스트로 이동
        function btnList(){
            location.href="${path}/review/reviewlist.do";
        }

        // 수정, 삭제 화면(편집화면)으로 이동
        function reviewEdit(regNum){
            $("#reviewDetailKey").val(regNum);
            /*alert($("#reviewDetailKey").val());*/
            /*alert("클릭 테스트");*/
            document.formReviewEdit.submit();
        }

        // 삭제
        function reviewDel(regNum){
            $("#reviewDelKey").val(regNum);
            /*alert($("#reviewDetailKey").val());*/
            /*alert("클릭 테스트");*/
            document.formreviewdel.submit();
        }

        //좋아요
        function good(regNum){
            $("#reviewDelKey").val(regNum);
            /*alert($("#reviewDetailKey").val());*/
            /*alert("클릭 테스트");*/
            document.폼이름.submit();
        }



    </script>

</head>


<body>
<%@include file="../include/top.jsp" %>

<form name="formReviewEdit" method="post" action="${path}/review/reviewInsert.do">
    <input type="hidden" name="reviewDetailKey" id="reviewDetailKey">
</form>

<form name="formReviewEdit" method="post" action="${path}/review/reviewInsert.do">
    <input type="hidden" name="reviewDetailKey" id="reviewDetailKeyGood">
</form>

<form name="formreviewdel" method="post" action="${path}/review/reviewdelsave.do">
    <input type="hidden" name="reviewDetailKey" id="reviewDelKey">
</form>

<div id="contents">
    <div id="contentsHeader">
        <h2>커뮤니티</h2>
    </div>
    <div id="contentsLocation">
        홈&gt 커뮤니티&gt 게임리뷰
    </div>
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

            <h1>${vo.title}</h1>
            <table>
                <tr>
                    <td>작성자 : </td>
                    <td>${vo.nickName}</td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>작성일 : </td>
                    <td>${vo.createDate}</td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>&#128366;</td> <%--조회수--%>
                    <td>${vo.views}</td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>&#x1f495</td> <%--좋아요--%>
                    <td>${vo.good}</td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                </tr>
                <tr>
                    <td>게임</td>
                    <td>${vo.gametitle}</td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>리뷰</td>
                </tr>
                <tr>
                    <td>${vo.reviewDetail}</td>
                </tr>
            </table>
                <table style="align-content: center; font-size: 50px;" border="1" >
                    <tr>
                        <td> <button type="button" onclick="good()"> &#x1f495 </button> <%--좋아요--%> </td>
                    </tr>
                    <tr>
                        <td>눌러 주세요</td>
                    </tr>
                </table>
                <button type="button" onclick="btnList()">목록</button>
                <button type="button" onclick ="reviewDel('${vo.regNum}')">삭제</button>
                <button type="button" onclick ="reviewEdit('${vo.regNum}')">수정</button>
                <button type="button" onclick="btnReply()">댓글</button>

                </c:forEach>
        </form>



    </div>
</div>
<%--!!!F;O;O;T;E;R 첨부해주세요--%>
<%@include file="../include/footer.jsp" %>
</body>

</html>