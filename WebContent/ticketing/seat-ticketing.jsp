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
	MovieDTO mdto = (MovieDTO)request.getAttribute("mdto");
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
				<input type="radio" name="seating" value="3">3자리
				<input type="radio" name="seating" value="4">4자리
	<hr>
	
	<!-- 좌석선택 -->
	<!--
	 cinema에 받아둔 좌석의 행,열을 이용해
	 for문으로 배열해 둠
	 후에 수정하실분은 유의할 것
	 -->
	 <table>
	 <tr>
	 	<td>
	 	</td>
	 	<td>
	 		<!-- 행 번호 -->
	 		<% for(int j=1;j<=seat_line;j++){%>
	 			<a><%=j %></a>
	 		<%} %>
	 	</td>
	 </tr>
	 <tr>
	 	<td>
	 		<!-- 열 번호 -->
	 		<!-- 좌석열에 대등해서 아스키코드 A=65값 부터 늘려서 뿌려줌 -->
	 		<% 
	 			Character alpChar = 65;
	 		for(int i=1;i<=seat_row;i++){
	 			String alpStr = String.valueOf(alpChar); 
	 		%>
	 			<a><%=alpStr %></a><br>
	 		<% alpChar++;
	 			} 
	 		%>
	 	</td>
		<td><!-- 좌석 배치 칸 -->
		<!-- 아스키코드 초기화후 i증가에 따라 증가 -->
	<%
		alpChar=65;
	for(int i=1;i<=seat_row;i++){
		String alpStr = String.valueOf(alpChar); 
			for(int j=1;j<=seat_line;j++){
				if(j==seat_line){ 	
	%>
		<!-- 버튼으로 해두었으나 나중에 태그변경 할 수도 있음 
			태그 변경시 jquery에서 받는 값도 수정 필요 
		-->
		 <input class="seat_on" type="button" name="seat<%=alpStr %><%=j %>" value="<%=alpStr %><%=j %>">
		  <%-- <%=alpStr %><%=j %>
		 </button> --%><br>
		<%}else{ %>
		 <input class="seat_on" type="button" name="seat<%=alpStr %><%=j %>" value="<%=alpStr %><%=j %>">
		  <%-- <%=alpStr %><%=j %>
		 </a> --%>
	<%}
	}
			alpChar++;} %>
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

				상영관 <input type="text" name="room_num" value="<%=roomNum %>" readonly> //roomNum 변경했습니다
					 <input type="hidden" name="cinema_num" value="<%=cdto.getCinema_num() %>">
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




