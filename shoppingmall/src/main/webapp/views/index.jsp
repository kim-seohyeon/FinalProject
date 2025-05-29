<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.1.min.js"></script>

<style>
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f7f7f7;
    }

    .container {
        position: relative; /* 위치 기준 잡기 */
        padding: 20px;
        max-width: 1200px;
        margin: 0 auto;
        /* flex 제거, 대신 content-area에 margin-right 적용 */
    }

    .content-area {
        /* 로그인 박스 너비 + 여유공간만큼 마진 줘서 겹치지 않게 */
        margin-right: 300px;
    }

    .login-box {
        position: fixed;
        top: 80px;
        right: 20px;
        width: 260px;
        background: white;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 10px;
        box-shadow: 2px 2px 8px rgba(0,0,0,0.1);
        z-index: 1000;
    }

    .product-grid {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 20px;
    }

    .product-item {
        width: 250px;
        background: white;
        padding: 10px;
        border-radius: 8px;
        box-shadow: 1px 1px 6px rgba(0,0,0,0.1);
        text-align: center;
    }

    .product-item img {
        max-width: 100%;
        height: auto;
        border-radius: 5px;
    }

    #more {
        text-align: center;
        margin: 30px 0;
    }

    ul {
        list-style: none;
        padding-left: 0;
    }

    ul li {
        margin: 5px 0;
    }
</style>

<script type="text/javascript">
$(function(){
	page = 1;
	$("#load-more").click(function(){
		page++;
		$.ajax({
			url:"loadMore",
			type: "post",
			data: {"page":page},
			dataType: "json",
			success: function(model){
				var item = "";
				$.each(model.list , function(idx, dto){
					item += '<div class="product-item">';
					item += '<a href="goodsDetail?goodsNum='+dto.goodsNum+'">';
					item += '<img src="/static/goodsUpload/'+dto.goodsImageStoreName+'" />';
					item += '<div>'+dto.goodsSubject+'</div>';
					item += '<div>'+dto.goodsWriter+'</div>';
					item += '</a>';
					item += '</div>';
				});
				$("#product-list").append(item);
				if(model.maxPage <= page) $("#more").hide();
			}
		});
	});
});
</script>
</head>

<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <div class="content-area">
        <c:if test="${!empty auth}">
            <ul>
                <c:if test="${auth.grade == 'emp'}">
                    <li><a href="/member/memberList">회원관리</a></li>
                    <li><a href="/employee/empList">직원관리</a></li>
                    <li><a href="/empPage/empMyPage">내정보 보기</a></li>
                    <li><a href="/goods/goodsList">상품관리</a></li>
                </c:if>
                <c:if test="${auth.grade == 'mem'}">
                    <li><a href="/item/wishList">찜 목록</a></li>
                    <li><a href="/item/purchaseList">구매목록</a></li>
                </c:if>
            </ul>
        </c:if>

        <div id="content">
            <div class="product-grid" id="product-list">
                <c:forEach items="${list}" var="dto">
                    <div class="product-item">
                        <a href="/item/detailView?goodsNum=${dto.goodsNum}">
                            <img src="/static/goodsUpload/${dto.goodsMainStoreImage}" />
                            <div>${dto.goodsName}</div>
                            <div><strong>${dto.goodsPrice}원</strong></div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div id="more">
            <button id="load-more">더보기</button>
        </div>
    </div>

    <c:if test="${empty auth}">
        <div class="login-box">
            <form:form modelAttribute="loginCommand" action="/login/login" method="post">
                <div>
                    <label><input type="checkbox" name="autoLogin" /> 자동 로그인</label><br/>
                    <label><input type="checkbox" name="idStore"
                        <c:if test="${loginCommand.idStore}">checked</c:if> /> 아이디 저장</label>
                </div>
                <div>
                    <form:input path="userId" placeholder="아이디" />
                    <form:errors path="userId"/>
                </div>
                <div>
                    <form:password path="userPw" placeholder="비밀번호"/>
                    <form:errors path="userPw"/>
                </div>
                <div>
                    <input type="submit" value="로그인" style="width:100%;" />
                </div>
                <div style="margin-top:10px; font-size:0.9em;">
                    <a href="/help/findId">아이디</a> /
                    <a href="/help/findPassword">비밀번호 찾기</a> |
                    <a href="/register/userAgree">회원가입</a>
                </div>
            </form:form>
        </div>
    </c:if>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
