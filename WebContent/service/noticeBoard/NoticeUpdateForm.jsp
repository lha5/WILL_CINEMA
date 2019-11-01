<%@page import="com.admin.service.notice.db.AdminNoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 공지사항 내용 수정</title>

<!-- summernote 적용시키기 위한 준비 -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<script src="./summernote/lang/summernote-ko-KR.js"></script>

</head>
<body>

	<div id="wrap">

	<%@ include file="../../include/header.jsp" %>
	
	<%
	AdminNoticeDTO andto =(AdminNoticeDTO) request.getAttribute("andto");
	String pageNum = (String) request.getAttribute("pageNum");
	%>

	<fieldset>
		<legend>게시판 글 수정하기</legend>
			<form action="./NoticeUpdateAction.an?pageNum=<%=pageNum %>" method="post">
		      <input type="hidden" name="num" value="<%=andto.getNum()%>"> 
			     글쓴이 : <input type="text" name="name" value="<%=andto.getName()%>" readonly><br>
			     비밀번호 : <input type="password" name="pass"><br>
			   카테고리: <input type=text name="category" value="<%=andto.getCategory()%>"><br> 
			     제목 : <input type="text" name="subject" value="<%=andto.getSubject()%>"><br>
			     내용 :<br> 
			     <textarea name="content" rows="10" cols="20"><%=andto.getContent() %></textarea><br>
			   <input type="submit" value="글수정하기">
		   </form>
	</fieldset> 



	<%@ include file="../../include/footer.jsp" %>
	
	</div>

</body>
</html>