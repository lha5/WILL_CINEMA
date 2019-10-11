<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 회원 계정 삭제</title>
<script type="text/javascript">
	function check() {
		var checking = confirm('정말 계정을 삭제하시겠습니까? 탈퇴한 회원의 정보는 복원되지 않습니다.');
	}
</script>
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
     <form action="./MemberDeleteAction.me" method="post" onsubmit="check();">
       	아이디 : <input type="text" name="id" value="<%=id %>" readonly>
       	<br>
		비밀번호 : <input type="password" name="pass">
		<br>               
        <input type="submit" value="회원 탈퇴">
     </form>  
  </fieldset>
  



</body>
</html>