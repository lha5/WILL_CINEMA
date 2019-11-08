<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Will_CINEMA - 상품 등록(관리자)</title>
<!-- 제품등록 내역 부족시 submit 차단  -->
<script type="text/javascript">
	function goodsCheck() { 
		if(document.goodsAddfr.category.value == ""){
			alert("카테고리를 입력하세요.");
			document.goodsAddfr.category.focus();
			return false;
		}
		if(document.goodsAddfr.name.value == ""){
			alert("제품명 입력하세요.");
			document.goodsAddfr.name.focus();
			return false;
		}
		if(document.goodsAddfr.content.value == ""){
			alert("제품설명을 입력하세요.");
			document.goodsAddfr.content.focus();
			return false;
		}
		if(document.goodsAddfr.price.value == ""){
			alert("제품가격을 입력하세요.");
			document.goodsAddfr.price.focus();
			return false;
		}
		if(document.goodsAddfr.image.value == ""){
			alert("제품이미지를 입력하세요.");
			document.goodsAddfr.image.focus();
			return false;
		}
		
	}
</script>
</head>
<body>

	<%@ include file="../include/header.jsp" %>


<h1> 상품 등록 </h1>

	<form action="./GoodsAddAction.al" method="post"
		 name="goodsAddfr" enctype="multipart/form-data"
		 onsubmit="return goodsCheck()">
	<table border="1">
	<tr>
	
	<td>카테고리</td>
	<td>
	<select name="category">
		<option value="">카테고리를 입력하십시오.</option>
		<option value="ticket">관람권</option>
		<option value="snack">스낵음료</option>
	</select>
	</td>
	</tr>
	<tr>
	<td>제품명</td> <td><input type ="text" name="name"></td>
	</tr>
	<tr>
	<td>제품설명</td> <td><textarea name="content" placeholder="제품설명에 대해 입력하시오."></textarea></td>
	</tr>
	<tr>
	<td>제품가격</td> <td><input type="text" name="price"></td>
	</tr>
	<tr>
	<td>제품이미지</td> <td><input type="file" name="image"></td>
	</tr>
	
	</table>
	<input type="submit" value="제품등록">
	<input type="reset" value="제품 재등록">
	<input type="button" value="리스트" onclick="location.href='./GoodsList.al'">
	</form>
	
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>