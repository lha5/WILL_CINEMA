<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<<<<<<< HEAD
=======
	<h1>WebContent/notice/NoticeDelete.jsp</h1>

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
<fieldset>
       <legend> 글 삭제 하기 </legend>
       <form action="./NoticeDeleteAction.an?pageNum=<%=pageNum %>" method="post">
         <input type="hidden" name="num" value="<%=num%>">      
                 비밀번호 : <input type="password" name="pass">         
         <input type="submit" value="삭제하기">       
       </form>    
    </fieldset>	

>>>>>>> branch 'master' of https://github.com/lha5/WILL_CINEMA.git

</body>
</html>