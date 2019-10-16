<%@page import="com.mall.db.MallDTO"%>
<%@page import="com.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/goodsOrder/goodsBuy.jsp</h1>
<%
	//request.setAttribute("memdto", memdto);
	//request.setAttribute("malldto", malldto);
	
	MemberDTO memdto = (MemberDTO)request.getAttribute("memdto");
	MallDTO malldto = (MallDTO)request.getAttribute("malldto");
	int amount = (int)request.getAttribute("amount");
%>

<h1>주문 내역</h1>
<table border="1">
	<tr>
	 <td>상품명</td>
	 <td>사진</td>
	 <td>수량</td>
	 <td>가격</td>
	</tr>
	<tr>
	 <td><%=malldto.getName() %></td>
	 <td><img src="./goodsImageUpload/<%=malldto.getImage() %>" witdh="50" height="50"></td>
	 <td><%=amount %></td>
	 <td><%=malldto.getPrice()*amount %>원</td>
	</tr>

</table>

<hr>
<!-- 주문 파트 미완성 -->
주문 관련하여 만들어야함
<fieldset>
	<from action="" method="post">
		<h3>주문자 정보</h3>
		이름 : <%=memdto.getName() %><br>
		휴대폰 : <%=memdto.getMobile() %><br>
		이메일 : <%=memdto.getEmail() %><br>
		
		<h3>수취자?</h3>
		이름 : <input type="text"><br>
		휴대폰 : <input type="text"><br>
		이메일 : <input type="text"><br>
		
		<h3>상품 코드 발송 방법</h3>
		<input type="checkbox"> 카카오톡
		<input type="checkbox"> 이메일
		
		<h3>결제 방법</h3>
		
		<hr>
		<input type ="submit" value = "주문">
		<!-- 취소시 메인으로 -->
		<input type ="#" value = "취소">
		<hr>
	</from>
</fieldset>


</body>
</html>