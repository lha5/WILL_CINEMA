<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 공지사항 글 삭제하기</title>


<!--CSS  -->
<link rel="stylesheet" href="././css/noticeDelete.css">

</head>
<body>
	<%@ include file="../../include/header.jsp" %>


	<%
	// 로그인 여부를 체크 하여, 비로그인시 삭제 불가 
		  // 로그인 페이지로 이동  
/* 	String id = (String)session.getAttribute("id");
	
	  if(id == null){
		  response.sendRedirect("./Main.me");
	  } */
	  int num = Integer.parseInt(request.getParameter("num"));
	  String pageNum = request.getParameter("pageNum");
	
	%>

       <legend> <h1>글 삭제 하기</h1> </legend>
       <form action="./NoticeDeleteAction.an?pageNum=<%=pageNum %>" method="post">
         <input type="hidden" name="num" value="<%=num%>">      
                 비밀번호 : <input type="password" name="pass">         
         <input type="submit" value="삭제하기" id="notidel">       
       </form>    
    

<%@ include file="../../include/footer.jsp" %>
</body>
</html>