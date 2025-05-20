<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empList</title>
</head>
<body>
직원목록<br/>
<a href="empWrite">직원등록</a>
<table border=1 width=600>
	<tr>
		<th>번호</th><th>직원번호</th><th>이름</th>
	</tr>

	<c:forEach items="${list }" var="dto" varStatus="idx">
		<tr>
			<th>
				${idx.count }		
			</th>			
			<th>
				<a href="empDetail?empNum=${dto.empNum }">${dto.empNum }
			</th>
			<th width=200>
				<a href="empDetail?empNum=${dto.empNum }">${dto.empName }</a>
			</th>
		</tr>
	</c:forEach>

</table>
</body>
</html>