<%@page import="com.service.QnA.db.QnADTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA</title>
</head>
<body>
<%@ include file="../../include/header.jsp" %>
	<%
		QnADTO qadto = (QnADTO)request.getAttribute("qadto");
		String pageNum = (String)request.getAttribute("pageNum");
	%>
	
	<fieldset>
		<legend>글 수정하기</legend>
		
		<form action="./QnAUpdateAction.sq?pageNum=<%=pageNum %>" method="post">
		<input type="hidden" name="num" value="<%=qadto.getNum() %>">
		글쓴이 : <input type="text" name="name" value="<%=qadto.getName() %>" readonly><br>
		비밀번호 : <input type="password" name="pass"><br>
		제목 : <input type="text" name="subject" value="<%=qadto.getSubject() %>"><br>
		카테고리 : <select name="category">
						<option value="#">#</option>
						<option value="#">#</option>
						<option value="#">#</option>
						<option value="#">#</option>
						<option value="#">#</option>
						<option value="#">#</option>
					</select><br>
		내용 : <br><textarea rows="10" cols="20" name="content"><%=qadto.getContent() %></textarea><br>
		첨부이미지 : <input type="file" name="image"><br>
		<input type="submit" value="글 수정하기">
		</form>
	</fieldset>
<%@ include file="../../include/footer.jsp" %>
</body>
</html>