<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findPw</title>
</head>
<body>
<jsp:include page="/views/header.jsp" />
<form action="findPassword" name="frm" id="frm" method="post">
	<table border="1" width="600" align="center">
		<tr><th>아이디</th>
		    <td><input type="text" name="userId" required="required"/></td></tr>
		<tr><th>전화번호</th>
		    <td><input type="text" name="userPhone" required="required"/></td></tr>
		<tr><th colspan="2"><input type="submit" value="비밀번호 찾기"/></th></tr>
	</table>
</form>
<%@ include file="/views/footer.jsp" %>
</body>
</html>