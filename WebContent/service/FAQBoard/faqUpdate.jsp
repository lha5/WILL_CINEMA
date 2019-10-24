<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
AdminFAQDTO afdto =(AdminFAQDTO) request.getAttribute("afdto");
String pageNum = (String) request.getAttribute("pageNum");	
%>
<%@ include file="../../include/header.jsp" %>

	<fieldset>
		<legend>글 수정하기</legend>
		
		<form action="./FAQUpdateAction.af?pageNum=<%=pageNum %>" method="post">
		<input type="hidden" name="num" value="<%=afdto.getNum() %>">
		글쓴이 : <input type="text" name="name" value="<%=afdto.getName() %>" readonly><br>
		비밀번호 : <input type="password" name="pass"><br>
		제목 : <input type="text" name="subject" value="<%=afdto.getSubject() %>"><br>
		카테고리 : <select name="category">
		<option value="영화예매">영화 예매</option>
		<option value="매점구매">매점 구매</option>
		<option value="이용안내">사이트 이용 안내</option>
		<option value="이벤트">이벤트</option>
		<option value="멤버십">멤버십/포인트</option>
		<option value="쿠폰">쿠폰</option>	
		</select><br>
		내용 : <br><textarea rows="10" cols="20" name="content"><%=afdto.getContent() %></textarea><br>
		첨부이미지 : <input type="file" name="image"><br>
		<input type="submit" value="글 수정하기">
		</form>
	</fieldset>

<%@ include file="../../include/footer.jsp" %>
</body>
</html>