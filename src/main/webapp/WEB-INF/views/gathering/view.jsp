<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">

<%@ include file="../include/js/header.jsp" %>
  <title>${dto.title} - 오프모임</title>

    <style>
    .map_wrap {
      position:relative;
    }

    .title {
      font-weight:bold;
      display:block;
    }

    .hAddr {
      position:absolute;
      right:10px;
      bottom:10px;
      border-radius: 2px;
      background:#fff;
      background:rgba(255,255,255,0.8);
      z-index:1;
      padding:5px;
    }

    #centerAddr {
      display: block;
      margin-top: 2px;
      font-weight: normal;
    }

    #infoWindow{
      background-color: white;
      border: 1px solid black;
      border-radius: 6px;
      padding: 10px 10px;
    }

    #infoWindow > span{
      display: block;
      line-height: 16px;
      max-width: 300px;
      word-break: break-all;      
    }

     #postInfo{
	   text-align: right;
	   padding-bottom: 5px;
     }
    	  
      #postInfo > span{
	      padding: 0 10px;
	      border-right: 1px solid black;
      }
    	  
      #postInfo > span:last-of-type{
	      border:  none;
      }
    
      #postUpper{
	      display: flex;
	      border-top: 2px solid black;
      }

      #postUpper > div:first-of-type{
	       padding: 30px 0;
        }

      #map{
	        width: 400px;
	        height: 280px;
	        border: 1px solid black;
	        text-align: center;
	        line-height: 257px;
	        overflow: hidden;
            position: relative;
        }


        #profileArea{
            padding: 30px 0 30px 50px;
            flex-grow: 1;
            display: flex;
            justify-content: space-between;
            flex-direction: column;
        }

        .status{
            width: 85px;
            border: 1px solid black;
            border-radius: 5px;
            padding: 0 10px;
            margin-right: 6px;
        }

        #title{
            padding-top: 10px;
            font-weight: bold;
            font-size: 22px;
        }

        #profileArea > ul{
            min-height: 215px;
            padding-left: 25px;
            flex-grow: 1;
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
            padding-top: 15px;
            margin-top: 0;
            margin-bottom: 10px;
        }

        #profileArea > ul > li{
            flex-grow: 1;
            font-size: 16px;
        }

        #profileArea .attendee_count, .waiting_count{
            font-size: 16px;
        }

        #profileArea > div:last-of-type{
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
        }

        #profileArea > div:last-of-type > span{
            font-weight: bold;
            font-size: 17px;
        }

        button[id*="bigBtn-"], button[class*="bigBtn-"]{
            width: 120px;
            height: 40px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 0;
            cursor: pointer;
        }

        #bigBtn-apply{
            background-color: #1432B1;
            border: 0;
            color: white;
        }

        .bigBtn-cancel{
            background-color: white;
            border: 1px solid black;
            margin-left: 5px;
        }

        #bigBtn-chat{
            background-color: #F9841A;
            border: 0;
            color: white;
        }

        #attendeeListShow{
            cursor: pointer;
        }

        #attendeeList{
            margin-top: 10px;
            left: 30px;
            display: flex;
            min-width: 200px;
            max-height: 500px;
            flex-wrap: wrap;
        }


        #attendeeList a{
            color: black;
            text-decoration: none;

        }

        .attendee{
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-right: 7px;
        }

        .attendee span{
            font-size: 13px;
        }

        .attendee img{
            width: 42px;
            height: 42px;
            margin-bottom: 3px;
            border-radius: 50%;
            object-fit: cover;
        }

        .waiting{
            display: flex;
        }


       #postMain{
            padding: 30px 13px;
            border-top: 2px dashed #D9D9D9;
            display: flex;
            flex-direction: column;
        }

        #replyUpper{
            display: flex;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #D9D9D9;
            border-top: 1px solid #D9D9D9;
        }

        #replyUpper > span:first-of-type{
            font-weight: bold;
            margin-right: 15px;
        }

        #replyUpper > span:nth-of-type(2){
            flex-grow: 1;
        }

        .reply{
            padding: 16px 13px;
            border-bottom: 1px solid #D9D9D9;
        }

        .reply > div:first-of-type{
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            margin-bottom: 5px;
        }

        .reply > div:first-of-type > span:first-of-type {
            font-weight: bold;
        }

        .dateDiv{
            font-size: 14px;
            padding-top: 13px;
            color: #5F5F5F;
        }

        .addRe_reply > a{
            text-decoration: none;
            color: black;
        }

        form[name="replyForm"]{
            text-align: right;
        }

        .re-replyForm{
            padding: 15px 20px 10px 20px;
        }

        [class*="re-reply"]{
            background-color: #F5F5F5;
            padding-top: 10px;
        }

        textarea{
            width: 100%;
            box-sizing: border-box;
            margin: 15px 0 5px 0;
            height: 100px;
            resize: none;
        }

        button[id*="btn-"], button[class*="btn-"]{
            width: 82px;
            height: 34px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 0;
            cursor: pointer;
        }

        #btn-GoList, #btn-Edit, #btn-Delete{
            border: 1px solid black;
            background-color: white;
        }

        #btn-Delete{
            margin: 0 5px;
        }


        .btn-AddReply, .btn-editReply, .btn-cancelReply{
            background-color: #3D3D43;
            border: 0;
            color: white;
        }

        .btn-cancelReply{
            margin-right: 5px;
        }


        /*여기부터 모달*/
        .popup-wrap{
            background-color:rgba(0,0,0,.3);
            z-index: 1000;
            justify-content:center;
            align-items: center;
            position: fixed;
            display: none;
            top:0;
            left:0;
            right:0;
            bottom:0;
            padding: 15px;
        }

        .popup{
            overflow: hidden;
            box-shadow: 5px 10px 10px 1px rgba(0,0,0,.3);
        }

        #applyPopup .popup-body{
            display: flex;
            flex-direction: column;
            padding: 20px;
            background-color:#ffffff;
        }

        #applyPopup .popup-body{
            max-width: 480px;
            min-height: 200px;
            justify-content: space-between;
        }

        #applyPopup .popup div{
            font-size: 16px;
        }

        #applyPopup .popup-body > div:last-of-type{
            display: flex;
            flex-direction: row;
            justify-content: center;
        }

        #applyPopup .popup-body button:first-of-type{
            margin-right: 10px;
        }

        #attendingPopup .popup-body{
            display: flex;
            flex-direction: column;
            padding: 30px 50px;
            background-color:#ffffff;
            align-items: center;
        }

        #attendingPopup .popup-body > div{
            display: flex;
            flex-direction: row;
            gap: 20px;
        }

        #attendingPopup .popup-body > button{
            margin-top: 20px;
            width: 80px;
        }

        #attendingPopup h2 {
            margin: 0 0 10px 0;
            padding: 0;
            text-align: center;
        }


        #attendingList, #waitingList{
            display: flex;
            flex-direction: column;
        }

        #waitingArea, #attendingArea{
            height: 100%;
        }

        #waitingArea{
            padding-left: 20px;
            border-left: 1px solid black;
        }

        #waitingArea > div:first-of-type{
            width: 100%;
            text-align: center;
            margin-bottom: 10px;
        }

        .attendingItem{
            display: flex;
            flex-direction: row;
            align-items: center;
            margin-bottom: 5px;
        }

        .attendingItem:last-of-type{
            margin-bottom: 0;
        }

        #attendingPopup img{
            width: 50px;
        }

        #waitingArea .attendingItem > div:first-of-type{
            width: 200px;
        }

        #attendingList .attendingItem button, .acceptBtn, .rejectBtn{
            width: 47px;
            height: 22px;
            border-radius: 10px;
            color: white;
            border: 0;
            font-size: 0.9em;
            cursor: pointer;
        }

        #attendingList .attendingItem button, .acceptBtn{
            background-color: #C53A32;
        }

        .rejectBtn{
            background-color: #1432B1;
            margin-left: 5px;
        }


    </style>

    <script>


        $(function(){

            getReplies();

            $("#bigBtn-apply").on("click", function(){

                if("${sessionScope.userid}" == ""){
                    if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                        location.href= "${path}/member/member_login.do";
                        return;
                    }

                    else return;

                }

                if("${dto.attendSystem}"=='p') {
                    document.body.style.overflowY = "hidden";
                    $("#applyPopup").css('display','flex').hide().fadeIn();
                    return;
                }

                if(confirm("이 모임에 참여하시겠습니까?")){

                  $.ajax({
                           type: "get",
                           url : "${path}/gathering/addAttendee.do",
                           data : {
                               "gathering_id": "${dto.gathering_id}"
                           },
                           success: function(result){
                               alert(result.message);
                               location.reload();
                           },
                           error: function(e){
                                   alert("에러가 발생했습니다.");
                           }
                       });
                   }

            });


            $(document).on("click", ".btn-AddReply", function() {

                if("${sessionScope.userid}" == ""){
                    if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                        location.href= "${path}/member/member_login.do";
                        return;
                    }
                    else return;
                }


                let form = $(this).closest("form");
                let reply_text = form.find('textarea[name="reply_text"]');
                reply_text.val(reply_text.val().trim());
                if(reply_text.val()=='') return;

                let queryString = form.serialize()+"&gathering_id="+"${dto.gathering_id}";

                $.ajax({
                    type: "get",
                    url : "${path}/gathering/addReply.do",
                    data : queryString,
                    success: function(result){
                       if(result){
                           reply_text.val("");
                           getReplies();
                       }
                       else alert("에러가 발생했습니다.");
                    },
                    error: function(){
                        alert("에러가 발생했습니다.");
                    }
                });



            });

        });


        function getReplies(){
            $.ajax({
                type: "get",
                url : "${path}/gathering/getReplies.do",
                data : {gathering_id : "${dto.gathering_id}"},
                success: function(result){
                    let list = result.list;
                    if(list!=null && list.length > 0){

                        let repliesContainer = $("#replies");
                        repliesContainer.empty();

                        for(let i=0; i<list.length; i++){

                            let addReplySpan = "";
                            if(list[i].show == 'Y'){
                                if("${sessionScope.userid}" == list[i].creator_id){
                                    addReplySpan =
                                        "<span class='addRe_reply'><img src='${path}/images/reply_arrow.png' width='15px'>" +
                                        "<img ><a href='javascript:showRe_reply(" + list[i].reply_id + "," +
                                        list[i].parent_reply + "," + list[i].inner_order + ")'>답글</a>" +
                                        "&nbsp&nbsp<a href='javascript:editReply(" +
                                        list[i].reply_id + ")'>수정</a>&nbsp&nbsp" +
                                        "<a href='javascript:deleteReply(" + list[i].reply_id + ")'>삭제</a>";
                                }

                                else{
                                    addReplySpan =
                                        "<span class='addRe_reply'><img src='${path}/images/reply_arrow.png' width='15px'>" +
                                        "<img ><a href='javascript:showRe_reply(" + list[i].reply_id + "," +
                                        list[i].parent_reply + "," + list[i].inner_order + ")'>답글</a>";
                                }
                            }


                            let reply = $("<div>").addClass("reply").attr("id", list[i].reply_id);

                            let writer = $("<span>").text(list[i].nickname);

                            let text = "";

                            if(list[i].show == 'Y'){
                                text= $("<div>").text(list[i].reply_text);
                            }

                            else{
                                text= $("<div>").text("[삭제된 댓글입니다.]");
                            }

                            if(list[i].depth > 0) {
                                reply.addClass("re-reply");
                                writer.html("<img width='10px' style='margin-right: 7px;' " +
                                    "src='${path}/images/re_reply.png'>" + writer.text());
                                let padding = Number(reply.css("padding-left"));
                                reply.css("padding-left", (padding + list[i].depth * 18) + "px");
                            }

                            let bigDiv = $("<div>");
                            let smallDiv = $("<div>");


                            let date = new Date(list[i].create_date);
                            let formattedDate = new Date(date + 3240 * 10000)
                                .toISOString().replace('T', ' ').replace(/\..*/,'');

                            let dateDiv = $("<div>").text(formattedDate);
                            dateDiv.addClass('dateDiv');

                            smallDiv.append(addReplySpan);
                            bigDiv.append(writer, smallDiv);
                            reply.append(bigDiv, text, dateDiv);

                            repliesContainer.append(reply);
                        }

                    }

                    $("#countReplies").text(list.length==null ? 0 : list.length);

                }, error: function(){
                    $("#countReplies").text(0);
                }
            });
        }

        function showRe_reply(reply_id){
            $("form[class='re-replyForm']").remove();

            let re_reply_form = $("<form>").addClass("re-replyForm")
                .attr({
                    name: "replyForm",
                    action: "${path}/gathering/addReply.do"
                });

            let textArea = $("<textarea>").attr({
                name: "reply_text"
            });

            let input = $("<input>").attr({
                type: "hidden",
                name: "mother_reply",
                value: reply_id
            });

            let button2 = $("<button>").attr({
                type: "button",
                class: "btn-cancelReply"
            }).text("취소");


            button2.click(function(){
                $("form[class='re-replyForm']").remove();
            });

            let button = $("<button>").attr({
                type: "button",
                class: "btn-AddReply"
            }).text("댓글쓰기");



            re_reply_form.append(textArea, input, button2, button);
            $("#" + reply_id).append(re_reply_form);

        }

        function editPost(){
            location.href="${path}/gathering/edit/${dto.gathering_id}";
        }

        function deletePost(){
            if(Number("${dto.attendee_count}") > 1){
                if(!confirm("게시글을 삭제하면 모든 채팅 내역이 삭제되며 모든 모임원이 자동으로 모임에서 나가게 됩니다. " +
                    "다른 모임원들과 상의하여 신중하게 결정해주세요!\n\n정말로 게시글을 삭제하시겠습니까?")){
                    return;
                }
            }

            else{
                if(!confirm("게시글을 삭제하면 모든 채팅 내역이 삭제됩니다.\n정말로 게시글을 삭제하시겠습니까?")){
                    return;
                }
            }

            location.href="${path}/gathering/delete.do?gathering_id=${dto.gathering_id}";
        }


        function withdraw(){
            if(confirm("정말로 이 모임을 탈퇴하시겠습니까?\n(자동으로 채팅방에서 나가게 됩니다.)")){
                $.ajax({
                        type: "get",
                        url : "${path}/gathering/withdraw.do",
                        data : {
                            "gathering_id": "${dto.gathering_id}"
                        },
                        success: function(result){
                            alert(result.message);
                            location.reload();
                            },
                        error: function(e){
                            if(e.status==999){
                                if(confirm("로그인 이후에 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?")){
                                    location.href= "${path}/member/member_login.do";
                                    return;
                                }
                            }
                            else{
                                alert("에러가 발생했습니다.");
                            }
                        }
                    });
                }

        }


        function modalClose(){
            $(".popup-wrap").fadeOut(); //페이드아웃 효과
            $("input[name='answer']").val('');
            document.body.style.overflowY = "auto";
        }

        function submitApplication(){

            $("input[name='answer']").val($("input[name='answer']").val().trim());
            let answer = $("input[name='answer']").val();
            if(answer == ""){
                alert("모임장의 질문에 대한 답변을 입력해주세요.");
            }

            else{
                $.ajax({
                    type: "get",
                    url : "${path}/gathering/addAttendee.do",
                    data : {
                        "answer": $("input[name='answer']").val(),
                        "gathering_id": "${dto.gathering_id}"
                    },
                    success: function(result){
                        alert(result.message);
                        location.reload();
                    },
                    error: function(e){
                        alert("에러가 발생했습니다.");
                    }
                });

            }

        }


        function cancelApplication(){
            if(confirm("모임 참가 신청을 취소하시겠습니까?")){
                $.ajax({
                    type: "get",
                    url : "${path}/gathering/cancelApplication.do",
                    data : {
                        "gathering_id": "${dto.gathering_id}"
                    },
                    success: function(result){
                        alert(result.message);
                        location.reload();
                    },
                    error: function(e){
                            alert("에러가 발생했습니다.");
                    }
                });
            }
        }


        function editReply(reply_id){

            let reply = $("#"+reply_id);
            let text = reply.children("div:eq(1)").text();

            let edit_reply_form = $("<form>").addClass("edit-replyForm")
                .attr({
                    name: "replyForm"
                });

            let textArea = $("<textarea>").attr({
                name: "reply_text"
            });

            textArea.text(text);

            let input = $("<input>").attr({
                type: "hidden",
                name: "reply_id",
                value: reply_id
            });

            let button = $("<button>").attr({
                type: "button",
                class: "btn-editReply"
            }).text("수정");

            button.click(function(){
               let form = $(this).closest("form[name='replyForm']");
               let reply_text = form.find('textarea[name="reply_text"]');
               reply_text.val(reply_text.val().trim());
               if(reply_text.val()=='') return;

               let queryString = form.serialize()+"&reply_id="+reply_id;

                $.ajax({
                    type: "get",
                    url : "${path}/gathering/editReply.do",
                    data : queryString,
                    success: function(result){
                        if(result.num > 0){
                            getReplies();
                        }
                        else alert("에러가 발생했습니다.");
                    },
                    error: function(){
                        alert("에러가 발생했습니다.");
                    }
                });

            });


            let button2 = $("<button>").attr({
                type: "button",
                class: "btn-cancelReply"
            }).text("취소");



            edit_reply_form.append(textArea, input, button2, button);
            let divs = reply.children("div");
            divs.remove();
            let original = divs;


            button2.click(function(){
                reply.find("form[class='edit-replyForm']").remove();
                reply.prepend(original);
            });

            reply.prepend(edit_reply_form);

        }


        function deleteReply(reply_id){

            if(confirm("이 댓글을 삭제하시겠습니까?")){
                $.ajax({
                    type: "get",
                    url : "${path}/gathering/deleteReply.do",
                    data : {
                        "reply_id": reply_id
                    },
                    success: function(result){
                        if(result.num > 0){
                            getReplies();
                        }
                        else alert("에러가 발생했습니다.");
                    },
                    error: function(){
                        alert("에러가 발생했습니다.");
                    }
                });
            }

        }


        function showAttendingList(){
            document.body.style.overflowY = "hidden";
            $("#attendingPopup").css('display','flex').hide().fadeIn();
            return;
        }




        function accept(event){

            let $button = $(event.currentTarget);

            if(confirm('이 회원의 모임참여를 승인하겠습니까?')){

                let attendee_id = $button.closest(".attendingItem").data("attendee_id");

                $.ajax({
                    type: "get",
                    url : "${path}/gathering/acceptApply.do",
                    data : {
                        "gathering_id": '${dto.gathering_id}',
                        "attendee_id": attendee_id,
                    },
                    success: function(result){
                        let message = result.message;

                        if(!message && message!=""){
                            alert(message);
                        }

                        if(result.attendeeDTOList){
                            makeList(result.attendeeDTOList, result.waitingDTOList);
                        }
                    },
                    error: function(){
                        alert("에러가 발생했습니다.");
                    }
                });
            }
        }


        function reject(event){

            let $button = $(event.currentTarget);

            if(confirm('이 회원의 참여신청을 거절하시겠습니까?')){

                let attendee_id = $button.closest(".attendingItem").data("attendee_id");

                $.ajax({
                    type: "get",
                    url : "${path}/gathering/rejectApply.do",
                    data : {
                        "gathering_id": '${dto.gathering_id}',
                        "attendee_id": attendee_id,
                    },
                    success: function(result){
                        let message = result.message;

                        if(!message && message!=""){
                            alert(message);
                        }

                        if(result.attendeeDTOList){
                            makeList(result.attendeeDTOList, result.waitingDTOList);
                        }
                    },
                    error: function(){
                        alert("에러가 발생했습니다.");
                    }
                });
            }


        }



        function throwAttendee(event){

            let $button = $(event.currentTarget);

            if(confirm('이 회원을 모임에서 탈퇴시키겠습니까?')){

                let attendee_id = $button.closest(".attendingItem").data("attendee_id");

                $.ajax({
                    type: "get",
                    url : "${path}/gathering/throwAttendee.do",
                    data : {
                        "gathering_id": '${dto.gathering_id}',
                        "attendee_id": attendee_id,
                    },
                    success: function(result){
                        let message = result.message;

                        if(!message && message!=""){
                            alert(message);
                        }

                        if(result.attendeeDTOList){
                            makeList(result.attendeeDTOList, result.waitingDTOList);
                        }
                    },
                    error: function(){
                        alert("에러가 발생했습니다.");
                    }
                });
            }
        }



        function makeList(attendeeDTOList, waitingDTOList){

            $attendeeList = $("<div>").prop("id", "attendeeList");
            $attendingList = $("<div>").prop("id", "attendingList");
            $waitingList = $("<div>").prop("id", "waitingList");


            for(let i=0; i<attendeeDTOList.length; i++){

                $attendingItem = $("<div>").addClass('attendingItem')
                    .data("attendee_id", attendeeDTOList[i].attendee_id);;
                $link = $("<a>").prop("href", "${path}/mypage/moveUserPage/" + attendeeDTOList[i].user_id);
                $attendee = "<div class='attendee'><img src='${path}/images/" +
                    attendeeDTOList[i].profile + "'><span>" + attendeeDTOList[i].nickname + "</span></div>";

                $throwBtn = "";
                if(attendeeDTOList[i].user_id != '${sessionScope.userid}'){
                    $throwBtn = "<button type='button' onclick='throwAttendee(event)'>강퇴</button>";
                }

                $link.append($attendee);
                $attendingItem.append($link, $throwBtn);
                $attendingList.append($attendingItem);
                $attendeeList.append($link.clone());
            }

            for(let i=0; i<waitingDTOList.length; i++){
                $attendingItem = $("<div></div>").addClass('attendingItem')
                    .data("attendee_id", waitingDTOList[i].attendee_id);
                $link = $("<a>").prop("href", "${path}/mypage/moveUserPage/" + waitingDTOList[i].user_id);
                $attendee = "<div class='attendee'><img src='${path}/images/" +
                    waitingDTOList[i].profile + "'><span>" + waitingDTOList[i].nickname + "</span></div>";

                $answer = "<div>" + waitingDTOList[i].answer + "</div>";

                $acceptBtn = "<button type='button' class='acceptBtn' onclick='accept(event)'>승인</button>";
                $rejectBtn = "<button type='button' class='rejectBtn' onclick='reject(event)'>반려</button>";

                $link.append($attendee);
                $attendingItem.append($link, $answer, $acceptBtn, $rejectBtn);
                $waitingList.append($attendingItem);
            }


            $("#attendeeListWrapper").html($attendeeList);
            $("#attendingListWrapper").html($attendingList);
            $("#waitingListWrapper").html($waitingList);
            $(".attendee_count").text(attendeeDTOList.length);
            $(".waiting_count").text(waitingDTOList.length);



        }



    </script>


