<%@page import="com.cinema.db.CineDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 영화관 지점</title>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	
	<%
	//관리자 확인

	//저장된 request값 가져오기
	List<CineDTO> cineList = (List<CineDTO>)request.getAttribute("cineList");
	
	
	%>

	<table border="1">
		<tr>
			<td colspan="7"><a href="./CinemaAdd.ci">등록</a></td>
		</tr>
 		
		
 		
	<% //리스트 갯수 
	for (int i = 0; i<cineList.size(); i++) {
		
		CineDTO cdto = cineList.get(i);
		String room = cdto.getRoom();
		int room_num = Integer.parseInt(room);
		
	%>	
		<tr>
 			<td>지점 번호</td>
 			<td>지역</td>
		 	<td>지점명</td>
		 	<td>관 수</td>
		 	<td>주소</td>
		 	<td>전화번호</td>
		 	<td>수정/삭제</td>
		 </tr>
		<tr>
			<td><%=cdto.getCinema_num() %></td>
			<td><%=cdto.getRegion() %></td>
		 	<td><%=cdto.getName() %></td>
		 	<td><%=room %></td>
		 	<td><%=cdto.getAddr() %></td>
		 	<td><%=cdto.getTel() %></td>
		 	<td colspan="9">
		 		<a href="./CinemaModify.ci?cinema_num=<%=cdto.getCinema_num() %>">관 추가 및 수정</a>
		 		/<a href="./CinemaDelete.ci?cinema_num=<%=cdto.getCinema_num() %>&room=<%=room%>">지점,관 삭제</a>
		 	</td>
		 </tr>	
		 
		 
		 <%//관 나누기
			for(int j=0;j<room_num;j++){
				int room_findnum = j+1; 
				String movie_num = cdto.getMovie_num().split(",")[j];
				String seat = cdto.getSeat().split(",")[j];
				String start_times = cdto.getStart_times().split(",")[j];
				String end_times = cdto.getEnd_times().split(",")[j];
				String start_priod = cdto.getStart_priod().split(",")[j];
				String end_priod = cdto.getEnd_priod().split(",")[j]; 
		%>
		 <tr>
		 	<td>영화번호(영화로 변경)</td>
		 	<td>관 번호</td>
		 	<td>좌석 수</td>
		 	<td>상영 시작 시간</td>
		 	<td>상영 종료 시간</td>
		 	<td>상영 시작 일</td>
		 	<td>상영 종료 일</td>
		 	
 		</tr>		
		
		 <tr>
		 	<td><%=movie_num %></td>
		 	<td><%=room_findnum %>관</td>
		 	<td><%=seat %>좌석</td>
		 	<td><%=start_times %></td>
		 	<td><%=end_times %></td>
		 	<td><%=start_priod %></td>
		 	<td><%=end_priod %></td>
		 	
		</tr>
	<%} %>
		<tr>
			<td colspan="7">-----------------------------------------
			---------------------------------------------------------
			</td>
		</tr>
	<%
	}
	%>

	</table>

	<%@ include file="../include/footer.jsp" %>
	
</body>
</html>