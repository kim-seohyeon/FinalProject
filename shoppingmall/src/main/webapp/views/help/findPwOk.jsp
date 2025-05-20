<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findPwOk</title>
</head>
<body>
<c:if test="${empty email }">
	정보가 없습니다. 다시 시도해주세요.
</c:if>

<c:if test="${!empty email }">
	glwl********@naver.com로 임시 비밀번호가 전송되었습니다.
</c:if>

</body>
</html>