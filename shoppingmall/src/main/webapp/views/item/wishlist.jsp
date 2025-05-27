<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜한 상품</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Inter', sans-serif;
        background-color: #f5f6f8;
        margin: 0;
        padding: 0;
        color: #333;
    }

    .container {
        max-width: 1100px;
        margin: 50px auto;
        padding: 0 20px;
    }

    h2 {
        font-size: 24px;
        font-weight: 600;
        text-align: center;
        margin-bottom: 40px;
    }

    .item-card {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #fff;
        border-radius: 16px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.06);
        transition: transform 0.2s ease;
    }

    .item-card:hover {
        transform: translateY(-4px);
    }

    .item-left {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .item-img img {
    max-width: 100px;
    max-height: 100px;
    border-radius: 12px;
    object-fit: contain;
    border: 1px solid #ddd;
    background-color: #fff;
    padding: 4px;
}


    .item-info {
        display: flex;
        flex-direction: column;
        gap: 6px;
    }

    .item-info .name {
        font-size: 18px;
        font-weight: 600;
        color: #111;
    }

    .item-info .brand {
        font-size: 14px;
        color: #888;
    }

    .item-right {
        text-align: right;
    }

    .item-right .price {
        font-size: 17px;
        font-weight: 600;
        color: #e60023;
        margin-bottom: 10px;
    }

    .item-right a {
        padding: 8px 16px;
        font-size: 14px;
        background-color: #222;
        color: #fff;
        text-decoration: none;
        border-radius: 8px;
        transition: background-color 0.3s ease;
    }

    .item-right a:hover {
        background-color: #444;
    }

    .empty-message {
        text-align: center;
        font-size: 18px;
        color: #aaa;
        padding: 80px 0;
    }

    @media (max-width: 768px) {
        .item-card {
            flex-direction: column;
            align-items: flex-start;
            gap: 16px;
        }

        .item-right {
            align-self: flex-end;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .item-right .price {
            margin-bottom: 0;
        }
    }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h2>찜한 상품 목록</h2>

    <c:if test="${empty wishList}">
        <div class="empty-message">찜한 상품이 없습니다.</div>
    </c:if>

    <c:if test="${not empty wishList}">
        <c:forEach var="item" items="${wishList}">
            <div class="item-card">
                <div class="item-left">
                    <div class="item-img">
                        <img src="/static/goodsUpload/${item.goodsMainStoreImage}" alt="${item.goodsName}" />
                    </div>
                    <div class="item-info">
                        <div class="name">${item.goodsName}</div>
                        <div class="brand">${item.stockName}</div>
                    </div>
                </div>
                <div class="item-right">
                    <div class="price">
                        <fmt:formatNumber value="${item.goodsPrice}" pattern="###,###" />원
                    </div>
                    <a href="/item/detailView?goodsNum=${item.goodsNum}">상세보기</a>
                </div>
            </div>
        </c:forEach>
    </c:if>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
