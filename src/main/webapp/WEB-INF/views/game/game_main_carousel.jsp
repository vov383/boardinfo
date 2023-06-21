<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ page session="true" %>
<!-- 세션사용여부 -->

<!DOCTYPE html>
<html>
<head>
    <style>
        .carousel-control {
            left: -12px;
        }

        .carousel-control.right {
            right: -12px;
        }

        .carousel {
            margin: 10px auto;
            padding: 0 20px;
        }

        .carousel .item {
            min-height: 200px;
            text-align: center;
            overflow: hidden;
        }

        .carousel .item .img-box {
            height: 150px;
            width: 100%;
            position: relative;
        }

        .carousel .item img {
            width: 150px;
            height: 150px;
            display: inline-block;
            position: absolute;
            bottom: 0;
            margin: 0 auto;
            left: 0;
            right: 0;
        }

        .carousel .item h4 {
            font-size: 18px;
            margin: 0;
        }

        .carousel .item .btn {
            color: #333;
            border-radius: 0;
            font-size: 11px;
            text-transform: uppercase;
            font-weight: bold;
            background: none;
            border: 1px solid #ccc;
            padding: 5px 10px;
            margin-top: 5px;
            line-height: 16px;
        }

        .carousel .item .btn:hover, .carousel .item .btn:focus {
            color: #fff;
            background: #000;
            border-color: #000;
            box-shadow: none;
        }

        .carousel .item .btn i {
            font-size: 14px;
            font-weight: bold;
            margin-left: 5px;
        }

        .carousel .thumb-wrapper {
            text-align: center;

        }
        .carousel .thumb-content {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            width: 160px;
        }

        .carousel .carousel-control {
            height: 80%;
            width: 40px;
            background: none;
            margin: auto 0;
        }

        .carousel .carousel-control i {
            font-size: 30px;
            position: absolute;
            top: 50%;
            display: inline-block;
            margin: -16px 0 0 0;
            z-index: 5;
            left: 0;
            right: 0;
            color: rgba(0, 0, 0, 0.8);
            text-shadow: none;
            font-weight: bold;
        }

        .carousel .carousel-control.left i {
            margin-left: -3px;
        }

        .carousel .carousel-control.left i {
            margin-right: -3px;
        }


        .divider {
            position: relative;
            height: 1px;
        }

        .div-transparent:before {
            content: "";
            position: absolute;
            top: 0;
            left: 5%;
            right: 5%;
            width: 90%;
            height: 1px;
            background-image: linear-gradient(to right, transparent, rgb(48, 49, 51), transparent);
        }

        .col-sm-1, .col-sm-2, .col-sm-8 {
            padding: 0;
        }

        .carousel .item h3 {
            margin-top: 0;
        }

        .subtitle {
            display: inline-block;
        }

        .more {
            float: right;
            margin-top: 20px;
        }
        .col-md-12 {
            height: 280px;
        }
    </style>
</head>
<body>
<!-- 모듈 내용 -->


<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2 class="subtitle">이 주의 랭킹</h2>
            <span class="more">
                <a href="${path}/game/gamerank/week"><h4>더보기</h4></a>
            </span>
            <div id="weeklyCarousel" class="carousel slide" data-ride="carousel" data-interval="0">
                <!-- Wrapper for carousel items -->
                <div class="carousel-inner">

                    <div class="item active">
                        <div class="row">
                            <c:set var="i" value="0"/>
                            <c:set var="j" value="5"/>

                            <c:forEach var="row" items="${map.weeklyList}">

                            <c:if test="${i%j==0 && i != 0}">
                            <div class="item">
                                <div class="row">
                                    </c:if>
                                    <c:choose>

                                    <c:when test="${i%j==0}">
                                    <div class="col-sm-2 col-sm-offset-1">
                                        </c:when>
                                        <c:otherwise>
                                        <div class="col-sm-2">
                                            </c:otherwise>

                                            </c:choose>

                                            <div class="thumb-wrapper">
                                                <a href="${path}/game/view.do?gnum=${row.gnum}">
                                                <div class="img-box">
                                                    <img src="${row.bgg_thumbnail}" class="img-responsive"
                                                         alt="">
                                                </div>
                                                <div class="thumb-content row">
                                                    <div class="col-sm-2 col-sm-offset-1"><h3>${row.game_rank}</h3></div>
                                                    <div class="col-sm-8 col-sm-offset-1">
                                                        <h4>${row.gametitle}</h4>
                                                        <p>${row.gametitle_eng}(${row.release_year})</p>
                                                    </div>
                                                </div>
                                                </a>
                                            </div>
                                        </div>
                                        <c:if test="${i%j==j-1}">
                                    </div>
                                </div>
                                </c:if>

                                <c:set var="i" value="${i+1}"/>

                                </c:forEach>
                            </div>

                            <!-- Carousel controls -->
                            <a class="carousel-control left" href="#weeklyCarousel" data-slide="prev">
                                <i class="fa fa-angle-left"></i>
                            </a>
                            <a class="carousel-control right" href="#weeklyCarousel" data-slide="next">
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="wrapper">
                    <div class="divider div-transparent"></div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <h2 class="subtitle">최신 등록 게임</h2>
                        <span class="more">
                            <a href="${path}/game/gamerank/newbie"><h4>더보기</h4></a>
                        </span>
                        <div id="newbieCarousel" class="carousel slide" data-ride="carousel" data-interval="0">
                            <!-- Wrapper for carousel items -->
                            <div class="carousel-inner">

                                <div class="item active">
                                    <div class="row">
                                        <c:set var="i" value="0"/>
                                        <c:set var="j" value="5"/>

                                        <c:forEach var="row" items="${map.newbieList}">

                                        <c:if test="${i%j==0 && i != 0}">
                                        <div class="item">
                                            <div class="row">
                                                </c:if>
                                                <c:choose>

                                                <c:when test="${i%j==0}">
                                                <div class="col-sm-2 col-sm-offset-1">
                                                    </c:when>
                                                    <c:otherwise>
                                                    <div class="col-sm-2">
                                                        </c:otherwise>

                                                        </c:choose>

                                                            <div class="thumb-wrapper">
                                                                <a href="${path}/game/view.do?gnum=${row.gnum}">
                                                                <div class="img-box">
                                                                    <img src="${row.bgg_thumbnail}" class="img-responsive"
                                                                         alt="">
                                                                </div>
                                                                <div class="thumb-content row">
                                                                    <div class="col-sm-2 col-sm-offset-1"><h3>${row.game_rank}</h3></div>
                                                                    <div class="col-sm-8 col-sm-offset-1">
                                                                        <h4>${row.gametitle}</h4>
                                                                        <p>${row.gametitle_eng}(${row.release_year})</p>
                                                                    </div>
                                                                </div>
                                                                </a>
                                                            </div>
                                                    </div>
                                                    <c:if test="${i%j==j-1}">
                                                </div>
                                            </div>
                                            </c:if>

                                            <c:set var="i" value="${i+1}"/>

                                            </c:forEach>
                                        </div>
                                        <!-- Carousel controls -->
                                        <a class="carousel-control left" href="#newbieCarousel" data-slide="prev">
                                            <i class="fa fa-angle-left"></i>
                                        </a>
                                        <a class="carousel-control right" href="#newbieCarousel" data-slide="next">
                                            <i class="fa fa-angle-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
</body>
</html>