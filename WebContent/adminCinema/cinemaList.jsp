<%@page import="com.cinema.db.CineDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/adminCinema/cinemaList.jsp</h1>
<%
	//관리자 확인

	//저장된 request값 가져오기
	List<CineDTO> cineList = (List<CineDTO>)request.getAttribute("cineList");
	
%>
<h2><a href="./CinemaAdd.ci">영화관 등록</a></h2>
<table border="1">
 <tr>
 	<td>번호</td>
 	<td>지역</td>
 	<td>지점명</td>
 	<td>주소</td>
 	<td>관 수</td>
 	<td>전화번호</td>
 	<td>사진</td>
 	<td>수정/삭제</td>
 </tr>
 <% for(int i=0;i<cineList.size();i++){
	 CineDTO cdto = cineList.get(i);
	 %>
  <tr>
 	<td><%=cdto.getLocation_num() %></td>
 	<td><%=cdto.getRegion() %></td>
 	<td><%=cdto.getName() %></td>
 	<td><%=cdto.getAddr() %></td>
 	<td><%=cdto.getRoom() %></td>
 	<td><%=cdto.getTel() %></td>
 	<td><img src="./upload/<%=cdto.getImage() %>" width="50" height="50"></td>
 	<td><a href="./CinemaModify.ci?location_num=<%=cdto.getLocation_num()%>">수정</a>
	      / 
	      <a href="./CinemaDelete.ci?location_num=<%=cdto.getLocation_num()%>">삭제</a></td>
 </tr>
	<%} %>

</table>
</body>
</html>