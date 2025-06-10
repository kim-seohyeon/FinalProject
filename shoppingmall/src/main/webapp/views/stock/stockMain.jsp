<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주식 메인 페이지</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        h2 {
            font-size: 2rem;
            font-weight: 700;
            text-align: left;
            color: #000;
            margin-bottom: 40px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
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

        .toggle-wish {
            background: none;
            border: none;
            font-size: 22px;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .toggle-wish:hover {
            transform: scale(1.3);
        }

        .wish-stock-list {
            margin-top: 50px;
            padding: 20px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.05);
        }

        .wish-stock-list h3 {
            font-size: 1.3rem;
            margin-bottom: 15px;
            color: #2c3e50;
        }

        .wish-stock-list a {
            color: #3498db;
            font-weight: bold;
            text-decoration: none;
        }

        .wish-stock-list a:hover {
            text-decoration: underline;
        }

        .wish-stock-list ul {
            list-style: none;
            padding: 0;
            margin-top: 10px;
        }

        .wish-stock-list li {
            padding: 10px 0;
            border-bottom: 1px solid #eaeaea;
        }

        @media (max-width: 600px) {
            .container {
                width: 95%;
            }

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
                width: 100px;
                color: #555;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h2>주식 정보 메인 페이지 📈</h2>

    <table>
        <thead>
            <tr>
                <th>종목명</th>
                <th>현재가</th>
                <th>찜</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list }" var="dto" varStatus="idx">
                <tr data-stock-code="00${idx.count }">
                    <td data-label="종목명">
                        <c:choose>
                            <c:when test="${dto.stockName == '삼성전자'}">
                                <a href="/stock/realStock" style="color: #2980b9; font-weight: bold; text-decoration: none;">
                                    ${dto.stockName}
                                </a>
                            </c:when>
                            <c:when test="${dto.stockName == '네이버'}">
                                <a href="/stock/stockX" style="color: #2980b9; font-weight: bold; text-decoration: none;">
                                    ${dto.stockName}
                                </a>
                            </c:when>
                            <c:when test="${dto.stockName == 'LG에너지솔루션'}">
                                <a href="/stock/stockX" style="color: #2980b9; font-weight: bold; text-decoration: none;">
                                    ${dto.stockName}
                                </a>
                            </c:when>
                            <c:when test="${dto.stockName == '카카오'}">
                                <a href="/stock/stockX" style="color: #2980b9; font-weight: bold; text-decoration: none;">
                                    ${dto.stockName}
                                </a>
                            </c:when>
                            <c:otherwise>
                                ${dto.stockName}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td data-label="현재가">${dto.price }</td>
                    <td data-label="찜"><button class="toggle-wish">❤️</button></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="wish-stock-list">
        <h3>내 관심 주식 목록</h3>
        <a href="/stock/wishlist">→ 관심주식 페이지로 이동</a>
        <ul id="wishStockList">
            <c:forEach var="wish" items="${wishStocks}">
                <li>
                    ${wish.stockName} <br/>
                    <span style="color:#888; font-size:0.9rem;">(${wish.stockNum})</span>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>

<script>
    $(document).ready(function () {
        const wishStocks = new Set();
        <c:forEach var="wish" items="${wishStocks}">
            wishStocks.add('${wish.stockNum}');
        </c:forEach>

        $(".toggle-wish").each(function () {
            const stockCode = $(this).closest("tr").data("stock-code");
            $(this).text(wishStocks.has(stockCode) ? "❤️" : "💔");
        });

        $(".toggle-wish").on("click", function () {
            const row = $(this).closest("tr");
            const stockCode = row.data("stock-code");
            const btn = $(this);

            $.ajax({
                url: "/stock/toggleFavorite",
                method: "POST",
                data: { stockCode: stockCode },
                success: function (res) {
                    alert(res.message);
                    refreshWishList(res.wishStocks);

                    if (wishStocks.has(stockCode)) {
                        btn.text("💔");
                        wishStocks.delete(stockCode);
                    } else {
                        btn.text("❤️");
                        wishStocks.add(stockCode);
                    }
                },
                error: function () {
                    alert("로그인이 필요합니다.");
                }
            });
        });

        function refreshWishList(wishes) {
            const list = $("#wishStockList");
            list.empty();
            wishes.forEach(w => {
                list.append(`<li>${w.stockNum}</li>`);
            });
        }
    });
</script>

<jsp:include page="/views/footer.jsp" />
</body>
</html>
