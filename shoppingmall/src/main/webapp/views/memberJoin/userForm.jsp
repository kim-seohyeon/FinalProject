<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-1.8.1.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src ="/static/js/daumAddressScript.js"></script>

<head>
<meta charset="UTF-8">
<title>userForm</title>
</head>
<body>
<form:form action = "userWrite" method="post" id="frm" modelAttribute="memberCommand">
<table border=1 width=700>
	<tr><td>아이디</td>
		<td><form:input path="memberId"  />
			<form:errors path="memberId" />아이디 중복 확인</td></tr>
	<tr><td>비밀번호</td>
		<td><form:password path="memberPw"  />
			<form:errors path="memberPw" /></td></tr>
	<tr><td>비밀번호 확인</td>
		<td><form:password path="memberPwCon" />
			<form:errors path="memberPwCon" /></td></tr>
	<tr><td>회원이름</td>
		<td><form:input path="memberName" />
			<form:errors path="memberName" /></td></tr>
	<tr><td>회원 연락처1</td>
		<td><form:input path="memberPhone1" />
			<form:errors path="memberPhone1" /></td></tr>
	<tr><td>회원 연락처2</td>
		<td><form:input path="memberPhone2" />
			<form:errors path="memberPhone2" /></td></tr>
	<tr><td>회원 주소</td>
		<td><input type="text" name="memberAddr" id="sample4_roadAddress"/>
			<button type="button" onclick="execDaumPostcode();">주소검색</button>
			<form:errors path="memberAddr" /></td></tr>
	<tr><td>회원 상세주소</td>
		<td><form:input path="memberAddrDetail" />
			<form:errors path="memberAddrDetail" /></td></tr>
	<tr><td>회원 우편번호</td>
		<td><input type="text" name="memberPost" id="sample4_postcode"/>
			<form:errors path="memberPost" /></td></tr>
	
	<tr><td>회원 이메일</td>
		<td><input type="email" name="memberEmail" value="${membercommand.memberEmail }" />
			<form:errors path="memberEmail" /></td></tr>
	<tr><td>회원 생년월일</td>
		<td><input type="date" name="memberBirth" />
			<form:errors path="memberBirth" /></td></tr>
	<tr><td>회원 성별</td>
		<td>
			<input type="radio" name="memberGender" value="F" checked="checked"/>여자
			<input type="radio" name="memberGender" value="M"/>남자</td></tr>
	
	<tr><td colspan="2">
			<input type="submit" value="가입하기"/>
			<input type="button" value="가입취소" onclick="javascript:location.href='/jspMVCHKShopping'"/>
		</td></tr>
</table>
</form:form>
</body>
</html>