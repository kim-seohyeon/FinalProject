<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경 결과</title>
<style>
  body {
    margin: 0;
    padding: 0 0 40px 0;
    background-color: #fff;
    font-family: Arial, sans-serif;
    color: #333;
  }

  .container {
    width: 600px;
    margin: 150px auto;
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 30px 40px 40px 40px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    background-color: #fff;
    text-align: center;
  }

  p {
    font-size: 20px;
    margin-bottom: 40px;
    color: #222;
  }

  a.home-btn {
    padding: 12px 20px;
    background-color: #3498db;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 1rem;
    cursor: pointer;
    transition: background 0.3s;
    
  }

  a.home-btn:hover {
    background-color: #0056b3;
  }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
  <c:if test="${not empty message}">
    <p>${message}</p>
  </c:if>
  <a href="/" class="home-btn">홈으로 이동</a>
</div>


</body>
<%@ include file="/views/footer.jsp" %>
</html>
