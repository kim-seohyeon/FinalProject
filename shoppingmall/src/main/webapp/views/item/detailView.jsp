<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detailView.jsp</title>
<script src="https://code.jquery.com/jquery-1.8.1.js"></script>
<script type="text/javascript">
$(function(){
    // 장바구니 버튼 클릭 시
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
                if(loc) 
                    location.href = "/item/cartList";
            },
            error: function(){
                window.open("/login/loginCk", "이름", "width=400, height=100, top=100, left=100");
            }
        });
    });
    
    //바로 구매 버튼 클릭 시
    $("#buyItem").click(function(){
    	if(${empty auth }){
    		window.open("/login/loginCk", "이름", "width=400, height=100, top=100, left=100");
    	}else{
    		location.href="buy?goodsNum=${dto.goodsNum}&cartQty="+$("#cartQty").val();
    	}
    	/*
    	$.ajax({
    		type: "post",
            url: "buy",   
            data: {
                "goodsNum": "${dto.goodsNum}",
                "cartQty": $("#cartQty").val()
            },
            success: function(){        
                let loc = confirm("구매 페이지로 이동하시겠습니까?");
                if(loc) 
                    location.href = "/item/itemBuy";
            },
            error: function(){
                window.open("/login/loginCk", "이름", "width=400, height=100, top=100, left=100");
            }
        });
    	*/
    });
    //문의하기 버튼 클릭 시
    

    // 찜하기 버튼 클릭 시
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
                alert("로그아웃 되었습니다. \n다시 로그인 해 주세요");
                window.open("/login/loginCk", "이름", "width=400, height=100, top=100, left=100");
            }
        });
    });
});
</script>

</head>
<body>
<table width=800 >
    <tr>
        <td rowspan=5><img src="/static/goodsUpload/${dto.goodsMainStoreImage }" /></td>
        <td>상품명 : ${dto.goodsName }</td>
    </tr>
    <tr>
        <td>브랜드명 : ${dto.stockName }</td>
    </tr>    
    <tr>
        <td>상품가격 : <fmt:formatNumber value="${dto.goodsPrice }" pattern="###,###"/>원</td>
    </tr>
    
    <tr>
        <td>조회수 : ${dto.visitCount }</td>
    </tr>
    <tr>
        <td>수량: <input type="number" min=1 value=1 step=1 id="cartQty"></td>
    </tr>    
    <tr>
        <td>
            <button type="button" id="cartBtn">장바구니</button> |
            <button type="button" id="buyItem">바로 구매</button> | 
            <button type="button" id="inquire">문의하기</button>
            <c:if test="${empty wish }">
                <img src="/static/images/emptyheart.jpg" width=30 id="wish"/>
            </c:if>
            <c:if test="${!empty wish }">
                <img src="/static/images/heart.jpg" width=30 id="wish"/>
            </c:if>
        </td>
    </tr>

    <tr>
        <td colspan=2>
            <div id="content">
                ${dto.goodsContents }<br/>
                <c:forTokens items="${dto.goodsDetailStoreImage }" delims="`" var="image">
                <img src="/static/goodsUpload/${image }" />
                </c:forTokens>
            </div>
        </td>
    </tr>    
    
</table>
</body>
</html>
