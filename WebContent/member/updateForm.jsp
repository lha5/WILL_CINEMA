<%@page import="com.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 회원 정보</title>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<%
		// 세션 가져오기 
		// String id = (String) session.getAttribute("id");

		// 아이디 없으면 메인으로 
		if (id == null) {
			response.sendRedirect("./MemberLogin.me");
		}

		MemberDTO mdto = (MemberDTO) request.getAttribute("mdto");

		String detailAddr = mdto.getDetailaddr();
		if (detailAddr == null) {
			detailAddr = "";
		}
	%>

	<fieldset>
		<legend> <%=mdto.getName()%>님의 정보 수정 </legend>
		<form action="./MemberUpdateAction.me" method="post">
		
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" value="<%=id%>" readonly></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pass"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%=mdto.getName()%>"></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input type="text" name="birthday" value="<%=mdto.getBirthday()%>"></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="mobile" value="<%=mdto.getMobile()%>"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" value="<%=mdto.getEmail()%>"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td>
						<input type="text" name="zipcode" value="<%=mdto.getZipcode()%>">
						<br>
						<input type="text" name="addr" value="<%=mdto.getAddr()%>">
						<br>
						<input type="text" name="detailaddr" value="">
					</td>
				</tr>
				<tr>
					<td>이벤트 메일 수신</td>
					<td>
						<input type="radio" name="receive" value="yes" <%if (mdto.getReceive().equals("yes")) {%>checked<%}%>> 예
						&nbsp;&nbsp;&nbsp;
						<input type="radio" name="receive" value="no" <%if (mdto.getReceive().equals("no")) {%>checked<%}%>> 아니오
					</td>
				</tr>
				<tr>
					<td>선호하는 장르</td>
					<td><input type="text" name="preference" value="<%=mdto.getPreference()%>"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="정보 수정">
						&nbsp;&nbsp;
						<input type="reset" value="다시 입력">
					</td>
				</tr>
			</table>
			
		</form>
	</fieldset>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>