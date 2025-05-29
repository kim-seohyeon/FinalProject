<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <script src="https://code.jquery.com/jquery-1.8.1.js"></script>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script type="text/javascript" src="/static/js/daumAddressScript.js"></script>
  <style>
    body {
      margin: 0;
      background-color: #ffffff;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: #34495e;
    }
    .container {
      max-width: 720px;
      margin: 60px auto;
      padding: 30px;
      background: #ffffff;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    h2 {
      margin-bottom: 20px;
      font-size: 1.8rem;
      color: #2c3e50;
      border-bottom: 2px solid #3498db;
      padding-bottom: 8px;
    }
    form table {
      width: 100%;
      border-collapse: collapse;
    }
    form td {
      padding: 10px 8px;
      vertical-align: middle;
    }
    form td:first-child {
      width: 30%;
      font-weight: 600;
      color: #2c3e50;
    }
    form input[type="text"],
    form input[type="password"],
    form input[type="email"],
    form input[type="date"],
    form input[type="tel"],
    form select {
      width: 100%;
      padding: 8px 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      box-sizing: border-box;
      font-size: 1rem;
      transition: border-color 0.3s;
    }
    form input:focus,
    form select:focus {
      outline: none;
      border-color: #3498db;
    }
    form input[type="radio"] {
      margin-left: 4px;
      margin-right: 4px;
    }
    .address-btn {
      margin-left: 6px;
      padding: 8px 12px;
      border: none;
      background: #3498db;
      color: #fff;
      border-radius: 6px;
      cursor: pointer;
      transition: background 0.3s;
    }
    .address-btn:hover {
      background: #2980b9;
    }
    .btn-group {
      text-align: center;
      margin-top: 20px;
    }
    .btn-group input {
      padding: 10px 24px;
      margin: 0 10px;
      border: none;
      border-radius: 6px;
      font-size: 1rem;
      cursor: pointer;
      transition: background 0.3s;
    }
    .btn-submit {
      background: #3498db;
      color: #fff;
    }
    .btn-submit:hover {
      background: #2980b9;
    }
    .btn-cancel {
      background: #ccc;
      color: #333;
    }
    .btn-cancel:hover {
      background: #aaa;
    }
    .error {
      color: #e74c3c;
      font-size: 0.9rem;
      margin-top: 4px;
    }
    @media (max-width: 600px) {
      .container {
        margin: 30px 10px;
        padding: 20px;
      }
      form td:first-child {
        display: block;
        width: 100%;
        margin-bottom: 6px;
      }
      form td:last-child {
        display: block;
        width: 100%;
      }
      .btn-group input {
        width: 45%;
        margin: 8px 2%;
      }
    }
  </style>
</head>
<body>
  <jsp:include page="/views/header.jsp" />

  <div class="container">
    <h2>회원가입</h2>
    <form:form action="userWrite" method="post" id="frm" modelAttribute="memberCommand">
      <table>
        <tr>
          <td>아이디</td>
          <td>
            <form:input path="memberId" />
            <form:errors path="memberId" cssClass="error" />
          </td>
        </tr>
        <tr>
          <td>비밀번호</td>
          <td>
            <form:password path="memberPw" />
            <form:errors path="memberPw" cssClass="error" />
          </td>
        </tr>
        <tr>
          <td>비밀번호 확인</td>
          <td>
            <form:password path="memberPwCon" />
            <form:errors path="memberPwCon" cssClass="error" />
          </td>
        </tr>
        <tr>
          <td>이름</td>
          <td>
            <form:input path="memberName" />
            <form:errors path="memberName" cssClass="error" />
          </td>
        </tr>
        <tr>
          <td>연락처1</td>
          <td>
            <form:input path="memberPhone1" />
            <form:errors path="memberPhone1" cssClass="error" />
          </td>
        </tr>
        <tr>
          <td>연락처2</td>
          <td>
            <form:input path="memberPhone2" />
            <form:errors path="memberPhone2" cssClass="error" />
          </td>
        </tr>
        <tr>
          <td>주소</td>
          <td>
            <input type="text" name="memberAddr" id="sample4_roadAddress" readonly />
            <button type="button" class="address-btn" onclick="execDaumPostcode();">주소검색</button>
            <form:errors path="memberAddr" cssClass="error" />
          </td>
        </tr>
        <tr>
          <td>상세주소</td>
          <td>
            <form:input path="memberAddrDetail" />
            <form:errors path="memberAddrDetail" cssClass="error" />
          </td>
        </tr>
        <tr>
          <td>우편번호</td>
          <td>
            <input type="text" name="memberPost" id="sample4_postcode" readonly />
            <form:errors path="memberPost" cssClass="error" />
          </td>
        </tr>
        <tr>
          <td>이메일</td>
          <td>
            <input type="email" name="memberEmail" value="${memberCommand.memberEmail}" />
            <form:errors path="memberEmail" cssClass="error" />
          </td>
        </tr>
        <tr>
          <td>생년월일</td>
          <td>
            <input type="date" name="memberBirth" />
            <form:errors path="memberBirth" cssClass="error" />
          </td>
        </tr>
        <tr>
          <td>성별</td>
          <td>
            <label><input type="radio" name="memberGender" value="F" checked /> 여자</label>
            <label><input type="radio" name="memberGender" value="M" /> 남자</label>
          </td>
        </tr>
      </table>

      <div class="btn-group">
        <input type="submit" value="가입하기" class="btn-submit" />
        <input type="button" value="가입취소" class="btn-cancel"
               onclick="location.href='/'" />
      </div>
    </form:form>
  </div>

  <jsp:include page="/views/footer.jsp" />
</body>
</html>
