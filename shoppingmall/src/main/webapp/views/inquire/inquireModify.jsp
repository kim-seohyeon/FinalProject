<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글 수정</title>
<style>
    body {
        margin: 0;
        padding: 0;
        background-color: #ffffff;
        font-family: 'Noto Sans KR', sans-serif;
        color: #333;
    }

    .container {
        max-width: 720px;
        margin: 80px auto;
        background-color: #ffffff;
        padding: 40px;
        border-radius: none;
        box-shadow: none;
    }

    h2 {
        font-size: 1.8rem;
        font-weight: 700;
        color: #2d3748;
        margin-bottom: 32px;
        text-align: center;
        /*border-bottom: 2px solid #0077cc;*/
        padding-bottom: 12px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th {
        text-align: left;
        padding: 16px 12px 12px 0;
        font-size: 1rem;
        font-weight: 600;
        color: #4a5568;
        width: 120px;
        vertical-align: top;
    }

    td {
        padding-bottom: 24px;
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 12px 14px;
        border: 1px solid #e2e8f0;
        border-radius: 10px;
        font-size: 1rem;
        background-color: #fdfdfd;
        transition: border 0.3s;
    }

    input[readonly] {
        background-color: #f1f5f9;
        color: #999;
    }

    input:focus,
    textarea:focus {
        border-color: #4299e1;
        outline: none;
    }

    textarea {
        resize: vertical;
        min-height: 150px;
    }

    .btn-group {
        display: flex;
        justify-content: center;
        gap: 16px;
        margin-top: 30px;
    }

    .btn-primary,
    .btn-secondary {
        padding: 12px 28px;
        font-size: 1rem;
        font-weight: 600;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .btn-primary {
        background-color: #0077cc;
        color: #fff;
    }

    .btn-primary:hover {
        background-color: #005fa3;
    }

    .btn-secondary {
        background-color: #e2e8f0;
        color: #2d3748;
    }

    .btn-secondary:hover {
        background-color: #cbd5e0;
    }

    @media (max-width: 600px) {
        .container {
            margin: 40px 20px;
            padding: 24px;
        }

        th {
            width: 100px;
        }
    }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h2>글 수정</h2>
    <form action="inquireModify" method="post">
        <table>
            <tr>
                <th>글 번호</th>
                <td><input type="text" name="inquireNum" value="${dto.inquireNum}" readonly></td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="inquireSubject" value="${dto.inquireSubject}" required></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="inquireContents" required>${dto.inquireContents}</textarea></td>
            </tr>
        </table>
        <div class="btn-group">
            <button type="submit" class="btn-primary">수정 완료</button>
            <button type="button" class="btn-secondary" onclick="location.href='inquireList'">글 목록</button>
        </div>
    </form>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
