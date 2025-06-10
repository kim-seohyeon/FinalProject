<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 수정</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
        }

        .container {
            max-width: 700px;
            margin: 50px auto;
            background: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
        }

        h2 {
            margin-bottom: 30px;
            color: #2c3e50;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            text-align: left;
            padding: 12px 10px;
            color: #555;
            width: 160px;
            vertical-align: top;
        }

        td {
            padding: 12px 10px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
        }

        input[readonly] {
            background-color: #f3f3f3;
        }

        .btn-group {
            text-align: center;
            margin-top: 30px;
        }

        input[type="submit"],
        button {
            padding: 10px 20px;
            font-size: 15px;
            margin: 0 10px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: white;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        button {
            background-color: #7f8c8d;
            color: white;
        }

        button:hover {
            background-color: #636e72;
        }
    </style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h2>🛠️ 상품 수정</h2>
    <form action="goodsModify" method="post">
        <table>
            <tr>
                <th>상품번호</th>
                <td><input type="text" name="goodsNum" value="${dto.goodsNum}" readonly /></td>
            </tr>
            <tr>
                <th>브랜드명 (주식종목이름)</th>
                <td><input type="text" name="stockName" value="${dto.stockName}" /></td>
            </tr>
            <tr>
                <th>상품명</th>
                <td><input type="text" name="goodsName" value="${dto.goodsName}" /></td>
            </tr>
            <tr>
                <th>상품가격</th>
                <td><input type="text" name="goodsPrice" value="${dto.goodsPrice}" /></td>
            </tr>
            <tr>
                <th>상품설명</th>
                <td><textarea name="goodsContents" rows="8">${dto.goodsContents}</textarea></td>
            </tr>
            <tr>
                <th>조회수</th>
                <td><input type="text" name="visitCount" value="${dto.visitCount}" readonly /></td>
            </tr>
        </table>
        <div class="btn-group">
            <input type="submit" value="수정완료" />
            <button type="button" onclick="location.href='goodsList'">상품목록</button>
        </div>
    </form>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
