<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <meta charset="UTF-8" />
    <title>내가 쓴 글</title>
    <style>
        html, body {
            margin: 0; 
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #fff;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto 20px auto;
            padding: 20px;
            background-color: white;      
        }

        h2 {
            font-size: 2rem;
            font-weight: 700;
            color: #000;
            margin-bottom: 50px;
            text-align: left;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 8px 16px rgba(0,0,0,0.05);
            background-color: white;
        }

        thead th {
            background-color: #3498db;
            color: white;
            font-weight: 600;
            padding: 14px 18px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        tbody td {
            padding: 14px 18px;
            border-bottom: 1px solid #e0e0e0;
            text-align: center;
            vertical-align: middle;
            color: #2c3e50;
        }

        tbody tr:hover {
            background-color: #f1f8ff;
            box-shadow: 0 2px 8px rgba(52, 152, 219, 0.2);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        a {
            color: #2c3e50;
            font-weight: 500;
            text-decoration: none;
        }

        a:hover {
            color: #3498db;
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .container {
                width: 95%;
                padding: 70px 10px 20px 10px;
            }

            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead tr {
                display: none;
            }

            tbody tr {
                margin-bottom: 15px;
                border-bottom: 2px solid #eee;
                padding-bottom: 10px;
            }

            tbody td {
                text-align: left;
                padding: 10px;
                position: relative;
            }

            tbody td::before {
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
        <h2>📝 내가 쓴 글</h2>

        <c:if test="${empty list}">
            <p style="text-align:center; padding:30px 0; color:#555; font-size:1.2rem;">
                작성한 글이 없습니다.
            </p>
        </c:if>

        <c:if test="${not empty list}">
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>내용</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dto" items="${list}" varStatus="status">
                        <tr>
                            <td data-label="번호">${status.count}</td>
                            <td data-label="제목">
                                <a href="<c:url value='/community/communityDetail?communityNum=${dto.communityNum}' />">
                                    ${dto.communitySubject}
                                </a>
                            </td>
                            <td data-label="내용">${dto.communityContent}</td>
                            <td data-label="작성일">
                                <fmt:formatDate value="${dto.communityDate}" pattern="yyyy-MM-dd" />
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>
