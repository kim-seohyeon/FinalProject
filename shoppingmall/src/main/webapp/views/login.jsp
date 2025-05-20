<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login.jsp</title>
</head>
<body>
<form action="loginOk" method="post">
<table border=1 align="center">
	<tr>
		<td><input type="text" name="userId"/></td>
		<td rowspan=2><input type="submit" value="로그인" /></td>
	</tr>
	
	<tr>
		<td><input type="password" name="userPw" /></td>
	</tr>
</table>
</form>
</body>
</html>