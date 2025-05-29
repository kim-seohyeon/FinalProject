<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style>
  body {
    margin: 0;
    background-color: #ffffff;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    color: #2c3e50;
  }
  .container {
    max-width: 500px;
    margin: 60px auto;
    padding: 30px;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    text-align: center;
  }
  h2 {
    margin-bottom: 30px;
    font-size: 1.8rem;
    color: #34495e;
    border-bottom: 2px solid #3498db;
    padding-bottom: 10px;
  }
  form {
    width: 100%;
  }
  table {
   width: 100%;
    border-collapse: collapse;
  }
  th, td {
    padding: 12px 5px;
    text-align: left;
    font-size: 16px;
  }
  th {
    width: 35%;
    font-weight: 600;
    color: #555;
  }
  input[type="text"] {
    width: 100%;
    padding: 8px 12px;
    font-size: 16px;
    border: 1px solid #bbb;
    border-radius: 4px;
    box-sizing: border-box;
    transition: border-color 0.3s ease;
  }
  input[type="submit"] {
    padding: 12px 20px;
    background-color: #3498db;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 1rem;
    cursor: pointer;
    transition: background 0.3s;
  }
  input[type="submit"]:hover {
    background-color: #2980b9;
  }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
  <h2>아이디 찾기</h2>
  <form action="findId" name="frm" id="frm" method="post">
    <table>
      <tr>
        <th>전화번호</th>
        <td><input type="text" name="userPhone" placeholder="휴대폰 번호를 입력하세요" /></td>
      </tr>
    </table>
    <input type="submit" value="아이디 찾기"/>
  </form>
</div>

</body>
<%@ include file="/views/footer.jsp" %>
</html>
