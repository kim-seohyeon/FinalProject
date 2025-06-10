<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${dto.goodsName} 상세보기</title>
<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', sans-serif;
        background-color: #ffffff;
    }

    .container {
        max-width: 800px;
        margin: 50px auto;
        background: #fff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
    }

    h2 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 30px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        border: 1px solid #ddd;
    }

    th, td {
        padding: 16px;
        border-bottom: 1px solid #ddd;
    }

    th {
        text-align: left;
        background-color: #f9fafc;
        width: 180px;
        font-weight: 600;
        color: #444;
    }

    td {
        background-color: #fff;
        color: #333;
    }

    img {
        margin-top: 10px;
        margin-right: 10px;
        border-radius: 5px;
        object-fit: cover;
        border: 1px solid #ccc;
    }

    .btn-group {
        margin-top: 30px;
        text-align: center;
    }

    .btn-group a {
        display: inline-block;
        padding: 10px 20px;
        background-color: #3498db;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        margin: 0 10px;
        transition: background-color 0.3s ease;
    }

    .btn-group a:hover {
        background-color: #2980b9;
    }
</style>

</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h2>📦 ${dto.goodsName} 상세정보</h2>
    <table>
        <tr><th>상품번호</th><td>${dto.goodsNum}</td></tr>
        <tr><th>브랜드명 (주식종목이름)</th><td>${dto.stockName}</td></tr>
        <tr><th>상품명</th><td>${dto.goodsName}</td></tr>
        <tr><th>상품가격</th><td>${dto.goodsPrice}</td></tr>
        <tr><th>상품설명</th><td>${dto.goodsContents}</td></tr>
        <tr><th>조회수</th><td>${dto.visitCount}</td></tr>
        <tr><th>등록한 사원</th><td>${dto.empNum}</td></tr>
        <tr><th>등록일</th><td>${dto.goodsRegist}</td></tr>
        <tr><th>수정한 사원</th><td>${dto.updateEmpNum}</td></tr>
        <tr><th>수정일</th><td>${dto.goodsUpdateDate}</td></tr>
        <tr>
            <th>메인 이미지</th>
            <td>
                <img width="300" height="200" src="/static/goodsUpload/${dto.goodsMainStoreImage}" alt="메인이미지" />
            </td>
        </tr>
        <tr>
            <th>상세 이미지</th>
            <td>
                <c:forTokens items="${dto.goodsDetailStoreImage}" delims="`" var="image">
                    <img width="300" height="200" src="/static/goodsUpload/${image}" alt="상세이미지" />
                </c:forTokens>
            </td>
        </tr>
    </table>

    <div class="btn-group">
        <a href="goodsUpdate?goodsNum=${dto.goodsNum}">상품 수정</a>
        <a href="goodsDelete?goodsNum=${dto.goodsNum}">상품 삭제</a>
        <a href="goodsList">상품 목록</a>
    </div>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
