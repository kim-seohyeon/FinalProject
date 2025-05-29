<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<style>
  body {
    margin: 0;
    background-color: #ffffff;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    color: #2c3e50;
  }
  .container {
    max-width: 500px;
    margin: 60px auto;
    padding: 40px;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    text-align: center;
  }
  h2 {
    margin-bottom: 20px;
    font-size: 1.8rem;
    color: #34495e;
    border-bottom: 2px solid #3498db;
    padding-bottom: 10px;
  }
  p {
    font-size: 1.2rem;
    margin-top: 20px;
  }
  .highlight {
    font-weight: bold;
    color: #3498db;
    font-size: 1.4rem;
  }
  .btn-back {
    margin-top: 30px;
    padding: 10px 25px;
    background-color: #3498db;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 1rem;
    cursor: pointer;
    transition: background 0.3s;
    text-decoration: none;
  }
  .btn-back:hover {
    background-color: #2980b9;
  }
</style>
</head>
<body>

<jsp:include page="/views/header.jsp" />

<div class="container">
  <h2>아이디 찾기 결과</h2>

  <c:choose>
    <c:when test="${not empty userId}">
      <p>당신의 아이디는 <span class="highlight">
        ${fn:substring(userId, 0, 3)}
        <c:forEach var="i" begin="1" end="${fn:length(userId) - 3}">
          *
        </c:forEach>
      </span> 입니다.</p>

    </c:when>
        <c:otherwise>
      <p>입력한 정보에 해당하는 아이디가 존재하지 않습니다.</p>
    </c:otherwise>
  </c:choose>

  <a href="/help/findId" class="btn-back">돌아가기</a>
</div>

</body>
</html>
