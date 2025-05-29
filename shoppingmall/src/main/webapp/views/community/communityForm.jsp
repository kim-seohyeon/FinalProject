<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String loginId = (String) session.getAttribute("loginId");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글 쓰기 폼</title>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background: #ffffff;
        margin: 0; padding: 0;
        color: #333;
    }
    /* 상단 네비게이션 스타일 */
    .header-container {
        width: 100%;
        background-color: #f8f9fa;
        padding: 10px 20px;
        border-bottom: 1px solid #ddd;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        /* position: fixed;  제거 */
        /* top: 0; */
        /* left: 0; */
        /* z-index: 1000; */
    }

    .nav-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1200px;
        margin: 0 auto;
    }

    .nav-left, .nav-right {
        display: flex;
        gap: 20px;
        align-items: center;
    }

    .nav-link {
        text-decoration: none;
        color: #333;
        font-weight: bold;
        transition: color 0.2s;
    }

    .nav-link:hover {
        color: #007bff;
    }

    .logo {
        font-size: 1.5em;
        font-weight: bold;
        color: #007bff;
        text-decoration: none;
    }
    
    /* 글쓰기 폼 컨테이너 - 상단 네비게이션바 높이 만큼 margin 조정 */
    .container {
        max-width: 800px;
        margin: 20px auto 40px auto; /* position fixed 아님으로 margin-top 줄임 */
        background: #fff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    h2 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 30px;
        font-size: 1.8rem;
        font-weight: 700;
        padding-bottom: 15px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        padding: 12px;
        text-align: left;
        vertical-align: top;
    }
    th {
        width: 120px;
        font-weight: 600;
        color: #555;
        background-color: #f7f9fc;
        border-radius: 6px;
    }
    input[type="text"],
    textarea,
    input[type="file"] {
        width: 100%;
        padding: 10px 14px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 1rem;
        transition: border-color 0.3s ease;
    }
    input[type="text"]:focus,
    textarea:focus,
    input[type="file"]:focus {
        border-color: #0077cc;
        outline: none;
    }
    textarea {
        resize: vertical;
        min-height: 150px;
    }
    input[type="submit"] {
        display: inline-block;
        background: #0077cc;
        color: #fff;
        font-weight: 600;
        padding: 12px 30px;
        border-radius: 5px;
        text-decoration: none;
        transition: background 0.3s ease;
        box-shadow: 0 4px 8px rgba(0,119,204,0.3);
        border: none;
        cursor: pointer;
        width: 100%;
        font-size: 16px;
    }
    input[type="submit"]:hover {
        background: #005fa3;
        box-shadow: 0 6px 12px rgba(0,95,163,0.5);
    }
    .back-link {
        display: block;
        text-align: center;
        margin-top: 20px;
        color: #0077cc;
        text-decoration: none;
        font-weight: 500;
    }
    .back-link:hover {
        text-decoration: underline;
    }
    small {
        display: block;
        margin-top: 5px;
        font-size: 0.9rem;
        color: #888;
    }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />
<!-- 상단 네비게이션 바 -->
   
   
<div class="container">
    <h2>글 등록</h2>

    <form name="communityForm" action="write" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <th>글번호</th>
                <td>
                    <input type="text" name="communityNum" value="${communityCommand.communityNum}" readonly />
                    <small>※ 번호는 자동으로 부여됩니다.</small>
                </td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>
                    <input type="text" value="${sessionScope.auth.userId}" readonly />
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" name="communitySubject" required />
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea rows="10" name="communityContent" required></textarea>
                </td>
            </tr>
            <tr>
                <th>이미지</th>
                <td>
                    <input type="file" name="uploadImage" accept="image/*" />
                    <small>이미지 파일을 선택하세요 (선택사항)</small>
                </td>
            </tr>
            <tr>
                <th>등록일</th>
                <td>
                    <span style="color: gray;">자동 등록됩니다</span>
                </td>
            </tr>
        </table>
        <input type="submit" value="게시글 등록" />
    </form>

    <a href="${pageContext.request.contextPath}/community/communityList" class="back-link">← 목록으로 돌아가기</a>
</div>

</body>
</html>
