<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>   
<html>
<head>
<meta charset="UTF-8">
<title>글 수정 폼</title>
<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #f7f9fc;
        margin: 0;
        padding: 40px;
        color: #333;
    }

    .form-container {
        width: 600px;
        margin: auto;
        background-color: #ffffff;
        padding: 30px 40px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    h2 {
        text-align: center;
        color: #007BFF;
        margin-bottom: 30px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 10px 12px;
        text-align: left;
        vertical-align: top;
    }

    th {
        background-color: #f0f0f0;
        width: 120px;
        font-weight: bold;
        color: #333;
        border-radius: 6px;
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 6px;
        box-sizing: border-box;
        color: #333;
    }

    input[type="submit"] {
        width: 100%;
        padding: 12px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 20px;
    }

    input[type="submit"]:hover {
        background-color: #0056b3;
    }

    .back-link {
        display: block;
        text-align: center;
        margin-top: 20px;
        color: #007BFF;
        text-decoration: none;
        font-weight: bold;
    }

    .back-link:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>

<div class="form-container">
    <h2>글 수정</h2>

    <form name="communityUpdateForm" action="update" method="post">
        <table>
            <tr>
                <th>글번호</th>
                <td>
                    <input type="text" name="communityNum" value="${community.communityNum}" readonly />
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
                    <textarea name="communityContent" rows="10" required>${community.communityContent}</textarea>
                </td>
            </tr>
        </table>
        <input type="submit" value="수정 완료" />
    </form>

    <a href="communityDetail?communityNum=${community.communityNum}" class="back-link">← 상세보기로 돌아가기</a>
</div>

</body>
</html>
