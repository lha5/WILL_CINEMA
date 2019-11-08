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
					<td><label>아이디</label></td>
					<td><%=id%></td>
				</tr>
				<tr>
			     	<td><label>비밀번호</label>
					<td><input type="password" name="pass"></td>
				</tr>
				<tr>	
					<td colspan="2">
					<input type="submit" value="회원 계정 삭제">
				</td>
				</tr>
		</table>
		</form>
		<!-- 탈퇴 확인 메시지 -->
		<script type="text/javascript">
			document.querySelector('form').addEventListener('submit', function() {
				confirm('정말 탈퇴를 진행하시겠습니까? 한번 삭제된 계정은 복구하실 수 없습니다.')
			});
		</script>
	</fieldset>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>