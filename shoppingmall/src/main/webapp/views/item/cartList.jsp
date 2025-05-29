<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Inter', sans-serif;
        background-color: #ffffff;
        margin: 0;
        padding: 0;
        color: #333;
    }
    .cart-container {
        max-width: 1100px;
        margin: 40px auto;
        padding: 0 20px;
    }
    .cart-header, .cart-item {
        display: grid;
        grid-template-columns: 40px 100px 1.5fr 100px 100px 120px 60px;
        align-items: center;
        background-color: #fff;
        padding: 16px 20px;
        margin-bottom: 10px;
        border-radius: 12px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.06);
    }
    .cart-header {
        font-weight: 600;
        background-color: #f0f2f5;
        border: 1px solid #ddd;
    }
    .cart-item img {
        max-width: 80px;
        max-height: 80px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid #ccc;
        background-color: #fff;
        padding: 4px;
    }
    .cart-item .product-name {
        font-size: 16px;
        font-weight: 500;
    }
    .cart-qty input[type="number"] {
        width: 60px;
        padding: 6px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 6px;
        text-align: center;
    }
    .cart-price, .cart-total {
        font-weight: 600;
        color: #e60023;
        font-size: 15px;
        text-align: center;
    }
    .cart-delete button {
        background-color: #ff4d4f;
        color: #fff;
        border: none;
        padding: 6px 10px;
        border-radius: 6px;
        cursor: pointer;
        font-size: 13px;
        transition: background-color 0.3s ease;
    }
    .cart-delete button:hover {
        background-color: #d9363e;
    }
    .total-summary {
        text-align: right;
        font-size: 18px;
        font-weight: bold;
        margin-top: 30px;
        color: #111;
        padding: 10px;
    }
    .cart-actions {
        text-align: right;
        margin: 30px 0;
    }
    .cart-actions input {
        background-color: #111;
        color: white;
        padding: 12px 24px;
        border: none;
        font-size: 15px;
        border-radius: 8px;
        cursor: pointer;
        margin-left: 12px;
        transition: background-color 0.3s ease;
    }
    .cart-actions input:hover {
        background-color: #333;
    }
</style>

<script src="https://code.jquery.com/jquery-1.8.1.js"></script>
<script>
$(function(){
    // 전체선택 체크박스 클릭 시
    $("#checkAll").click(function(){
        $("input[name='prodCk']").prop("checked", this.checked);
        updateTotalSummary();
    });

    // 개별 체크박스 클릭 시 전체선택 체크박스 상태 업데이트 및 총액 갱신
    $("input[name='prodCk']").click(function(){
        const total = $("input[name='prodCk']").length;
        const checked = $("input[name='prodCk']:checked").length;
        $("#checkAll").prop("checked", total === checked);
        updateTotalSummary();
    });

    // 수량 변경 시 AJAX로 수량 업데이트 요청 및 총액 갱신
    $(document).on('change', '.qtyInput', function(){
        const $row = $(this).closest('.cart-item');
        const goodsNum = $row.data('goodsnum');
        const cartQty = $(this).val();

        $.ajax({
            url: '/item/updateCartQty',
            type: 'post',
            dataType: 'json',
            data: {
                goodsNum: goodsNum,
                cartQty: cartQty
            },
            success: function(result){
                if(result){
                    $row.find('.totalPrice').text(result.toLocaleString() + "원");
                    updateTotalSummary();
                } else {
                    alert("응답 오류");
                }
            },
            error: function(){
                alert("수량 변경 실패 또는 로그인 필요");
            }
        });
    });

    // 페이지 로드 시 총액 계산
    updateTotalSummary();
});

// 총 결제 예상금액 업데이트 함수
function updateTotalSummary(){
    let sum = 0;
    $("input[name='prodCk']:checked").each(function(){
        const $row = $(this).closest('.cart-item');
        const totalText = $row.find('.totalPrice').text().replace(/원|,/g,'');
        sum += parseInt(totalText) || 0;
    });
    $('.total-summary').text("총 결제 예상금액: " + sum.toLocaleString() + "원");
}

// 선택한 상품 삭제 처리 함수
function deleteSelectedItems() {
    var chk_arr = [];
    $("input:checkbox[name='prodCk']:checked").each(function(){
        chk_arr.push($(this).val());
    });
    if(chk_arr.length === 0){
        alert("삭제할 상품을 선택해주세요.");
        return;
    }

    $.ajax({
        type : "post",
        url : "deleteCart",
        traditional: true,
        data : {goodsNums : chk_arr},
        dataType: "text",
        success:function(result){
            if(result){
                location.reload();
            }else{
                alert("삭제 실패했습니다.");
            }
        },
        error:function(){
            alert("서버 오류");
        }
    });
}
</script>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="cart-container">
    <div class="cart-header">
        <div><input type="checkbox" id="checkAll" checked /></div>
        <div>이미지</div>
        <div>상품명</div>
        <div>수량</div>
        <div>단가</div>
        <div>총액</div>
        <div>삭제</div>
    </div>

    <form action="itemBuy" method="post">
        <c:forEach items="${list}" var="dto">
            <div class="cart-item" data-goodsnum="${dto.goodsNum}">
                <div><input type="checkbox" name="prodCk" value="${dto.goodsNum}" checked /></div>
                <div><img src="/static/goodsUpload/${dto.goodsMainStoreImage}" alt="상품 이미지" /></div>
                <div class="product-name">${dto.goodsName}</div>
                <div class="cart-qty">
                    <input type="number" class="qtyInput" min="1" value="${dto.cartQty}" />
                </div>
                <div class="cart-price">
                    <fmt:formatNumber value="${dto.goodsPrice}" pattern="###,###" />원
                </div>
                <div class="cart-total totalPrice">
                    <fmt:formatNumber value="${dto.cartQty * dto.goodsPrice}" pattern="###,###" />원
                </div>
                <div class="cart-delete">
                    <button type="button" onclick="$(this).closest('.cart-item').find('input[type=checkbox]').prop('checked', true); deleteSelectedItems();">X</button>
                </div>
            </div>
        </c:forEach>

        <div class="total-summary">총 결제 예상금액: 0원</div>

        <div class="cart-actions">
            <input type="button" value="선택 삭제" onclick="deleteSelectedItems()" />
            <input type="submit" value="선택 상품 주문하기" />
        </div>
    </form>
</div>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
