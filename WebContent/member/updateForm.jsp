<%@page import="com.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>UpdateMember</title>
</head>
<body>

<%
/* 세션 가져오기  */
String id=(String)session.getAttribute("id");
/* 아이디 없으면 메인으로   */
if(id == null){
	response.sendRedirect("./MemberLogin.me");

}


 MemberDTO mdto = (MemberDTO)request.getAttribute("mdto");

%>

<!--  나중에 앞에꺼 다하고 하기   -->

<fieldset>
<legend> 회원정보수정- 무엇을 수정할것인지 대화하기 </legend>
<form action="/MemberUpdateAction.me" method="post">
아이디 : <input type="text" name="id" value="<%=id%>" readonly>
비밀번호: <input type="password" name="pass" value ="<%=mdto.getPass() %>">
이름 : <input type="text" name ="name" value="<%=mdto.getName()%>">
생일 : <input type="text" name="birthday" value="<%=mdto.getBirthday()%>">
휴대폰 : <input type="text" name="mobile" value="<%=mdto.getMobile()%>">
이메일 :  <input type="text" name="email" value="<%=mdto.getEmail()%>">
주소 : <input type="text" name="addr" value="<%=mdto.getAddr()%>">
상세주소 : <input type="text" name="addrdetail" value="<%=mdto.getDetailaddr()%>">
우편번호: <input type="text" name="zipcode" value="<%=mdto.getZipcode()%>">
수신 : <input type="text" name="receive" value="<%=mdto.getReceive()%>">
선호장르:<input type="text" name="preference" value="<%=mdto.getPreference()%>">

<input type="submit" value="회원정보 수정">
</form>

</fieldset>



</body>
</html>