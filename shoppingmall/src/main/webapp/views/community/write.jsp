<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>글 작성</title>
</head>
<body>
    <h2>게시글 작성</h2>
    <form action="/community/write" method="post">
        <p>
            작성자: <input type="text" name="author" required>
        </p>
        <p>
            제목: <input type="text" name="title" required>
        </p>
        <p>
            내용:<br>
            <textarea name="content" rows="10" cols="50" required></textarea>
        </p>
        <button type="submit">등록</button>
    </form>
    <br>
    <a href="/community">목록으로 돌아가기</a>
</body>
</html>