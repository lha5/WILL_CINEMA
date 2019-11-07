<%@page import="com.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 회원 정보</title>

<!-- CSS -->
<style type="text/css">
fieldset {
	width: 700px;
	height: auto;
	margin: 50px auto;
	border-style: none;
}

legend {
	text-align: center;
	font-family: inherit;
	font-size: 2em;
	color: #240e04;
}

table {
	border-collapse: collapse;
	border-top: 2px solid #240e04;
	border-bottom: 2px solid #240e04;
	margin: 50px auto;
	width: 600px;
	padding: 10px;
}

td {
	height: 50px;
	padding: 10px 5px;
}

td:NTH-CHILD(1) {
	padding-left: 10px;
}

td:NTH-CHILD(2) {
	text-align: center;	
}

tr:NTH-CHILD(10)>td:NTH-CHILD(1) {
	text-align: center;
}

input[type=text], input[type=password], input[type=email] {
	width: 240px;
	height: auto;
	line-height: normal;
	padding: .8em .5em;
	font-family: inherit;
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border: 1px solid #240e04;
	color: #240e04;
	font-size: 14px;
}

input[type=submit] {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border: 1px solid #d7282d;
	background-color: #d7282d;
	font-family: inherit;
	color: #ffffff;
	padding: 5px;
}

input[type=reset] {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border: 1px solid #240e04;
	background-color: #ffffff;
	color: #240e04;
	font-family: inherit;
	padding: 5px;
}
</style>

</head>
<body>
	
	<%@ include file="../include/header.jsp" %>
	
		<%
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
		<legend>개인 정보 수정</legend>
		<form action="./MemberUpdateAction.me" method="post">
		
			<table>
				<tr>
					<td>아이디</td>
					<td><%=id%></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pass" ></td>
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
						&nbsp;<input type="text" name="zipcode" value="<%=mdto.getZipcode()%>">
						<br>
						&nbsp;<input type="text" name="addr" value="<%=mdto.getAddr()%>">
						<br>
						<input type="text" name="detailaddr" placeholer="상세주소">
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
					<td>
						<select name="preference">
							<option value="액션" <%if (mdto.getPreference().equals("액션")) {%>selected<%}%>>액션</option>
							<option value="SF" <%if (mdto.getPreference().equals("SF")) {%>selected<%}%>>SF</option>
							<option value="판타지" <%if (mdto.getPreference().equals("판타지")) {%>selected<%}%>>판타지</option>
							<option value="드라마" <%if (mdto.getPreference().equals("드라마")) {%>selected<%}%>>드라마</option>
							<option value="스릴러" <%if (mdto.getPreference().equals("스릴러")) {%>selected<%}%>>스릴러</option>
							<option value="호러" <%if (mdto.getPreference().equals("호러")) {%>selected<%}%>>호러</option>
							<option value="애니메이션" <%if (mdto.getPreference().equals("애니메이션")) {%>selected<%}%>>애니메이션</option>
							<option value="기타" <%if (mdto.getPreference().equals("기타")) {%>selected<%}%>>기타</option>
						</select>
					</td>
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