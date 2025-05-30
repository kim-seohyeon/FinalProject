<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageName" value="community" />

<html>
<head>
    <meta charset="UTF-8">
    <title>내가 좋아요 누른 게시물</title>

    <style>
        /* 기본 마진, 패딩 제거 */
        html, body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #ffffff; /* 커뮤니티 페이지 배경과 동일 */
        }

        /* 상단 네비게이션 스타일 */
     

        /* 컨테이너 스타일 */
        .container {
            max-width: 1000px;
            margin: 0 auto 20px auto;
            padding: 20px;
            background-color: white;
       
        }

        /* 제목 스타일 (커뮤니티 페이지와 동일) */
        h2 {
            font-size: 2rem;
            font-weight: 700;
            color: #000;
            margin-bottom: 50px; /* 커뮤니티 페이지와 맞춤 */
            text-shadow: none;
            letter-spacing: normal;
            text-align: left;
        }

        /* 좋아요 누른 게시물이 없을 때 메시지 */
        .no-posts {
            font-size: 1.2rem;
            color: #555;
            padding: 30px 0;
            text-align: center;
        }

        /* 테이블 스타일 완전 동일하게 커뮤니티 페이지에서 복사 */
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
            text-align: center; /* 커뮤니티 페이지는 중앙 정렬 */
            color: #2c3e50;
            vertical-align: middle;
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

        /* 게시글 제목 링크 스타일 */
        a.post-link {
            color: #2c3e50;
            font-weight: 500;
            text-decoration: none;
        }

        a.post-link:hover {
            color: #3498db;
            text-decoration: underline;
        }

        /* 반응형 모바일 대응 */
        @media (max-width: 600px) {
            .container {
                width: 95%;
                padding: 10px;
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
        <h2>내가 좋아요한 게시물</h2> <!-- 제목 넣기 -->

        <c:if test="${empty likedPosts}">
            <p class="no-posts">좋아요 누른 게시물이 없습니다.</p>
        </c:if>

        <c:if test="${not empty likedPosts}">
            <table>
                <thead>
                    <tr>
                        <th>번호</th> <!-- 번호 컬럼 추가, 커뮤니티 페이지와 동일 -->
                        <th>작성자</th>
                        <th>제목</th>
                        <th>내용</th>
                        <th>좋아요 수</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="post" items="${likedPosts}" varStatus="idx">
                        <tr>
                            <td data-label="번호">${idx.count}</td>
                            <td data-label="작성자">${post.communityWriter}</td>
                            <td data-label="제목">
                                <a href="<c:url value='/community/communityDetail?communityNum=${post.communityNum}' />" class="post-link">
                                    ${post.communitySubject}
                                </a>
                            </td>
                            <td data-label="내용">${post.communityContent}</td>
                            <td data-label="좋아요 수">${post.likeCount}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>
