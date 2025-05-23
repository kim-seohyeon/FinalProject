<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<style>
    table {
        width: 800px;
        border-collapse: collapse;
        margin: 20px auto;
    }
    caption {
        font-size: 1.5em;
        margin-bottom: 10px;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }
    img {
        max-width: 100px;
    }
    input[type="submit"] {
        padding: 8px 16px;
        font-size: 1em;
    }
</style>
<script src="https://code.jquery.com/jquery-1.8.1.js"></script>
<script>
$(function() {
    // 전체 선택 체크박스 제어
    $("#checkAll").click(function(){
        $("input[name='prodCk']").prop("checked", this.checked);
    });

    // 개별 체크박스 해제 시 전체 선택 체크박스도 해제
    $("input[name='prodCk']").click(function(){
        const total = $("input[name='prodCk']").length;
        const checked = $("input[name='prodCk']:checked").length;
        $("#checkAll").prop("checked", total === checked);
    });
});
</script>
<script>
$(function(){
    $(document).on('change', '.qtyInput', function(){
        const $row = $(this).closest('tr');
        const goodsNum = $row.data('goodsnum');
        const cartQty = $(this).val();

        $.ajax({
            url: '/item/updateCartQty',
            type: 'post',
            data: {
                goodsNum: goodsNum,
                cartQty: cartQty
            },
            success: function(result){
                $row.find('.totalPrice').text(result.toLocaleString() + "원");
            },
            error: function(){
                alert("수량 변경 실패 또는 로그인 필요");
            }
        });
    });
});
</script>
<script>
function deleteSelectedItems() {
	var chk_arr = [];
	$("input:checkbox[name='prodCk']:checked").each(function(){
		chk_arr.push($(this).val());
	});
    $.ajax({
    	type : "post",
    	url : "deleteCart",
    	data : {goodsNums : chk_arr},
    	dataType: "text",
    	success:function(result){
    		if(result){
    			location.reload();
    		}else{
    			location.href="/";
    		}
    	},
    	error:function(){
    		alert("서버오류");
    	}
    });
}
</script>

</head>
<body>

<form action="itemBuy" method="post" >
    <table>
        <caption>장바구니</caption>
        <thead>
            <tr>
                <th><input type="checkbox" id="checkAll" checked /></th>
                <th>상품 이미지</th>
                <th>상품명</th>
                <th>수량</th>
                <th>합계금액</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="dto">
                <tr data-goodsnum="${dto.goodsNum}">
    <td><input type="checkbox" name="prodCk" value="${dto.goodsNum}" checked /></td>
    <td><img src="/static/goodsUpload/${dto.goodsMainStoreImage}" /></td>
    <td>${dto.goodsName}</td>
    <td>
        <input type="number" class="qtyInput" min="1" value="${dto.cartQty}" />
    </td>
    <td class="totalPrice">
        <fmt:formatNumber value="${dto.cartQty * dto.goodsPrice}" pattern="###,###" />원
    </td>
</tr>

            </c:forEach>
        </tbody>
        <tfoot>
    <tr>
        <td colspan="5" style="text-align: right;">
            <input type="button" value="삭제" onclick="deleteSelectedItems()" style="padding: 8px 16px; font-size: 1em;" />
			<input type="submit" value="구매하기" style="padding: 8px 16px; font-size: 1em;" />
        </td>
    </tr>
</tfoot>
        
    </table>
</form>

</body>
</html>
