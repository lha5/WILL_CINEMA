<%@page import="com.member.db.MemberDAOImpl"%>
<%@page import="com.member.db.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>메인페이지</h1>
<%

String id=(String)session.getAttribute("id");
if(id==null){
	response.sendRedirect("./MemberLogin.me");
}

%>
<!--css 만들때 로그인 로그아웃 버튼 만들기  
표현식 - =id 님이 로그안하셨습니다.
  -->

<input type="button" value="로그아웃" 
onclick="location.href='./MemberLogout.me'">

<!-- css 수정할때 조정하기  -->
<hr>
<a href="./MemberInfo.me">회원 정보 조회</a> 
<hr>
<a href="./MemberUpdate.me">회원 정보 수정</a>
<hr>
<a href="./MemberDelete.me">회원 정보 삭제</a>
<hr>

<!-- 관리자전용 -->

<%
if(id != null){
	if(id.equals("admin")){
	
		%>
		<a href="./MemberList.me">회원 목록 관리(관리자 전용)</a>
		<%	
	}
}

%>


</body>
</html>