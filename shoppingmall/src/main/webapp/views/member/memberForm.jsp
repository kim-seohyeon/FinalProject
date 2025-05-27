<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberForm</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src ="/static/js/daumAddressScript.js"></script>
</head>
<body>
<jsp:include page="/views/header.jsp" />
회원정보 등록
<form action="memberWrite" method="post">
	<table border=1 width=600>

		<tr>
			<td>회원번호</td>
			<td><input type="text" name="memberNum" value="${memberNum }" readonly="readonly"/>자동부여</td>
		</tr>
		
		<tr>
			<td>회원이름</td>
			<td><input type="text" name="memberName"/></td>
		</tr>
	
		<tr>
			<td>회원아이디</td>
			<td><input type="text" name="memberId"/></td>
		</tr>
		
		<tr>
			<td>회원비밀번호</td>
			<td><input type="password" name="memberPw"/></td>
		</tr>
	
		<tr>
			<td>회원주소</td>
			<td><input type="text" name="memberAddr" id="sample4_roadAddress"/>
				<button type="button" onclick="execDaumPostcode();">주소검색</button>
			</td>
		</tr>
		
		<tr>
			<td>회원상세주소</td>
			<td><input type="text" name="memberAddrDetail"/></td>
		</tr>
		<tr>
			<td>회원우편번호</td>
			<td><input type="text" name="memberPost" id="sample4_postcode"/></td>
		</tr>
		<tr>
			<td>회원등록일</td>
			<td><input type="date" name="memberRegist"/></td>
		</tr>
		<tr>
			<td>회원성별</td>
			<td>
				<input type="radio" name="memberGender" value="F" checked="checked"/>여자
				<input type="radio" name="memberGender" value="M"/>남자
			</td>
		</tr>
		<tr>
			<td>회원연락처1</td>
			<td><input type="tel" name="memberPhone1"/></td>
		</tr>
		<tr>
			<td>회원연락처2</td>
			<td><input type="tel" name="memberPhone2"/></td>
		</tr>
		<tr>
			<td>회원이메일</td>
			<td><input type="email" name="memberEmail"/></td>
		</tr>
		<tr>
			<td>회원생년월일</td>
			<td><input type="date" name="memberBirth"/></td>
		</tr>								
		<tr>
			<td colspan=2>
				<input type="submit" value="회원등록"/>
				<input type="button" value="회원리스트" onclick="javascript:location.href='memberList'"/>
			</td>			
		</tr>	
			
	</table>
</form>
<%@ include file="/views/footer.jsp" %>
</body>
</html>