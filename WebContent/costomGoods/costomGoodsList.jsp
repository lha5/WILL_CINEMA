<%@page import="java.util.List"%>
<%@page import="com.mall.db.MallDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 매점</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/goodsList.css">

<style type="text/css">
	nav>ul>li:NTH-CHILD(5)>ul {
	display: block;
	}
</style>

</head>
<body>

	
	<%@ include file="../include/header.jsp" %>

	<%
	// DB에서 가져온 정보 저장
	// request.setAttribute("goodsList", goodsList);
	List goodsList = (List)request.getAttribute("goodsList");
	%>
	
	<table>
		<tr>
		<%
		for(int i=0;i<goodsList.size();i++){ 
			MallDTO mdto = (MallDTO)goodsList.get(i);	
		%>
			<td>
				<img src="./goodsImageUpload/<%=mdto.getImage() %>"	width="130" height="130"><br>
				<a href="./GoodsDetail.ml?num=<%=mdto.getGoods_num()%>"><%=mdto.getName() %></a><br>
				<%=mdto.getPrice() %>원
			</td>
		<%
		} 
		%>
		</tr>
	</table>

	<%@ include file="../include/footer.jsp" %>
	
	
</body>
</html>