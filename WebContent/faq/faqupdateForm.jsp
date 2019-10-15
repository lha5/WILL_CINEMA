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
Integer num = (Integer)request.getAttribute("num");
%>

<fieldset>
<legend>FAQ 글 수정하기</legend>
<form action="./FAQUpdateAction.af" method="post">
제목:<input type="text" name = "subject" value="<%=afdto.getSubject()%>"><br>
내용:<textarea name="content" rows="10" cols="10"></textarea><br>
<input type="submit" value="글 수정하기">
</form>
</fieldset>

</body>
</html>