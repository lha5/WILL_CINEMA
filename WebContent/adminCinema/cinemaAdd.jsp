<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - (관리자 전용 - 영화관 등록)</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="./css/main.css">
</head>
<body>

<%@ include file="../include/header.jsp" %>
	<form action="./CinemaAddAction.ci" method="post" name="cinemaAddfr" onsubmit="return cinemaAddsCheck()">
		<table border="1">
			
			<tr>
				<td>지역</td>
				<td>
					<select name="region">
					 <option value="1">서울</option>
					 <option value="2">경기/인천</option>
					 <option value="3">충청/대전</option>
					 <option value="4">전라/광주</option>
					 <option value="5">경북/대구</option>
					 <option value="6">경남/부산/울산</option>
					 <option value="7">강원</option>
					 <option value="8">제주</option>
					</select>
				</td>
				<td>지점명</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>주소</td> <!-- 다음 API ? -->
				<td><input type="text" name="addr"></td>
				<td>전화번호</td>
				<td><input type="text" name="tel"></td>
			</tr>
			<tr>
				<td>상영관 수</td>
				<td><input type="text" name="room"></td>
				<td colspan="2"><input type="button" name="add_room" value="관 추가"></td>
			</tr>
			<!-- ajax -->
			
			<tbody>
			<tr>
				<td>1상영관 상영 영화</td>
				<td><input type="text" name="movie1"><input type="hidden" name="room_countnum" value=1></td>
				<td>좌석 수(행,열)</td> <!-- (A~Z),(1~9) -->
				
				<td>
				<select name="seat_line1">
				<option value="">좌석 행을 입력하시오</option>
				<option value="12">12</option>
				<option value="14">14</option>
				<option value="16">16</option>
				</select>
				,
				<select name="seat_row1">
				<option value="">좌석 열을 입력하시오</option>
				<option value="18">18</option>
				<option value="20">20</option>
				<option value="22">22</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>상영 시작시간</td>
				<td><input type="text" name="start_times1"></td>
				<td>상영 종료시간</td>
				<td><input type="text" name="end_times1"></td>
			</tr>
			<tr>
				<td>상영 시작일</td>
				<td><input type="text" name="start_priod1"></td>
				<td>상영 종료일</td>
				<td><input type="text" name="end_priod1"></td>
			</tr>
			
			</tbody>
			
			
			<tr>
				<td colspan="4">
					<input type="submit" value="지점 등록 하기">
				</td>
			</tr>
		</table>	
	</form>
	
	 
	<script>
    //상영관 번호 및 name태그에 붙일 번호 생성
    var i = $('input[name=room_countnum]').val();
    
    
    
    //추가 버튼
    $(document).ready(function(){
    $('input[name=add_room]').click(function(){
    	// 번호 상승
        i++;
    	
        if(i>8){
    		alert("8관 이상 추가 안됩니다.");
    		return;
    	}
        
    	var addRoomText =
    	'<tbody>'+  
        '<tr>'+
		'<td>'+i+'상영관 상영 영화</td>'+
		'<td><input type="text" name="movie'+i+'">'+
		'</td>'+
		'<td>좌석 수(행,열)</td>'+
		'<td>'+
		'<select name="seat_line"'+i+'>'+
		'<option value="">좌석 행을 입력하시오</option>'+
		'<option value="12">12</option>'+
		'<option value="14">14</option>'+
		'<option value="16">16</option>'+
		'</select>'+
		','+
		'<select name="seat_row"'+i+'>'+
		'<option value="">좌석 열을 입력하시오</option>'+
		'<option value="18">18</option>'+
		'<option value="20">20</option>'+
		'<option value="22">22</option>'+
		'</select>'+
		'</td>'+
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
     
    //삭제 버튼 (현재 삭제후 번호 변경이 어려워 주석처리)
    // 만약 사용시 밑의 구문을 addRoomText에 추가
    /* '<tr>'+
		'<td><input type="button" name="delRoom">'+
		'<input type="hidden" name="deletenum" value='+i+'></td>'+
	'</tr>'+ */
    
    
    /* $(document).on("click","input[name=delRoom]",function(){
         
        var trHtml = $(this).parent().parent().parent();
         
        trHtml.remove(); //tr 테그 삭제
   
        
    }); */
    
    });
    

</script>	

<%@ include file="../include/footer.jsp" %>
</body>
</html>