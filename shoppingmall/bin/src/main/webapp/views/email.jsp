<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>email</title>
</head>
<body>
<form action="mailling" method="post" >
<input type="submit" value="보내기"><br />
보내는 사람 : <input type="text" name="fromEmail" /><br />
받는  사람 : <input type="text" name="toEmail" /><br />
제목 : <input type="text" name="subject"><br />
내용 : <textarea rows="5" cols="50" name="contents"></textarea>
</form>
</body>
</html>