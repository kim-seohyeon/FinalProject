<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>약관 동의</title>
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
    .terms-text {
      width: 100%;
      height: 200px;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 8px;
      background: #f9f9f9;
      font-size: 1rem;
      line-height: 1.5;
      resize: none;
      margin-bottom: 20px;
    }
    .checkbox-group {
      display: flex;
      align-items: center;
      margin-bottom: 30px;
    }
    .checkbox-group input {
      margin-right: 8px;
      transform: scale(1.2);
    }
    .btn-submit {
      display: inline-block;
      padding: 12px 30px;
      background: #3498db;
      color: #fff;
      border: none;
      border-radius: 6px;
      font-size: 1rem;
      cursor: pointer;
      transition: background 0.3s;
    }
    .btn-submit:hover {
      background: #2980b9;
    }
    @media (max-width: 600px) {
      .container {
        margin: 30px 10px;
        padding: 20px;
      }
      .terms-text {
        height: 160px;
      }
    }
  </style>
</head>
<body>
  <jsp:include page="/views/header.jsp" />

  <div class="container">
    <h2>회원가입 약관 동의</h2>
    <form action="userWrite" method="get">
      <textarea class="terms-text" readonly>
[필수] 회원가입 약관
1.목적
이 약관은 회원가입 및 서비스 이용에 관한 기본 사항을 규정합니다.

2.회원의 의무

정확한 정보를 입력해야 하며, 타인의 정보를 도용하면 안 됩니다.

서비스 이용 중 법령 및 공공질서에 위반되는 행위를 금지합니다.

3.회사의 의무

회원의 개인정보를 보호하며, 동의 없이 제3자에게 제공하지 않습니다.

안정적인 서비스 제공을 위해 최선을 다합니다.

4.서비스 이용

서비스는 회원가입 후 이용할 수 있으며, 회사는 서비스 내용을 변경하거나 종료할 수 있습니다.

5.회원 탈퇴 및 자격 상실

회원은 언제든 탈퇴할 수 있으며, 약관 위반 시 서비스 이용이 제한될 수 있습니다.  

      </textarea>

      <div class="checkbox-group">
        <input type="checkbox" id="agree" name="agree" required />
        <label for="agree">약관에 동의합니다.</label>
      </div>

      <button type="submit" class="btn-submit">회원가입</button>
    </form>
  </div>

  <jsp:include page="/views/footer.jsp" />
</body>
</html>
