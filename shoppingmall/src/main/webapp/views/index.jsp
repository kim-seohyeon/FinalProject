<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>



<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.1.min.js"></script>
<script type="text/javascript">

$(function(){
	page = 1;
	$("#load-more").click(function(){
		page++;
		$.ajax({
			url:"loadMore",
			type: "post",
			data: {"page":page},
			dataType: "json",
			success: function(model){
				var item = "";
				item += '<table align = "center" width="900">';
				item += 	'<tr>';
				
				$.each(model.list , function(idx, dto){
					item += 		'<td><a href="goodsDetail?goodsNum='+dto.goodsNum+'">';
					item += 			'<img src="/static/goodsUpload/'+dto.goodsImageStoreName+'" width=300/>';
					item += 			''+dto.goodsSubject+'<br/>';
					item += 			''+dto.goodsWriter+'<br/>';
					item += 			'</a>';
					item += 		'</td>';
					if((idx + 1) % 3) item += "</tr><tr>";
				});
				item += 	'</tr>';
				item += '</table>';
				$("#content").append(item);
				if(model.maxPage <= page) $("#more").css("display", "none")
			},
		});
	});
});

</script>


</head>

<body>
hk shoppingmall<br/>
<a href="mailling">메일링</a> | <a href="library">자료실</a> | <a href="/community/communityList">커뮤니티</a>

<c:if test="${!empty auth }">
<ul>
	<c:if test="${auth.grade == 'emp' }">
		<li><a href="/member/memberList">회원관리</a></li>
		<li><a href="/employee/empList">직원관리</a></li>
		<li><a href="/empPage/empMyPage">내정보 보기</a></li>
		<li><a href="/goods/goodsList">상품관리</a></li>
	</c:if>
	<c:if test="${auth.grade == 'mem' }">
		<li><a href="/myPage/memberMyPage">내정보 보기</a></li>
		<li><a href="/item/cartList">장바구니</a></li>
		<li><a href="/item/wishList">찜 목록</a></li>
		<li><a href="/item/purchaseList">구매목록</a></li>
		
	</c:if>
	<li><a href="/login/logout">로그아웃</a></li>
</ul>
</c:if>

<c:if test="${empty auth }">

<form:form modelAttribute="loginCommand" action="/login/login" method="post">
<table border=1>
	<tr>
		<td colspan=2>
			자동 로그인<input type="checkbox" name="autoLogin" /> | 
			아이디 저장<input type="checkbox" name="idStore" 
				<c:if test="${loginCommand.idStore }">checked</c:if>/>
		</td>
	</tr>
	<tr>
		<td><form:input path="userId"/>
			<form:errors path="userId"/></td>
		<td rowspan=2><input type="submit" value="로그인"/></td>
	</tr>
	<tr>
		<td><form:password path="userPw" />
			<form:errors path="userPw"/>
		</td>
	</tr>
	<tr>
		<td colspan=2>
			<a href="/help/findId">아이디</a>/
			<a href="/help/findPassword">비밀번호찾기</a> | 
			<a href="/register/userAgree">회원가입</a></td>
	</tr>		
</table>
</form:form>
</c:if>

<div id="content">
<table width=800 align="center">
	<c:forEach items="${list }" var="dto" varStatus="idx">
	    <c:if test="${idx.index % 3 == 0}"><tr></c:if>
			<td>
				<a href="/item/detailView?goodsNum=${dto.goodsNum}">
					<img src="/static/goodsUpload/${dto.goodsMainStoreImage}" width="300" height="150"/><br/>
					${dto.goodsName }<br/>
					${dto.goodsPrice }원
				</a>
			</td>
		<c:if test="${(idx.index + 1) % 3 == 0}"></tr></c:if>
	</c:forEach>
</table>

</div>

<div id="more">
	<table align="center" width=900>
		<tr>
			<th>
				<button id="load-more">더보기</button>
			</th>
		</tr>
	</table>
</div>
</body>
</html>