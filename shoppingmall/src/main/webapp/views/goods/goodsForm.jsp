<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background: #ffffff;
        margin: 0; padding: 0;
        color: #333;
    }

    .container {
        max-width: 800px;
        margin: 20px auto 40px auto;
        background: #fff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    h2 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 30px;
        font-size: 1.8rem;
        font-weight: 700;
        padding-bottom: 15px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 12px;
        text-align: left;
        vertical-align: top;
    }

    th {
        width: 150px;
        font-weight: 600;
        color: #555;
        background-color: #f7f9fc;
        border-radius: 6px;
    }

    input[type="text"],
    input[type="number"],
    textarea,
    input[type="file"] {
        width: 100%;
        padding: 10px 14px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 1rem;
        transition: border-color 0.3s ease;
    }

    input[type="text"]:focus,
    input[type="number"]:focus,
    textarea:focus,
    input[type="file"]:focus {
        border-color: #0077cc;
        outline: none;
    }

    textarea {
        resize: vertical;
        min-height: 150px;
    }

    input[type="submit"] {
        display: inline-block;
        background: #0077cc;
        color: #fff;
        font-weight: 600;
        padding: 12px 30px;
        border-radius: 5px;
        text-decoration: none;
        transition: background 0.3s ease;
        box-shadow: 0 4px 8px rgba(0,119,204,0.3);
        border: none;
        cursor: pointer;
        width: 100%;
        font-size: 16px;
        margin-top: 20px;
    }

    input[type="submit"]:hover {
        background: #005fa3;
        box-shadow: 0 6px 12px rgba(0,95,163,0.5);
    }

    small {
        display: block;
        margin-top: 5px;
        font-size: 0.9rem;
        color: #888;
    }
</style>

<script>
  function validateForm() {
    var goodsName = document.forms["goodsForm"]["goodsName"].value;
    var goodsPrice = document.forms["goodsForm"]["goodsPrice"].value;
    var goodsContents = document.forms["goodsForm"]["goodsContents"].value;

    if (goodsName === "" || goodsPrice === "" || goodsContents === "") {
      alert("상품명, 가격, 상품설명은 필수 항목입니다.");
      return false;
    }
  }
</script>
</head>

<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
  <h2>상품 등록</h2>

  <form name="goodsForm" action="goodsWrite" method="POST" enctype="multipart/form-data" onsubmit="return validateForm()">
    <table>
      <tr>
        <th>상품번호</th>
        <td>
          <input type="text" name="goodsNum" value="${goodsCommand.goodsNum}" readonly />
          <small>※ 번호는 자동으로 부여됩니다.</small>
        </td>
      </tr>
      <tr>
        <th>브랜드명<br/>(주식종목이름)</th>
        <td><input type="text" name="stockName" required /></td>
      </tr>
      <tr>
        <th>상품명</th>
        <td><input type="text" name="goodsName" required /></td>
      </tr>
      <tr>
        <th>상품가격</th>
        <td><input type="number" name="goodsPrice" required /></td>
      </tr>
      <tr>
        <th>상품설명</th>
        <td><textarea name="goodsContents" required></textarea></td>
      </tr>
      <tr>
        <th>대문이미지</th>
        <td><input type="file" name="goodsFile" required /></td>
      </tr>
      <tr>
        <th>상품설명이미지</th>
        <td><input type="file" name="goodsImageFile" multiple="multiple" /></td>
      </tr>
    </table>

    <input type="submit" value="상품 등록" />
  </form>
</div>

</body>
</html>
