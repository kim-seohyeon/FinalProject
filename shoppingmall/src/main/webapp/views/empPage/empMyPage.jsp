<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- String 관련 메서드 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empMyPage.jsp</title>
</head>
<body>
<jsp:include page="/views/header.jsp" />
내 정보 상세보기(직원)

<ul>
	<li><a href='<c:url value="/"/>'>홈</a></li>
	<li><a href='/empPage/empMyPage'>직원정보 보기</a></li>
	<li><a href='/empPage/empUpdate'>직원정보 수정</a></li>
	<li><a href="/empPage/empNewPw">비밀번호 변경</a></li>
	<li><a>직원 탈퇴</a></li>
</ul>

직원 번호: ${dto.empNum }<br/>
직원 이름: ${dto.empName }<br/>
직원 아이디: ${dto.empId }<br/>
직원 주소: ${dto.empAddr }<br/>
직원 상세주소: ${dto.empAddrDetail }<br/>
직원 우편번호: ${dto.empPost }<br/>
직원 연락처: ${dto.empPhone }<br/>
직원 주민번호: ${dto.empJumin }<br/>
직원 이메일: ${dto.empEmail }<br/>
직원 입사일: ${dto.empHireDate }<br/>

</body>
<%@ include file="/views/footer.jsp" %>
</html>