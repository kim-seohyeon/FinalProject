<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empDetail</title>
</head>
<body>
직원정보 상세보기<br/>

<table border=1 width=600>

	<tr>
		<td>번호</td>
		<td>${employeeCommand.empNum }</td>
	</tr>

	<tr>
		<td>이름</td>
		<td>${employeeCommand.empName }</td>
	</tr>
	<tr>
		<td>아이디</td>
		<td>${employeeCommand.empId }</td>
	</tr>

	<tr>
		<td>주소</td>
		<td>${employeeCommand.empAddr }
		</td>
	</tr>
	<tr>
		<td>상세주소</td>
		<td>${employeeCommand.empAddrDetail }</td>
	</tr>
	<tr>
		<td>우편번호</td>
		<td>${employeeCommand.empPost }</td>
	</tr>
	<tr>
		<td>연락처</td>
		<td>${employeeCommand.empPhone }</td>
	</tr>		
	<tr>
		<td>주민번호</td>
		<td>${employeeCommand.empJumin }</td>
	</tr>		
	<tr>
		<td>이메일</td>
		<td>${employeeCommand.empEmail }</td>
	</tr>		
	<tr>
		<td>입사일</td>
		<td>
			<fmt:formatDate value="${employeeCommand.empHireDate}" pattern="yyyy-MM-dd"/>
		</td>
	</tr>				
	<tr>
		<td colspan=2>
			<button type="button" 
					onclick="javascript:location.href='empList'">직원목록</button>
			<button type="button" 
					onclick="javascript:location.href='empUpdate?empNum=${employeeCommand.empNum }'">직원수정</button>
			<button type="button" 
					onclick="javascript:location.href='empDelete?empNum=${employeeCommand.empNum }'">직원삭제</button>
		
		</td>			
	</tr>	
		
</table>

</body>
</html>