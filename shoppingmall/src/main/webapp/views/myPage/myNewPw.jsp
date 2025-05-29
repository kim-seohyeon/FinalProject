<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<script src="https://code.jquery.com/jquery-1.8.1.js"></script>
<script type="text/javascript">
$(function(){
  $("#frm").submit(function(){
    if($("#newPw").val() != $("#newPwCon").val()){
      alert("비밀번호 확인이 일치하지 않습니다.");
      $("#newPwCon").val("");
      $("#newPw").val("");
      $("#newPw").focus();
      return false;
    }
  });
});
</script>

<style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #ffffff; /* 하얀 배경 */
    margin: 0;
    padding: 0;
    color: #222;
  }

  .container {
    max-width: 900px;
    margin: 60px auto 100px;
    padding: 0 30px;
  }

  h1 {
    font-size: 2rem;
    font-weight: 700;
    color: #000;
    margin-bottom: 40px;
    text-align: left;
  }

  ul.mypage-menu {
    list-style: none;
    display: flex;
    padding: 0;
    margin-bottom: 50px;
    border-bottom: 2px solid #2980b9;
  }

  ul.mypage-menu li {
    margin-right: 40px;
  }

  ul.mypage-menu li a {
    text-decoration: none;
    font-weight: 600;
    color: #2980b9;
    font-size: 1.1rem;
    padding-bottom: 10px;
    display: inline-block;
    border-bottom: 3px solid transparent;
    transition: border-color 0.3s ease;
  }

  ul.mypage-menu li a.active,
  ul.mypage-menu li a:hover {
    border-bottom-color: #2980b9;
  }

  form.modify-form {
    width: 100%;
  }

  form.modify-form ul {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  form.modify-form li {
    display: flex;
    align-items: center;
    margin-bottom: 25px;
  }

  form.modify-form li label {
    flex: 0 0 150px;
    font-weight: 600;
    color: #333;
    text-align: right;
    padding-right: 20px;
    font-size: 1rem;
  }

  form.modify-form li input[type="text"],
  form.modify-form li input[type="password"],
  form.modify-form li input[type="email"],
  form.modify-form li input[type="tel"],
  form.modify-form li input[type="date"] {
    flex: 1;
    height: 36px;
    padding: 6px 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 1rem;
    transition: border-color 0.3s ease;
  }

  form.modify-form li input[type="text"]:focus,
  form.modify-form li input[type="password"]:focus,
  form.modify-form li input[type="email"]:focus,
  form.modify-form li input[type="tel"]:focus,
  form.modify-form li input[type="date"]:focus {
    border-color: #2980b9;
    outline: none;
    box-shadow: 0 0 5px #2980b9;
  }

  form.modify-form li .error-msg {
    color: red;
    margin-left: 170px;
    margin-top: -20px;
    margin-bottom: 15px;
    font-size: 0.9rem;
    font-weight: 600;
  }

  input[type="submit"] {
    margin-left: 170px;
    padding: 12px 40px;
    font-size: 1.1rem;
    background-color: #2980b9;
    color: white;
    border: none;
    border-radius: 8px;
    font-weight: 700;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }

  input[type="submit"]:hover {
    background-color: #1f6390;
  }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
  <h1>MY PAGE | 비밀번호 변경</h1>

  <ul class="mypage-menu">
    <li><a href='<c:url value="/"/>'>홈</a></li>
    <li><a href='/myPage/memberMyPage'>내정보 보기</a></li>
    <li><a href='/myPage/memberUpdate'>내정보 수정</a></li>
    <li><a href="/myPage/myNewPw" class="active">🔒 비밀번호 변경</a></li>
    <li><a href="/myPage/memberDrop">회원 탈퇴</a></li>
  </ul>

  <form action="myNewPw" method="post" id="frm" class="modify-form">
    <ul>
      <li>
        <label for="oldPw">현재 비밀번호</label>
        <input id="oldPw" type="password" name="oldPw" required />
      </li>
      <li>
        <span class="error-msg">${pwErr }</span>
      </li>
      <li>
        <label for="newPw">새 비밀번호</label>
        <input id="newPw" type="password" name="newPw" required />
      </li>
      <li>
        <label for="newPwCon">새 비밀번호 확인</label>
        <input id="newPwCon" type="password" name="newPwCon" required />
      </li>
      <li>
        <input type="submit" value="비밀번호 변경"/>
      </li>
    </ul>
  </form>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
