<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 회원 계정 삭제</title>


<!-- CSS -->
<link rel="stylesheet" href="./css/memberDelete.css">


</head>
<body>

	<%@ include file="../include/header.jsp" %>
	<%
	// String id = (String) session.getAttribute("id");

	if(id ==null){
		response.sendRedirect("./MemberLogin.me");
	}
	%>
	
	<fieldset class="deleteField">
	<span id="outout">회원 탈퇴</span> 
		<form action="./MemberDeleteAction.me" class="sec" method="post">
			<table>
				<tr>
					<td><label><i class="ri-2g" ></i>아이디</label></td>
					<td><input type="text" name="id" value="<%=id%>" readonly></td>
				</tr>
				<tr>
			     	<td><label><i class="ri-2g">비밀번호</i></label>
					<td><input type="password" name="pass"></td>
				</tr>
				<tr>	
					<td colspan="2">
					<input type="submit" value="회원탈퇴">
				</td>
				</tr>
		</table>
		</form>
	</fieldset>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>