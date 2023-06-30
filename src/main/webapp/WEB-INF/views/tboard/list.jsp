<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <%@ include file="../include/js/header.jsp" %>
    <script src="${path}/include/js/jquery-3.6.3.min.js"></script>
    <link rel="stylesheet" href="${path}/include/css/trade/list.css">
    <script type="text/javascript">
        function memberPostList() {

        }


        $(function () {

            $("#searchForm").on("load", function () {
                const searchForm = $("form[name='searchForm']");
                searchForm.find("select[naem='category']").val("${map.sDto.category}");
                searchForm.find("select[name='search_option']").val("${map.sDto.search_option}");
                searchForm.find("select[name='keyword']").val("${map.sDto.keyword}");
            });

            /*글쓰기 버튼*/
            $("#btnWrite").on("click", function () {
                location.href = "${path}/tboard/write.do";
            });

            $(".category").on("click", function () {
                let category = $(this).text();
                let searchForm = $("form[name='searchForm']");
                searchForm.find("select[name='category']").val(category);
                searchForm.submit();
            });
        });

        /*중고거래 view*/
        function view(tb_num) {
            location.href = "${path}/tboard/view/" + tb_num;
        }

        /*중고거래 페이지 이동*/
        function list(page) {
            let queryString = $("form[name='searchForm']").serialize() + "&curPage=" + page;
            location.href = "${path}/tboard/list.do?" + queryString;
        }
    </script>
</head>
<body>
<header>
    <%@include file="../include/top.jsp" %>
