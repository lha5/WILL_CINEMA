<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@page import="com.movie.db.MovieDTO"%>
<%@page import="com.cinema.db.CineDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="./css/seat-ticketing.css">
</head>
<body>
<h1>WebContent/ticketing/seat-tiketing.jsp</h1>
<%
	//세션 처리
	//회원 확인


	//데이터 저장
	//*후에 합칠때 변경 필요
	/* request.setAttribute("mdto", mdto);
		request.setAttribute("cdto", cdto);
		request.setAttribute("running_date", running_date);
		request.setAttribute("running_time", running_time); */
	AdminMovieDTO mdto = (AdminMovieDTO)request.getAttribute("mdto");

	CineDTO cdto = (CineDTO)request.getAttribute("cdto");
	String running_date = (String)request.getAttribute("running_date");
	String running_time = (String)request.getAttribute("running_time");
	String saleTime = (String)request.getAttribute("saleTime"); //조조,심야
	int roomNum = (Integer)request.getAttribute("roomNum"); //상영관 번호
	
	String seat = cdto.getSeat().split(",")[0];
	Integer seat_row = Integer.parseInt(seat.split(" ")[0]);
	Integer seat_line = Integer.parseInt(seat.split(" ")[1]);
	
	System.out.println("좌석 행 :"+seat_row+", 좌석 열 :"+seat_line);

%>


<fieldset>
	<legend>좌석 선택</legend>
	<!-- form action -->
	<form action="SeatSelectAction.ti" method="post">
	성인 : <select name="adult">
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
		</select>

	청소년 : <select name="teenager">
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
		</select>
		
	시니어 : <select name="senior">
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
		</select>
		
	최대 8자리
	<hr>	
	<!-- 시간 부족시 삭제? -->
	좌석 붙임 설정 <input type="radio" name="seating" value="1">1자리
				<input type="radio" name="seating" value="2">2자리
				<input type="radio" name="seating" value="4">4자리
	<hr>
	
	<!-- 좌석선택 -->
	<!--
	 cinema에 받아둔 좌석의 행,열을 이용해
	 for문으로 배열해 둠
	 후에 수정하실분은 유의할 것
	 -->
	 
	 <table class="seat">
	 <tr>
	 		<!-- 열 번호 -->
	 		<!-- 좌석열에 대등해서 아스키코드 A=65값 부터 늘려서 뿌려줌 -->

		<td><!-- 좌석 배치 칸 -->
		<!-- 아스키코드 초기화후 i증가에 따라 증가 -->
	<%
	Character alpChar = 65;
	for(int i=1;i<=seat_row;i++){
		String alpStr = String.valueOf(alpChar); 
			for(int j=0;j<=seat_line;j++){
				if(j==0){
	%>			
				<input class="seatbg" type="button" name="seat<%=alpStr %>" value="<%=alpStr %>" disabled="disabled">
	<%	
				}else{
	%>
				<input class="seat_on" type="button" name="seat<%=alpStr %><%=j %>" value="<%=j %>">
	<%			}
			}%>
	<br>
	<%
		alpChar++;
	} %>
			</td>
		</tr>
	</table>
	
	
	<!-- /좌석선택 -->
	<hr>
	<input type="submit" value="결제하기">
	<hr>
	
	<!-- 예약 정보 -->
	<!-- 테이블 형식은 후에 css중 변경 가능 -->
	<table border="1">
		<tr>
			<td>
				영화<br>
				<img src="/upload/<%=mdto.getPoster() %>">
				<input type="text" name="movie_title" value="<%=mdto.getTitle() %>">
				<input type="hidden" name="movie_num" value="<%=mdto.getTitle() %>">
				
			</td>
			<td>
				예매정보<br>
				상영일 <input type="text" name="running_date" value="<%=running_date %>" readonly><br>
				상영시간 <input type="text" name="running_time" value="<%=running_time %>" readonly><br>
				<!-- 상영관의 경우 데이터 값 가져와서  -->

				상영관 <input type="text" name="room_num" value="<%=roomNum %>" readonly>
					 <input type="hidden" name="cinema_num" value="<%=cdto.getCinema_num() %>"  readonly>
				<br>
				좌석 <input type="text" name="seat"><br>
			</td>
			<td>
				총 결제 금액
				<!-- 좌석 선택후 가격 결정  -->
				영화예매 \<input type="text" name="price" value="0">
						
			</td>
		</tr>
	</table>
	
	</form>
</fieldset>

</body>
</html>