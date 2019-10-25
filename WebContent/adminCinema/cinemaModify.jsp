
<%@page import="com.cinema.db.CineDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - (관리자 전용 - 영화관 수정)</title>
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
	
	//지역 명칭을 코드로 변환
	//지역 분류
	//1-서울, 2-경기/인천, 3-충청/대전, 4-전라/광주, 5-경북/대구
	//6-경남/부산/울산, 7-강원, 8-제주
	if(region.equals("경기/인천")){regionCode=2;}
	else if(region.equals("충청/대전")){regionCode=3;}
	else if(region.equals("전라/광주")){regionCode=4;}
	else if(region.equals("경북/대구")){regionCode=5;}
	else if(region.equals("경남/부산/울산")){regionCode=6;}
	else if(region.equals("강원")){regionCode=7;}
	else if(region.equals("제주")){regionCode=8;}
	else{regionCode=1;}
	
	//

%>

<form action="./CinemaModifyAction.ci" method="post">
	<input type="hidden" name="cinema_num" value="<%=cdto.getCinema_num()%>">
		<table border="1">
			<tr>
				<td>지역</td>
				<td>
		<!-- //1-서울, 2-경기/인천, 3-충청/대전, 4-전라/광주, 5-경북/대구, 6-경남/부산/울산, 7-강원, 8-제주 -->
					<select name="region">
					 <option value="1" <%if(regionCode==1){%>selected<%} %>>
					  서울</option>
					 <option value="2" <%if(regionCode==2){%>selected<%} %>>
					  경기/인천</option>
					 <option value="3" <%if(regionCode==3){%>selected<%} %>>
					  충청/대전</option>
					 <option value="4" <%if(regionCode==4){%>selected<%} %>>
					  전라/광주</option>
					 <option value="5" <%if(regionCode==5){%>selected<%} %>>
					  경북/대구</option>
					 <option value="6" <%if(regionCode==6){%>selected<%} %>>
					  경남/부산/울산</option>
					 <option value="7" <%if(regionCode==7){%>selected<%} %>> 
					  강원</option>
					 <option value="8" <%if(regionCode==8){%>selected<%} %>>
					  제주</option>
					</select>
				</td>
				<td>지점명</td>
				<td><input type="text" name="name" value="<%=cdto.getName()%>"><input type="hidden" name="room_countnum" value=<%=room %>></td>
			</tr>
			<tr>
				<td>주소</td> <!-- 다음 API ? -->
				<td><input type="text" name="addr" value="<%=cdto.getAddr()%>"></td>
				<td>전화번호</td>
				<td><input type="text" name="tel" value="<%=cdto.getTel()%>"></td>
			</tr>
			<tr>
				<td>상영관 수</td>
				<td><input type="text" name="room" value="<%=cdto.getRoom() %>"></td>
				<td colspan="2"><input type="button" name="add_room" value="관 추가"></td>
			</tr>
			<!-- ajax -->
			<tbody>
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
			<tr>
				<td><%=room_num %>상영관 상영 영화</td>
				<td><input type="text" name="movie<%=room_num %>" value="<%=movie_num %>"></td>
				<td>좌석 수(행,열)</td> <!-- (A~Z),(1~9) -->
				<td><input type="text" name="seat_line<%=room_num %>" size="5" value="<%=seat.split(" ")[0] %>">
					,<input type="text" name="seat_row<%=room_num %>" size="5" value="<%=seat.split(" ")[1] %>"></td>
			</tr>
			<tr>
				<td>상영 시작시간</td>
				<td><input type="text" name="start_times<%=room_num%>" value="<%=start_times%>"></td>
				<td>상영 종료시간</td>
				<td><input type="text" name="end_times<%=room_num%>" value="<%=end_times%>"></td>
			</tr>
			<tr>
				<td>상영 시작일</td>
				<td><input type="text" name="start_priod<%=room_num%>" value="<%=start_priod%>"></td>
				<td>상영 종료일</td>
				<td><input type="text" name="end_priod<%=room_num%>" value="<%=end_priod%>"></td>
			</tr>
			<%}
			
			%>
			</tbody>
			<!-- /ajax -->
			<tr>
				<td colspan="4">
					<input type="submit" value="지점,영화 수정 및 추가 하기">
					<input type="button" value="뒤로" onclick="history.back();">
				</td>
			</tr>
		</table>	
	</form>
	
	<script>
    //상영관 번호 및 name태그에 붙일 번호 생성
    var i = $('input[name=room_countnum]').val();
    
    var room = $('input[name=room]').val();
    
    //추가 버튼
    $(document).ready(function(){
    $('input[name=add_room]').click(function(){
    	// 번호 상승
        i++;
    	
    	room++;
    	
        if(i>8){
    		alert("8관 이상 추가 안됩니다.");
    		return;
    	}
        $('input[name=room]').val(room);
        
    	var addRoomText =
    	'<tbody>'+  
        '<tr>'+
		'<td>'+i+'상영관 상영 영화</td>'+
		'<td><input type="text" name="movie'+i+'">'+
		'</td>'+
		'<td>좌석 수(행,열)</td>'+
		'<td><input type="text" name="seat_line'+i+'" size="5">,'+
		'<input type="text" name="seat_row'+i+'" size="5"></td>'+
	'</tr>'+
	'<tr>'+
		'<td>상영 시작시간</td>'+
		'<td><input type="text" name="start_times'+i+'"></td>'+
		'<td>상영 종료시간</td>'+
		'<td><input type="text" name="end_times'+i+'"></td>'+
	'</tr>'+
	'<tr>'+
		'<td>상영 시작일</td>'+
		'<td><input type="text" name="start_priod'+i+'"></td>'+
		'<td>상영 종료일</td>'+
		'<td><input type="text" name="end_priod'+i+'"></td>'+
	'</tr>'+
	
	'</tbody>'
	;
             
        var trHtml = $( "tbody:last" ); //last를 사용하여 room_addbody라는 명을 가진 마지막 태그 호출
         
        trHtml.after(addRoomText); //마지막 room_addbody명 뒤에 붙인다.
        
        
        
    });
     
    
    });
    

</script>	
	
<%@ include file="../include/footer.jsp" %>	
	
</body>

</html>