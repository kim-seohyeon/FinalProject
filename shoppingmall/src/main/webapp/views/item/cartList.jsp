<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cartList.jsp</title>
</head>
<body>	
<form action="itemBuy" method="post">
<table width=600 align="center">
<caption>장바구니</caption>
	<tr><td><input type = "checkbox" id="checkBoxes" checked="checked"/></td>
		<td>이미지</td><td>제품이름</td><td>수량</td><td>합계금액</td></tr>
	
	<c:forEach items="${list }" var="dto">	
	<tr><td><input type = "checkbox" name="prodCk" value="${dto.goodsNum }" checked="checked"/></td>
		<td><img src="/goods/upload/${dto.goodsImage }" width=30/></td><td>${dto.goodsName }</td><td>${dto.cartQty }</td><td>${dto.cartQty * dto.goodsPrice }</td></tr>
	</c:forEach>
	
	<tr>
		<td colspan=5 align="right"><input type="submit" value="구매하기"></td>
	</tr>
</table>
</form>

</body>
</html>