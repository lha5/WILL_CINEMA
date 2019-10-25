<%@page import="com.cinema.db.CineDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - (관리자 전용 - 영화관 삭제)</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

</head>
<body>

<%@ include file="../include/header.jsp" %>
<%

	//request 정보 저장
	CineDTO cdto = (CineDTO)request.getAttribute("cdto");
	int room = Integer.parseInt(cdto.getRoom());

	String region = cdto.getRegion();
	int regionCode = 0;
	
	

%>

<form action="./CinemaDeleteAction.ci" name="cine_del_fr" method="post">
	<input type="hidden" name="cinema_num" value="<%=cdto.getCinema_num()%>">
	<input type="hidden" name="check_del" value="0">
		<table border="1">
			<tr>
				<td>지역</td>
				<td>
		<!-- //1-서울, 2-경기/인천, 3-충청/대전, 4-전라/광주, 5-경북/대구, 6-경남/부산/울산, 7-강원, 8-제주 -->
					<input type="text" name="region" value="<%=region %>" readonly>
				</td>
				<td>지점명</td>
				<td><input type="text" name="name" value="<%=cdto.getName()%>" readonly></td>
			</tr>
			<tr>
				<td>주소</td> <!-- 다음 API ? -->
				<td><input type="text" name="addr" value="<%=cdto.getAddr()%>" readonly></td>
				<td>전화번호</td>
				<td><input type="text" name="tel" value="<%=cdto.getTel()%>" readonly></td>
			</tr>
			<tr>
				<td>상영관 수</td>
				<td><input type="text" name="room" value="<%=cdto.getRoom() %>" readonly>
					<input type="hidden" name="before_room" value="<%=cdto.getRoom() %>">
				</td>
				<td><input type="button" name="del_cinema" value="<%=cdto.getName() %> 삭제"></td>
				
			</tr>
			<!-- ajax -->
			
			<% 
			
				for(int i=0;i<room;i++){
				int room_num = i+1;
				String movie_num = cdto.getMovie_num().split(",")[i];
				String seat = cdto.getSeat().split(",")[i];
				String start_times = cdto.getStart_times().split(",")[i];
				String end_times = cdto.getEnd_times().split(",")[i];
				String start_priod = cdto.getStart_priod().split(",")[i];
				String end_priod = cdto.getEnd_priod().split(",")[i]; 
			%>
			<tbody>
			<tr>
				<td><%=room_num %>상영관 상영 영화</td>
				<td><input type="text" name="movie<%=room_num %>" value="<%=movie_num %>" readonly>
					<input type="hidden" name="del_room_num" value="<%=room_num%>">
				</td>
				<td>좌석 수(행,열)</td> <!-- (A~Z),(1~9) -->
				<td><input type="text" name="seat_line<%=room_num %>" size="5" value="<%=seat.split(" ")[0] %>" readonly>
					,<input type="text" name="seat_row<%=room_num %>" size="5" value="<%=seat.split(" ")[1] %>" readonly></td>
			</tr>
			<tr>
				<td>상영 시작시간</td>
				<td><input type="text" name="start_times<%=room_num%>" value="<%=start_times%>" readonly></td>
				<td>상영 종료시간</td>
				<td><input type="text" name="end_times<%=room_num%>" value="<%=end_times%>" readonly></td>
			</tr>
			<tr>
				<td>상영 시작일</td>
				<td><input type="text" name="start_priod<%=room_num%>" value="<%=start_priod%>" readonly></td>
				<td>상영 종료일</td>
				<td><input type="text" name="end_priod<%=room_num%>" value="<%=end_priod%>" readonly></td>
			</tr>
			<tr>
				<td><input type="button" name="delRoom" value="<%=room_num%>상영관 삭제"></td>
			</tr>
			</tbody>
			<%}
			
			%>
			
			<!-- /ajax -->
			<tr>
				<td colspan="4">
					<input type="button" name="del_someroom"  value="상영관 삭제 적용">
					<input type="button" value="뒤로" onclick="history.back();">
				</td>
			</tr>
		</table>	
	</form>

<script>
    
	var del_room_num = "";
  	var del_count = 0;
	var room = $('input[name=room]').val();
	
    $(document).ready(function(){
    	
    //지점 삭제 버튼 
    //지점 삭제 코드는 0
    //상영관 삭제 코드는 1
    $('input[name=del_cinema]').click(function(){
    	$('input[name=check_del]').val('0');
    	
    	var del_check = confirm("시네마 지점이 삭제 됩니다.");
    	
    	if(del_check){
    		$('form[name=cine_del_fr]').submit();
    	}else{
    		location.replace('./CinemaAdminDetail.ci');
    	}
    	
    });	
    
   
    //상영관 삭제 버튼
    //del_room_num : 삭제된 상영관 번호
    $('input[name=delRoom]').click(function(){
    	room--;
    	$('input[name=room]').val(room);
    	
    	/* if(room>del_count){
    		del_room_num += $('input[name=del_room_num]').val()+",";
    	}else if(room=del_count){
    		del_room_num += $('input[name=del_room_num]').val();
    	} */
    	
    	//alert($('input[name=del_room_num]').val());
    	//alert(room);
    	
        var trHtml = $(this).parent().parent().parent();
         
        trHtml.remove(); //tr 테그 삭제
   
        
    });
    
  	//상영관 삭제 적용 버튼
  	//지점 삭제 코드는 0
    //상영관 삭제 코드는 1
    $('input[name=del_someroom]').click(function(){
    	$('input[name=check_del]').val('1');
    	
    	$('form[name=cine_del_fr]').submit();
    	
    	
    });	
    
  });
</script>
<%@ include file="../include/footer.jsp" %>
</body>
</html>