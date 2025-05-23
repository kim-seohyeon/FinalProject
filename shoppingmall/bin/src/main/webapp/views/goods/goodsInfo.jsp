 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goodsInfo.jsp</title>
</head>
<body>
<table border=1 align="center" width="600">
<caption>${dto.goodsName } 상품 상세보기</caption>
	<tr><th width="150" >상품번호</th>
		<td>${dto.goodsNum }</td></tr>
	<tr><th width="150" >브랜드명(주식종목이름)</th>
		<td>${dto.stockName }</td></tr>	
	<tr><th width="150" >상품명</th>
		<td>${dto.goodsName }</td></tr>
	<tr><th>상품가격</th>
		<td>${dto.goodsPrice }</td></tr>
	<tr><th>상품설명</th>
		<td>${dto.goodsContents }</td></tr>
	<tr><th>조회수</th>
		<td>${dto.visitCount }</td></tr>
	<tr><th>등록한 사원</th>
		<td>${dto.empNum }</td></tr>
	<tr><th>등록일</th>
		<td>${dto.goodsRegist }</td></tr>
	<tr><th>수정한 사원</th>
		<td>${dto.updateEmpNum }</td></tr>
	<tr><th>수정일</th>
		<td>${dto.goodsUpdateDate }</td></tr>	
	<tr><th>메인이미지</th>
		<td><img width="300" height="200" src="/static/goodsUpload/${dto.goodsMainStoreImage }"/></td></tr>	
	<tr>
		<th>상품 상세 이미지</th>
		<td>
			<c:forTokens items="${dto.goodsDetailStoreImage }" delims="`" var="image">
				<img width="300" height="200" src="/static/goodsUpload/${image }"/>
			</c:forTokens>
		</td>
	</tr>	
		
				
	<tr><th colspan="2">
		<a href="goodsUpdate?goodsNum=${dto.goodsNum }">상품수정</a> | 
		<a href="goodsDelete?goodsNum=${dto.goodsNum }">상품 삭제</a> | 
		<a href="goodsList">상품목록</a></th></tr>
</table>
</body>
</html>

