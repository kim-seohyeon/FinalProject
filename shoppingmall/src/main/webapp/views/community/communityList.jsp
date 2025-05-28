<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Community List</title>

    <style>
        /* 주식 페이지 스타일과 통일된 컨테이너 스타일 */
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
             /* background-color: white; */
    /* border-radius: 8px; */
    /* box-shadow: 0 4px 10px rgba(0,0,0,0.1); */
            font-family: 'Segoe UI', sans-serif;
        }

        /* 제목 스타일 */
        h2 {
    		font-size: 2rem;         /* 주식 제목 크기와 동일하게 */
    		font-weight: 700;     /* 기본 굵기 */
    		text-align: left;        /* 왼쪽 정렬 */
    		color: #000;             /* 기본 검정색 */
   			margin-bottom: 50px;     /* 주식 제목과 비슷한 간격 */
    		/* 기존 강조 스타일 제거 */
    		text-shadow: none;
    		letter-spacing: normal;
}

        /* 버튼 스타일 (주식 페이지 스타일에 맞춤) */
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

        /* 테이블 스타일 (주식 페이지와 최대한 비슷하게) */
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
    <h2>커뮤니티 메인 페이지 📋 </h2>

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
                    <td data-label="등록일"><fmt:formatDate value="${dto.communityDate}" pattern="yyyy-MM-dd" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
