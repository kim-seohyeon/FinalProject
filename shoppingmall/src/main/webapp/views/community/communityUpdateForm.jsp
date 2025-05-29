<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글 수정 폼</title>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background: #ffffff;
        margin: 0; padding: 0;
        color: #333;
    }

    .container {
        max-width: 800px;
        margin: 20px auto 40px auto;
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
    textarea {
        width: 100%;
        padding: 10px 14px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 1rem;
        transition: border-color 0.3s ease;
        color: #333;
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
<div class="container">
    <h2>글 수정</h2>

    <form name="communityUpdateForm" action="update" method="post">
        <table>
            <tr>
                <th>글번호</th>
                <td>
                    <input type="text" name="communityNum" value="${community.communityNum}" readonly />
                    <small>※ 번호는 자동으로 부여됩니다.</small>
                </td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>
                    <input type="text" name="communityWriter" value="${community.communityWriter}" readonly />
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" name="communitySubject" value="${community.communitySubject}" required />
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea name="communityContent" required>${community.communityContent}</textarea>
                </td>
            </tr>
            <tr>
                <th>등록일</th>
                <td>
                    <span style="color: gray;">자동 등록됩니다</span>
                </td>
            </tr>
        </table>
        <input type="submit" value="수정 완료" />
    </form>

    <a href="communityDetail?communityNum=${community.communityNum}" class="back-link">← 상세보기로 돌아가기</a>
</div>

</body>
</html>
