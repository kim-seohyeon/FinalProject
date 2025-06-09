<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>자료실 상세보기</title>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background: #ffffff;
        color: #333;
        margin: 0;
        padding: 0;
    }
    .container {
        width: 95%;
        max-width: 860px;
        margin: 50px auto;
        background: #fff;
        border-radius: none;
        box-shadow: none;
        padding: 40px 50px;
    }
    h1 {
        font-size: 1.6rem;
        font-weight: 700;
        margin-bottom: 35px;
        padding-bottom: 15px;
        border-bottom: 3px solid #0077cc;
        color: #2c3e50;
    }
    .detail-section {
        margin-bottom: 25px;
    }
    .detail-title {
        font-weight: 600;
        font-size: 1.05rem;
        margin-bottom: 6px;
        color: #555;
    }
    .detail-content {
        font-size: 1.1rem;
        color: #222;
    }
    .content-box {
        background: #f9fbfc;
        border: 1px solid #dce7f2;
        border-radius: 8px;
        padding: 18px 22px;
        white-space: pre-wrap;
        line-height: 1.65;
        font-size: 1rem;
        margin-top: 8px;
    }
    .file-list {
        margin: 30px 0 40px;
    }
    .file-list a {
        display: inline-block;
        background: #eef5fc;
        border: 1px solid #bcdff9;
        border-radius: 5px;
        padding: 10px 15px;
        margin: 6px 8px 0 0;
        color: #0077cc;
        font-weight: 500;
        text-decoration: none;
        transition: all 0.2s ease;
    }
    .file-list a:hover {
        background: #d8eefd;
        border-color: #a3d2f6;
    }
    .image-box {
        margin: 30px 0;
        text-align: center;
    }
    .image-box img {
        max-width: 100%;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
    .btn-group {
        text-align: center;
        margin-top: 50px;
    }
    .btn {
        display: inline-block;
        padding: 12px 28px;
        font-size: 1rem;
        font-weight: 600;
        border-radius: 6px;
        text-decoration: none;
        margin: 0 10px;
        transition: background 0.3s ease;
        box-shadow: 0 4px 8px rgba(0, 119, 204, 0.3);
        color: white;
        background: #0077cc;
    }
    .btn:hover {
        background: #005fa3;
        box-shadow: 0 6px 12px rgba(0, 95, 163, 0.4);
    }
    .btn-secondary {
        background: #e5e7eb;
        color: #333;
        box-shadow: none;
    }
    .btn-secondary:hover {
        background: #d1d5db;
        color: #111;
    }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h1>자료실 상세보기</h1>

    <div class="detail-section">
        <div class="detail-title">글 번호</div>
        <div class="detail-content">${libraryCommand.libNum}</div>
    </div>

    <div class="detail-section">
        <div class="detail-title">작성자</div>
        <div class="detail-content">${libraryCommand.libWriter}</div>
    </div>

    <div class="detail-section">
        <div class="detail-title">제목</div>
        <div class="detail-content">${libraryCommand.libSubject}</div>
    </div>
    
    <div class="detail-section">
    <div class="detail-title">조회수</div>
    <div class="detail-content">${libraryCommand.libReadCount}</div>
	</div>
    

    <div class="detail-section">
        <div class="detail-title">내용</div>
        <div class="content-box">${libraryCommand.libContent}</div>
    </div>

    <div class="detail-section file-list">
        <c:set var="originalFileName" value="${fn:split(libraryCommand.libOriginalName, '`')}"/>
        <c:forTokens items="${libraryCommand.libStoreName}" delims="`" var="fileName" varStatus="idx">
            <a href="libDownLoad?oname=${originalFileName[idx.index]}&sname=${fileName}">
                ${originalFileName[idx.index]}
            </a>
        </c:forTokens>
    </div>

    <c:if test="${not empty libraryCommand.libImageStoreName}">
        <div class="image-box">
            <img src="/static/libUpload/${libraryCommand.libImageStoreName}" alt="첨부 이미지" />
        </div>
    </c:if>
	<c:if test="${sessionScope.auth.grade == 'emp'}">

	    <div class="btn-group">
	        <a href="libUpdate?libNum=${libraryCommand.libNum}" class="btn">자료실 수정</a>
	        <a href="libDelete?libNum=${libraryCommand.libNum}" class="btn btn-secondary">자료실 삭제</a>
	        <a href="library" class="btn btn-secondary">목록으로</a>
	    </div>
	</c:if>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
