<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글 상세보기</title>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background: #ffffff;
        margin: 0;
        padding: 0;
        color: #333;
    }
    .container {
        max-width: 800px;
        margin: 50px auto;
        background: #fff;
        padding: 40px;
        border-radius: none;
        box-shadow: none;
    }
    h2 {
        font-size: 1.6rem;
        margin-bottom: 30px;
        border-bottom: 2px solid #0077cc;
        padding-bottom: 10px;
        color: #2c3e50;
        text-align: left;
    }
    table.detail-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px;
    }
    .detail-table th,
    .detail-table td {
        padding: 14px;
        border: 1px solid #ddd;
        text-align: left;
    }
    .detail-table th {
        background: #f0f4f8;
        width: 150px;
        font-weight: 600;
        color: #555;
    }
    .action-links {
        text-align: center;
        margin-top: 20px;
    }
    .action-links a {
        display: inline-block;
        margin: 0 10px;
        color: #0077cc;
        text-decoration: none;
        font-weight: 500;
    }
    .action-links a:hover {
        text-decoration: underline;
    }

    .comment-section {
        margin-top: 40px;
    }
    .comment-section h4 {
        font-size: 1.2rem;
        margin-bottom: 15px;
        color: #0077cc;
        border-bottom: 1px solid #ddd;
        padding-bottom: 5px;
    }
    textarea {
        width: 100%;
        padding: 10px;
        font-size: 1rem;
        border-radius: 6px;
        border: 1px solid #ccc;
        resize: vertical;
        margin-bottom: 10px;
    }
    .btn-submit {
        padding: 10px 20px;
        background: #0077cc;
        color: white;
        border: none;
        border-radius: 6px;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.3s;
    }
    .btn-submit:hover {
        background: #005fa3;
    }
    .comment {
        margin-bottom: 15px;
        padding: 12px 15px;
        background: #f9fafb;
        border-radius: 6px;
        border: 1px solid #e1e4e8;
    }
    .comment strong {
        color: #2c3e50;
    }
    .comment small {
        color: #888;
        margin-left: 10px;
    }
    .comment a {
        color: #cc0000;
        text-decoration: none;
        margin-left: 10px;
    }
    .comment a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h2>글 상세보기</h2>
    <table class="detail-table">
        <tr><th>글 번호</th><td>${dto.inquireNum}</td></tr>
        <tr><th>작성자</th><td>${dto.inquireWriter}</td></tr>
        <tr><th>제목</th><td>${dto.inquireSubject}</td></tr>
        <tr><th>내용</th><td>${dto.inquireContents}</td></tr>
    </table>

    <div class="action-links">
        <a href="inquireUpdate?inquireNum=${dto.inquireNum}">글 수정</a> |
        <a href="inquireDelete?inquireNum=${dto.inquireNum}" onclick="return confirm('글을 삭제하시겠습니까?');">글 삭제</a> |
        <a href="inquireList">글 목록</a>
    </div>

    <div class="comment-section">
        <h4>댓글 작성</h4>
        <form action="icommentWrite" method="post">
            <input type="hidden" name="inquireNum" value="${dto.inquireNum}" />
            <textarea name="icommentContent" rows="3" placeholder="댓글을 입력하세요" required></textarea>
            <br>
            <button type="submit" class="btn-submit">댓글 작성</button>
        </form>

        <br>

        <c:choose>
            <c:when test="${not empty icommentList}">
                <h4>댓글 목록</h4>
                <c:forEach var="icomment" items="${icommentList}">
                    <div class="comment">
                        <strong>${icomment.memberId}</strong>
                        ${icomment.icommentContent}
                        <small><fmt:formatDate value="${icomment.icommentDate}" type="both"/></small>
                        <c:if test="${auth != null && auth.userId == icomment.memberId}">
                            <a href="icommentDelete?icommentId=${icomment.icommentId}&inquireNum=${icomment.inquireNum}" 
                               onclick="return confirm('댓글을 삭제하시겠어요?');">삭제</a>
                        </c:if>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>작성된 댓글이 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
