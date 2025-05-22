<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empNewPw.jsp</title>
</head>
<body>
직원 비밀번호 변경 페이지<br/>
<ul>
	<li><a href='<c:url value="/"/>'>홈</a></li>
	<li><a href='/empPage/empMyPage'>내정보 보기</a></li>
	<li><a href='/empPage/empUpdate'>내정보 수정</a></li>
	<li><a href="/empPage/empNewPw">비밀번호 변경</a></li>
	<li><a>회원 탈퇴</a></li>
</ul>

<form action="empNewPw" method="post" id="frm">
현재 비밀번호: <input type="password" name="oldPw" id="oldPw" required="required"/>
			<span style="color:red">${pwErr }</span><br/>
새 비밀번호: <input type="password" name="newPw" id="newPw" required="required"/><br/>
새 비밀번호 확인: <input type="password" name="newPwCon" id="newPwCon" required="required"/><br/>
<input type="submit" value="비밀번호 변경"/>
</form>
</body>
</html>