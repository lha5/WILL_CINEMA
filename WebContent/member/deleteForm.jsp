<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 회원 계정 삭제</title>
</head>
<body>
<h1>회원탈퇴하는곳</h1>

<%
String id = (String)session.getAttribute("id");

if(id ==null){
	response.sendRedirect("./MemberLogin.me");
}



%>
<fieldset>
     <legend> 회원 탈퇴 </legend>
     <form action="./MemberDeleteAction.me" method="post" onsubmit="javascript:confirm('정말 탈퇴를 진행하시겠습니까? 확인을 누르시면 모든 정보가 삭제됩니다.');">
       	아이디 : <input type="text" name="id" value="<%=id %>" readonly>
       	<br>
		비밀번호 : <input type="password" name="pass">
		<br>               
        <input type="submit" value="회원 탈퇴">
     </form>  
  </fieldset>
  



</body>
</html>