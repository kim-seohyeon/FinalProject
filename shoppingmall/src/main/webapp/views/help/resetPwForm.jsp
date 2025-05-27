<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>resetPwForm.jsp</title>
</head>
<body>
<h2>새 비밀번호 입력</h2>
<form action="resetPassword" method="post">
    <input type="hidden" name="userId" value="${userId}"/>
    <label for="newPassword">새 비밀번호:</label>
    <input type="password" name="newPassword" id="newPassword" required/>
    <button type="submit">비밀번호 변경</button>
</form>
</body>
</html>