<!-- 

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goodsForm.jsp</title>
</head>
<body>
<form action="goodsWrite" method="POST" enctype="multipart/form-data">
<table border = "1" width ="600" align="center">
	<tr><th width="100">상품번호</th>
		<td><input type="text" name="goodsNum" value="${goodsCommand.goodsNum }" readonly="readonly" />번호자동부여</td></tr>
	<tr><th>상품명</th>
		<td><input type="text" name="goodsName"/></td></tr>
	<tr><th>상품가격</th>
		<td><input type="number" name="goodsPrice"/></td></tr>
	<tr><th>상품설명</th>
		<td><textarea rows="10" cols="50" name="goodsContents"></textarea></td></tr>
	<tr><th>대문이미지</th>
		<td><input type="file" name="mainImage" /></td></tr>
	<tr><th>상품설명이미지</th>
		<td><input type="file" name="image1" />
			<input type="file" name="image2" />
			<input type="file" name="image3" /></td>
	</tr>		
		
		
		
	<tr><th colspan="2"><input type="submit" value="상품등록" /></th></tr>
</table>	
</form>
</body>
</html>

-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 폼</title>
<script>
  function validateForm() {
    var goodsName = document.forms["goodsForm"]["goodsName"].value;
    var goodsPrice = document.forms["goodsForm"]["goodsPrice"].value;
    var goodsContents = document.forms["goodsForm"]["goodsContents"].value;
    
    if (goodsName == "" || goodsPrice == "" || goodsContents == "") {
      alert("상품명, 가격, 상품설명은 필수 항목입니다.");
      return false;
    }
  }
</script>
</head>
<body>
<h2>상품 등록</h2>

<form name="goodsForm" action="goodsWrite" method="POST" enctype="multipart/form-data" onsubmit="return validateForm()">
  <table border="1" width="600" align="center">
    <tr><th width="100">상품번호</th>
      <td><input type="text" name="goodsNum" value="${goodsCommand.goodsNum }" readonly="readonly" />번호 자동 부여</td></tr>
    <tr><th>상품명</th>
      <td><input type="text" name="goodsName" required /></td></tr>
    <tr><th>상품가격</th>
      <td><input type="number" name="goodsPrice" required /></td></tr>
    <tr><th>상품설명</th>
      <td><textarea rows="10" cols="50" name="goodsContents" required></textarea></td></tr>
    <tr><th>대문이미지</th>
      <td><input type="file" name="mainImage" required /></td></tr>
    <tr><th>상품설명이미지</th>
      <td>
        <input type="file" name="image1" />
        <input type="file" name="image2" />
        <input type="file" name="image3" />
      </td>
    </tr>  
    <tr><th colspan="2"><input type="submit" value="상품등록" /></th></tr>
  </table>  
</form>

</body>
</html>
