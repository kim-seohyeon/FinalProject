<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${dto.goodsName} - 상세 보기</title>
<script src="https://code.jquery.com/jquery-1.8.1.js"></script>
<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #ffffff;
        margin: 0;
        padding: 0;
    }
    .wrapper {
        max-width: 960px;
        margin: 50px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: none;
        box-shadow: none;
    }
    .product {
        display: flex;
        gap: 30px;
    }
    .product img.main-image {
        width: 350px;
        border-radius: 10px;
        border: 1px solid #ddd;
    }
    .details {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 12px;
    }
    .details h2 {
        font-size: 24px;
        margin: 0;
    }
    .details .brand, .details .views {
        color: #777;
        font-size: 14px;
    }
    .details .price {
        font-size: 20px;
        color: #d60000;
        font-weight: bold;
    }
    .controls {
        margin-top: 10px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .controls input[type="number"] {
        width: 60px;
        padding: 5px;
    }
    .controls button {
        padding: 8px 14px;
        border: none;
        border-radius: 6px;
        background-color: #333;
        color: #fff;
        cursor: pointer;
    }
    #wish {
        cursor: pointer;
        width: 28px;
        transition: transform 0.2s;
    }
    #wish:hover {
        transform: scale(1.1);
    }
    .description {
        margin-top: 40px;
        border-top: 1px solid #ddd;
        padding-top: 20px;
    }
    .description img {
        width: 100%;
        margin-top: 20px;
        border-radius: 10px;
    }
    
    .review-section, .review-list {
        margin-top: 40px;
        padding: 20px;
        border-top: 1px solid #ddd;
    }
    textarea {
        width: 100%;
        padding: 10px;
        resize: none;
    }    
    .single-review {
        margin-bottom: 20px;
        padding: 10px;
        background-color: #f9f9f9;
        border-radius: 6px;
    }
</style>

<script>
$(function(){
    $("#cartBtn").click(function(){
        $.ajax({
            type: "post",
            url: "cart",   
            data: {
                "goodsNum": "${dto.goodsNum}",
                "cartQty": $("#cartQty").val()
            },
            success: function(){        
                let loc = confirm("장바구니로 이동하시겠습니까?");
                if(loc) location.href = "/item/cartList";
            },
            error: function(){
                window.open("/login/loginCk", "로그인", "width=400, height=100");
            }
        });
    });

    $("#buyItem").click(function(){
        if(${empty auth}) {
            window.open("/login/loginCk", "로그인", "width=400, height=100");
        } else {
            location.href = "buy?goodsNum=${dto.goodsNum}&cartQty=" + $("#cartQty").val();
        }
    });

    $("#wish").click(function(){
        $.ajax({
            type : "post",
            url : "wishItem",
            data : { "goodsNum" : "${dto.goodsNum}" },
            dataType: "json",
            success : function(response){
                if(response){
                    $("#wish").attr("src", "/static/images/heart.jpg");
                } else {
                    $("#wish").attr("src", "/static/images/emptyheart.jpg");
                }
            },
            error:function(){
                alert("로그아웃 되었습니다.\n다시 로그인 해 주세요");
                window.open("/login/loginCk", "로그인", "width=400, height=100");
            }
        });
    });
});
</script>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="wrapper">
    <div class="product">
        <img class="main-image" src="/static/goodsUpload/${dto.goodsMainStoreImage}" alt="상품 메인 이미지">
        <div class="details">
            <h2>${dto.goodsName}</h2>
            <div class="brand">브랜드: ${dto.stockName}</div>
            <div class="price"><fmt:formatNumber value="${dto.goodsPrice}" pattern="###,###"/>원</div>
            <div class="views">조회수: ${dto.visitCount}</div>

            <div class="controls">
                <input type="number" min="1" value="1" id="cartQty">
                <button type="button" id="cartBtn">장바구니</button>
                <button type="button" id="buyItem">바로 구매</button>
                <c:if test="${empty wish}">
                    <img src="/static/images/emptyheart.jpg" id="wish">
                </c:if>
                <c:if test="${!empty wish}">
                    <img src="/static/images/heart.jpg" id="wish">
                </c:if>
            </div>
        </div>
    </div>

    <div class="description">
        <p>${dto.goodsContents}</p>
        <c:forTokens items="${dto.goodsDetailStoreImage}" delims="`" var="image">
            <img src="/static/goodsUpload/${image}" alt="상품 상세 이미지">
        </c:forTokens>
    </div>
    
    <!-- 후기 작성 폼 -->
