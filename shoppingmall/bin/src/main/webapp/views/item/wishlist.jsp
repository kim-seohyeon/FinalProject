<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Wish List</title>
<style>
    table {
        width: 800px;
        border-collapse: collapse;
        margin: 20px auto;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }
    img {
        max-width: 100px;
    }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<h2 style="text-align:center;">찜한 상품 목록</h2>

<c:if test="${empty wishList}">
    <p style="text-align:center;">찜한 상품이 없습니다.</p>
</c:if>

<c:if test="${not empty wishList}">
    <table>
        <thead>
            <tr>
                <th>상품 이미지</th>
                <th>상품명</th>
                <th>가격</th>
                <th>브랜드</th>
                <th>상세보기</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${wishList}">
                <tr>
                    <td><img src="/static/goodsUpload/${item.goodsMainStoreImage}" /></td>
                    <td>${item.goodsName}</td>
                    <td><fmt:formatNumber value="${item.goodsPrice}" pattern="###,###" />원</td>
                    <td>${item.stockName}</td>
                    <td><a href="/item/detailView?goodsNum=${item.goodsNum}">보기</a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>
<%@ include file="/views/footer.jsp" %>
</body>
</html>
