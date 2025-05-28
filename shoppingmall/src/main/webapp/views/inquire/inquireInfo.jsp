<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>inquireInfo</title>
</head>
<body>
<jsp:include page="/views/header.jsp" />
<table border=1 align="center" width="600">

<caption> 글 상세보기</caption>
	<tr><th width="150" >글 번호</th>
		<td>${dto.inquireNum }</td></tr>
	<tr><th width="150" >작성자</th>
		<td>${dto.inquireWriter }</td></tr>	
	<tr><th width="150" >제목</th>
		<td>${dto.inquireSubject }</td></tr>
	<tr><th width="150" >내용</th>
		<td>${dto.inquireContents }</td></tr>

<tr><th colspan="2">
		<a href="inquireUpdate?inquireNum=${dto.inquireNum }">글 수정</a> | 
		<a href="inquireDelete?inquireNum=${dto.inquireNum }">글 삭제</a> | 
		<a href="inquireList">글 목록</a></th></tr>
</table>

<br>
<div style="width:600px; margin:0 auto;">

    <!-- 댓글 작성 폼 -->
    <form action="icommentWrite" method="post">
        <input type="hidden" name="inquireNum" value="${dto.inquireNum}" />
        <textarea name="icommentContent" rows="3" cols="70" placeholder="댓글을 입력하세요"></textarea><br>
        <input type="submit" value="댓글 작성" />
    </form>

    <br>
    <!-- 댓글 목록 -->
    <c:if test="${not empty icommentList}">
        <h4>댓글 목록</h4>
        <ul>
            <c:forEach var="icomment" items="${icommentList}">
                <li>
                    <strong>${icomment.memberId}</strong> :
                    ${icomment.icommentContent}
                    <small>
                    <fmt:formatDate value="${icomment.icommentDate}" type="both"/>
                    </small>
                </li>
            </c:forEach>
        </ul>
    </c:if>

    <c:if test="${empty icommentList}">
        <p>작성된 댓글이 없습니다.</p>
    </c:if>

</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>