</head>
<body>
<%@include file="../include/top.jsp" %>

<c:if test="${message!=null}">
    <script>
        alert("${message}");
    </script>
</c:if>

<div id="contents">
    <div id="contentsHeader">
        <h2>오프모임</h2>
    </div>
    <div id="contentsLocation">
        홈 &gt 오프모임
    </div>
    <div id="contentsMain">
    		<div id="postInfo">
    		<span>
	    		<fmt:formatDate value="${dto.post_date}" pattern="yyyy-MM-dd HH:mm"/>
			</span><span>조회 ${dto.view_count}</span>
    		</div>
            <div id="postUpper">
                <div>
                 <div class="map_wrap">
					  <div id="map"></div>
    				  	<div class="hAddr">
					    <span class="title">주소정보</span>
					    <span id="centerAddr"></span>
				   </div>
				 </div>
                </div>

				 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aaa4a3ee6e039439424a544717323d1a&libraries=services"></script>
<script>

  var mapContainer = document.getElementById('map'); // 지도를 표시할 div

  var mapOption =
          {
            center: new kakao.maps.LatLng("${dto.lat}", "${dto.lng}"), // 지도의 중심좌표
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
    zIndex:4,
    disableAutoPan: true
  });

  var infoDiv = document.getElementById('centerAddr');


  makeMap("${dto.lat}", "${dto.lng}");

  function makeMap(lat, lan){
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

        if("${dto.place_name}"!=null && "${dto.place_name}"!=""){
            content = "<div id='infoWindow'><span>" + "${dto.place_name}" + "</span></div>";
        }
        else
            content = '<div id="infoWindow"><span>'+result[0].address.address_name + '</span></div>';

        var position = new kakao.maps.LatLng("${dto.lat}", "${dto.lng}");
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
				 
                <div id="profileArea">
                    <div>
                        <span class="status">${dto.status}</span>
                        <span class="status">
                        <c:choose>
                        	<c:when test="${dto.attendSystem=='p'}">
                        	승인제
                        	</c:when>
                        	<c:otherwise>
                        	선착순
                        	</c:otherwise>
                        </c:choose>
                        </span>
                    </div>
                    <div id="title">${dto.title}</div>
                    <ul>
                        <li>장소:&nbsp&nbsp${dto.address1} ${dto.address2} ${dto.address3} ${dto.place_name}</li>
                        <li>일시:&nbsp&nbsp
                            <fmt:parseDate value="${dto.gathering_date}"
                                           pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both"/>
                            <fmt:formatDate value="${parsedDateTime}" pattern="yyyy.M.dd a h:mm"/>
                        <li>유의사항:&nbsp&nbsp
                        	<c:choose>
                        		<c:when test="${dto.note==null || dto.note == ''}">
                        			-
                        		</c:when>
                        		<c:otherwise>
     		                        ${dto.note}
                        		</c:otherwise>
                        	</c:choose>

                        </li>
                        <li><span class="attendee_count">${dto.attendee_count}</span>/${dto.maxPeople}명 참가중
                            <c:if test="${waitCount>0}">(대기 <span class="waiting_count">${waitCount}</span>명)
                            </c:if>
                            <c:if test="${dto.writer_id == sessionScope.userid}">
                                <button type="button" onclick="showAttendingList()">참가자 관리</button>
                            </c:if>
                            <div id="attendeeListWrapper">
                                <div id="attendeeList">
                                    <c:forEach var="attendee" items="${dto.attendeeDTOList}">
                                        <a href="${path}/mypage/moveUserPage/${attendee.user_id}">

                                        <div class="attendee">
                                            <img src="${path}/images/${attendee.profile}">
                                            <span>${attendee.nickname}</span>
                                        </div>
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <div>
                        <span>작성자: ${dto.nickname}</span>
                        <!--모집완료, 모집마감 고려해서 다시 짜기-->
                        <c:choose>
                            <c:when test="${type == 'WAIT'}">
                                <button type="button" class="bigBtn-cancel" onclick="cancelApplication()">신청취소</button>
                            </c:when>
                            <c:when test="${type == 'ATTENDING'}">
                                <div>
                                <button type="button" id="bigBtn-chat"
                                        onclick="location.href='${path}/chat/room.do?gathering_id=${dto.gathering_id}'">
                                    채팅하기</button>
                                    <c:if test="${dto.writer_id != sessionScope.userid}">
                                    <button type="button" class="bigBtn-cancel"
                                        onclick="withdraw()">
                                    탈퇴하기</button>
                                    </c:if>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${dto.status == '모집중'}">
                                <button type="button" id="bigBtn-apply">참가신청</button>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <div id="postMain">
            ${dto.gathering_content}
            </div>

            <div id="replyArea">
                <div id="replyUpper">
                    <span>댓글[<span id="countReplies"></span>]</span>
                    <span>이 모임에 대해 궁금한 사항이 있으면 댓글을 달아보세요.</span>
                    <c:if test="${sessionScope.userid==dto.writer_id}">
                        <c:if test="${dto.status == '모집중'}">
                            <button type="button" id="btn-Edit"
                                    onclick='editPost()'>수정
                            </button>
                        </c:if>
                        <button type="button" id="btn-Delete"
                                onclick="deletePost()"> 삭제
                        </button>
                    </c:if>
                    <form name="form1" action="${path}/gathering/list.do">
                        <input type="hidden" name="showAvailable" value="${showAvailable}">
                        <input type="hidden" name="option" value="${option}">
                        <input type="hidden" name="keyword" value="${keyword}">
                        <input type="hidden" name="from" value="${from}">
                        <input type="hidden" name="to" value="${to}">
                        <input type="hidden" name="curPage" value="${curPage}">
                        <c:forEach var="address1" items="${address1List}">
                            <input type="hidden" name="address1" type="hidden" value="${address1}">
                        </c:forEach>
                        <button type="submit" id="btn-GoList">목록</button>
                    </form>
                </div>
                <div id="replies">
                </div>
                <form name="replyForm" action="${path}/gathering/addReply.do">
                    <textarea name="reply_text"></textarea>
                    <input type="hidden" name="gathering_id" value="${dto.gathering_id}">
                    <button type="button" class="btn-AddReply">댓글쓰기</button>
                </form>
            </div>
    </div>


    <div class="popup-wrap" id="applyPopup">
        <div class="popup">
            <div class="popup-body">
                <div>이 모임은 허가제 모임입니다.<br>
                    다음 질문에 답한 뒤 모임장의 승인을 받아야 참석할 수 있습니다.</div>
                <div>[질문]&nbsp;${dto.question}</div>
                <input name="answer">
                <div>
                    <button type="button" onclick="submitApplication()">답변제출</button>
                    <button type="button" onclick="modalClose()">취소</button>
                </div>
            </div>
        </div>
    </div>


    <div class="popup-wrap" id="attendingPopup">
        <div class="popup">
            <div class="popup-body">
                <div>
                    <div id="attendingArea">
                        <h2>참가자 (<span class="attendee_count">${dto.attendee_count}</span>/${dto.maxPeople})</h2>
                        <div id="attendingListWrapper">
                            <div id="attendingList">
                            <c:forEach var="attendee" items="${dto.attendeeDTOList}">
                                <div class="attendingItem" data-attendee_id="${attendee.attendee_id}">
                                    <a href="${path}/mypage/moveUserPage/${attendee.user_id}">
                                        <div class="attendee">
                                            <img src="${path}/images/${attendee.profile}">
                                            <span>${attendee.nickname}</span>
                                        </div>
                                    </a>
                                    <c:if test="${attendee.user_id != sessionScope.userid}">
                                        <button type="button" onclick="throwAttendee(event)">강퇴</button>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                        </div>
                    </div>
                    <c:if test="${waitCount > 0}">
                        <div id="waitingArea">
                            <h2>대기자 총 <span class="waiting_count">${waitCount}</span>명</h2>
                            <div>"${dto.question}"</div>
                            <div id="waitingListWrapper">
                                <div id="waitingList">
                                <c:forEach var="waiting" items="${dto.waitingDTOList}">
                                    <div class="attendingItem" data-attendee_id="${waiting.attendee_id}">
                                        <a href="${path}/mypage/moveUserPage/${waiting.user_id}">
                                            <div class="attendee">
                                                <img src="${path}/images/${waiting.profile}">
                                                <span>${waiting.nickname}</span>
                                            </div>
                                        </a>
                                        <div>${waiting.answer}</div>
                                        <button type="button" class="acceptBtn" onclick="accept(event)">승인</button>
                                        <button type="button" class="rejectBtn" onclick="reject(event)">반려</button>
                                    </div>
                                </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:if>

                </div>
                    <button type="button" onclick="modalClose()">닫기</button>
                </div>
            </div>
        </div>
    </div>


<%@include file="../include/footer.jsp" %>
</body>
</html>