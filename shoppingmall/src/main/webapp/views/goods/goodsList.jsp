<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 목록</title>
    <style>
        /* 기본 설정 */
        html, body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #ffffff;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
        }

        h2 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 30px;
            color: #2c3e50;
        }

        .add-button {
            display: inline-block;
            padding: 10px 18px;
            margin-bottom: 20px;
            background-color: #27ae60;
            color: white;
            font-weight: bold;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }
        .add-button:hover {
            background-color: #219150;
        }

        table {
            width: 100%;
            border-collapse: collapse;
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

        /* 반응형 대응 */
        @media (max-width: 600px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead tr {
                display: none;
            }

            tr {
                margin-bottom: 15px;
                border-bottom: 2px solid #eee;
                padding-bottom: 10px;
            }

            td {
                text-align: left;
                padding: 10px;
                position: relative;
            }

            td::before {
                content: attr(data-label);
                font-weight: bold;
                display: inline-block;
                width: 140px;
                color: #555;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/views/header.jsp" />

    <div class="container">
        <h2>📦 상품 목록</h2>
        <a href="goodsWrite" class="add-button">➕ 상품 추가</a>

        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>상품번호</th>
                    <th>브랜드명(주식종목이름)</th>
                    <th>상품명</th>
                    <th>상품가격</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="dto" varStatus="idx">
                    <tr>
                        <td data-label="번호">${idx.count}</td>
                        <td data-label="상품번호">
                            <a href="<c:url value='/goods/goodsDetail?goodsNum=${dto.goodsNum}' />">
                                ${dto.goodsNum}
                            </a>
                        </td>
                        <td data-label="브랜드명">${dto.stockName}</td>
                        <td data-label="상품명">${dto.goodsName}</td>
                        <td data-label="상품가격">${dto.goodsPrice}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <%@ include file="/views/footer.jsp" %>
</body>
</html>
