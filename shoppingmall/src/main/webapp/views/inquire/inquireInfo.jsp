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
        border-radius: 0;
        box-shadow: none;
    }
    h2 {
            font-size: 1.6rem;
            margin-bottom: 30px;
            border-bottom: 2px solid #0077cc;
            padding-bottom: 10px;
            color: #2c3e50;
            font-weight: 700;
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
        margin-top: 50px;
    }
    .action-links a {
        display: inline-block;
        margin: 0 10px;
        color: #0077cc;
        text-decoration: none;
        font-weight: 500;
        font-size: 15px;
    }
    .action-links a:hover {
        text-decoration: underline;
    }
    p {
        margin: 8px 0;
        font-weight: 500;
    }
    hr {
        border: none;
        border-top: 1px solid #ddd;
        margin: 30px 0;
    }

    .comment-section {
        margin-top: 10px;
        display: none;
    }
    h3 {
        margin-top: 0;
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
        background-color: #0077cc;
        color: white;
        border: none;
        padding: 5px 10px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        font-size: 10px;
        margin-top: 10px;
        margin-right: 6px;
        transition: background-color 0.3s;
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
    .comment p {
        margin: 4px 0;
    }
    .comment strong {
        font-weight: 700;
    }

    .delete-link {
        color: #0077cc;
        text-decoration: none;
        font-weight: 500;
        cursor: pointer;
        margin-left: 10px;
        font-size: 12px;
        vertical-align: middle;
    }
    .delete-link:hover {
        text-decoration: underline;
    }
    .delete-link .icon {
        margin-right: 4px;
        vertical-align: middle;
    }
    #toggleCommentBtn {
        background: none;
        border: none;
        color: #0077cc;
        font-weight: 600;
        cursor: pointer;
        font-size: 14px;
        margin-top: 10px;
        display: inline-flex;
        align-items: center;
        padding: 0;
        transition: color 0.3s;
    }
    #toggleCommentBtn:hover {
        color: #005fa3;
        text-decoration: underline;
    }
    #toggleCommentBtn .icon {
        margin-right: 6px;
        font-size: 16px;
    }
</style>
<script>
    function toggleCommentForm() {
        var form = document.getElementById("comment-section");
        if (!form) return;
        form.style.display = (form.style.display === "none" || form.style.display === "") ? "block" : "none";
    }
    function toggleEditForm(commentId) {
        var form = document.getElementById("editForm-" + commentId);
        if (!form) return;
        form.style.display = (form.style.display === "none" || form.style.display === "") ? "block" : "none";
    }
</script>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h2>문의내역 확인</h2>
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
    <hr>

    <button id="toggleCommentBtn" onclick="toggleCommentForm()">
        <span class="icon">✏️</span> 댓글 작성
    </button>

    <div id="comment-section" class="comment-section">
        <form action="icommentWrite" method="post">
            <input type="hidden" name="inquireNum" value="${dto.inquireNum}" />
            <textarea id="icommentContent" name="icommentContent" rows="4" required></textarea><br/>
            <input type="submit" value="댓글 등록" class="btn-submit" />
        </form>
    </div>
    <hr>
    <br>
<h3>댓글</h3>
<c:choose>
    <c:when test="${not empty icommentList}">
        <c:forEach var="icomment" items="${icommentList}">
            <div class="comment">
                <p>
                    <strong>
                        <c:choose>
                            <c:when test="${not empty icomment.empId}">
                                ${icomment.empId} <span style="color: blue;">[직원]</span>
                            </c:when>
                            <c:otherwise>
                                ${icomment.memberId} <span style="color: green;">[회원]</span>
                            </c:otherwise>
                        </c:choose>
                    </strong> |
                    <fmt:formatDate value="${icomment.icommentDate}" pattern="yyyy-MM-dd HH:mm"/>

                    <c:if test="${auth != null 
                                && ((not empty icomment.memberId && auth.userId eq icomment.memberId) 
                                     || (not empty icomment.empId && auth.userId eq icomment.empId))}">
                        <a href="icommentDelete?icommentId=${icomment.icommentId}&inquireNum=${icomment.inquireNum}" 
                           class="delete-link"
                           onclick="return confirm('댓글을 삭제하시겠어요?');">
                            🗑️삭제
                        </a>
                    </c:if>
                </p>
                <p>${icomment.icommentContent}</p>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <p>작성된 댓글이 없습니다.</p>
    </c:otherwise>
</c:choose>

</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
