<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>글 상세보기</title>
    <style>
        /* 스타일 그대로 유지 */
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
        p {
            margin: 8px 0;
            font-weight: 500;
        }
        hr {
            border: none;
            border-top: 1px solid #ddd;
            margin: 30px 0;
        }
        .content-area {
            min-height: 100px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 6px;
            background: #f9fafb;
            line-height: 1.6;
            white-space: pre-wrap;
            margin-bottom: 30px;
        }
        .post-image {
            max-width: 400px;
            width: 100%;
            aspect-ratio: 1 / 1;
            margin: 20px auto;
            border-radius: 6px;
            display: block;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        button, input[type="submit"] {
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
        
        button:hover, input[type="submit"]:hover {
            background-color: #005fa3;
        }
        .like-btn {
            background-color: #e74c3c;
        }
        .like-btn:hover:not(:disabled) {
            background-color: #c0392b;
        }
        .like-btn:disabled {
            background-color: #bdc3c7;
            cursor: default;
        }
        .like-info {
            margin-left: 10px;
            font-weight: 600;
            font-size: 12px;
            color: #e74c3c;
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
        textarea {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border-radius: 6px;
            border: 1px solid #ccc;
            resize: vertical;
            margin-bottom: 10px;
        }
        #commentForm {
            margin-top: 20px;
            display: none;
        }
        a.back-link {
            display: inline-block;
            margin-top: 40px;
            color: #0077cc;
            text-decoration: none;
            font-weight: 600;
            
        }
        a.back-link:hover {
            text-decoration: underline;
        }
        .action-links {
            margin-top: 20px;
            
        }
        .action-links a {
            margin-right: 10px;
            color: #0077cc;
            text-decoration: none;
            font-weight: 500;
            font-size : 15px;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
        .comment-actions {
            margin-left: 10px;
            font-size: 12px;
        }
        .comment-actions a {
            color: #0077cc;
            text-decoration: none;
            margin-left: 6px;
        }
        .comment-actions a:hover {
            text-decoration: underline;
        }
        /* 댓글 작성 버튼 스타일 */
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
            var form = document.getElementById("commentForm");
            form.style.display = (form.style.display === "none" || form.style.display === "") ? "block" : "none";
        }
        function toggleEditForm(commentId) {
            var form = document.getElementById("editForm-" + commentId);
            form.style.display = (form.style.display === "none" || form.style.display === "") ? "block" : "none";
        }
    </script>
</head>
<body>

<jsp:include page="/views/header.jsp" />

<div class="container">
    <h2>${community.communitySubject}</h2>

    <p>작성자: ${community.communityWriter}</p>
    <p>등록일: <fmt:formatDate value="${community.communityDate}" pattern="yyyy-MM-dd" /></p>
    <p>조회수: ${community.viewCount}</p>

    <c:if test="${auth != null && auth.userId == community.communityWriter}">
        <div class="action-links">
            <!-- 수정, 삭제는 GET 요청으로 처리 -->
            <a href="<c:url value='/community/update?communityNum=${community.communityNum}' />">글 수정</a> |  
            <a href="<c:url value='/community/delete?communityNum=${community.communityNum}' />" onclick="return confirm('글을 삭제하시겠습니까?');">글 삭제</a>
        </div>
    </c:if>

    <hr />

    <div class="content-area">${community.communityContent}</div>

    <c:if test="${not empty community.imagePath}">
        <img src="${pageContext.request.contextPath}/static/upload/community/${community.imagePath}" alt="이미지" class="post-image" />
    </c:if>

    <hr />

    <!-- 좋아요 버튼 - POST 요청 -->
    <form action="<c:url value='/community/like' />" method="post" style="display:inline;">
        <input type="hidden" name="communityNum" value="${community.communityNum}" />
        <c:choose>
            <c:when test="${auth != null}">
                <button type="submit" class="like-btn">
                    <c:choose>
                        <c:when test="${!empty num}">
                            ♥ 좋아요 취소
                        </c:when>
                        <c:otherwise>
                            ♡ 좋아요
                        </c:otherwise>
                    </c:choose>
                </button>
            </c:when>
            <c:otherwise>
                <button type="button" class="like-btn" disabled title="로그인 후 이용 가능합니다">♡ 좋아요</button>
            </c:otherwise>
        </c:choose>
        <span class="like-info">${likeCount}개</span>
    </form>

    <hr />
    <!-- 댓글 작성 버튼 (아이콘 + 텍스트) -->
    <button id="toggleCommentBtn" onclick="toggleCommentForm()">
        <span class="icon">✏️</span> 댓글 작성
    </button>
    <div id="commentForm">
        <form action="<c:url value='/community/commentWrite' />" method="post">
            <input type="hidden" name="communityNum" value="${community.communityNum}" />
            <label for="content"></label><br/>
            <textarea id="content" name="content" rows="4" required></textarea><br/>
            <input type="submit" value="댓글 등록" />
        </form>
    </div>
    <hr>
    <h3>댓글</h3>

    <c:forEach var="comment" items="${commentList}">
        <div class="comment">
            <p>
                <strong>${comment.memberId}</strong> |
                <fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm" />

                <c:if test="${auth != null && auth.userId == comment.memberId}">
                    <span class="comment-actions">
                        <a href="javascript:void(0);" onclick="toggleEditForm('${comment.commentNum}')">✏️ 수정 </a>
                        <a href="javascript:void(0);" onclick="if(confirm('정말 이 댓글을 삭제하시겠습니까?')) { document.getElementById('deleteForm-${comment.commentNum}').submit(); }">🗑️ 삭제</a>
                    </span>

                    <form id="deleteForm-${comment.commentNum}" action="<c:url value='/community/commentDelete' />" method="post" style="display:none;">
                        <input type="hidden" name="commentNum" value="${comment.commentNum}" />
                        <input type="hidden" name="communityNum" value="${community.communityNum}" />
                    </form>
                </c:if>
            </p>
            <p>${comment.content}</p>

            <!-- 댓글 수정 폼 -->
            <form id="editForm-${comment.commentNum}" action="<c:url value='/community/commentUpdate' />" method="post" style="display:none; margin-top: 10px;">
                <input type="hidden" name="commentNum" value="${comment.commentNum}" />
                <input type="hidden" name="communityNum" value="${community.communityNum}" />
                <textarea name="content" rows="3" required>${comment.content}</textarea><br/>
                <input type="submit" value="저장" />
            </form>
        </div>
    </c:forEach>

    <a href="<c:url value='/community/communityList' />" class="back-link">← 목록으로</a>
</div>

</body>
</html>
