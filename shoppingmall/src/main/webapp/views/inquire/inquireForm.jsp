<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    .container {
        max-width: 800px;
        margin: 50px auto;
        background: #fff;
        border-radius: none;
        box-shadow: none;
        padding: 40px;
    }
    h2 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 30px;
        font-size: 1.8rem;
        font-weight: 700;
        padding-bottom: 15px;
    }
    .form-row {
        display: flex;
        margin-bottom: 20px;
        align-items: center;
    }
    .form-label {
        width: 120px;
        font-weight: 600;
        color: #555;
    }
    .form-input {
        flex: 1;
    }
    input[type="text"],
    textarea {
        width: 100%;
        padding: 10px 14px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 1rem;
        transition: border-color 0.3s ease;
    }
    input[type="text"]:focus,
    textarea:focus {
        border-color: #0077cc;
        outline: none;
    }
    textarea {
        resize: vertical;
        min-height: 150px;
    }
    .form-footer {
        text-align: center;
        margin-top: 30px;
    }
    .btn {
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
    }
    .btn:hover {
        background: #005fa3;
        box-shadow: 0 6px 12px rgba(0,95,163,0.5);
    }
    .back-link {
        display: inline-block;
        margin-top: 20px;
        color: #0077cc;
        text-decoration: none;
        font-weight: 500;
    }
    .back-link:hover {
        text-decoration: underline;
    }
    .info-text {
        font-size: 0.9rem;
        color: #888;
        margin-top: 5px;
    }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h2>글 등록</h2>
    <form name="inquireForm" action="write" method="post">
        <div class="form-row">
            <label class="form-label">글 번호</label>
            <div class="form-input">
                <input type="text" name="inquireNum" value="${inquireCommand.inquireNum }" readonly />
                <div class="info-text">※ 번호는 자동으로 부여됩니다.</div>
            </div>
        </div>
        <div class="form-row">
            <label class="form-label">작성자</label>
            <div class="form-input">
                <input type="text" name="inquireWriter" required />
            </div>
        </div>
        <div class="form-row">
            <label class="form-label">제목</label>
            <div class="form-input">
                <input type="text" name="inquireSubject" required />
            </div>
        </div>
        <div class="form-row">
            <label class="form-label">내용</label>
            <div class="form-input">
                <textarea name="inquireContents" required></textarea>
            </div>
        </div>
        <div class="form-footer">
            <button type="submit" class="btn">글 등록</button>
        </div>
    </form>
    <div class="form-footer">
        <a href="/community" class="back-link">← 목록으로 돌아가기</a>
    </div>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
