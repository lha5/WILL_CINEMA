<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 등록</title>
<script type="text/javascript">
	



</script>
</head>
<body>

<h1>WebContent/adminGoods/goodsAdd.jsp</h1>

<h1> 상품 등록 </h1>

	<form action="./GoodsAddAction.al" method="post" enctype="multipart/form-data" >
	<table border="1">
	<tr>
	
	<td>카테고리</td>
	<td>
	<select name="category">
		<option value="">을 입력하십시오.</option>
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
	<input type="reset" value="취소">
	<input type="button" value="메인으로" onclick="location.href='../Main.me'">
	</form>
	


</body>
</html>