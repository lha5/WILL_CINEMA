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

<script type="text/javascript">
	$(function(){
		var row= $('#row').val();
		var col= $('#col').val();
		
		alert("행: "+row + ", 열: "+col);
		
		/*--------------- 처음 실행될것들 ----------------*/
		//인원수
		var pNum=$('select[name=adult]').val()*1+
		$('select[name=teenager]').val()*1+$('select[name=senior]').val()*1;
		
		//좌석 붙임 설정
		$('input[type=radio]').prop('disabled', true);
		
		
		/*--------------- 처음 실행될것들 ----------------*/
		
		//인원 선택
		$('select').bind('change', function(){
			pNum=$('select[name=adult]').val()*1+
			$('select[name=teenager]').val()*1+$('select[name=senior]').val()*1;
			$('#one').prop('disabled', false);
			$('#one').prop('checked', true);
			alert("선택된 좌석"+pNum);
			if(pNum==1){//1명
				//마우스 이동시
				$('input[type=button]').bind('mouseover', function(){
					$(this).css('background-color', 'black');
				}).bind('mouseleave', function(){
					$(this).css('background-color', '#848484');
				});
			}else{
				$('input[type=button]').unbind('mouseover').unbind('mouseleave');
			}
		});
		
		//버튼 클릭
		$('input[type=button]').bind('click', function(){
			if(pNum==0){
				alert("인원을 선택하세요");
			}else if(pNum==1){//1명
				alert('클릭');
				//클래스의 속성을 변경으로 바꾸기
				$(this).css('background-color', 'black');
			}
		});
		
		//인원이 1명일때 버튼 변경
		/* if(pNum==1){
			
		} */
		
		
		
		
		
	});



</script>
</head>
<body>
<h1>WebContent/ticketing/seat-tiketing.jsp</h1>
<%
	//세션 처리
	//회원 확인


	AdminMovieDTO mdto = (AdminMovieDTO)request.getAttribute("mdto"); //선택한 영화 정보

	CineDTO cdto = (CineDTO)request.getAttribute("cdto"); //선택한 영화관 정보
	String running_date = (String)request.getAttribute("running_date");//상영일
	String running_time = (String)request.getAttribute("running_time");//상영시간

	String saleTime = (String)request.getAttribute("saleTime"); //조조,심야
	int roomNum = (Integer)request.getAttribute("roomNum"); //상영관 번호
	
	String seat = cdto.getSeat().split(",")[roomNum-1]; //좌석
	//Integer row = Integer.parseInt(seat.split(" ")[0]); //행
	//Integer col = Integer.parseInt(seat.split(" ")[1]); //열
	int row=14;
	int col=18;
	
	System.out.println("좌석 행 :"+row+", 좌석 열 :"+col);

%>


<fieldset>
	<legend>좌석 선택</legend>
	<!-- form action -->
	<form action="SeatSelectAction.ti" method="post">
	<input type="hidden" id="row" value=<%=row %>>
	<input type="hidden" id="col" value=<%=col %>>
	성인 : <select name="adult">
			<option value="0" selected="selected">0</option>
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
			<option value="0" selected="selected">0</option>
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
			<option value="0" selected="selected">0</option>
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
	좌석 붙임 설정 <input type="radio" id="one" name="seating" value="1">1자리
				<input type="radio" id="two" name="seating" value="2">2자리
				<input type="radio" id="three" name="seating" value="4">4자리
	<hr>
	
	<!-- 좌석선택 -->
	<!--
	 cinema에 받아둔 좌석의 행,열을 이용해
	 for문으로 배열해 둠
	 후에 수정하실분은 유의할 것
	 -->
	 
	 <table class="seatTable">
	 <tr>
	 		<!-- 열 번호 -->
	 		<!-- 좌석열에 대등해서 아스키코드 A=65값 부터 늘려서 뿌려줌 -->

		<td><!-- 좌석 배치 칸 -->
		<!-- 아스키코드 초기화후 i증가에 따라 증가 -->
	<%
	Character alpChar = 65;
	for(int i=1;i<=row;i++){
		String alpStr = String.valueOf(alpChar); 
			for(int j=0;j<=col;j++){
				if(j==0){//행 알파벳 보여줌
	%>			
				<input class="seatbg" type="button" name="seat<%=alpStr %>" value="<%=alpStr %>" disabled="disabled">
	<%	
				}else{
					//행:12 열:18 좌우 3개
					if(col==18){
						if(j<=3){
						%>
						<input class="seat grNum<%=j %>" type="button" name="seat<%=i %><%=j %>" value="<%=j %>">
						<%
						}else if(j>=15){
						%>
						<input class="seat grNum<%=j %>" type="button" name="seat<%=i %><%=j %>" value="<%=j %>">
						<%
						}else{
						%>
						<input class="seat grNum<%=j %>" type="button" name="seat<%=i %><%=j %>" value="<%=j %>">
						<%	
						}
					}else if(col==20){//행:14 열:20 좌우 4개
						if(j<=4){
						%>
						<input class="seat grNum<%=j %>" type="button" name="seat<%=i %><%=j %>" value="<%=j %>">
						<%
						}else if(j>=17){
						%>
						<input class="seat grNum<%=j %>" type="button" name="seat<%=i %><%=j %>" value="<%=j %>">
						<%
						}else{
						%>
						<input class="seat grNum<%=j %>" type="button" name="seat<%=i %><%=j %>" value="<%=j %>">
						<%
						}	
					}else if(col==22){//행:16 열:22 좌우 5개
						if(j<=5){
						%>
						<input class="grNum<%=j %>" type="button" name="seat<%=i %><%=j %>" value="<%=j %>">
						<%
						}else if(j>=18){
						%>
						<input class="seat grNum<%=j %>" type="button" name="seat<%=i %><%=j %>" value="<%=j %>">
						<%
						}else{
						%>
						<input class="seat grNum<%=j %>" type="button" name="seat<%=i %><%=j %>" value="<%=j %>">
						<%
						}	
					}
	
				}
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
				<%-- <img src="/upload/<%=mdto.getPoster() %>"> --%>
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