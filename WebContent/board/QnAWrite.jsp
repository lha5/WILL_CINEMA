<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/board/QnAWrite.jsp</h1>
	
	<fieldset>
		<legend>글쓰기</legend>
		<form action="./QnAWriteAction.sq" method="post">
			글쓴이 : <input type="text" name="name"><br>
			비밀번호 : <input type="password" name="pass"> 비밀글 설정 : <input type="checkbox" name="secreat"><br>
			제목 : <input type="text" name="subject"><br>
			카테고리 : <select name="category">
						<option value="#">#</option>
						<option value="#">#</option>
						<option value="#">#</option>
						<option value="#">#</option>
						<option value="#">#</option>
						<option value="#">#</option>
					</select><br>
			첨부이미지 : <input type="file" name="image"><br>
			내용 : <textarea name="content" row="10" cols="20"></textarea><br>
			<input type="submit" value="글쓰기">
		</form>
	</fieldset>
	
</body>
</html>