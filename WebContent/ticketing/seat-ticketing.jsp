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
	
	String seat = cdto.getSeat().split(",")[0];
	Integer seat_row = Integer.parseInt(seat.split(" ")[0]);
	Integer seat_line = Integer.parseInt(seat.split(" ")[1]);
	
	System.out.println("좌석 행 :"+seat_row+", 좌석 열 :"+seat_line);
%>


<fieldset>
	<legend>좌석 선택</legend>
	<!--  -->
	<form action="" method="post">
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
		 <input class="seat" type="button" name="seat<%=alpStr %><%=j %>" value="<%=alpStr %><%=j %>">
		  <%-- <%=alpStr %><%=j %>
		 </button> --%><br>
		<%}else{ %>
		 <input class="seat" type="button" name="seat<%=alpStr %><%=j %>" value="<%=alpStr %><%=j %>">
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
	
	<!-- 테이블 형식은 후에 css중 변경 가능 -->
	<table border="1">
		<tr>
			<td>
				영화<br>
				<img src="/upload/<%=mdto.getPoster() %>">
				<%=mdto.getTitle() %>
				
			</td>
			<td>
				예매정보<br>
				상영일 <input type="text" name="running_date" value="<%=running_date %>" readonly><br>
				상영시간 <input type="text" name="running_time" value="<%=running_time %>" readonly><br>
				<!-- 상영관의 경우 데이터 값 가져와서  -->
				상영관 <input type="text" value="<%=cdto.getRoom() %>"><br>
				좌석 <input type="text" name="seat" ><br>
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
			
	//좌석 수 선택
		var seat_count = 0;
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
		var clicked_seat = "";//
		$('.seat').on("click",function(){
			if(seat_count==0){//인원수 선택하지 않았을때 좌석선택을 막음
				return false;
			}
			
			var seat_num = $('input[name=seat]').val(); //선택한 좌석을 보여주는 input값 가져오기
			
			if(seat_num==null){//선택한 좌석이 없을때 선택한 좌석 추가
				clicked_seat += $(this).val()+" ";
				$('input[name=seat]').val(clicked_seat);
			}
			
			for(var i=0;i<=seat_count;i++){
				
			}
			
			
			clicked_seat += $(this).val()+" ";
			//alert(clicked_seat);
			$('input[name=seat]').val(clicked_seat);

		});
	
	//데이터 전송
	

	</script>

</body>
</html>