<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관심 주식 목록</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 2em;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 15px;
            border: 1px solid #e0e0e0;
            text-align: center;
            transition: background-color 0.3s;
        }

        th {
            background-color: #2980b9;
            color: white;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .footer {
            text-align: center;
            margin-top: 30px;
            color: #7f8c8d;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h2>관심 주식 목록</h2>
    <table>
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
</div>

<div class="footer">
    <p>© 2025 주식 정보 시스템. 모든 권리 보유.</p>
</div>

<jsp:include page="/views/footer.jsp" />
</body>
</html>
