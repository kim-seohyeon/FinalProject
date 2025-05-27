<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myNewPw.jsp</title>
<script src="https://code.jquery.com/jquery-1.8.1.js"></script>
<script type="text/javascript">
$(function(){
	$("#frm").submit(function(){
		if($("#newPw").val() != $("#newPwCon").val()){
			alert("비밀번호 확인이 일치하지 않습니다.");
			$("#newPwCon").val("");
			$("#newPw").val("");
			$("#newPw").focus();
			return false;
		}
	});
});
</script>
</head>
<body>
<jsp:include page="/views/header.jsp" />
비밀번호 변경<br/>

<ul>
	<li><a href='<c:url value="/"/>'>홈</a></li>
	<li><a href='/myPage/memberMyPage'>내정보 보기</a></li>
	<li><a href='/myPage/memberUpdate'>내정보 수정</a></li>
	<li><a href="/myPage/myNewPw">비밀번호 변경</a></li>
	<li><a href="/myPage/memberDrop">회원 탈퇴</a></li>
</ul>

<form action="myNewPw" method="post" id="frm">
현재 비밀번호: <input type="password" name="oldPw" id="oldPw" required="required"/>
			<span style="color:red">${pwErr }</span><br/>
새 비밀번호: <input type="password" name="newPw" id="newPw" required="required"/><br/>
새 비밀번호 확인: <input type="password" name="newPwCon" id="newPwCon" required="required"/><br/>
<input type="submit" value="비밀번호 변경"/>
</form>
<%@ include file="/views/footer.jsp" %>
</body>
</html>