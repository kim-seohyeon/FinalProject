<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.1.min.js"></script>

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
    		margin-left: -730px; /* 추가, 값은 조정 가능 */
            color: #000;
            margin-bottom: 50px;
            text-shadow: none;
            letter-spacing: normal;
        }

    .button-group {
        display: flex;
        justify-content: center;
        margin-left: -800px; 
        gap: 10px;
        margin-bottom: 30px;
    }

   .button-group a {
    display: inline-block;
    padding: 6px 14px;        /* 기존 10px 20px에서 작게 조절 */
    background-color: #ADD8E6;; /* 연한 블루색 */
    color: white;
    border-radius: 6px;
    font-size: 12px;          /* 기존 14px에서 작게 */
    transition: background-color 0.3s;
}

.button-group a:hover {
    background-color: #7FBFEF; /* 살짝 진한 블루로 호버 */
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
        transition: transform 0.2s;
    }

    .product-item:hover {
        transform: translateY(-5px);
    }

    .product-item img {
        width: 100%;
        height: 180px;
        object-fit: cover;
    }

    .product-item div {
        padding: 10px;
        font-size: 14px;
        text-align: center;
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
</style>

<script type="text/javascript">
$(function(){
	page = 1;
	$("#load-more").click(function(){
		page++;
		$.ajax({
			url:"loadMore",
			type: "post",
			data: {"page":page},
			dataType: "json",
			success: function(model){
				var item = "";
				$.each(model.list , function(idx, dto){
					item += '<div class="product-item">';
					item += '<a href="goodsDetail?goodsNum='+dto.goodsNum+'">';
					item += '<img src="/static/goodsUpload/'+dto.goodsImageStoreName+'" />';
					item += '<div>'+dto.goodsSubject+'</div>';
					item += '<div>'+dto.goodsWriter+'</div>';
					item += '</a>';
					item += '</div>';
				});
				$("#product-list").append(item);
				if(model.maxPage <= page) $("#more").hide();
			}
		});
	});
});
</script>
</head>

<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <c:if test="${!empty auth}">
        <div class="section-title">SJD 판매상품!!🛍️</div>
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
                        <img src="/static/goodsUpload/${dto.goodsMainStoreImage}" />
                        <div>${dto.goodsName}</div>
                        <div><strong>${dto.goodsPrice}원</strong></div>
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