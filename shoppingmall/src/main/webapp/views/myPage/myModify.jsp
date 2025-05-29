<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보 수정</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src ="js/daumAddressScript.js"></script>

<style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #ffffff;
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
    justify-content: flex-start;
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

  .gender-group {
    flex: 1;
    display: flex;
    gap: 20px;
  }

  .gender-group label {
    font-weight: normal;
    cursor: pointer;
  }

  .gender-group input[type="checkbox"] {
    transform: scale(1.2);
    margin-right: 6px;
  }

  input[readonly] {
    background-color: #e9ecef;
    cursor: not-allowed;
  }

  .address-btn {
    margin-left: 10px;
    padding: 6px 12px;
    background-color: #2980b9;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    font-size: 0.9rem;
    transition: background-color 0.3s ease;
  }

  .address-btn:hover {
    background-color: #1f6390;
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
  <h1>MY PAGE | 내정보 수정</h1>

  <ul class="mypage-menu">
    <li><a href='<c:url value="/"/>'>홈</a></li>
    <li><a href='/myPage/memberMyPage'>내정보 보기</a></li>
    <li><a href='/myPage/memberUpdate' class="active">🛠️ 내정보 수정</a></li>
    <li><a href="/myPage/myNewPw">비밀번호 변경</a></li>
    <li><a href="/myPage/memberDrop">회원 탈퇴</a></li>
  </ul>

  <form class="modify-form" action="memberUpdate" method="post" name="frm">
    <ul>
      <li>
        <label for="memberName">이름</label>
        <input id="memberName" type="text" name="memberName" value="${dto.memberName }"/>
      </li>

      <li>
        <label for="memberId">아이디</label>
        <input id="memberId" type="text" name="memberId" value="${dto.memberId }" readonly/>
      </li>

      <li>
        <label for="memberPw">비밀번호</label>
        <input id="memberPw" type="password" name="memberPw"/>
      </li>
      <li>
        <span class="error-msg">${pwErr }</span>
      </li>

      <li>
        <label for="memberAddr">주소</label>
        <input id="memberAddr" type="text" name="memberAddr" value="${dto.memberAddr }"/>
        <input type="button" class="address-btn" value="주소검색" onclick="execDaumPostcode();"/>
      </li>

      <li>
        <label for="memberAddrDetail">상세주소</label>
        <input id="memberAddrDetail" type="text" name="memberAddrDetail" value="${dto.memberAddrDetail }"/>
      </li>

      <li>
        <label for="memberPost">우편번호</label>
        <input id="memberPost" type="text" name="memberPost" value="${dto.memberPost }"/>
      </li>

      <li>
        <label for="memberPhone1">연락처1</label>
        <input id="memberPhone1" type="tel" name="memberPhone1" value="${dto.memberPhone1 }"/>
      </li>

      <li>
        <label for="memberPhone2">연락처2</label>
        <input id="memberPhone2" type="tel" name="memberPhone2" value="${dto.memberPhone2 }"/>
      </li>

      <li>
        <label>성별</label>
        <div class="gender-group">
          <label><input type="checkbox" name="memberGender" value="M" <c:if test="${dto.memberGender == 'M'}">checked</c:if> />남자</label>
          <label><input type="checkbox" name="memberGender" value="F" <c:if test="${dto.memberGender == 'F'}">checked</c:if> />여자</label>
        </div>
      </li>

      <li>
        <label for="memberRegist">등록일</label>
        <input id="memberRegist" type="date" name="memberRegist" value="${fn:substring(dto.memberRegist, 0, 10) }"/>
      </li>

      <li>
        <label for="memberBirth">생년월일</label>
        <input id="memberBirth" type="date" name="memberBirth" value="${fn:substring(dto.memberBirth, 0, 10) }"/>
      </li>

      <li>
        <label for="memberEmail">이메일</label>
        <input id="memberEmail" type="email" name="memberEmail" value="${dto.memberEmail }"/>
      </li>

      <li>
        <input type="submit" value="수정 완료"/>
      </li>
    </ul>
  </form>
</div>

<jsp:include page="/views/footer.jsp" />
</body>
</html>
