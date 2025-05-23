<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>communityList.jsp</title>
</head>
<body>
<!-- 게시글 목록 보여주기 -->
<a href="write">문의글 쓰기</a><br />

<table border=1 width="600" align="center">
	<caption>문의글 목록</caption>
	<tr><th>번호</th><th>작성자</th><th>제목</th></tr>
	<c:forEach items="${list }" var="dto" varStatus="idx">
		<tr>
			<th>${idx.count }</th>
			<th><a href="<c:url value='/inquire/inquireDetail?inquireNum=${dto.inquireNum}' />">${dto.inquireWriter }</a></th>
			<th>${dto.inquireSubject }</th>
		</tr>
	</c:forEach>
</table>
</body>
</html>
