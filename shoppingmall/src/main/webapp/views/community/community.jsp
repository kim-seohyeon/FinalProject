<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>커뮤니티</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .post { border-bottom: 1px solid #ccc; margin-bottom: 10px; padding-bottom: 10px; }
        .post-title { font-size: 18px; font-weight: bold; }
        .post-meta { color: gray; font-size: 13px; }
        .write-btn { margin-bottom: 20px; display: inline-block; }
    </style>
</head>
<body>
<style>
  .header-title {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 2.5rem;          /* 크고 시원하게 */
    color: white;             /* 진한 네이비 계열 색상 */
    text-align: center;         /* 가운데 정렬 */
    margin: 30px 0 40px 0;      /* 위 아래 공간 넉넉하게 */
    text-shadow: 2px 2px 5px rgba(44, 62, 80, 0.3);  /* 은은한 그림자 */
    letter-spacing: 2px;        /* 글자 사이 간격 */
    background-color : lightblue;
  }
</style>

<h2 class="header-title">슬기로운 투자생활</h2>

<!-- 게시글 등록 페이지로 이동하는 링크 -->
<div class="write-btn">
    <a href="/community/write">
        <button>새 글 작성하기</button>
    </a>
</div>

<hr>

<!-- 게시글 목록 보여주기 -->
<c:if test="${not empty posts}">
    <ul>
        <c:forEach var="post" items="${posts}">
            <li class="post">
                <div class="post-title">${post.title}</div>
                <div class="post-meta">작성자: ${post.author} | 작성일: ${post.createdDate}</div>
                <p>${post.content}</p>
            </li>
        </c:forEach>
    </ul>
</c:if>

<!-- 게시글이 없을 경우 -->
<c:if test="${empty posts}">
    <p>등록된 게시글이 없습니다.</p>
</c:if>

</body>
</html>
