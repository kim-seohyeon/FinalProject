<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>purchaseList.jsp</title>
<style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #ffffff;
    margin: 0;
    padding: 0;
    color: #34495e;
  }

  .container {
    width: 90%;
    max-width: 1000px;
    margin: 60px auto 100px;
    padding: 0 30px;
    color: #2c3e50;
  }

  h1 {
    text-align: left;
    color: #000;
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 40px;
  }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 8px 16px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 14px 18px;
            border-bottom: 1px solid #e0e0e0;
            text-align: center;
            color: #2c3e50;
        }

        th {
            background-color: #3498db;
            color: white;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f1f8ff;
            box-shadow: 0 2px 8px rgba(52, 152, 219, 0.2);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        td a {
            color: #2c3e50;
            font-weight: 500;
            text-decoration: none;
        }

        td a:hover {
            color: #3498db;
            text-decoration: underline;
        }



  @media (max-width: 700px) {
    .container {
      padding: 0 15px;
      margin: 40px auto 60px;
    }
    thead tr {
      font-size: 1rem;
    }
    tbody td {
      padding: 12px;
      font-size: 0.9rem;
    }
  }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
  <h1>구매 목록📦</h1>

  <table>
    <thead>
      <tr>
        <th>주문번호 / 결제번호</th>
        <th>상품명</th>
        <th>주문상태</th>
      </tr>
    </thead>
    <tbody>
      <c:if test="${not empty list}">
        <c:forEach items="${list}" var="dto">
          <tr>
            <td>${dto.purchaseNum}</td>
            <td>${dto.goodsName}</td>
            <td>${dto.purchaseStatus}</td>
          </tr>
        </c:forEach>
      </c:if>
    </tbody>
  </table>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
