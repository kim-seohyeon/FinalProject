<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .header-container {
        width: 100%;
        background-color: #f8f9fa;
        padding: 10px 20px;
        border-bottom: 1px solid #ddd;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }

    .nav-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1200px;
        margin: 0 auto;
    }

    .nav-left, .nav-right {
        display: flex;
        gap: 20px;
        align-items: center;
    }

    .nav-link {
        text-decoration: none;
        color: #333;
        font-weight: bold;
        transition: color 0.2s, border-bottom 0.2s;
        padding-bottom: 4px;
    }

    .nav-link:hover {
        color: #007bff;
    }

    .nav-link.active {
        color: #007bff;
        border-bottom: 2px solid #007bff;
    }

    .logo {
        font-size: 1.5em;
        font-weight: bold;
        color: #007bff;
        text-decoration: none;
    }
</style>

<div class="header-container">
    <div class="nav-bar">
        <div class="nav-left">
            <a href="/" class="logo">홈</a>
            <a href="/item/cartList" class="nav-link ${pageName == 'cart' ? 'active' : ''}">장바구니</a>
            <a href="/community/communityList" class="nav-link ${pageName == 'community' ? 'active' : ''}">커뮤니티</a>
            <a href="/library" class="nav-link ${pageName == 'library' ? 'active' : ''}">자료실</a>
            <a href="/inquire/inquireList" class="nav-link ${pageName == 'inquire' ? 'active' : ''}">문의하기</a>
            <a href="/stock/main" class="nav-link ${pageName == 'stock' ? 'active' : ''}">주식</a>
        </div>
        <div class="nav-right">
            <c:choose>
                <c:when test="${not empty sessionScope.auth}">
                    <a href="/myPage/memberMyPage" class="nav-link ${pageName == 'mypage' ? 'active' : ''}">마이페이지</a>
                    <a href="/login/logout" class="nav-link">로그아웃</a>
                </c:when>
                <c:otherwise>
                    <a href="/register/userAgree" class="nav-link ${pageName == 'register' ? 'active' : ''}">회원가입</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
