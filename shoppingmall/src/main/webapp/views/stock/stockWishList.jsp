<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관심 주식 목록</title>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<h2>관심 주식 목록</h2>
<table border="1">
    <thead>
        <tr>
            <th>종목 번호</th>
            <th>등록일</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="stock" items="${wishStocks}">
            <tr>
                <td>${stock.stockNum}</td>
                <td>${stock.wishStockDate}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<jsp:include page="/views/footer.jsp" />
</body>
</html>
