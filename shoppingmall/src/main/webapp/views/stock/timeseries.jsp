<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>일별/실시간 시세 보기</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        h3 {
            font-size: 1.5rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 20px;
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

        canvas {
            margin-top: 40px;
            width: 100%;
            max-width: 100%;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }

        .back-link {
            display: inline-block;
            margin-top: 30px;
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .back-link:hover {
            background-color: #2980b9;
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
    <h2>일별 및 실시간 주가 시세 📊</h2>

    <h3>실시간 체결 정보</h3>
    <table>
        <thead>
            <tr>
                <th>시간</th>
                <th>체결가</th>
                <th>등락률</th>
                <th>체결량(주)</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td data-label="시간">09:41:39</td>
                <td data-label="체결가">269,500원</td>
                <td data-label="등락률">-0.91%</td>
                <td data-label="체결량(주)">5</td>
            </tr>
            <tr>
                <td data-label="시간">09:41:38</td>
                <td data-label="체결가">269,500원</td>
                <td data-label="등락률">-0.91%</td>
                <td data-label="체결량(주)">1</td>
            </tr>
            <tr>
                <td data-label="시간">09:41:38</td>
                <td data-label="체결가">269,000원</td>
                <td data-label="등락률">-1.10%</td>
                <td data-label="체결량(주)">5</td>
            </tr>
            <!-- 추가 데이터 생략 -->
        </tbody>
    </table>

    <h3>일별 시세 정보</h3>
    <table>
        <thead>
            <tr>
                <th>날짜</th>
                <th>종가</th>
                <th>등락률</th>
                <th>거래량(주)</th>
                <th>거래대금</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td data-label="날짜">2023-05-24</td>
                <td data-label="종가">77,400원</td>
                <td data-label="등락률">0.26%</td>
                <td data-label="거래량(주)">123,456</td>
                <td data-label="거래대금">9,548,000,000원</td>
            </tr>
            <tr>
                <td data-label="날짜">2023-05-23</td>
                <td data-label="종가">77,200원</td>
                <td data-label="등락률">-0.51%</td>
                <td data-label="거래량(주)">98,765</td>
                <td data-label="거래대금">7,630,000,000원</td>
            </tr>
            <tr>
                <td data-label="날짜">2023-05-22</td>
                <td data-label="종가">77,600원</td>
                <td data-label="등락률">0.78%</td>
                <td data-label="거래량(주)">87,654</td>
                <td data-label="거래대금">6,800,000,000원</td>
            </tr>
            <!-- 추가 데이터 생략 -->
        </tbody>
    </table>

    <a href="/stock/main" class="back-link">← 주식 메인 페이지로 돌아가기</a>
</div>
<!-- dd -->
<jsp:include page="/views/footer.jsp" />
</body>
</html>