</header>
<div id="contents">
    <div id="contentsHeader">
        <div id="searchFormSection">
            <span class="h2">
                중고장터
            </span>
            <div class="searchFormMain">
                <form id="searchForm" name="searchForm" method="post"
                      action="${path}/tboard/list.do">
                    <div class="search">
                        <select name="category">
                            <c:choose>
                                <c:when test="${map.sDto.category eq 'all'}">
                                    <option value="all" selected="selected">전체</option>
                                    <option value="판매">판매</option>
                                    <option value="구매">구매</option>
                                    <option value="나눔">나눔</option>
                                    <option value="완료">완료</option>
                                </c:when>
                                <c:when test="${map.sDto.category eq '판매'}">
                                    <option value="all">전체</option>
                                    <option value="판매" selected="selected">판매</option>
                                    <option value="구매">구매</option>
                                    <option value="나눔">나눔</option>
                                    <option value="완료">완료</option>
                                </c:when>
                                <c:when test="${map.sDto.category eq '구매'}">
                                    <option value="all">전체</option>
                                    <option value="판매">판매</option>
                                    <option value="구매" selected="selected">구매</option>
                                    <option value="나눔">나눔</option>
                                    <option value="완료">완료</option>
                                </c:when>
                                <c:when test="${map.sDto.category eq '나눔'}">
                                    <option value="all">전체</option>
                                    <option value="판매">판매</option>
                                    <option value="구매">구매</option>
                                    <option value="나눔" selected="selected">나눔</option>
                                    <option value="완료">완료</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="all">전체</option>
                                    <option value="판매">판매</option>
                                    <option value="구매">구매</option>
                                    <option value="나눔">나눔</option>
                                    <option value="완료" selected="selected">완료</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                        <div class="dot"></div>
                        <select name="search_option" id="searchType">
                            <c:choose>
                                <c:when test="${map.sDto.search_option == 'all'}">
                                    <option value="all" selected="selected">제목+내용+유저 ID+닉네임</option>
                                    <option value="title">제목</option>
                                    <option value="description">내용</option>
                                    <option value="create_user">유저 ID</option>
                                    <option value="nickname">닉네임</option>
                                </c:when>
                                <c:when test="${map.sDto.search_option == 'title'}">
                                    <option value="all">제목+내용+유저 ID+닉네임</option>
                                    <option value="title" selected="selected">제목</option>
                                    <option value="description">내용</option>
                                    <option value="create_user">유저 ID</option>
                                    <option value="nickname">닉네임</option>
                                </c:when>
                                <c:when test="${map.sDto.search_option == 'description'}">
                                    <option value="all">제목+내용+유저 ID+닉네임</option>
                                    <option value="title">제목</option>
                                    <option value="description" selected="selected">내용</option>
                                    <option value="create_user">유저 ID</option>
                                    <option value="nickname">닉네임</option>
                                </c:when>
                                <c:when test="${map.sDto.search_option == 'description'}">
                                    <option value="all">제목+내용+유저 ID+닉네임</option>
                                    <option value="title">제목</option>
                                    <option value="description">내용</option>
                                    <option value="create_user" selected="selected">유저 ID</option>
                                    <option value="nickname">닉네임</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="all">제목+내용+유저 ID+닉네임</option>
                                    <option value="title">제목</option>
                                    <option value="description">내용</option>
                                    <option value="create_user">유저 ID</option>
                                    <option value="nickname" selected="selected">닉네임</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                        <input name="keyword" id="keyword" value="${map.sDto.keyword}" maxlength="70">
                        <div class="button">
                            <button>검색</button>
                        </div>
                        <div class="dot"></div>
                        <div class="class">
                            <button type="button" id="btnWrite">글쓰기</button>
                        </div>
                    </div>
                </form>
                <%--검색form end--%>
            </div>
        </div>

        <div>총 게시물 수 : ${map.count}</div>

        <div class="categories">
            <div class="category" title="전체">전체</div>
            <div class="category" title="판매">판매</div>
            <div class="category" title="구매">구매</div>
            <div class="category" title="나눔">나눔</div>
            <div class="category" title="완료">완료</div>
        </div>
    </div>
    <section id="contentsMain">
        <article class="itemList">
            <c:forEach var="row" items="${map.list}">
                <div class="itemCard">
                    <a href="#" onclick="view(${row.tb_num})" target="_blank">
                        <div class="imgCard-thumbnail">
                            <c:choose>
                                <c:when test="${row.tb_thumbnail != null}">
                                    <%-- 업로드 경로에서 썸네일 이미지 리턴 --%>
                                    <img src='${path}/resources/uploaded_image${row.tb_thumbnail}'>
                                </c:when>
                                <c:otherwise>
                                    <img src="${path}/images/no-image-svgrepo-com.svg" alt="" width="20%">
                                </c:otherwise>

                            </c:choose>
                        </div>
                    </a>
                    <div class="info">
                        <div class="title">
                                    <span class="text">
                                        <a href="#" onclick="view(${row.tb_num})">${row.title}</a>
                                    </span>
                        </div>
                        <c:choose>
                            <c:when test="${row.category eq '판매'}">
                                        <span class="category" title="판매">
                                            <a href="${path}/tboard/list.do?category=판매">판매</a>
                                        </span>
                            </c:when>
                            <c:when test="${row.category eq '구매'}">
                                        <span class="category" title="구매">
                                            <a href="${path}/tboard/list.do?category=구매">구매</a>
                                        </span>
                            </c:when>
                            <c:when test="${row.category eq '나눔'}">
                                        <span class="category" title="나눔">
                                            <a href="${path}/tboard/list.do?category=나눔">나눔</a>
                                        </span>
                            </c:when>
                            <c:otherwise>
                                        <span class="category" title="완료">
                                            <a href="${path}/tboard/list.do?category=완료">완료</a>
                                        </span>
                            </c:otherwise>
                        </c:choose>
                        <div class="price"
                        >
                            <c:choose>
                                <c:when test="${row.category eq '나눔'}">
                                    무료
                                </c:when>
                                <c:otherwise>
                                    ${row.price}&nbsp;원
                                </c:otherwise>
                            </c:choose>
                            <div class="userNick">
                                <a href="#" onclick="memberPostList(${row.create_user})">${row.nickname}</a>
                            </div>
                        </div>
                        <div class="place">
                            <span>${row.address1}</span>
                            <span class="dot"></span>
                            <span>${row.address2}</span>
                        </div>
                        <div class="subInfo">
                            <div class="viewCount">
                                    <%--조회수 눈알모양, 폰트어썸에서 가져옴--%>
                                <i class="fa-solid fa-eye"></i>
                                    ${row.view_count}
                            </div>
                            <div class="dot"></div>
                            <div class="likeCount">
                                <a href="#" onclick="likeIt(${row.tb_num})">
                                    <i class="fa-solid fa-heart"></i>
                                </a>
                                ${row.good_count}
                            </div>
                            <div class="reCount"><i class="fa-regular fa-comment-dots"></i>${row.re_count}</div>
                            <div class="dot"></div>
                            <div class="createDate">
                                <i class="fa-regular fa-timer"></i>
                                    ${row.create_date}
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </article>
    </section>
    <%--페이지네이션--%>
    <section class="pagenation">
        <c:if test="${map.pager.curPage > 1}">
            <div class="pageItem">
                <a href="#" onclick="list(1)">&lt;&lt;</a>
            </div>
        </c:if>
        <c:if test="${pager.curBlock > 1}">
            <div class="pageItem">
                <a href="#" onclick="list('${map.pager.prevBlock}')">&lt;</a>
            </div>
        </c:if>
        <c:forEach var="num" begin="${map.pager.blockStart}" end="${map.pager.blockEnd}">
            <c:choose>
                <c:when test="${num == map.pager.curPage}">
                    <!-- 현재 페이지인 경우 onclick 없음 -->
                    <div class="pageItem">
                        <div id="curPage" style="color:red;">${num}</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="pageItem">
                        <a href="#" onclick="list('${num}')">${num}</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${map.pager.curBlock < map.pager.totBlock}">
            <div class="pageItem">
                <a href="#" onclick="list('${map.pager.nextBlock}')">&gt;</a>
            </div>
        </c:if>
        <c:if test="${map.pager.curPage < map.pager.totPage}">
            <div class="pageItem">
                <a href="#" onclick="list(${map.pager.totPage})">&gt;&gt;</a>
            </div>
        </c:if>
    </section>
</div>
<%--</div>--%>
<footer>
    <%@include file="../include/footer.jsp" %>
</footer>
</body>
</html>
