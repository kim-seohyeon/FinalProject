<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>

<style>
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #ffffff;
        color: #333;
    }
    a {
        text-decoration: none;
        color: #333;
    }
    a:hover {
        color: #007BFF;
    }
    .container {
        padding: 40px 20px;
        max-width: 1200px;
        margin: 0 auto;
    }
    .section-title {
        font-size: 2rem;
        font-weight: 700;
        text-align: center;
        margin-left: -730px;
        color: #000;
        margin-bottom: 50px;
    }
    .button-group {
        display: flex;
        justify-content: center;
        margin-left: -800px;
        gap: 10px;
        margin-bottom: 30px;
        margin-top: 30px;
    }
    .button-group a {
        display: inline-block;
        padding: 6px 14px;
        background-color: #ADD8E6;
        color: white;
        border-radius: 6px;
        font-size: 12px;
        transition: background-color 0.3s;
    }
    .button-group a:hover {
        background-color: #7FBFEF;
        color: white;
    }
    .product-grid {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
    }
    .product-item {
        width: calc(20% - 20px);
        background: #fff;
        border: 1px solid #e0e0e0;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        overflow: hidden;
        transition: all 0.3s ease-in-out;
    }
    .product-item:hover {
        transform: translateY(-6px);
        box-shadow: 0 6px 15px rgba(0,0,0,0.12);
    }
    .product-item img {
        width: 100%;
        height: 180px;
        object-fit: contain;
        background-color: #ffffff;
        padding: 10px;
    }
    .product-name {
        padding: 8px 6px 4px;
        font-size: 14px;
        font-weight: 500;
        text-align: center;
        word-break: keep-all;
        height: 36px;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }
    .product-price {
        font-size: 16px;
        color: #e74c3c;
        font-weight: bold;
        text-align: center;
        padding-bottom: 10px;
    }
    #more {
        text-align: center;
        margin: 40px 0;
    }
    #load-more {
        padding: 10px 20px;
        background-color: #007BFF;
        border: none;
        border-radius: 6px;
        color: white;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    #load-more:hover {
        background-color: #0056b3;
    }
    .login-box {
        position: fixed;
        top: 120px;
        right: 40px;
        width: 240px;
        background: #fff;
        padding: 20px;
        border: 1px solid #e0e0e0;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    .login-box input[type="text"],
    .login-box input[type="password"],
    .login-box input[type="submit"] {
        width: 100%;
        padding: 10px;
        margin: 8px 0;
        border: 1px solid #ccc;
        border-radius: 6px;
        box-sizing: border-box;
        font-size: 14px;
    }
    .login-box input[type="submit"] {
        background-color: #007BFF;
        color: white;
        cursor: pointer;
        border: none;
        transition: background-color 0.3s;
    }
    .login-box input[type="submit"]:hover {
        background-color: #0056b3;
    }

    /* 슬라이더용 스타일 */
    .slider-container {
    	width: 1200px;           /* 원하는 배너 너비 */
    	height: 300px;         /* 원하는 배너 높이 */
    	overflow: hidden;
    	position: relative;
    }
    
    .slider-container img{
        width: 100%;
    	height: 100%;
    	object-fit: contain
        max-height: 400px;
        position: absolute;
        overflow: hidden;
        margin-bottom: 40px;
        border-radius: 12px;
    }

    .slider-container img.active {
        opacity: 1;
        z-index: 1;
    }
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(function(){
    let currentPage = 1;

    $("#load-more").click(function(){
        currentPage++;
        $.ajax({
            url: "/goods/page",
            method: "GET",
            data: { page: currentPage },
            dataType: "json",
            success: function(model) {
                let html = "";
                $.each(model.list, function(idx, dto){
                    html += 
                        '<div class="product-item">' +
                            '<a href="/item/detailView?goodsNum=' + dto.goodsNum + '">' +
                                '<img src="/static/goodsUpload/' + dto.goodsMainStoreImage + '" alt="' + dto.goodsName + '" />' +
                                '<div class="product-name">' + dto.goodsName + '</div>' +
                                '<div class="product-price">' + dto.goodsPrice + '원</div>' +
                            '</a>' +
                        '</div>';
                });
                $("#product-list").append(html);

                if (model.maxPage <= currentPage) {
                    $("#more").hide();
                }
            },
            error: function() {
                alert("상품을 불러오는 데 실패했습니다.");
                currentPage--;
            }
        });
    });
});

// 슬라이더 전환 기능

        $(function(){
            interval = setInterval(up_content, 4000);
            $("#content").hover(function(){
                clearInterval(interval);
            },function(){
                interval = setInterval(up_content, 4000);
            });
        });
        function up_content(){
            $("#content img:last").after($("#content img:first"));
        }
        function down_content(){
            $("#content img:first").before($("#content img:last"));
        }

</script>

</head>

<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <c:if test="${!empty auth}">
        <!-- 슬라이더 이미지 영역 -->
        <div class="slider-container" id="content">
            <img src="<c:url value='/static/images/aaaa.jpg' />" alt="배너1" />
            <img src="<c:url value='/static/images/aaaa1.jpg' />" alt="배너2" />
            <img src="<c:url value='/static/images/aaaa2.jpg' />" alt="배너3" />
        </div>

        <div class="button-group">
            <a href="/item/wishList">찜 목록</a>
            <a href="/item/purchaseList">구매 목록</a>
        </div>
    </c:if>

    <div id="content">
        <div class="product-grid" id="product-list">
            <c:forEach items="${list}" var="dto">
                <div class="product-item">
                    <a href="/item/detailView?goodsNum=${dto.goodsNum}">
                        <img src="/static/goodsUpload/${dto.goodsMainStoreImage}" alt="${dto.goodsName}" />
                        <div class="product-name">${dto.goodsName}</div>
                        <div class="product-price">${dto.goodsPrice}원</div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <div id="more">
        <button id="load-more">더보기</button>
    </div>

    <c:if test="${empty auth}">
        <div class="login-box">
            <form:form modelAttribute="loginCommand" action="/login/login" method="post">
                <div>
                    <label><input type="checkbox" name="autoLogin" /> 자동 로그인</label><br/>
                    <label><input type="checkbox" name="idStore"
                        <c:if test="${loginCommand.idStore}">checked</c:if> /> 아이디 저장</label>
                </div>
                <div>
                    <form:input path="userId" placeholder="아이디" />
                    <form:errors path="userId"/>
                </div>
                <div>
                    <form:password path="userPw" placeholder="비밀번호"/>
                    <form:errors path="userPw"/>
                </div>
                <div>
                    <input type="submit" value="로그인" />
                </div>
                <div style="margin-top:10px; font-size:0.85em; text-align: center;">
                    <a href="/help/findId">아이디</a> /
                    <a href="/help/findPassword">비밀번호 찾기</a> |
                    <a href="/register/userAgree">회원가입</a>
                </div>
            </form:form>
        </div>
    </c:if>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
