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

<%
/* 세션 가져오기  */
String id=(String)session.getAttribute("id");

/* 아이디 없으면 메인으로   */
if (id == null) {
	response.sendRedirect("./MemberLogin.me");
}

MemberDTO mdto = (MemberDTO)request.getAttribute("mdto");
%>

	<fieldset>
		<legend> <%=mdto.getName()%>님의 정보 수정 </legend>
		<form action="./MemberUpdateAction.me" method="post">
			아이디 <input type="text" name="id" value="<%=id%>" readonly>
			<br>
			비밀번호 <input type="password" name="pass">
			<br>
			이름 <input type="text" name="name" value="<%=mdto.getName()%>">
			<br>
			생일 <input type="text" name="birthday" value="<%=mdto.getBirthday()%>">
			<br>
			휴대폰 <input type="text" name="mobile" value="<%=mdto.getMobile()%>">
			<br>
			이메일 <input type="text" name="email" value="<%=mdto.getEmail()%>">
			<br>
			우편번호: <input type="text" name="zipcode" value="<%=mdto.getZipcode()%>">
			<br>
			주소  <input type="text" name="addr" value="<%=mdto.getAddr()%>">
			<br>
			상세주소 <input type="text" name="addrdetail" value="<%=mdto.getDetailaddr()%>">
			<br>
			이벤트 메일 수신 <input type="text" name="receive" value="<%=mdto.getReceive()%>">
			<br>
			선호장르 <input type="text" name="preference" value="<%=mdto.getPreference()%>">
			<br><br>
			<input type="submit" value="회원 정보 수정">
			&nbsp;&nbsp;
			<input type="reset" value="다시 입력">
		</form>
	</fieldset>



</body>
</html>