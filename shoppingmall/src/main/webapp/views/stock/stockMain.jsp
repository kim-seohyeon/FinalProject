<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주식 메인 페이지</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .stock-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #34495e;
            margin-bottom: 20px;
        }

        .stock-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .stock-table th, .stock-table td {
            padding: 15px;
            border: 1px solid #ddd;
            text-align: center;
            transition: background-color 0.3s;
        }

        .stock-table th {
            background-color: #3498db;
            color: white;
        }

        .stock-table tr:hover {
            background-color: #ecf0f1;
        }

        .toggle-wish {
            background: none;
            border: none;
            font-size: 28px;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .toggle-wish:hover {
            transform: scale(1.2);
        }

        canvas {
            margin-top: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .wish-stock-list {
            margin-top: 40px;
            padding: 20px;
            background: #ecf0f1;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .wish-stock-list h3 {
            color: #34495e;
            margin-bottom: 15px;
        }

        .wish-stock-list ul {
            list-style-type: none;
            padding: 0;
        }

        .wish-stock-list li {
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
            transition: background-color 0.3s;
        }

        .wish-stock-list li:hover {
            background-color: #dfe6e9;
        }

        .wish-stock-list li:last-child {
            border-bottom: none;
        }

        .footer {
            text-align: center;
            margin-top: 30px;
            color: #7f8c8d;
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
            <!-- 추가 종목 예시 -->
            <tr data-stock-code="003">
                <td>카카오</td>
                <td>105,000원</td>
                <td><button class="toggle-wish">❤️</button></td>
            </tr>
            <tr data-stock-code="004">
                <td>네이버</td>
                <td>360,000원</td>
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
        // 찜 상태 목록을 가져옵니다.
        const wishStocks = new Set();
        <c:forEach var="wish" items="${wishStocks}">
            wishStocks.add('${wish.stockNum}');
        </c:forEach>

        // 각 버튼의 상태를 초기화합니다.
        $(".toggle-wish").each(function () {
            const stockCode = $(this).closest("tr").data("stock-code");
            if (wishStocks.has(stockCode)) {
                $(this).text("❤️"); // 찜 상태
            } else {
                $(this).text("💔"); // 찜 아님
            }
        });

        // 찜 상태 토글 기능
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
                    
                    // 버튼 상태 변경
                    if (wishStocks.has(stockCode)) {
                        btn.text("💔"); // 찜에서 제거됨
                        wishStocks.delete(stockCode);
                    } else {
                        btn.text("❤️"); // 찜 추가됨
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

    // 차트
    const ctx = document.getElementById('stockChart').getContext('2d');
    const stockChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['10:00', '11:00', '12:00', '13:00', '14:00', '15:00'],
            datasets: [{
                label: '삼성전자 주가',
                data: [77400, 77600, 77500, 77800, 78300, 78400],
                borderColor: '#3498db',
                backgroundColor: 'rgba(52, 152, 219, 0.2)',
                tension: 0.3,
                fill: true
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: true,
                    labels: {
                        color: '#34495e'
                    }
                }
            }
        }
    });
</script>

<div class="footer">
    <p>© 2025 주식 정보 시스템. 모든 권리 보유.</p>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
