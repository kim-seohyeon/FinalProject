<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Community List</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 30px;
        }

        .container {
            width: 80%;
            max-width: 800px;
            margin: auto;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        .write-button {
            display: block;
            width: 100px;
            margin: 10px auto 30px;
            padding: 10px 20px;
            background-color: blue;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .write-button:hover {
            background-color: #45a049;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 12px 16px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: blue;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        a {
            color: #007BFF;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>커뮤니티 글 목록</h2>

    <a href="write" class="write-button">글쓰기</a>

    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>작성자</th>
                <th>제목</th>
                <th>등록일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="dto" varStatus="idx">
                <tr>
                    <td>${idx.count}</td>
                    <td>${dto.communityWriter}</td>
                    <td>
                        <a href="<c:url value='/community/communityDetail?communityNum=${dto.communityNum}' />">
                            ${dto.communitySubject}
                        </a>
                    </td>
                    <td><fmt:formatDate value="${dto.communityDate}" pattern="yyyy-MM-dd" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
