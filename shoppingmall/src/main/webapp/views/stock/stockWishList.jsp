<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관심 주식 목록</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #ffffff;
            color: #333;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 30px;
            background: #fff;
            border-radius: none;
            box-shadow: none;
        }

        h2 {
            text-align: left;
            font-size: 2em;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        .content {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 40px;
        }

        .stock-list {
            display: grid;
            gap: 20px;
        }

        .stock-card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #fafafa;
            border: 1px solid #e0e0e0;
            padding: 20px;
            border-radius: 12px;
            transition: box-shadow 0.3s;
        }

        .stock-card:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.07);
        }

        .stock-info {
            display: flex;
            flex-direction: column;
        }

        .stock-num {
            font-size: 1.2em;
            font-weight: bold;
            color: #34495e;
        }
        
         .stock-name {
            font-size: 1.2em;
            font-weight: bold;
            color: #34495e;
        }

        .stock-date {
            font-size: 0.95em;
            color: #7f8c8d;
        }

        .stock-price-placeholder {
            font-size: 1em;
            color: #2980b9;
        }

        .realtime-section {
            background-color: #f9f9fb;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 12px;
            box-shadow: inset 0 0 10px rgba(0,0,0,0.03);
        }

        .realtime-section h3 {
            font-size: 1.4em;
            margin-bottom: 15px;
            color: #2c3e50;
        }

        .realtime-placeholder {
            text-align: center;
            font-size: 1em;
            color: #aaa;
            padding-top: 40px;
        }

/*         .footer {
            text-align: center;
            margin-top: 50px;
            color: #95a5a6;
            font-size: 0.9em;
        } */

        @media (max-width: 768px) {
            .content {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h2>관심 주식 목록 ❤️</h2>
    <div class="content">
        <!-- 관심 주식 리스트 -->
        <div class="stock-list">
            <c:forEach var="stock" items="${wishStocks}">
                <div class="stock-card">
                    <div class="stock-info">
                        <span class="stock-num">종목 번호: ${stock.stockNum}</span>
                        <span class="stock-name">종목명: ${stock.stockName}</span>
                        <span class="stock-date">등록일: ${stock.wishStockDate}</span>
                    </div>
	                <c:if test="${not empty list}">
	                    <div class="stock-price-placeholder">
	                        <span class="stock-price">현재가: ${list[0].price}</span>
	                    </div>
	                </c:if>
                </div>
            </c:forEach>
        </div>

        <!-- 실시간 주가 정보 영역 -->
        <div class="realtime-section">
            <h3>실시간 주가 정보</h3>
            <div class="realtime-placeholder">
                여기에 실시간 주가 정보가 표시 고민중<br>
                아직 모르겠다. 담주에 하자ㅎㅎ
            </div>
        </div>
    </div>
</div>

<!-- <div class="footer">
    <p>© 2025 주식 정보 시스템. 모든 권리 보유.</p>
</div> -->

<jsp:include page="/views/footer.jsp" />
</body>
</html>
