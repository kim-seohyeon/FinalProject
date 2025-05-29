<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<style>
  body {
    margin: 0;
    padding: 0 0 40px 0;
    background-color: #fff;
    font-family: Arial, sans-serif;
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

  label {
    font-size: 18px;
    margin-bottom: 10px;
    align-self: flex-start;
  }

  input[type="password"] {
    width: 100%;
    max-width: 400px;
    padding: 8px 10px;
    font-size: 16px;
    margin-bottom: 30px;
    border: 1px solid #ccc;
    border-radius: 4px;
  }

  button {
    padding: 12px 20px;
    background-color: #3498db;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 1rem;
    cursor: pointer;
    transition: background 0.3s;
  }

  button:hover {
    background-color: #0056b3;
  }

</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
  <h2>새 비밀번호 입력</h2>
  
  <form action="resetPassword" method="post">
      <input type="hidden" name="userId" value="${userId}"/>
      <label for="newPassword"></label>
      <input type="password" name="newPassword" id="newPassword" required />
      <button type="submit">비밀번호 변경</button>
  </form>
</div>


</body>
<%@ include file="/views/footer.jsp" %>
</html>
