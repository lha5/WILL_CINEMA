<%@page import="com.admin.mall.db.AdminMallDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Will_CINEMA - 상품 수정(관리자)</title>
</head>
<body>

	<%@ include file="../include/header.jsp" %>

<%
	//상품의 정보를 저장(request)
	//request.setAttribute("amdto", amdto);
	AdminMallDTO amdto = (AdminMallDTO)request.getAttribute("amdto");
	
	// 후에 데이터 없이 넘어가는것 막는 JQuery문 입력할것
%>

<h1> 상품 수정 </h1>

	<form action="./GoodsModifyAction.al" method="post" enctype="multipart/form-data">
	<input type="hidden" name="goods_num" value="<%=amdto.getGoods_num()%>">
	<input type="hidden" name="prev_image" value="<%=amdto.getImage()%>">
	<table border="1">
	<tr>
	
	<td>카테고리</td>
	<td>
	<select name="category">
		<option value="ticket"
		<%if(amdto.getCategory().equals("ticket")){%>selected<%} %>
		>관람권</option>
		<option value="snack"
		<%if(amdto.getCategory().equals("snack")){%>selected<%} %>
		>스낵음료</option>
	</select>
	</td>
	</tr>
	<tr>
	<td>제품명</td> <td><input type ="text" name="name" value="<%=amdto.getName() %>"></td>
	</tr>
	<tr>
	<td>제품설명</td> <td><textarea name="content"><%=amdto.getContent()%></textarea></td>
	</tr>
	<tr>
	<td>제품가격</td> <td><input type="text" name="price" value="<%=amdto.getPrice() %>"></td>
	</tr>
	<tr>
	<td>제품이미지</td> 
	<td><input type="file" name="image">
	<img src="./goodsImageUpload/<%=amdto.getImage()%>"></td>
	</tr>
	
	</table>
	<input type="submit" value="제품 수정">
	<input type="reset" value="제품 수정 취소">
	<input type="button" value="리스트" onclick="location.href='./GoodsList.al'">
	</form>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>