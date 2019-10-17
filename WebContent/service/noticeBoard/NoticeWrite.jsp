<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../../include/header.jsp" %>
	
	<%
	if (id == null || !id.equals("admin")) {
		response.sendRedirect("./Main.me");
	}
	%>

	<fieldset>
	<form action="./NoticeWriteAction.an" method="post" enctype="multipart/form-data">
		글쓴이: <input type="text" name="name" value="<%=id%>"><br>
		비밀번호 : <input type="password" name="pass"><br>
		     제목 : <input type="text" name="subject"><br>
		   이미지: <input type="file" name="image"><br>
		     내용 :<br> 
		     <textarea name="content" rows="10" cols="20"></textarea><br>
		   <input type="submit" value="글쓰기"> 	
	</form>
	</fieldset>
	
	<%@ include file="../../include/footer.jsp" %>
</body>
</html>