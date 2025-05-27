<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>agree</title>
</head>
<body>
<jsp:include page="/views/header.jsp" />
<form action="userWrite" method="get">
필수[글 내용]<br/>
<textarea rows="5" cols="80" readonly="readonly">
규약
</textarea><br/>

<input type="checkbox" required="required"/>동의<br/>
<input type="submit" value="회원가입"/>

</form>
<%@ include file="/views/footer.jsp" %>
</body>
</html>