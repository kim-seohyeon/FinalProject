<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src ="/static/js/daumAddressScript.js"></script>
</head>
<body>
회원정보 수정
<form action="/member/memberUpdate" method="post">
	<table border=1 width=600>

		<tr>
			<td>회원번호</td>
			<td><input type="text" name="memberNum" value="${dto.memberNum }" 
						readonly="readonly"/>자동부여</td>
		</tr>
	
		<tr>
			<td>회원아이디</td>
			<td><input type="text" name="memberId" value="${dto.memberId }" readonly="readonly"/></td>
		</tr>

		<tr>
			<td>회원비밀번호</td>
			<td><input type="password" name="memberPw"/>
				<span style="color:red">${pwErr }</span></td>
		</tr>	

		<tr>
			<td>회원이름</td>
			<td><input type="text" name="memberName" value="${dto.memberName }"/></td>
		</tr>

		<tr>
			<td>회원주소</td>
			<td><input type="text" name="memberAddr" value="${dto.memberAddr }" id="sample4_roadAddress"/>
				<button type="button" onclick="execDaumPostcode();">주소검색</button>
			</td>
		</tr>
		<tr>
			<td>회원상세주소</td>
			<td><input type="text" name="memberAddrDetail" value="${dto.memberAddrDetail }" /></td>
		</tr>
		<tr>
			<td>회원우편번호</td>
			<td><input type="text" name="memberPost" value="${dto.memberPost }" id="sample4_postcode" /></td>
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
			<td><input type="tel" name="memberPhone1" value="${dto.memberPhone1 }" /></td>
		</tr>
		<tr>
			<td>회원연락처2</td>
			<td><input type="tel" name="memberPhone2" value="${dto.memberPhone2 }" /></td>
		</tr>
		<tr>
			<td>회원이메일</td>
			<td><input type="email" name="memberEmail" value="${dto.memberEmail }" /></td>
		</tr>		
		<tr>
			<td>회원생년월일</td>
			<td><input type="Date" name="memBirth" value='<fmt:formatDate value="${dto.memberBirth }" pattern="yyyy-MM-dd"/>'/></td>
		</tr>				
		<tr>
			<td colspan=2>
				<input type="submit" value="수정완료"/>
				<input type="button" value="목록으로" 
						onclick="javascript:location.href='memberList'"/>
			</td>			
		</tr>	
			
	</table>
</form>
</body>
</html>