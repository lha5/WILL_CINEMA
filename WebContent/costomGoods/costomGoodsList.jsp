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

#container {
	/* border: 1px solid red; */
	width: 900px;
	height: 900px;
	margin: 50px auto;
	padding: 0px auto 50px auto;
}

#goods {
	text-align: center;
}

#goods>li {
	float: left;
	/* border: 1px solid blue; */
	width: 190px;
	height: 220px;
	margin: 20px 0px 55px 78px;
	padding-top: 10px;
}

a>#goodsName {
	font-size: 1.2em;
}

#clear {
	clear: both;
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
	
	<div id="container">
	<ul id="goods">
		<%
		for (int i = 0; i < goodsList.size(); i++) { 
			MallDTO mdto = (MallDTO) goodsList.get(i);	
		%>
			<li>
				<a href="./GoodsDetail.ml?num=<%=mdto.getGoods_num()%>">
					<img src="./upload/<%=mdto.getImage()%>" width="150" height="150">
					<br>
					<span id="goodsName"><%=mdto.getName()%></span>
				</a>
				<br><br>
				<%=mdto.getPrice() %>원
			</li>
		<%
		} 
		%>
	</ul>
	</div>
	
	<div id="clear"></div>
	
	<%@ include file="../include/footer.jsp" %>
		
</body>
</html>