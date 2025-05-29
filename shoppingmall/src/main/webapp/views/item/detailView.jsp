<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${dto.goodsName} - 상세 보기</title>
<script src="https://code.jquery.com/jquery-1.8.1.js"></script>
<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #ffffff;
        margin: 0;
        padding: 0;
    }
    .wrapper {
        max-width: 960px;
        margin: 50px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    }
    .product {
        display: flex;
        gap: 30px;
    }
    .product img.main-image {
        width: 350px;
        border-radius: 10px;
        border: 1px solid #ddd;
    }
    .details {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 12px;
    }
    .details h2 {
        font-size: 24px;
        margin: 0;
    }
    .details .brand, .details .views {
        color: #777;
        font-size: 14px;
    }
    .details .price {
        font-size: 20px;
        color: #d60000;
        font-weight: bold;
    }
    .controls {
        margin-top: 10px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .controls input[type="number"] {
        width: 60px;
        padding: 5px;
    }
    .controls button {
        padding: 8px 14px;
        border: none;
        border-radius: 6px;
        background-color: #333;
        color: #fff;
        cursor: pointer;
    }
    #wish {
        cursor: pointer;
        width: 28px;
        transition: transform 0.2s;
    }
    #wish:hover {
        transform: scale(1.1);
    }
    .description {
        margin-top: 40px;
        border-top: 1px solid #ddd;
        padding-top: 20px;
    }
    .description img {
        width: 100%;
        margin-top: 20px;
        border-radius: 10px;
    }
</style>

<script>
$(function(){
    $("#cartBtn").click(function(){
        $.ajax({
            type: "post",
            url: "cart",   
            data: {
                "goodsNum": "${dto.goodsNum}",
                "cartQty": $("#cartQty").val()
            },
            success: function(){        
                let loc = confirm("장바구니로 이동하시겠습니까?");
                if(loc) location.href = "/item/cartList";
            },
            error: function(){
                window.open("/login/loginCk", "로그인", "width=400, height=100");
            }
        });
    });

    $("#buyItem").click(function(){
        if(${empty auth}) {
            window.open("/login/loginCk", "로그인", "width=400, height=100");
        } else {
            location.href = "buy?goodsNum=${dto.goodsNum}&cartQty=" + $("#cartQty").val();
        }
    });

    $("#wish").click(function(){
        $.ajax({
            type : "post",
            url : "wishItem",
            data : { "goodsNum" : "${dto.goodsNum}" },
            dataType: "json",
            success : function(response){
                if(response){
                    $("#wish").attr("src", "/static/images/heart.jpg");
                } else {
                    $("#wish").attr("src", "/static/images/emptyheart.jpg");
                }
            },
            error:function(){
                alert("로그아웃 되었습니다.\n다시 로그인 해 주세요");
                window.open("/login/loginCk", "로그인", "width=400, height=100");
            }
        });
    });
});
</script>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="wrapper">
    <div class="product">
        <img class="main-image" src="/static/goodsUpload/${dto.goodsMainStoreImage}" alt="상품 메인 이미지">
        <div class="details">
            <h2>${dto.goodsName}</h2>
            <div class="brand">브랜드: ${dto.stockName}</div>
            <div class="price"><fmt:formatNumber value="${dto.goodsPrice}" pattern="###,###"/>원</div>
            <div class="views">조회수: ${dto.visitCount}</div>

            <div class="controls">
                <input type="number" min="1" value="1" id="cartQty">
                <button type="button" id="cartBtn">장바구니</button>
                <button type="button" id="buyItem">바로 구매</button>
                <c:if test="${empty wish}">
                    <img src="/static/images/emptyheart.jpg" id="wish">
                </c:if>
                <c:if test="${!empty wish}">
                    <img src="/static/images/heart.jpg" id="wish">
                </c:if>
            </div>
        </div>
    </div>

    <div class="description">
        <p>${dto.goodsContents}</p>
        <c:forTokens items="${dto.goodsDetailStoreImage}" delims="`" var="image">
            <img src="/static/goodsUpload/${image}" alt="상품 상세 이미지">
        </c:forTokens>
    </div>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
