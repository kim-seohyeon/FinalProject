<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findPw</title>
<style>
  body {
    margin: 0;
    padding: 0 0 40px 0;
    background-color: #fff;
    font-family: Arial, sans-serif;
    color: #2c3e50;
  }

  /* 네비바 아래 큰 박스 컨테이너 */
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
    padding: 12px 10px;
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

  input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
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
  <h2>비밀번호 찾기</h2>
  
  <form action="findPassword" name="frm" id="frm" method="post" novalidate>
    <table>
      <tr>
        <th>아이디</th>
        <td><input type="text" name="userId" required="required" /></td>
      </tr>
      <tr>
        <th>전화번호</th>
        <td><input type="text" name="userPhone" required="required" /></td>
      </tr>
      <tr>
        <th colspan="2"style="text-align: center;">
          <input type="submit" value="비밀번호 찾기" />
        </th>
      </tr>
    </table>
  </form>
</div>


</body>
<%@ include file="/views/footer.jsp" %>
</html>
