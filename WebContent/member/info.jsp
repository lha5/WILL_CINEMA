<%@page import="com.member.db.MemberDTO"%>
<%@page import="com.member.db.MemberDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 회원 목록</title>
</head>
<body>
<h1>멤버 정보 보기 CSS 해야 합니다 </h1>
<%

String id = (String)session.getAttribute("id");  

if(id == null){
	response.sendRedirect("./MemberLogin.me");
	
}
MemberDTO mdto=(MemberDTO)request.getAttribute("mdto"); 

%>

<table border="1">
<tr>
<td>아이디</td>
<td>패스워드</td>
<td>이름</td>
<td>생일</td>
<td>모바일</td>
</tr>


<tr>
<td><%=mdto.getId() %></td>
<td><%=mdto.getPass() %></td>
<td><%=mdto.getName() %></td>
<td><%=mdto.getBirthday() %></td>
<td><%=mdto.getMobile() %></td>
</tr>

<tr>
<td>이메일</td>
<td>우편번호</td>
<td>주소</td>
<td>상세주소</td>
<td>포인트</td>
</tr>

<tr>
<td><%=mdto.getEmail() %></td>
<td><%=mdto.getZipcode() %></td>
<td><%=mdto.getAddr() %></td>
<td><%=mdto.getDetailaddr() %></td>
<td><%=mdto.getPoint() %></td>
</tr>

<tr>
<td>회원등급</td>
<td>수신</td>
<td>선호장르</td>
<td colspan="2">회원가입날짜</td>

</tr>

<tr>
<td><%=mdto.getLevel() %></td>
<td><%=mdto.getReceive() %></td>
<td><%=mdto.getPreference() %></td>
<td colspan="2"><%=mdto.getReg_date() %></td>
</tr>

</table>


<h2><a href="./Main.me">메인으로 이동</a></h2>





</body>
</html>