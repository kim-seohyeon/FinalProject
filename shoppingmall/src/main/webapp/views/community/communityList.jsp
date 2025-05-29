<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageName" value="community" />

<html>
<head>
    <meta charset="UTF-8">
    <title>Community List</title>

    <style>
        /* 기본 마진, 패딩 제거 */
        html, body {
            margin: 0;
            padding: 0;
        }

        /* 주식 페이지 스타일과 통일된 컨테이너 스타일 */
        .container {
            max-width: 1000px;
            margin: 0 auto 20px auto;
            padding: 20px;
            font-family: 'Segoe UI', sans-serif;
        }

        /* 상단 네비게이션 스타일 */
        .header-container {
            width: 100%;
            background-color: #f8f9fa;
            padding: 10px 20px;
            border-bottom: 1px solid #ddd;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        /* 제목 스타일 */
        h2 {
            font-size: 2rem;
            font-weight: 700;
            text-align: left;
            color: #000;
            margin-bottom: 50px;
            text-shadow: none;
            letter-spacing: normal;
        }

        /* 버튼 스타일 */
        .write-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3498db;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            margin-bottom: 20px;
            transition: background-color 0.3s;
        }

        .write-button:hover {
            background-color: #2980b9;
        }

        /* 테이블 스타일 */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 8px 16px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 14px 18px;
            border-bottom: 1px solid #e0e0e0;
            text-align: center;
            color: #2c3e50;
        }

        th {
            background-color: #3498db;
            color: white;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f1f8ff;
            box-shadow: 0 2px 8px rgba(52, 152, 219, 0.2);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        td a {
            color: #2c3e50;
            font-weight: 500;
            text-decoration: none;
        }

        td a:hover {
            color: #3498db;
            text-decoration: underline;
        }

        /* 반응형 모바일 대응 */
        @media (max-width: 600px) {
            .container {
                width: 95%;
            }

            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead tr {
                display: none;
            }

            tr {
                margin-bottom: 15px;
                border-bottom: 2px solid #eee;
                padding-bottom: 10px;
            }

            td {
                text-align: left;
                padding: 10px;
                position: relative;
            }

            td::before {
                content: attr(data-label);
                font-weight: bold;
                display: inline-block;
                width: 100px;
                color: #555;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/views/header.jsp" />

    <div class="container">
        <h2>커뮤니티 메인 페이지 📋</h2>

        <a href="write" class="write-button">✏️ 게시글 작성</a>

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
                        <td data-label="번호">${idx.count}</td>
                        <td data-label="작성자">${dto.communityWriter}</td>
                        <td data-label="제목">
                            <a href="<c:url value='/community/communityDetail?communityNum=${dto.communityNum}' />">
                                ${dto.communitySubject}
                            </a>
                        </td>
                        <td data-label="등록일">
                            <fmt:formatDate value="${dto.communityDate}" pattern="yyyy-MM-dd" />
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>

</html>
