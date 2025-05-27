<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>inquireInfo</title>
</head>
<body>
<jsp:include page="/views/header.jsp" />
<table border=1 align="center" width="600">

<caption> 글 상세보기</caption>
	<tr><th width="150" >글 번호</th>
		<td>${dto.inquireNum }</td></tr>
	<tr><th width="150" >작성자</th>
		<td>${dto.inquireWriter }</td></tr>	
	<tr><th width="150" >제목</th>
		<td>${dto.inquireSubject }</td></tr>
	<tr><th width="150" >내용</th>
		<td>${dto.inquireContents }</td></tr>


<tr><th colspan="2">
		<a href="inquireUpdate?inquireNum=${dto.inquireNum }">글 수정</a> | 
		<a href="inquireDelete?inquireNum=${dto.inquireNum }">글 삭제</a> | 
		<a href="inquireList">글 목록</a></th></tr>


</table>
<%@ include file="/views/footer.jsp" %>
</body>
</html>