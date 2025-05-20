<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberDetail</title>
</head>
<body>
회원 정보 상세보기<br/>

회원번호: ${dto.memberNum }<br/>
회원아이디: ${dto.memberId }<br/>
회원이름: ${dto.memberName }<br/>
회원주소: ${dto.memberAddr }<br/>
회원상세주소: ${dto.memberAddrDetail }<br/>
회원우편번호: ${dto.memberPost }<br/>
회원등록일: <fmt:formatDate value="${dto.memberRegist }" pattern="yyyy-MM-dd"/> <br/>
회원성별: ${dto.memberGender }<br/>
회원연락처1: ${dto.memberPhone1 }<br/>
회원연락처2: ${dto.memberPhone2 }<br/>
회원이메일: ${dto.memberEmail }<br/>
회원생년월일: <fmt:formatDate value="${dto.memberBirth }" pattern="yyyy-MM-dd"/> <br/>

<a href="memberList">회원 목록</a> |
<a href="memberUpdate?memberNum=${dto.memberNum }">회원 수정</a> | 
<a href="memberDelete?memberNum=${dto.memberNum }">회원 탈퇴</a>

</body>
</html>