<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>item/goodsOrder.jsp</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/static/js/daumAddressScript.js"></script>
<style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #ffffff;
    margin: 0;
    padding: 0;
    color: #34495e;
  }

  .container {
    width: 95%;
    max-width: 900px;
    margin: 60px auto;
    padding: 20px;
    background: #ffffff;
  }

  h2 {
    border-bottom: 2px solid #3498db;
    padding-bottom: 10px;
    margin-bottom: 20px;
    font-size: 1.6rem;
    color: #2c3e50;
  }

  table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 10px;
    margin-bottom: 30px;
  }

  th, td {
    text-align: center;
    padding: 12px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
  }

  th {
    background: #3498db;
    color: #fff;
    font-weight: 700;
  }

  td img {
    width: 50px;
    border-radius: 6px;
  }

  .form-section {
    max-width: 500px;
    margin: 50;
    background: #ffffff;
    padding: 20px;
    border-radius: none;
    box-shadow:  none;
  }

  .form-section label {
    display: block;
    margin: 8px 0 4px;
    font-weight: 600;
  }

  .form-section input[type="text"],
  .form-section input[type="tel"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
  }

  .form-section input[readonly] {
    background-color: #e9ecef;
  }

  .payment-section {
    text-align: center;
    margin-top: 40px;
  }

  .payment-section p {
    font-size: 1.2rem;
    margin-bottom: 20px;
    font-weight: 700;
  }

  .payment-section input[type="submit"] {
    padding: 14px 40px;
    background: #3498db;
    color: #fff;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    cursor: pointer;
    transition: background 0.3s ease;
  }

  .payment-section input[type="submit"]:hover {
    background: #2980b9;
  }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
  <h2>주문 상품 정보</h2>

  <table>
    <tr>
      <th>상품 대표 이미지</th>
      <th>상품명</th>
      <th>수량 / 개당 금액</th>
      <th>총 금액</th>
    </tr>
    <c:forEach items="${list}" var="dto">
      <tr>
        <td><img src="/static/goodsUpload/${dto.goodsMainStoreImage}" /></td>
        <td>${dto.goodsName}</td>
        <td>${dto.cartQty}개 / ${dto.goodsPrice}원</td>
        <td>${dto.goodsPrice * dto.cartQty}원</td>
      </tr>
    </c:forEach>
  </table>

  <form action="goodsOrder" method="post">
    <input type="hidden" name="purchaseName" value="${list[0].goodsName}'외' ${list.size() -1}개" />
    <input type="hidden" name="goodsNums" value="${nums}" />
    <input type="hidden" name="totalPaymentPrice" value="${goodsTotalPrice}" />

    <div class="form-section">
      <h2>배송 정보</h2>
      <label>받는 사람</label>
      <input type="text" name="deliveryName" />

      <label>주소</label>
      <input type="text" name="deliveryAddr" id="sample4_roadAddress" onclick="execDaumPostcode();" readonly />

      <label>상세 주소</label>
      <input type="text" name="deliveryAddrDetail" />

      <label>우편번호</label>
      <input type="text" name="deliveryPost" readonly id="sample4_postcode" />

      <label>연락처</label>
      <input type="tel" name="deliveryPhone" />

      <label>배송 메세지</label>
      <input type="text" name="message" />
    </div>

    <div class="payment-section">
      <p>총 결제 금액: ${goodsTotalPrice}원</p>
      <input type="submit" value="결제하기" />
    </div>
  </form>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
