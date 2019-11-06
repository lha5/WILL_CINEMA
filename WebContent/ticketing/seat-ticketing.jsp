<%@page import="java.util.List"%>
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
		var regexp = /\B(?=(\d{3})+(?!\d))/g; //정규식
		var selectSeat='';
		var row= $('#row').val();//총 행 개수
		var col= $('#col').val();//총 열 개수
		var price=0;
		var person_num='';
		var seatRow=new Array();
		var seatCol=new Array();
		if($('input[name=seatRow]').length!=0){
			seatRow=new Array($('input[name=seatRow]').length);
			seatCol=new Array($('input[name=seatCol]').length);
		}
		/*--------------- 처음 실행될것들 ----------------*/
		//예약좌석 비활성
		if($('input[name=seatRow]').length!=0){
			for(var i=0; i<$('input[name=seatRow]').length; i++){
				seatRow[i]=$('input[name=seatRow]')[i].value;
				seatCol[i]=$('input[name=seatCol]')[i].value;
				console.log(seatRow[i]+" "+seatCol[i]);
				$('.seatTable').find('input[name=seat'+seatRow[i]+seatCol[i]+']').addClass('reserve');
			}
		}
		//인원수
		var pNum=$('select[name=adult]').val()*1+
		$('select[name=teenager]').val()*1+$('select[name=senior]').val()*1;
		
		//좌석 붙임 설정
		$('input[type=radio]').prop('disabled', true);
		
		
		/*--------------- 처음 실행될것들 ----------------*/
		
		//인원 선택
		$('select').bind('change', function(){
			//좌석 초기화
			$('input[name=seat]').val("");
			pNum=$('select[name=adult]').val()*1+
			$('select[name=teenager]').val()*1+$('select[name=senior]').val()*1;
			$('input[name=price]').val("");//가격초기화
			
			//셀렉트를 변경하면 초기화
			$('.seatTable').find('input[type=button].disabled').removeClass('disabled');
			$('.seatTable').find('input[type=button].on').removeClass('on');
			alert("선택된 좌석"+pNum);
			
			//좌석개수
			var seatlen=$('.seatTable').find('.seat').length-1;
			var grSize=$('.seatTable').find('.seat').eq(seatlen).attr('class');
			grSize=grSize.split(' ')[1];
			//전체 그룹 개수
			grSize=grSize.substr(5);
			
			if(pNum==1){//1명
				$('#one').prop('disabled', false);
				$('#one').prop('checked', true);
				//마우스 이동시
				$('input[type=button]').bind('mouseover', function(){
					$(this).addClass("over");
				}).bind('mouseleave', function(){
					$(this).removeClass("over");
				});
				
				/*---------함수로 변경---------  */
				
				//1명 선택시
				for(var i=1; i<=Number(grSize); i++){
					var grSeLen=$('.seatTable').find('.grNum'+i+'[class*=on]').length;
					var grRemain=$('.seatTable').find('.grNum'+i).length-grSeLen;
					//남은자리가 2자리일 때
					if(grRemain==2){//선택 못하게 막음
						$('.seatTable').find('.grNum'+i).not('.on').each(function(){
							if(!$(this).hasClass('reserve')){
								$(this).addClass('disabled');
							}
						});
					}else if(grRemain>2){//2자리 이상일때
						//그룹의 두번째좌석 비활성
						$('.seatTable').find('.grNum'+i).eq(1).not('.on').each(function(){
							if(!$(this).hasClass('reserve')){
								$(this).addClass('disabled');
							}
						});
						//그룹의 마지막의 다음좌석 비활성
						$('.seatTable').find('.grNum'+i).eq(grRemain-2).not('.on').each(function(){
							if(!$(this).hasClass('reserve')){
								$(this).addClass('disabled');
							}
						});
					}
				}
				
			}else if(pNum==2){//2명 선택시(남은 인원2명)
				$('#one').prop('disabled', true);
				$('#four').prop('disabled', true);
				$('#two').prop('disabled', false);
				$('#two').prop('checked', true);
				
				
				
				//1명 선택시
				for(var i=1; i<=Number(grSize); i++){
					var grSeLen=$('.seatTable').find('.grNum'+i+'[class*=on]').length;
					var grRemain=$('.seatTable').find('.grNum'+i).length-grSeLen;

					//남은자리가 2자리일 때
					if(grRemain==2){//선택 못하게 막음
						$('.seatTable').find('.grNum'+i).not('.on').each(function(){
							if(!$(this).hasClass('reserve')){
								$(this).addClass('disabled');
							}
						});
					}else if(grRemain>2){//2자리 이상일때
						//그룹의 두번째좌석 비활성
						$('.seatTable').find('.grNum'+i).eq(1).not('.on').each(function(){
							if(!$(this).hasClass('reserve')){
								$(this).addClass('disabled');
							}
						});
						//그룹의 마지막의 다음좌석 비활성
						$('.seatTable').find('.grNum'+i).eq(grRemain-2).not('.on').each(function(){
							if(!$(this).hasClass('reserve')){
								$(this).addClass('disabled');
							}
						});
					}
				}
				
			}else if(pNum==3){
				
			}else if(pNum==4){
				
			}else if(pNum==5){
				
			}else if(pNum==6){
				
			}else if(pNum==7){
				
			}else if(pNum==8){
				
			}else{
				alert("최대 인원수는 8명입니다.");
				pNum=$('select[name=adult]').val(0)+$('select[name=teenager]').val(0)+$('select[name=senior]').val(0);
				//$('input[type=button]').unbind('mouseover').unbind('mouseleave');
				
			}
		});
		
		//버튼 클릭
		$('input[type=button]').bind('click', function(){
			alert(pNum);
			if(pNum==0){
				alert("인원을 선택하세요");
			}else if(pNum==1){//1명
				alert('클릭');
				//클릭했을때 
				if($(this).hasClass("on")){//이미 클릭된 상태면
					$(this).removeClass("on");
					$(this).siblings('input[type=button]').not($(this)).removeClass('disabled');
				}else{//클릭되지 않은 상태
					$(this).removeClass("over");
					$(this).addClass("on");
					$(this).siblings('input[type=button]').not($(this)).addClass('disabled');
					selectSeat=$(this).attr('name');
					selectSeat=selectSeat.substr(4);
					alert(selectSeat);
					$('input[name=seat]').val(selectSeat);//좌석에 적기
					//가격 설정   조조:7000, 6000,5000
					/* price=$('select[name=adult]').val()*10000+
						$('select[name=teenager]').val()*8000+$('select[name=senior]').val()*5000
					$('input[name=price]').val(price.toString().replace(regexp,','));
					 */
					
					
				}

			}else if(pNum==2){
				//클릭했을때 
				if($(this).hasClass("on")){//이미 클릭된 상태면
					$(this).removeClass("on");
					$(this).siblings('input[type=button]').not($(this)).removeClass('disabled');
				}else{//클릭되지 않은 상태
					$(this).removeClass("over");
					$(this).addClass("on");
					$(this).siblings('input[type=button]').not($(this)).addClass('disabled');
				}
			}else if(pNum==3){
				
			}else if(pNum==4){
				
			}else if(pNum==5){
				
			}else if(pNum==6){
				
			}else if(pNum==7){
				
			}else if(pNum==8){
				
			}else{
				
			}
			person_num="";

			if($('select[name=adult]').val()>=1){
				person_num='성인'+$('select[name=adult]').val();
			}
			if($('select[name=teenager]').val()>=1){
				if(person_num!="")
					person_num+=',청소년'+$('select[name=teenager]').val();
				else
					person_num+='청소년'+$('select[name=teenager]').val();
			}
			if($('select[name=senior]').val()>=1){
				if(person_num!="")
					person_num+=',시니어'+$('select[name=senior]').val();
				else
					person_num+='시니어'+$('select[name=senior]').val();
			}
			$('input[name=person_num]').val(person_num);
			price=$('select[name=adult]').val()*10000+
				$('select[name=teenager]').val()*8000+$('select[name=senior]').val()*5000
			$('input[name=payment]').val(price);
			$('input[name=price]').val(price.toString().replace(regexp,','));
			$('input[name=person_num]').val(person_num);
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


	//AdminMovieDTO mdto = (AdminMovieDTO) request.getAttribute("mdto"); //선택한 영화 정보
	//CineDTO cdto = (CineDTO)request.getAttribute("cdto"); //선택한 영화관 정보
	//String running_date = (String)request.getAttribute("running_date"); //상영일
	//String running_time = (String)request.getAttribute("running_time"); //상영시간


	AdminMovieDTO mdto = (AdminMovieDTO)request.getAttribute("mdto"); //선택한 영화 정보

	CineDTO cdto = (CineDTO)request.getAttribute("cdto"); //선택한 영화관 정보
	String running_date = (String)request.getAttribute("running_date");//상영일
	String running_time = (String)request.getAttribute("running_time");//상영시간

	String saleTime = (String)request.getAttribute("saleTime"); //조조,심야
	int roomNum = (Integer)request.getAttribute("roomNum"); //상영관 번호
	String week=(String)request.getAttribute("week"); //요일
	
	
	List seatRow=(List)request.getAttribute("seatRow");
	List seatCol=(List)request.getAttribute("seatCol");
	System.out.println(seatRow+" "+seatCol);
	
	String seat = cdto.getSeat().split(",")[roomNum-1]; //총좌석
	//Integer row = Integer.parseInt(seat.split(" ")[0]); //행
	//Integer col = Integer.parseInt(seat.split(" ")[1]); //열
	int row=16;
	int col=18;
	
	System.out.println("좌석 행 :"+row+", 좌석 열 :"+col);

%>


<fieldset>
	<legend>좌석 선택</legend>
	<!-- form action -->
	<form action="TicketOrderAction.ti" method="post">
	<input type="hidden" id="row" value=<%=row %>>
	<input type="hidden" id="col" value=<%=col %>>
	<input type="hidden" name="payment">
	<input type="hidden" name="person_num">
	<%
	if(seatRow.size()!=0){
	for(int i=0; i<seatRow.size(); i++){ %>
	<input type="hidden" name="seatRow" value=<%=seatRow.get(i) %>>
	<input type="hidden" name="seatCol" value=<%=seatCol.get(i) %>>
	<%} 
	}%>
	
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
				<input type="radio" id="four" name="seating" value="4">4자리
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
	int cnt=1;
	for(int i=1;i<=row;i++){
		String alpStr = String.valueOf(alpChar); 
			for(int j=0;j<=col;j++){
				int grNum=3;
				
				if(j==0){//행 알파벳 보여줌
	%>			
				<a class="seatbg" type="button" name="seat<%=alpStr %>"><%=alpStr %></a>
	<%	
				}else{
					//행:12 열:18 좌우 3개
					if(col==18){
						if(j<=3){
							grNum=grNum*(i-1)+1;
						%>
						<input class="seat grNum<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
						<%
						}else if(j>=16){
							grNum=grNum*(i-1)+3;
						%>
						<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
						<%
						}else{
							grNum=grNum*(i-1)+2;
							if(cnt==12*i-11){
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}
							}else if(cnt==12*i){
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}
							}else{
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}
							}
							cnt++;
						}
					}else if(col==20){//행:14 열:20 좌우 4개
						if(j<=4){
							grNum=grNum*(i-1)+1;
						%>
						<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
						<%
						}else if(j>=17){
							grNum=grNum*(i-1)+3;
						%>
						<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
						<%
						}else{
							grNum=grNum*(i-1)+2;
							if(cnt==12*i-11){
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}
							}else if(cnt==12*i){
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}
							}else{
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}
							}
							cnt++;
						}	
					}else if(col==22){//행:16 열:22 좌우 5개
						if(j<=5){
							grNum=grNum*(i-1)+1;
						%>
						<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
						<%
						}else if(j>=18){
							grNum=grNum*(i-1)+3;
						%>
						<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
						<%
						}else{
							grNum=grNum*(i-1)+2;
							if(cnt==12*i-11){
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}
							}else if(cnt==12*i){
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}
							}else{
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}
							}
							cnt++;
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
				<img src="/upload/<%=mdto.getPoster() %>">
				<input type="text" name="movie_title" value="<%=mdto.getTitle() %>">
				<input type="hidden" name="movie_num" value="<%=mdto.getMovie_num() %>">
				
			</td>
			<td>
				예매정보<br>
				상영일 <input type="text" name="running_date" value="<%=running_date %>(<%=week %>)" readonly><br>
				상영시간 <input type="text" name="running_time" value="<%=running_time %>" readonly><br>
				<!-- 상영관의 경우 데이터 값 가져와서  -->

				상영관 <input type="text" name="room_num" value="<%=cdto.getName()%> <%=roomNum %>관" readonly>
					 <input type="hidden" name="cinema_num" value="<%=cdto.getCinema_num() %>"  readonly>
					 <input type="hidden" name="roomNum" value="<%=roomNum %>"  readonly>
				<br>
				좌석 <input type="text" name="seat" readonly><br>
			</td>
			<td>
				총 결제 금액
				<!-- 좌석 선택후 가격 결정  -->
				영화예매 <input type="text" name="price"> 원
						
			</td>
		</tr>
	</table>
	
	</form>
</fieldset>

</body>
</html>