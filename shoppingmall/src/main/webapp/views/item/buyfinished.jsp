<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 완료</title>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f4f6f8;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 600px;
        margin: 100px auto;
        padding: 40px;
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 4px 16px rgba(0,0,0,0.1);
        text-align: center;
    }

    .container h1 {
        font-size: 32px;
        color: #2ecc71;
        margin-bottom: 20px;
    }

    .container p {
        font-size: 18px;
        color: #333;
        margin-bottom: 30px;
    }

    .btn-group a {
        display: inline-block;
        padding: 10px 20px;
        margin: 0 10px;
        background-color: #3498db;
        color: white;
        border-radius: 8px;
        text-decoration: none;
        font-weight: bold;
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
    <h1>🎉 결제가 완료되었습니다!</h1>
    <p>구매해주셔서 감사합니다.<br>구매 내역은 마이페이지에서 확인하실 수 있습니다.</p>
    <div class="btn-group">
        <a href="purchaseList">구매리스트로 가기</a>
        <a href="<c:url value='/' />">홈으로</a>
    </div>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
