<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- String 관련 메서드 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myModify.jsp</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src ="js/daumAddressScript.js"></script>

</head>
<body>
내 정보 수정<br/>
<ul>
	<li><a href='<c:url value="/"/>'>홈</a></li>
	<li><a href='/myPage/memberMyPage'>내정보 보기</a></li>
	<li><a href='/myPage/memberUpdate'>내정보 수정</a></li>
	<li><a href="/myPage/myNewPw">비밀번호 변경</a></li>
	<li><a href="/myPage/memberDrop">회원 탈퇴</a></li>
</ul>
<form action="memberUpdate" method="post" name="frm">
이름: <input type="text" name="memberName" value="${dto.memberName }"/><br/>
아이디: <input type="text" name="memberId" value="${dto.memberId }" readonly="readonly"/><br/>

비밀번호: <input type="password" name="memberPw"/>
		<span style="color:red">${pwErr }</span><br/>

주소: <input type="text" name="memberAddr" id="sample4_roadAddress" value="${dto.memberAddr }"/>
	 <input type="button" value="주소검색" onclick="execDaumPostcode();"/><br/>
상세주소: <input type="text" name="memberAddrDetail" value="${dto.memberAddrDetail }"/><br/>
우편번호: <input type="text" name="memberPost" id="sample4_postcode" value="${dto.memberPost }"/><br/>
연락처1: <input type="tel" name="memberPhone1" value="${dto.memberPhone1 }"/><br/>
연락처2: <input type="tel" name="memberPhone2" value="${dto.memberPhone2 }"/><br/>
성별: <input type="checkbox" name="memberGender" value="M" <c:if test="${dto.memberGender == 'M'}">checked</c:if> />남자
	 <input type="checkbox" name="memberGender" value="F" <c:if test="${dto.memberGender == 'F'}">checked</c:if> />여자<br/>
등록일: <input type="date" name="memberRegist" value="${fn:substring(dto.memberRegist, 0, 10) }" /><br/>
생년월일: <input type="date" name="memberBirth" value="${fn:substring(dto.memberBirth, 0, 10) }"/><br/>
이메일: <input type="email" name="memberEmail" value="${dto.memberEmail }"/><br/>
<input type="submit" value="회원정보 수정 완료"/>
</form>

</body>
</html>