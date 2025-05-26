<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>inquireModify</title>
</head>
<body>
글 수정 페이지
<form action="inquireModify" method="post" >
<table border=1 align="center" width="600">
	<caption> 문의 상세보기</caption>
	<tr><th width="150" >글 번호</th>
		<td><input type="text" name="inquireNum" value="${dto.inquireNum }" readonly="readonly"></td></tr>
	<tr><th width="150" >제목</th>
		<td><input type="text" name="inquireSubject" value="${dto.inquireSubject }"></td></tr>
	<tr><th width="150" >내용</th>
		<td><input type="text" name="inquireContents" value="${dto.inquireContents }"></td></tr>
		<tr><th colspan="2">
		<input type="submit" value="수정완료" />
		<button type="button" onclick="">글 목록</button></th></tr>
</table>
</form>

</body>
</html>