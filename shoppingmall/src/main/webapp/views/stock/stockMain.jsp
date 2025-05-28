<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주식 메인 페이지</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .stock-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        .stock-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .stock-table th, .stock-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .stock-table th {
            background-color: #f4f4f4;
        }

        canvas {
            margin-top: 30px;
        }

        .wish-stock-list {
            margin-top: 40px;
        }
    </style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="stock-container">
    <h1>주식 정보 메인 페이지</h1>

    <table class="stock-table">
        <thead>
            <tr>
                <th>종목명</th>
                <th>현재가</th>
                <th>찜 상태</th>
            </tr>
        </thead>
        <tbody>
            <tr data-stock-code="001">
                <td>삼성전자</td>
                <td>78,400원</td>
                <td><button class="toggle-wish">❤️</button></td>
            </tr>
            <tr data-stock-code="002">
                <td>LG에너지솔루션</td>
                <td>408,000원</td>
                <td><button class="toggle-wish">❤️</button></td>
            </tr>
        </tbody>
    </table>

    <div class="wish-stock-list">
        <h3>⭐ 내 관심 주식</h3>
        <a href="/stock/wishlist">관심주식</a>
        <ul id="wishStockList">
            <c:forEach var="wish" items="${wishStocks}">
                <li>${wish.stockNum}</li>
            </c:forEach>
        </ul>
    </div>

    <canvas id="stockChart" width="800" height="400"></canvas>
</div>

<script>
    $(document).ready(function () {
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

    // 차트
    const ctx = document.getElementById('stockChart').getContext('2d');
    const stockChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['10:00', '11:00', '12:00', '13:00', '14:00', '15:00'],
            datasets: [{
                label: '삼성전자 주가',
                data: [77400, 77600, 77500, 77800, 78300, 78400],
                borderColor: 'blue',
                backgroundColor: 'rgba(0, 123, 255, 0.2)',
                tension: 0.3,
                fill: true
            }]
        }
    });
</script>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