<div class="review-section">
    <h3>상품 후기 작성</h3>
    <c:choose>
        <c:when test="${empty auth}">
            <p>로그인 후 후기를 작성하실 수 있습니다.</p>
        </c:when>
        <c:when test="${not empty list }">
        	<c:forEach items="${list }" var="dto">
	            <form action="/review/write" method="post" class="review-form">
	                <input type="hidden" name="goodsNum" value="${dto.goodsNum}">
	                <input type="hidden" name="purchaseNum" value="${dto.purchaseNum}">
	                <textarea name="reviewContent" rows="4" cols="60" placeholder="후기를 입력해 주세요" required></textarea>
	                <div class="review-form-buttons">
	                    <button type="submit" class="review-submit-btn">후기 등록</button>
	                </div>
	            </form>
            </c:forEach>	
        </c:when>
        <c:otherwise>
            <p>이 상품을 구매한 경우에만 후기를 작성할 수 있습니다.</p>
        </c:otherwise>
    </c:choose>
</div>

<style>
.review-section {
    margin-top: 40px;
    padding: 20px;
    border-top: 1px solid #ddd;
}

.review-form {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.review-form textarea {
    width: 100%;
    padding: 10px;
    resize: none;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.review-form-buttons {
    display: flex;
    justify-content: flex-end;
}

.review-submit-btn {
    padding: 8px 16px;
    background-color: #333;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.review-submit-btn:hover {
    background-color: #555;
}
</style>

    <!-- 후기 목록 출력 -->
    <div class="review-list">
    <h3>상품 후기</h3>
    <c:if test="${not empty reviewList}">
        <div class="review-container">
            <c:forEach var="review" items="${reviewList}">
                <div class="single-review">
                    <div class="review-header">
                        <div class="review-author">${review.memberId}</div>
                        <div class="review-date">
                            <fmt:formatDate value="${review.reviewDate}" pattern="yyyy-MM-dd HH:mm" />
                        </div>
                    </div>
                    <div class="review-content">${review.reviewContent}</div>
                    <c:if test="${auth != null && auth.userId == review.memberId}">
                        <div class="review-actions">
                            <form id="deleteReviewForm-${review.reviewNum}" action="<c:url value='/item/deleteReview' />" method="post" style="display:inline;">
                                <input type="hidden" name="reviewNum" value="${review.reviewNum}" />
                                <input type="hidden" name="goodsNum" value="${dto.goodsNum}" />
                                <a href="javascript:void(0);" onclick="if(confirm('이 후기를 삭제하시겠습니까?')) { document.getElementById('deleteReviewForm-${review.reviewNum}').submit(); }" class="review-delete-btn">🗑️ 삭제</a>
                            </form>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </c:if>
    <c:if test="${empty reviewList}">
        <p>작성된 후기가 없습니다.</p>
    </c:if>
</div>

<style>
.review-list {
    margin-top: 40px;
    padding: 20px;
    border-top: 1px solid #ddd;
}

.review-container {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.single-review {
    padding: 15px;
    background-color: #f9f9f9;
    border-radius: 6px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.review-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.review-author {
    font-weight: bold;
}

.review-date {
    color: #777;
    font-size: 14px;
}

.review-content {
    line-height: 1.5;
}

.review-actions {
    display: flex;
    justify-content: flex-end;
    margin-top: 10px;
}

.review-delete-btn {
    color: #d00;
    font-size: 13px;
    font-weight: 600;
    text-decoration: none;
}

.review-delete-btn:hover {
    color: #a00;
}
</style>
    
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
