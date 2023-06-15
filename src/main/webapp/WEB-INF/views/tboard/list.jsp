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
        $(document).ready(function() {
            $.ajax({
                url: '${path}/tboard/getListImage', // Replace with the actual URL for your controller
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    var productList = response.products; // Assuming the response contains an array of products

                    var productContainer = $('#product-list');

                    // Iterate over the product list and create cards
                    productList.forEach(function(product) {
                        // Create a card element for each product
                        var card = $('<div class="product-card"></div>');

                        // Set the card content, e.g., product name and price
                        card.append('<h2>' + product.name + '</h2>');
                        card.append('<p>Price: ' + product.price + '</p>');

                        // Load the image using another AJAX request
                        $.ajax({
                            url: '/getImage', // Replace with the URL for retrieving images
                            type: 'GET',
                            data: { productId: product.id }, // Pass any necessary data, e.g., product ID
                            success: function(imageUrl) {
                                // Set the image source once it's retrieved
                                card.append('<img src="' + imageUrl + '">');
                            },
                            error: function() {
                                // Handle errors loading the image, if necessary
                            }
                        });

                        // Add the card to the product container
                        productContainer.append(card);
                    });
                },
                error: function() {
                    // Handle errors retrieving the product list, if necessary
                }
            });
        });

        $(function () {
            $("#btnWrite").on("click", function () {
                location.href = "${path}/tboard/write.do";
            });

            function list(page) {
                location.href = "${path}/tboard/list.do?curPage=" + page;
            }
        });

        function view(tb_num) {
            location.href = "${path}/tboard/view/" + tb_num;
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
                중고거래 게시판
            </span>
            <div class="searchFormMain">
                <form id="searchForm" name="searchForm" method="post"
                      action="${path}/tboard/list.do">
                    <div class="search">
                        <select name="select_category">
                            <option value="all" selected="selected">전체</option>
                            <option value="s">판매중</option>
                            <option value="b">구매</option>
                            <option value="n">나눔</option>
                            <option value="f">완료</option>
                        </select>
                        <div class="dot"></div>
                        <select name="search_option" id="searchType">
                            <option value="all" selected="selected">제목+내용+작성자</option>
                            <option value="title">제목</option>
                            <option value="description">내용</option>
                            <option value="writer">작성자</option>
                        </select>
                        <input name="keyword" id="keyword" value="${map.keyword}" maxlength="70">
                        <div class="button">
                            <button>검색</button>
                        </div>
                        <div class="dot"></div>
                        <div class="class">
                            <button type="button" id="btnWrite">글쓰기</button>
                        </div>
                    </div>
                </form>
            </div>

        </div>

        <div>총 게시물 수 : ${map.count}</div>

        <div class="categories">
            <div class="category" title="전체">
                <a href="${path}/tboard/list.do">전체</a>
            </div>
            <div class="category" title="판매">
                <a href="${path}/tboard/list.do?select_category=s">판매</a>
            </div>
            <div class="category" title="구매">
                <a href="${path}/tboard/list.do?select_category=b">구매</a>
            </div>
            <div class="category" title="나눔">
                <a href="${path}/tboard/list.do?select_category=n">나눔</a>
            </div>
            <div class="category" title="완료">
                <a href="${path}/tboard/list.do?select_category=f">완료</a>
            </div>
        </div>
    </div>
    <section id="contentsMain">
        <article class="itemList">
            <c:forEach var="row" items="${map.list}">
                <c:choose>
                    <c:when test="${row.del == 'N'}">
                        <div class="itemCard">
                            <a href="#" target="_blank">
                                <div class="imgCard-thumbnail">
                                    <img src='${path}/resources/uploaded_image${row.first_image}' alt="이미지 자리">
                                </div>
                            </a>
                            <div class="info">
                                <div class="title">
                                    <span class="text">
                                        <a href="#" onclick="view(${row.tb_num})">${row.title}</a>
                                    </span>
                                    <span class="category">
                                        <c:choose>
                                            <c:when test="${row.category == 's'}">
                                                <div class="category" title="판매">
                <a href="${path}/tboard/list.do?select_category=s">판매</a>
            </div>
                                            </c:when>
                                            <c:when test="${row.category == 'b'}">
                                                <div class="category" title="구매">
                <a href="${path}/tboard/list.do?select_category=b">구매</a>
            </div>
                                            </c:when>
                                            <c:when test="${row.category == 'n'}">
                                                <div class="category" title="나눔">
                <a href="${path}/tboard/list.do?select_category=n">나눔</a>
            </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="category" title="완료">
                <a href="${path}/tboard/list.do?select_category=f">완료</a>
            </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <div class="place">
                                        <span>${row.address1}</span>
                                        <span class="dot"></span>
                                        <span>${row.address2}</span>
                                    </div>
                                    <div class="price">
                                            ${row.price}
                                    </div>
                                    <div class="subInfo">
                                        <div class="viewCount">
                                            <%--조회수 눈알모양, 폰트어썸에서 가져옴--%>
                                        <i class="fa-solid fa-eye"></i>
                                        ${row.view_count}
                                        </div>
                                        <div class="dot"></div>
                                        <div class="interestCount">
                                            <i class="fa-solid fa-heart"></i>
                                        </div>
                                        <div class="reCount"><i class="fa-regular fa-comment-dots"></i>${row.re_count}
                                        </div>
                                        <div class="dot"></div>
                                        <div class="createDate">
                                            <i class="fa-regular fa-timer"></i>
                                            <fmt:formatDate value="${row.create_date}"
                                                            pattern="yyyy-MM-dd HH:mm:ss"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="#" onclick="view(${row.tb_num})">삭제된 게시물입니다.</a>
                        <div class="delInfo">
                                ${row.update_user} <br>
                            <i class="fa-regular fa-timer"></i>
                            <fmt:formatDate value="${row.update_date}"
                                            pattern="yyyy-MM-dd HH:mm:ss"/>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </article>
    </section>
    <%--페이지네이션--%>
    <section class="pagenation">

        <c:if test="${map.pager.curBlock > 1}">
        <div class="pageItem">
            <a href="#" onclick="list('1')">[처음]</a>
        </div>
        >
        </c:if>
        <c:if test="${map.pager.curBlock > 1}">
        <div class="pageItem">
            <a href="#" onclick="list('${map.pager.prevPage}')">
                [이전]</a>
        </div>
        </c:if>
        <c:forEach var="num"
                   begin="${map.start}"
                   end="${map.end}">
        <c:choose>
        <c:when test="${num == map.pager.curPage}">
        <!-- 현재 페이지인 경우 하이퍼링크 제거 -->
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
            <a href="#"
               onclick="list('${map.pager.nextPage}')">[다음]</a>
        </div>
        </c:if>
        <c:if test="${map.pager.curPage < map.pager.totPage}">
        <div class="pageItem">
            <a href="#"
               onclick="list('${map.pager.totPage}')">[끝]</a>
        </div>
        </c:if>
</div>
</section>


</div>
</div>
<footer>
    <%@include file="../include/footer.jsp" %>
</footer>
</body>
</html>