<!-- 스크립트 -->
	<script>			
			
	
	
	
	
	//인원 수 선택
		var seat_count = 0;//선택한 인원 총수
		$('input[name=seating]').attr('disabled',true);
		/* 후에 header나 footer의 영향으로 select가 다중이 될 경우 변경하면 됨 */
		$('select').change(function(){
			
			var adult_count = $("select[name=adult] option:selected").val();
			var teenager_count = $("select[name=teenager] option:selected").val();
			var senior_count = $("select[name=senior] option:selected").val();
			//alert(adult_count+","+teenager_count+","+senior_count);
			seat_count = parseInt(adult_count) + parseInt(teenager_count) + parseInt(senior_count);
			//alert(seat_count+","+adult_count+","+teenager_count+","+senior_count);
			if(seat_count>8){	//8좌석 이상 선택시 선택한 값0으로 만들고 경고창
				//alert(seat_count);
				alert("최대 8좌석 예약만 가능합니다.");
				$(this).val("0").prop("selected",true);
				
			}
			
			//인원수 선택을 바꿨을 경우 좌석 초기화
			$('input[name=seat]').val("");
			$('.seat_off').attr('class','seat_on');
			clicked_seat="";
			
			if(seat_count==0){
				$('input[name=seating]').attr('disabled',true);
			}else{
				$('input[name=seating]').attr('disabled',false);
			}
			
			
			
		});//
		
		
		
		
		
	//좌석 붙임 - 구현 x
		var seating_num=0;
		$('input[name=seating]').click(function () {
			var seating_num = $(this).val();
			//alert(seating_num);	
		});
		
		
	//좌석 선택
	//	
		$('.seat_on').click(function(){
			//중복 선택을 막기위한 클래스 이름 가져오기
			var class_name = $(this).attr('class');
			//alert(class_name);
			//alert(class_name=='seat_on');
			//alert(class_name=="seat_on");
			
			
			//중복 선택을 막기위해 클래스 명이 'seat_on' 일때 만 작동
			if(class_name=="seat_on"){	
			//alert("seat_on 작동");
			
			//인원수 선택하지 않았을때 좌석선택을 막음
			if(seat_count==0){
				seat_clicked_count=0;
				return false;
			}
			//좌석붙임 선택이 없을시 좌석번호 선택 막음 - 현재 구현x
			
			//선택한 좌석을 담아둔 input값 가져오기 
			var seat_num_total = $('input[name=seat]').val();
			//누른 좌석 번호값
			var clicked_seat = $(this).val();
			var clicked_seat_total = "";
			
			//좌석 선택 가능 횟수
			//등록된 좌석 수가 입력된 총 인원수 초과 되었을시 입력 작동 중지
			var selected_num = seat_num_total.split(" ");
			if(selected_num.length>seat_count){
				alert("인원수 초과");
				return false;
			}
			
			/*       좌석추가           */
			
			//선택한 좌석이 없을때 선택한 좌석 추가
			
			// 좌석추가
			seat_num_total += clicked_seat+" ";
			$('input[name=seat]').val(seat_num_total);
			
			/*      /좌석추가         */
			
			//좌석번호 등록 후 등록한 버튼으로 변경 
			//클래스 명 seat_off으로 변경
			$(this).attr('class','seat_off');
			
			}//seat_on
			
			
			//선택한 버튼 다시 누를때 좌석선택 취소
			else if(class_name=='seat_off'){
				
				/* 값 초기화 및 가져오기 */
				
				//선택한 좌석을 담아둔 input값 가져오기 
				var seat_num_total = $('input[name=seat]').val();
				//alert("지금 선택된 좌석번호"+seat_num_total);
				
				var seat_num_change = seat_num_total.split(" ");
				//alert("split으로 나눈 번호 :"+seat_num_change);
				
				//선택한 버튼의 좌석번호
				var seat_num_this = $(this).val();
				//alert("누른 좌석번호"+seat_num_this);
				
				//split으로 나눈 값을 비교할 변수 생성
				seat_num_name_change = "";
				//비교처리 후 선택한 좌석을 담을 변수
				var seat_num_name_change_total = "";
				
				/* 값 초기화 및 가져오기 */
				
				//split으로 나눠 값을 비교해 같은 좌석번호를 삭제
				for(var i=0;i<seat_count;i++){
					seat_num_change = seat_num_total.split(" ")[i];
					//클릭한 좌석번호의 값과 저장되어있던 버튼 값이 같은지 비교
					if(seat_num_this==seat_num_change || seat_num_change==null){
						//seat_num_name_change_total += "";
						continue;
					}else{
						seat_num_name_change_total += seat_num_change+" ";
						//alert("비교후 모든 좌석번호 : "+seat_num_name_change_total);
					}
					seat_num_name_change_total.substring
						(0, seat_num_name_change_total.length-1);
					
				}//for
				
				//alert("비교후 모든 좌석번호 : "+seat_num_name_change_total);
				
				//비교 처리 후 좌석번호 등록 
				$('input[name=seat]').val(seat_num_name_change_total);
				
				//가격 초기화
				
				//등록된 좌석번호 삭제 후 등록되지 않은 버튼으로 변경 
				//클래스 명 seat_on으로 변경
				$(this).attr('class','seat_on');
				
			}//seat_off
			
		});//좌석 선택 동작
		
		
		
		
	
	

	</script>

</body>
</html>