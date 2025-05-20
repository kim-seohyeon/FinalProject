<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empForm</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src ="/static/js/daumAddressScript.js"></script>
</head>
<body>
직원등록<br/>
<form:form action="empWrite" method="post" modelAttribute="employeeCommand">
	<table border=1 width=600>

		<tr>
			<td>번호</td>
			<td><form:input path="empNum" /></td>
		</tr>
	
		<tr>
			<td>이름</td>
			<td><form:input path="empName" />
				<form:errors path="empName"/></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><form:input path="empId" />
				<form:errors path="empId"/></td>
		</tr>
		
		<tr>
			<td>비밀번호</td>
			<td><form:password path="empPw" />
				<form:errors path="empPw"/></td>
		</tr>

		<tr>
			<td>주소</td>
			<td><form:input path="empAddr" id="sample4_roadAddress" />
				<button type="button" onclick="execDaumPostcode();">주소검색</button>
				<form:errors path="empAddr"/>
			</td>
		</tr>
		<tr>
			<td>상세주소</td>
			<td><form:input path="empAddrDetail" />
				<form:errors path="empAddrDetail"/></td>
		</tr>
		<tr>
			<td>우편번호</td>
			<td><form:input path="empPost" id="sample4_postcode"/>
				<form:errors path="empPost"/></td>
		</tr>
		<tr>
			<td>연락처</td>
			<td><form:input path="empPhone" />
				<form:errors path="empPhone"/></td>
		</tr>		
		<tr>
			<td>주민번호</td>
			<td><form:input path="empJumin" />
				<form:errors path="empJumin"/></td>
		</tr>		
		<tr>
			<td>이메일</td>
			<td><form:input path="empEmail" />
				<form:errors path="empEmail"/></td>
		</tr>		
		<tr>
			<td>입사일</td>
			<td><input type="date" path="empHireDate" />
				<form:errors path="empHireDate"/></td>
		</tr>				
		<tr>
			<td colspan=2>
				<input type="submit" value="등록"/>
				<input type="button" value="목록으로" 
						onclick="javascript:location.href='empList'"/>
			</td>			
		</tr>	
			
	</table>
</form:form>
</body>
</html>