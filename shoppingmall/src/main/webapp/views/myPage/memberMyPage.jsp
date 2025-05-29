<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberMyPage.jsp</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #ffffff;
        margin: 0;
        padding: 0;
        color: #34495e;
    }

    .container {
        width: 90%;
        max-width: 1000px;
        margin: 60px auto 100px;
        background-color: transparent;
        padding: 0 30px;
        border-radius: 0;
        box-shadow: none;
        border: none;
    }

    h1 {
        text-align: left;
        color: #000;
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 40px;
    }

    /* 메뉴 스타일 내정보 수정 페이지 스타일과 동일하게 */
    ul.nav {
        list-style: none;
        display: flex;
        padding: 0;
        margin-bottom: 50px;
        border-bottom: 2px solid #2980b9;
    }

    ul.nav li {
        margin-right: 40px;
    }

    ul.nav li:last-child {
        margin-right: 0;
    }

    ul.nav a {
        text-decoration: none;
        font-weight: 600;
        color: #2980b9;
        font-size: 1.1rem;
        padding-bottom: 10px;
        display: inline-block;
        border-bottom: 3px solid transparent;
        transition: border-color 0.3s ease;
    }

    /* 현재 페이지 링크 스타일 */
    ul.nav a.active,
    ul.nav a:hover {
        border-bottom-color: #2980b9;
    }

    .info-list {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 16px;
    }

    .info-item {
        background-color: #f9f9f9;
        padding: 10px 16px;
        border-radius: 8px;
        border: 1px solid #ddd;
        font-size: 0.95rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        min-height: 40px;
    }

    .info-item span.label {
        font-weight: 700;
        color: #2980b9;
    }

    .footer {
        text-align: center;
        margin-top: 40px;
        font-size: 0.9rem;
        color: #95a5a6;
    }

    @media (max-width: 700px) {
        .info-list {
            grid-template-columns: 1fr;
        }
    }
</style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h1>MY PAGE | 내정보</h1>  <!-- 왼쪽 정렬 + 블랙 + 임티 추가 -->

    <ul class="nav">
        <li><a href='<c:url value="/"/>'> 홈</a></li>
        <li><a href='/myPage/memberMyPage'class="active">👤 내정보 보기</a></li>
        <li><a href='/myPage/memberUpdate'> 내정보 수정</a></li>
        <li><a href="/myPage/myNewPw"> 비밀번호 변경</a></li>
        <li><a href="/myPage/memberDrop"> 회원 탈퇴</a></li>
    </ul>

    <div class="info-list">
        <div class="info-item">
            <span class="label">이름</span>
            <span>${dto.memberName }</span>
        </div>
        <div class="info-item">
            <span class="label">아이디</span>
            <span>${dto.memberId }</span>
        </div>
        <div class="info-item">
            <span class="label">주소</span>
            <span>${dto.memberAddr }</span>
        </div>
        <div class="info-item">
            <span class="label">상세주소</span>
            <span>${dto.memberAddrDetail }</span>
        </div>
        <div class="info-item">
            <span class="label">우편번호</span>
            <span>${dto.memberPost }</span>
        </div>
        <div class="info-item">
            <span class="label">연락처1</span>
            <span>${dto.memberPhone1 }</span>
        </div>
        <div class="info-item">
            <span class="label">연락처2</span>
            <span>${dto.memberPhone2 }</span>
        </div>
        <div class="info-item">
            <span class="label">성별</span>
            <span>
                <c:if test="${dto.memberGender == 'M'}">남자</c:if>
                <c:if test="${dto.memberGender == 'F'}">여자</c:if>
            </span>
        </div>
        <div class="info-item">
            <span class="label">등록일</span>
            <span>${fn:substring(dto.memberRegist, 0, 10) }</span>
        </div>
        <div class="info-item">
            <span class="label">생년월일</span>
            <span>${fn:substring(dto.memberBirth, 0, 10) }</span>
        </div>
        <div class="info-item">
            <span class="label">이메일</span>
            <span>${dto.memberEmail }</span>
        </div>
    </div>
</div>

<div class="footer">
    <%@ include file="/views/footer.jsp" %>
</div>
</body>
</html>
