<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.1.min.js"></script>
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
				item += '<table class="table table-borderless text-center mx-auto" style="width:900px;">';
				item += 	'<tr>';
				
				$.each(model.list , function(idx, dto){
					item += 		'<td><a href="goodsDetail?goodsNum='+dto.goodsNum+'">';
					item += 			'<img src="/static/goodsUpload/'+dto.goodsImageStoreName+'" width=300/>';
					item += 			'<br/>'+dto.goodsSubject;
					item += 			'<br/>'+dto.goodsWriter;
					item += 			'</a></td>';
					if((idx + 1) % 3) item += "</tr><tr>";
				});
				item += 	'</tr>';
				item += '</table>';
				$("#content").append(item);
				if(model.maxPage <= page) $("#more").css("display", "none")
			},
		});
	});
});
</script>
</head>

<body>
<jsp:include page="/views/header.jsp" />

<!-- 메인 레이아웃 -->
<div class="container mt-4 d-flex justify-content-between align-items-start">

  <!-- 왼쪽: 콘텐츠 영역 -->
  <div id="content" class="flex-grow-1 me-3">
    <table class="table table-borderless text-center mx-auto" style="width:900px;">
      <c:forEach items="${list }" var="dto" varStatus="idx">
        <c:if test="${idx.index % 3 == 0}"><tr></c:if>
        <td>
          <a href="/item/detailView?goodsNum=${dto.goodsNum}">
            <img src="/static/goodsUpload/${dto.goodsMainStoreImage}" width="300" height="150"/><br/>
            ${dto.goodsName }<br/>
            ${dto.goodsPrice }원
          </a>
        </td>
        <c:if test="${(idx.index + 1) % 3 == 0}"></tr></c:if>
      </c:forEach>
    </table>

    <!-- 더보기 버튼 -->
    <div id="more" class="text-center my-4">
      <button id="load-more" class="btn btn-primary">더보기</button>
    </div>
  </div>

  <!-- 오른쪽: 로그인 폼 영역 -->
  <c:if test="${empty auth}">
    <div class="login-box bg-white border rounded shadow-sm p-4" style="width: 300px;">
      <h5 class="mb-3">로그인</h5>
      <form:form modelAttribute="loginCommand" action="/login/login" method="post">
        <div class="form-check form-switch mb-2">
          <input class="form-check-input" type="checkbox" name="autoLogin" id="autoLogin">
          <label class="form-check-label" for="autoLogin">자동 로그인</label>
        </div>
        <div class="form-check form-switch mb-3">
          <input class="form-check-input" type="checkbox" name="idStore" id="idStore"
            <c:if test="${loginCommand.idStore}">checked</c:if> />
          <label class="form-check-label" for="idStore">아이디 저장</label>
        </div>
        <div class="mb-3">
          <label>아이디</label>
          <form:input path="userId" cssClass="form-control"/>
          <form:errors path="userId" cssClass="text-danger small"/>
        </div>
        <div class="mb-3">
          <label>비밀번호</label>
          <form:password path="userPw" cssClass="form-control"/>
          <form:errors path="userPw" cssClass="text-danger small"/>
        </div>
        <div class="d-grid">
          <input type="submit" value="로그인" class="btn btn-primary"/>
        </div>
        <div class="mt-3 text-end small">
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
