<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 비밀번호 변경</title>

<!-- 오류 방지 -->
<script type="text/javascript">
	function checkValue() {
		var form = document.updateForm;
		
		if (!form.pass.value) {
			alert("비밀번호를 입력하세요.");
			document.upForm.pass.focus();
			return false;
		}
		if (form.pass.value != form.pass2.value) {
			alert("동일한 비밀번호를 입력하세요.");
			document.upForm.pass2.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	
	<%
		if (id == null) {
			response.sendRedirect("./MemberLogin.me");
		}
	%>
	
	<form action="./MemberPassUpdateAction.me" name="updateForm" method="post" onsubmit="checkValue();">
		<table border="1">
			<tr>
				<td>변경하실 비밀번호를 입력하세요.</td>
			</tr>
			<tr>
				<td>
					<input type="password" name="pass">
					<br><br>
					<input type="password" name="pass2">
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="확인">
				</td>
			</tr>
		</table>
	</form>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>