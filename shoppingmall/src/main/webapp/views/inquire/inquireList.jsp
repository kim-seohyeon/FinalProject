<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의글 목록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        h2 {
            font-size: 2rem;
            font-weight: 700;
            text-align: left;
            color: #000;
            margin-bottom: 40px;
        }

        .top-bar {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }

        .top-bar a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3498db;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .top-bar a:hover {
            background-color: #2980b9;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
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

        .pagination {
            text-align: center;
            padding: 30px 0;
        }

        .pagination a, .pagination span {
            margin: 0 5px;
            text-decoration: none;
            color: #2980b9;
            font-weight: bold;
        }

        .pagination span {
            color: #7f8c8d;
        }

        .footer {
            text-align: center;
            margin: 60px 0 20px 0;
            font-size: 14px;
            color: #7f8c8d;
        }

        /* 반응형 대응 */
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

            .top-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .top-bar a {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h2>문의글 목록 ✉️</h2>

    <div class="top-bar">
        <a href="write">문의글 쓰기</a>
    </div>

    <table>
        <thead>
        <tr>
            <th>번호</th>
            <th>작성자</th>
            <th>제목</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="dto" varStatus="idx">
            <tr>
                <td data-label="번호">${idx.count}</td>
                <td data-label="작성자">
                    <a href="<c:url value='/inquire/inquireDetail?inquireNum=${dto.inquireNum}' />">
                        ${dto.inquireWriter}
                    </a>
                </td>
                <td data-label="제목">${dto.inquireSubject}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- 페이징 처리가 필요할 경우 아래 영역 추가 -->
    <%-- 
    <div class="pagination">
        <a href="#">[이전]</a>
        <a href="#">1</a>
        <a href="#">2</a>
        <span>[다음]</span>
    </div>
    --%>
</div>

<div class="footer">
    <p>© 2025 고객문의 시스템. 모든 권리 보유.</p>
</div>

<jsp:include page="/views/footer.jsp" />
</body>
</html>
