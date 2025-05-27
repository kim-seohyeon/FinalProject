<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findIdOk.jsp</title>
</head>
<body>

<c:if test="${not empty userId}">
    당신의 아이디는 
    ${fn:substring(userId, 0, 3)}
    <c:forEach var="i" begin="1" end="${fn:length(userId) - 3}">
        *
    </c:forEach>
    입니다.
</c:if>

<c:if test="${empty userId}">
    입력한 정보에 해당하는 아이디가 존재하지 않습니다.
</c:if>
</body>
</html>