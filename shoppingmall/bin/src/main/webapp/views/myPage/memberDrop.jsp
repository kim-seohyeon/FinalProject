<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberDrop.jsp</title>
</head>
<body>
회원탈퇴<br/>

<ul>
	<li><a href='<c:url value="/"/>'>홈</a></li>
	<li><a href='/myPage/memberMyPage'>내정보 보기</a></li>
	<li><a href='/myPage/memberUpdate'>내정보 수정</a></li>
	<li><a href="/myPage/myNewPw">비밀번호 변경</a></li>
	<li><a href="/myPage/memberDrop">회원 탈퇴</a></li>
</ul>
<form action="memberDropOk.my" method="post">
비밀번호: <input type="password" id="memberPw" name="memberPw"/>
   	    <input type="submit" value="회원탈퇴" />
   	    <div style = "color: red">${pwErr }</div>
</form>
</body>
</html>