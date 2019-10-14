<%@page import="java.util.ArrayList"%>
<%@page import="com.admin.service.event.db.AdminEventDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function chk(num){
		if(confirm("삭제하시겠습니까?")){
			location.href="./EventDelete.ae?num="+num;
		}else{
			return false;
		}
	}
</script>
</head>
<body>
<%
	List<AdminEventDTO> arr = (ArrayList<AdminEventDTO>)request.getAttribute("arr");
%>
<h1>상품 리스트</h1>
<h3><a href="./EventSummary.ae">이벤트 페이지</a></h3>
<!-- 카테고리 만들기 -->
<table border="1">
	<tr><td>번호</td><td>카테고리</td><td>제목</td>
	<td>이미지</td><td>이벤트 기간</td><td>수정/삭제</td>
<%for(int i=0; i<arr.size(); i++){
	AdminEventDTO aedto=arr.get(i);
	%>
	<tr>
	<td><%=aedto.getNum() %></td>
	<td><%=aedto.getCategory() %></td>
	<td><%=aedto.getSubject() %></td>
	<td>
		<img src="./upload/<%=aedto.getImage().split(",")[0] %>" width="120" hegiht="80">
	</td>
	<td><%=aedto.getF_date() %>~<%=aedto.getE_date() %></td>
	<td><input type="button" value="수정" onclick="location.href='./EventUpdate.ae?num=<%=aedto.getNum()%>'"> 
	<input type="button" value="삭제" onclick="chk(<%=aedto.getNum()%>);"></td>
	<%} %>
</table>
</body>
</html>