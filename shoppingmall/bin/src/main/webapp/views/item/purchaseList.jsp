<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>purchaseList.jsp</title>
</head>
<body>
<jsp:include page="/views/header.jsp" />
   <table width="800" align="center" border="1">
      <tr>
         <td>주문번호 / 결제번호</td>
         <td>상품명</td>
         <td>주문상태</td>
      </tr>
    <c:forEach items="${list }" var="dto">
	<tr>
         <td>${dto.purchaseNum}</td>
         <td>${dto.goodsName}</td>
         <td>${dto.purchaseStatus}</td>
      </tr>
   </c:forEach>
   
   
  </table>
  <%@ include file="/views/footer.jsp" %>
</body>