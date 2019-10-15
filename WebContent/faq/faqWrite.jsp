<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% // 아이디 인증 받을까 말까?? 고민중!!
%>
<h1>FAQ 글쓰기 (admin)가능</h1>

<fieldset>
<legend>FAQ 쓰기</legend>
<form action="./FAQWriteAction.af" method="post">

제목  <input type="text" name = "subject" > <br>
내용 <br>
<textarea name="content" rows="10" cols="10"></textarea>
<input type="submit" value="FAQ 쓰기"> 
</form>

</fieldset>


</body>
</html>