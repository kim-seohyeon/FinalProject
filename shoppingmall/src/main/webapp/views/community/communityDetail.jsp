<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8" />
    <title>글 상세보기</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #ffffff;
            margin: 0;
            padding: 7px;
            color: #2c3e50;
        }
        .container {
            width: 80%;
            max-width: 800px;
            margin: auto;
            padding: 20px 0;
        }
        h2 {
            font-size: 2rem;
            font-weight: bold;
            color: #3498db;
            margin-bottom: 20px;
        }
        p {
            margin: 5px 0;
            color: #2c3e50;
            font-weight: 500;
        }
        hr {
            border: none;
            border-top: 1px solid #e0e0e0;
            margin: 20px 0;
        }
        .content-area {
            min-height: 100px;
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 6px;
            background-color: #fafafa;
            font-size: 16px;
            line-height: 1.6;
            white-space: pre-wrap;
            margin-bottom: 30px;
            color: #2c3e50;
            overflow-wrap: break-word;
        }
        .post-image {
            max-width: 400px;
            width: 100%;
            aspect-ratio: 1 / 1;
            margin-bottom: 20px;
            border-radius: 6px;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        .comment {
            border: 1px solid #e0e0e0;
            padding: 12px;
            margin-bottom: 12px;
            border-radius: 6px;
            background: #fafafa;
            color: #2c3e50;
            font-weight: 500;
        }
        button, input[type="submit"] {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
            margin-top: 10px;
            margin-right: 6px;
            transition: background-color 0.3s;
        }
        button:hover, input[type="submit"]:hover {
            background-color: #2980b9;
        }
        button.small-btn {
            padding: 4px 10px;
            font-size: 12px;
            margin-top: 4px;
            margin-right: 4px;
        }
        button.small-btn:hover {
            background-color: #2980b9;
        }
        button.post-btn {
            padding: 6px 12px;
            font-size: 12px;
            margin-top: 6px;
            margin-right: 6px;
        }
        button.post-btn:hover {
            background-color: #2980b9;
        }
        #commentForm {
            margin-top: 20px;
        }
        textarea {
            width: 100%;
            border-radius: 6px;
            border: 1px solid #e0e0e0;
            padding: 10px;
            font-size: 14px;
            resize: vertical;
            color: #2c3e50;
        }
        a.back-link {
            display: inline-block;
            margin-top: 25px;
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }
        a.back-link:hover {
            text-decoration: underline;
        }
        .like-btn {
            background-color: #e74c3c;
            border-radius: 6px;
            padding: 8px 16px;
            font-weight: bold;
            font-size: 14px;
            cursor: pointer;
            color: white;
            border: none;
            transition: background-color 0.3s;
        }
        .like-btn:hover:not(:disabled) {
            background-color: #c0392b;
        }
        .like-btn:disabled {
            background-color: #bdc3c7;
            cursor: default;
        }
        .like-info {
            display: inline-block;
            margin-left: 10px;
            font-weight: 600;
            color: #e74c3c;
            vertical-align: middle;
            font-size: 14px;
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

    <c:if test="${auth != null && auth.userId == community.communityWriter}">
        <a href="<c:url value='/community/update?communityNum=${community.communityNum}' />">
            <button class="post-btn">글 수정하기</button>
        </a>
        <a href="<c:url value='/community/delete?communityNum=${community.communityNum}' />"
           onclick="return confirm('정말 이 글을 삭제하시겠습니까?');">
            <button class="post-btn" style="background-color: #dc3545;">글 삭제하기</button>
        </a>
    </c:if>

    <hr />

    <div class="content-area">${community.communityContent}</div>

    <c:if test="${not empty community.imagePath}">
        <img src="${pageContext.request.contextPath}/static/upload/community/${community.imagePath}" alt="이미지" class="post-image" />
    </c:if>

    <hr />

    <!-- 좋아요 버튼 및 개수 표시 (댓글 위로 이동) -->
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
        <span class="like-info">${likeCount}명</span>
    </form>

    <hr />

    <h3>댓글</h3>

    <c:forEach var="comment" items="${commentList}">
        <div class="comment">
            <p>
                <strong>${comment.memberId}</strong> | 
                <fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm" />
            </p>
            <p>${comment.content}</p>

            <c:if test="${auth != null && auth.userId == comment.memberId}">
                <button class="small-btn" onclick="toggleEditForm('${comment.commentNum}')">수정</button>
                <a href="<c:url value='/community/commentDelete?commentNum=${comment.commentNum}&communityNum=${community.communityNum}' />"
                   onclick="return confirm('정말 이 댓글을 삭제하시겠습니까?');">
                    <button class="small-btn" style="background-color: #dc3545;">삭제</button>
                </a>

                <form id="editForm-${comment.commentNum}" action="<c:url value='/community/commentUpdate' />" method="post" style="display:none; margin-top: 10px;">
                    <input type="hidden" name="commentNum" value="${comment.commentNum}" />
                    <input type="hidden" name="communityNum" value="${community.communityNum}" />
                    <textarea name="content" rows="3" required>${comment.content}</textarea><br/>
                    <input type="submit" value="저장" />
                </form>
            </c:if>
        </div>
    </c:forEach>

    <button onclick="toggleCommentForm()">댓글 작성</button>

    <div id="commentForm" style="display:none;">
        <form action="<c:url value='/community/commentWrite' />" method="post">
            <input type="hidden" name="communityNum" value="${community.communityNum}" />
            <label for="content">내용:</label><br/>
            <textarea id="content" name="content" rows="4" required></textarea><br/>
            <input type="submit" value="댓글 등록" />
            
        </form>
    </div>

    <a href="<c:url value='/community/communityList' />" class="back-link">← 목록으로</a>
</div>
</body>
</html>
