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
			<td colspan="9"><a href="./CinemaAdd.ci">등록</a></td>
		</tr>
 		<tr>
 			<td>번호</td>
 			<td>지역</td>
		 	<td>지점명</td>
		 	<td>관 수</td>
		 	<td>주소</td>
		 	<td>전화번호</td>
		 	<td>영화번호(영화로 변경)</td>
		 	<td>관 번호</td>
		 	<td>좌석 수</td>
		 	<td>상영 시작 시간</td>
		 	<td>상영 종료 시간</td>
		 	<td>상영 시작 일</td>
		 	<td>상영 종료 일</td>
		 	<td>수정/삭제</td>
 		</tr>
	<% for (int i = 0; i < cineList.size(); i++) {
		
		CineDTO cdto = cineList.get(i);
		String room = cdto.getRoom();
		int room_num = Integer.parseInt(room);
		
	%>
		<tr>
			<td><%=cdto.getCinema_num() %>번호</td>
			<td><%=cdto.getRegion() %>지역</td>
		 	<td><%=cdto.getName() %>이름</td>
		 	<td><%=room %>관</td>
		 	<td><%=cdto.getAddr() %>주소</td>
		 	<td><%=cdto.getTel() %>전화</td>
		 	<td>영화번호</td>
		 	<td>관 번호</td>
		 	<td>좌석</td>
		 	<td>상영 시작 시간</td>
		 	<td>상영 종료 시간</td>
		 	<td>상영 시작 일</td>
		 	<td>상영 종료 일</td>
		 	<td><a href="./CinemaModify.ci?location_num=<%=cdto.getCinema_num() %>">수정</a>
		 		/<a href="./CinemaDelete.ci?location_num=<%=cdto.getCinema_num() %>">삭제</a>
		 	</td>
		</tr>
	<%
	}
	%>

	</table>

	<%@ include file="../include/footer.jsp" %>
	
</body>
</html>