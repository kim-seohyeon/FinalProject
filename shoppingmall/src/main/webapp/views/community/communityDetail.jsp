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
            background-color: #f7f9fc;
            margin: 0;
            padding: 30px;
            color: #333;
        }
        .container {
            width: 80%;
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            color: #007BFF;
            margin-bottom: 5px;
        }
        p {
            margin: 5px 0;
        }
        hr {
            border: none;
            border-top: 1px solid #ddd;
            margin: 20px 0;
        }
        .comment {
            border: 1px solid #ccc;
            padding: 12px;
            margin-bottom: 12px;
            border-radius: 6px;
            background: #fafafa;
        }
        button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            margin-top: 10px;
        }
        button:hover {
            background-color: #0056b3;
        }
        #commentForm {
            margin-top: 20px;
        }
        textarea {
            width: 100%;
            border-radius: 6px;
            border: 1px solid #ccc;
            padding: 10px;
            font-size: 14px;
            resize: vertical;
        }
        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 12px 20px;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 10px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        a.back-link {
            display: inline-block;
            margin-top: 25px;
            color: #007BFF;
            text-decoration: none;
            font-weight: bold;
        }
        a.back-link:hover {
            text-decoration: underline;
        }
        .edit-btn {
            margin-top: 15px;
        }
    </style>
    <script>
        function toggleCommentForm() {
            var form = document.getElementById("commentForm");
            if (form.style.display === "none") {
                form.style.display = "block";
            } else {
                form.style.display = "none";
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h2>${community.communitySubject}</h2>
    <p>작성자: ${community.communityWriter}</p>
    <p>등록일: <fmt:formatDate value="${community.communityDate}" pattern="yyyy-MM-dd" /></p>

    <c:if test="${auth != null && auth.userId == community.communityWriter}">
        <a href="<c:url value='/community/update?communityNum=${community.communityNum}' />" class="edit-btn">
            <button>글 수정하기</button>
        </a>
         <a href="<c:url value='/community/delete?communityNum=${community.communityNum}' />" class="edit-btn" 
       onclick="return confirm('정말 이 글을 삭제하시겠습니까?');">
        <button style="background-color: #dc3545;">글 삭제하기</button>
    </a>

    </c:if>

    <hr>
    <p>내 용: ${community.communityContent}</p>
    <hr>
    <h3>댓글</h3>
    <c:forEach var="comment" items="${commentList}">
        <div class="comment">
            <p><strong>${comment.memberId}</strong> | <fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm" /></p>
            <p>${comment.content}</p>
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
