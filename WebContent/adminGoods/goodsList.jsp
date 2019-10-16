<%@page import="java.util.ArrayList"%>
<%@page import="com.admin.mall.db.AdminMallDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%@ include file="../include/header.jsp" %>

	<h1>WebContent/adminGoods/goodsList.jsp</h1>
	
	<%
	// DB에서 가져온 정보 저장
	//request.setAttribute("goodsList", goodsList);
	List goodsList = (List)request.getAttribute("goodsList");
	%>

	<h1>상품 목록(관리자 전용)</h1>
	
	<h3><a href="./GoodsAdd.al">상품 등록하기(관리자)</a></h3>
	
	<table border="1">
	
	  <tr>
	    <td>번호</td>
	    <td>카테고리</td>
	    <td>상품명</td>
	    <td>사진</td>
	    <td>가격</td>
	    <td>수정/삭제</td>	    
	  </tr>
	  <% for(int i=0;i<goodsList.size();i++){
		  AdminMallDTO amdto = (AdminMallDTO)goodsList.get(i);
		  %>
		   <tr>
	    <td><%=amdto.getGoods_num() %></td>
	    <td><%=amdto.getCategory() %></td>
	    <td><%=amdto.getName() %></td>
	    <td><img src="./goodsImageUpload/<%=amdto.getImage() %>"></td>
	    <td><%=amdto.getPrice() %> 원</td>
	    <td> <a href="./GoodsModify.al?num=<%=amdto.getGoods_num()%>">수정</a>
	      / 
	      <a href="./GoodsDelete.al?num=<%=amdto.getGoods_num()%>">삭제</a></td>
	  </tr>
	  <%} %>
	  
	  </table>
	  
	  <%@ include file="../include/footer.jsp" %>
</body>
</html>