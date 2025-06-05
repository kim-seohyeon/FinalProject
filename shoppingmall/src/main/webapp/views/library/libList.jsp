<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자료실 목록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/static/js/checkBox.js"></script>
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

        h1 {
            font-size: 2rem;
            font-weight: 700;
            text-align: left;
            color: #000;
            margin-bottom: 50px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .top-bar a, .top-bar input[type="submit"] {
            background-color: #2980b9;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            text-decoration: none;
            transition: background-color 0.2s;
            cursor: pointer;
        }

        .top-bar a:hover, .top-bar input[type="submit"]:hover {
            background-color: #1f6391;
        }

        .search-form {
            text-align: right;
            margin-bottom: 25px;
        }

        .search-form input[type="search"] {
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            width: 220px;
            margin-right: 8px;
        }

        .search-form input[type="submit"] {
            padding: 10px 18px;
            background-color: #27ae60;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
        }

        .search-form input[type="submit"]:hover {
            background-color: #1e8e4f;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
        }

        th, td {
            padding: 16px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #3498db;
            color: white;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f2f6fc;
        }

        .pagination {
            text-align: center;
            margin-top: 30px;
        }

        .pagination a, .pagination span {
            display: inline-block;
            margin: 0 6px;
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: bold;
            text-decoration: none;
        }

        .pagination a {
            color: #2980b9;
            background-color: #ecf5ff;
            transition: background-color 0.2s;
        }

        .pagination a:hover {
            background-color: #d0e9ff;
        }

        .pagination span {
            color: #bdc3c7;
        }

        p {
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h1>자료실 목록 📂</h1>
    <p>총 검색 결과 수: <strong>${count}</strong>건</p>

    <form class="search-form" action="library" method="get">
        <input type="search" name="searchWord" placeholder="검색어 입력" value="${searchWord}" />
        <input type="submit" value="검색" />
    </form>

    <form action="libDelete" method="post">
		<c:if test="${sessionScope.auth.grade == 'emp'}">
		    <div class="top-bar">
		        <a href="libWrite">자료 등록</a>
		        <input type="submit" value="선택 삭제" />
		    </div>
		</c:if>

        <table>
            <thead>
                <tr>
                    <th><input type="checkbox" id="checkBoxs" /></th>
                    <th>번호</th>
                    <th>글쓴이</th>
                    <th>제목</th>
                    <th>등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="dto">
                    <tr>
                        <td><input type="checkbox" name="nums" value="${dto.libNum}" /></td>
                        <td>${dto.libNum}</td>
                        <td><a href="libInfo?libNum=${dto.libNum}">${dto.libWriter}</a></td>
                        <td><a href="libInfo?libNum=${dto.libNum}">${dto.libSubject}</a></td>
                        <td><fmt:formatDate value="${dto.libRegist}" pattern="yyyy-MM-dd" /></td>

                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="pagination">
            <c:if test="${page <= 1}">
                <span>[이전]</span>
            </c:if>
            <c:if test="${page > 1}">
                <a href="library?page=${page - 1}">[이전]</a>
            </c:if>

            <c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
                <a href="library?page=${i}">[${i}]</a>
            </c:forEach>

            <c:if test="${page < maxPage}">
                <a href="library?page=${page + 1}">[다음]</a>
            </c:if>
            <c:if test="${page >= maxPage}">
                <span>[다음]</span>
            </c:if>
        </div>
    </form>
</div>

<jsp:include page="/views/footer.jsp" />
</body>
</html>
