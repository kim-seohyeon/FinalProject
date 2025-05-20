<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- String 관련 메서드 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empModify.jsp</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src ="js/daumAddressScript.js"></script>

</head>
<body>
직원 정보 수정<br/>
<ul>
	<li><a href='<c:url value="/"/>'>홈</a></li>
	<li><a href='/empPage/empMyPage'>직원정보 보기</a></li>
	<li><a href='/empPage/empUpdate'>직원정보 수정</a></li>
	<li><a href="/empPage/empPwUpdate">비밀번호 변경</a></li>
	<li><a>직원 탈퇴</a></li>
</ul>
<form action="empModify" method="post" id="frm">
직원 번호: <input type="text" name="empNum" value="${dto.empNum }" readonly="readonly"/><br/>
직원 이름: <input type="text" name="empName" value="${dto.empName }" /><br/>
직원 아이디: <input type="text" name="empId" value="${dto.empId }" readonly="readonly"/><br/>

직원 비밀번호: <input type="password" name="empPw"/>
			<span style="color:red">${pwErr }</span><br/>

직원 주소: <input type="text" name="empAddr" id="sample4_roadAddress" value="${dto.empAddr }"/>
		<input type="button" value="주소검색" onclick="execDaumPostcode();"/><br/>
직원 상세주소: <input type="text" name="empAddrDetail" value="${dto.empAddrDetail }"/><br/>
직원 우편번호: <input type="text" name="empPost" id="sample4_postcode" value="${dto.empPost }" /><br/>
직원 연락처:<input type="tel" name="empPhone" value="${dto.empPhone }"/><br/>
직원 주민번호: <input type="text" name="empJumin" value="${dto.empJumin }" readonly="readonly"/><br/>
직원 이메일: <input type="email" name="empEmail" value="${dto.empEmail }"/><br/>
직원 입사일: <input type="date" name="empHireDate" value="${dto.empHireDate }" readonly="readonly"/><br/>
<input type="submit" value="직원정보 수정완료"/>
</form>
</body>
</html>