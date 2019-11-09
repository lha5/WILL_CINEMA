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
<title>WILL CINEMA - 좌석 선택</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="./css/seat-ticketing.css">

<script type="text/javascript">
	$(function(){
		//전체 좌석개수
		var seatlen=$('.seatTable').find('.seat').length-1;
		//전체 그룹 개수 계산
		var grSize=$('.seatTable').find('.seat').eq(seatlen).attr('group'); //ex)grNum15
		//전체 그룹 개수
		grSize=grSize.substr(5);
		var curGroup=grSize;
		
		var regexp = /\B(?=(\d{3})+(?!\d))/g; //정규식
		var selectSeat=0;
		var row= $('#row').val();//총 행 개수
		var col= $('#col').val();//총 열 개수
		var price=0;
		var person_num='';
		var seatRow=new Array();
		var seatCol=new Array();
		$('input[name=price]').val(price);
		$('input[name=payment]').val(price);
		if($('input[name=seatRow]').length!=0){
			seatRow=new Array($('input[name=seatRow]').length);
			seatCol=new Array($('input[name=seatCol]').length);
		}
		/*--------------- 처음 실행될것들 ----------------*/
		
		//예약좌석 비활성1
		if($('input[name=seatRow]').length!=0){
			for(var i=0; i<$('input[name=seatRow]').length; i++){
				seatRow[i]=$('input[name=seatRow]')[i].value;
				seatCol[i]=$('input[name=seatCol]')[i].value;
				$('.seatTable').find('input[name=seat'+seatRow[i]+seatCol[i]+']').addClass('reserve');
			}
		}
		//선택할수 있는 인원수
		var pNum=$('select[name=adult]').val()*1+
		$('select[name=teenager]').val()*1+$('select[name=senior]').val()*1;
		
		//좌석 붙임 설정
		$('input[type=radio]').prop('disabled', true);
		
		/*--------------- 처음 실행될것들 ----------------*/
		
		
		/*---------------마우스 이동, 밖, 클릭 ------------------------*/
		$('.seatTable').find('input[type=button]').bind('mouseover', function(){
				overMouse(this);
			}).bind('mouseleave', function(){
				$('.seatTable').find('input[type=button]').removeClass('over');
			}).bind('click',function(){
				onMouse(this);
				getpNum();
				
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
				
				var seatNum='';
				
				for(var i=0; i<$('.seatTable').find('input[class*=on]').length; i++){
					if(i==0){
						seatNum=$('.seatTable').find('input[class*=on]').eq(i).attr('name').substr(4);
					}else{
						seatNum=seatNum+","+$('.seatTable').find('input[class*=on]').eq(i).attr('name').substr(4);
					}
				} 
				$('input[name=seat]').val(seatNum);				
				
				//인원
				$('input[name=person_num]').val(person_num);
				
				
				
			});
		/*---------------마우스 이동, 밖, 클릭 ------------------------*/
		
		/*--------------- 셀렉트 박스(인원선택) -------------*/
		$('select').bind('change', function(){
			//좌석 초기화
			$('input[name=seat]').val("");
			pNum=$('select[name=adult]').val()*1+
			$('select[name=teenager]').val()*1+$('select[name=senior]').val()*1;
			$('input[name=price]').val("0");//가격초기화
			
			//셀렉트를 변경하면 초기화
			$('.seatTable').find('input[type=button].disabled').removeClass('disabled');
			$('.seatTable').find('input[type=button].on').removeClass('on');
			
			getpNum();
			//selectSeatFn();
		});
		/*--------------- 셀렉트 박스(인원선택) -------------*/
		
		/*-------------------- 좌석붙임 라디오버튼 변경 -------------------*/
		$('input[type=radio]').change(function(){
			selectSeat=Number($('input[type=radio]:checked').val());
			
			//getpNum();
			selectSeatFn();
		});
		/*-------------------- 좌석붙임 라디오버튼 변경 -------------------*/

		/*----------- 마우스 올렸을때 선택 -----------  */
		function overMouse(select){
			var selSeat=$(select);//선택한것
			var group = selSeat.attr('group');//그룹번호
			var allGrp = $('.seatTable').find('.'+group).length; //그룹내의 좌석수
			var index = $('.seatTable').find('.'+group).index(selSeat); //그룹내의 자신 위치
			var allSeat=$('.seatTable').find('.'+group); //모든 그룹
			var right=allGrp-(index+selectSeat);//라디오박스에서 선택한 자리와 현재자리를 전체 개수에 뺌

			//좌석이 있으면
			if(!selSeat.hasClass('on')&&!selSeat.hasClass('disabled')
					&&!selSeat.hasClass('reserve')&&selectSeat>0){
				if(selectSeat>1){//선택좌석이 2개 이상일때
					if(index<2){//왼쪽에 자리가 1개 이하일때
						for(var i=0; i<selectSeat; i++)
							allSeat.eq(i).addClass('over');
					}else if(right<1){//오른쪽에 남은자리가 1자리 이하일때
						for(var i=1; i<=selectSeat; i++)
							allSeat.eq(allGrp-i).addClass('over');
					}else if(index>1&&right>1){//왼쪽과 오른쪽 남은자리가 1자리 이상
						if(index%2==1)//선택한 좌석이 홀수일때 짝수부터 시작
							index-=1;
						for(var i=0; i<selectSeat; i++)
							allSeat.eq(index+i).addClass('over');
					}else{
						if(right<2&&index-1<2){//왼쪽자리 오른쪽자리 1자리 이하
							index=0;
						}else if(right<2&&index-1>1){//왼쪽자리 1자리 이상 오른쪽자리 1자리 이하
							index-=1;
						}
						for(var i=0; i<selectSeat; i++)
							allSeat.eq(index+i).addClass('over');
					}
				}else{//선택좌석 1개일때
					$(select).addClass('over');
				}
			}
		}
		/*----------- 마우스 올렸을때 선택 -----------  */
		
		/*----------- 마우스 클릭시 선택 -----------  */
		function onMouse(select){
			var selSeat=$(select);//선택한것
			var group = selSeat.attr('group');//그룹번호
			var allGrp = $('.seatTable').find('.'+group).length; //그룹내의 좌석수
			var index = $('.seatTable').find('.'+group).index(selSeat); //그룹내의 자신 위치
			var allSeat=$('.seatTable').find('.'+group); //모든 그룹
			var right=allGrp-(index+selectSeat);//라디오박스에서 선택한 자리와 현재자리를 전체 개수에 뺌
			
			/* $('.seatTable').find('input[type=button]').removeClass('over'); */
			
			/* alert(selSeat +" " + group +" " + allGrp + " " + index + " "+allSeat + selectSeat);*/
			//좌석이 있으면
			if(!selSeat.hasClass('on')&&!selSeat.hasClass('disabled')
					&&!selSeat.hasClass('reserve')&&selectSeat>0){
				if(selectSeat>1){//선택좌석이 2개 이상일때
					if(index<2){//왼쪽에 자리가 1개 이하일때
						for(var i=0; i<selectSeat; i++){
							allSeat.eq(i).removeClass('over');
							allSeat.eq(i).addClass('on');
						}
					}else if(right<1){//오른쪽에 남은자리가 1자리 이하일때
						for(var i=1; i<=selectSeat; i++){
							allSeat.eq(allGrp-i).removeClass('over');
							allSeat.eq(allGrp-i).addClass('on');
						}
					}else if(index>1&&right>1){//왼쪽과 오른쪽 남은자리가 1자리 이상
						if(index%2==1)//선택한 좌석이 홀수일때 짝수부터 시작
							index-=1;
						for(var i=0; i<selectSeat; i++){
							allSeat.eq(index+i).removeClass('over');
							allSeat.eq(index+i).addClass('on');
						}
					}else{
						if(right<2&&index-1<2){//왼쪽자리 오른쪽자리 1자리 이하
							index=0;
						}else if(right<2&&index-1>1){//왼쪽자리 1자리 이상 오른쪽자리 1자리 이하
							index-=1;
						}
						for(var i=0; i<selectSeat; i++){
							allSeat.eq(index+i).removeClass('over');
							allSeat.eq(index+i).addClass('on');
						}
					}
				}else{//선택좌석 1개일때
					$(select).removeClass('over');
					$(select).addClass('on');
				}
				
				pNum=pNum-selectSeat;
				
				/* console.log("선택된 좌석 : "+$('.seatTable').find('.'+group).attr('name')); */
			}else if(selSeat.hasClass('on')){
				//선택한 버튼의 그룹번호
				//on 클래스를 제거
				$('.seatTable').find('.'+group).removeClass('on');
				
				pNum=pNum+$('.seatTable').find('.'+group).length;
			}
		}
		/*----------- 마우스 클릭시 선택 -----------  */
		
		
		/*------------------- pNum재설정 -----------------  */
		function getpNum(){
			/* pNum=$('select[name=adult]').val()*1+
			$('select[name=teenager]').val()*1+$('select[name=senior]').val()*1; */
			//초기 라디오버튼 클릭
			if(pNum==0){
				//좌석 붙임 설정
				$('input[type=radio]').prop('disabled', true);
				selectSeat=0;
			}else if(pNum==1){//1명
				$('#one').prop('disabled', false);
				$('#one').prop('checked', true);
				selectSeat=1;
			}else if(pNum==2){//2명 선택시(남은 인원2명)
				$('#one').prop('disabled', true);
				$('#four').prop('disabled', true);
				$('#two').prop('disabled', false);
				$('#two').prop('checked', true);
				selectSeat=2;
			}else if(pNum==3){
				$('input[type=radio]').prop('disabled', true);
				selectSeat=3;
			}else if(pNum==4){
				$('#one').prop('disabled', true);
				$('#four').prop('disabled', false);
				$('#two').prop('disabled', false);
				$('#two').prop('checked', true);
				selectSeat=2;
			}else if(pNum==5){
				$('#one').prop('disabled', true);
				$('#four').prop('disabled', false);
				$('#two').prop('disabled', false);
				$('#two').prop('checked', true);
				selectSeat=2;
			}else if(pNum==6){
				$('#one').prop('disabled', true);
				$('#four').prop('disabled', false);
				$('#two').prop('disabled', false);
				$('#two').prop('checked', true);
				selectSeat=2;
			}else if(pNum==7){
				$('#one').prop('disabled', true);
				$('#four').prop('disabled', false);
				$('#two').prop('disabled', false);
				$('#two').prop('checked', true);
				selectSeat=2;
			}else if(pNum==8){
				$('#one').prop('disabled', true);
				$('#four').prop('disabled', false);
				$('#two').prop('disabled', false);
				$('#two').prop('checked', true);
				selectSeat=2;
			}else if(pNum>=8){
				alert("최대 인원수는 8명입니다.");
				pNum=$('select[name=adult]').val(0)+$('select[name=teenager]').val(0)+$('select[name=senior]').val(0);
				selectSeat=0;
				$('input[type=radio]').prop('disabled', true);
			}
			
			selectSeatFn();
		}
		/*------------------- pNum재설정 -----------------  */
		
		
		/*----------- 라디오버튼 좌석 붙임 설정-----------  */
		function selectSeatFn(){
			//전체 좌석개수
			seatlen=$('.seatTable').find('.seat').length-1;
			//전체 그룹 개수 계산
			grSize=$('.seatTable').find('.seat').eq(seatlen).attr('group'); //ex)grNum15
			//전체 그룹 개수
			grSize=grSize.substr(5);
			
			$('.seatTable').find('input[type=button]').not('.on').removeClass('disabled');
			
			if(selectSeat==0){
				if($('.seatTable').find('input[type=button]').hasClass("on")){//이미 클릭된 상태면
					$('.seatTable').find('input[type=button]').not('.on').addClass('disabled');
				}else{//클릭되지 않은 상태
					$('.seatTable').find('input[type=button].disabled').removeClass('disabled');
				}
				price=$('select[name=adult]').val()*10000+
				$('select[name=teenager]').val()*8000+$('select[name=senior]').val()*5000;
				//가격
				$('input[name=payment]').val(price);
				$('input[name=price]').val(price.toString().replace(regexp,','));
			}else if(selectSeat==1){
				//1명 선택시
				for(var i=1; i<=Number(grSize); i++){//첫 그룹부터 끝 그룹까지
					var grSeLen=$('.seatTable').find('.grNum'+i+'[class*=on]').length;
					var grRemain=$('.seatTable').find('.grNum'+i).length-grSeLen;//남은 자리수
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
			}else if(selectSeat==2){
				for(var i=1; i<=Number(grSize); i++){//첫 그룹부터 끝 그룹까지
					var grSeLen=$('.seatTable').find('.grNum'+i+'[class*=on]').length;
					var grRemain=$('.seatTable').find('.grNum'+i).length-grSeLen;//남은 자리수
					
					if(grRemain<2||grRemain==3){//남은좌석수 1or 3이면
						$('.seatTable').find('.grNum'+i).not('.on').each(function(){
							if(!$(this).hasClass('reserve')){
								$(this).addClass('disabled');
							}
						});
					}else if(grRemain==5){
						$('.seatTable').find('.grNum'+i).not('.on').each(function(n){
							if(n==2){
								if(!$(this).hasClass('reserve')){
									$(this).addClass('disabled');
								}
							}
						});
					}
				}
			}else if(selectSeat==3){
				for(var i=1; i<=Number(grSize); i++){//첫 그룹부터 끝 그룹까지
					var grSeLen=$('.seatTable').find('.grNum'+i+'[class*=on]').length;
					var grRemain=$('.seatTable').find('.grNum'+i).length-grSeLen;//남은 자리수
					
					if(grRemain<3||grRemain==4){//남은좌석수 1,2or 4이면
						$('.seatTable').find('.grNum'+i).not('.on').each(function(){
							if(!$(this).hasClass('reserve')){
								$(this).addClass('disabled');
							}
						});
					}
				}
			}else if(selectSeat==4){
				for(var i=1; i<=Number(grSize); i++){//첫 그룹부터 끝 그룹까지
					var grSeLen=$('.seatTable').find('.grNum'+i+'[class*=on]').length;
					var grRemain=$('.seatTable').find('.grNum'+i).length-grSeLen;//남은 자리수
					
					if(grRemain<4||grRemain==5){//남은좌석수 1,2,3or 5이면
						$('.seatTable').find('.grNum'+i).not('.on').each(function(){
							if(!$(this).hasClass('reserve')){
								$(this).addClass('disabled');
							}
						});
					}
				}
			}
			grReset();
		}
		
		/*----------- 라디오버튼 좌석 붙임 설정-----------  */
		
		/*----------- 좌석 선택시 그룹 재설정-----------  */
		function grReset(){
			var group=0;
			grSize=1;//전체 그룹 개수 초기화
			var cnt=0;
			$('.seatTable').find('input[type=button]').each(function(){			
				var line=$(this).attr('seat-line');
				if(cnt>1) line= $(this).prev().attr('seat-line');

				/* console("이전 라인 : " + line/*  + "현재 라인 : "+$(this).attr('seat-line')); */
				var grClass = $(this).attr('group');//그룹번호
				//var innergroup =$(this).data('group');
				var innergroup =curGroup; //이전 저장된 그룹수
				$(this).removeClass(grClass);//현재 좌석 그룹번호 지움
				/* $(this).attr */
				//현재 좌석이 사용불가나 예약,선택 되어있으면
				if($(this).hasClass('on') ||$(this).hasClass('disabled') 
						|| $(this).hasClass('reserve')||innergroup!=group){
					if(innergroup!=group){
						group=innergroup;
						grSize++;
					}else if($(this).hasClass('disabled')){ //선택불가 왼쪽좌석이 선택가능할때
						if(!$(this).prev().hasClass('disabled')){
							group=innergroup;
							grSize++;
						}
					}else if($(this).hasClass('reserve')){//예약좌석 왼쪽좌석이 예약안됐을때
						if(!$(this).prev().hasClass('reserve')){
							group=innergroup;
							grSize++;
						}
					}else if($(this).hasClass('on')){
						if(!$(this).prev().hasClass('on')
								&&$(this).prev().length>0){
							group=innergroup;
							grSize++;
						}
					}
				}
				
				//현재 좌석이 선택된 좌석이 아니고 이전 좌선이 선택됐을때
				if(!$(this).hasClass('on')&&$(this).prev().hasClass('on')){
					group=innergroup;
					grSize++;
				}else if(!$(this).hasClass('disabled')//현재 좌석이 사용가능하고 이전좌석도 사용가능
						&&$(this).prev().hasClass('disabled')){
					group=innergroup;
					grSize++;
				}else if(line!=$(this).attr('seat-line')){
					group=innergroup;
					grSize++;
				}
				
				$(this).addClass('grNum'+grSize).attr('group','grNum'+grSize);
				cnt++;
			});
		}
		/*----------- 좌석 선택시 그룹 재설정-----------  */
	});
	
	function check(){
		var form = document.fr;
			alert(form.payment.value);
		  if (form.payment.value==0) {
				alert("좌석을 선택하세요");
				document.fr.adult.focus();
				return false;
		  }
	}



</script>
</head>
<body>
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
<%@ include file="../../include/header.jsp" %>
<div class="bgColor">
<h1>인원/좌석선택</h1>
<fieldset class="loginField">
	<div>
	<!-- form action -->
	<form action="TicketOrderAction.ti" class="seatForm" name="fr" onsubmit="return check();" method="post">
	<input type="hidden" id="row" value=<%=row %>>
	<input type="hidden" id="col" value=<%=col %>>
	<input type="hidden" name="payment">
	<input type="hidden" name="person_num">
	
	<div>
	<%
	if(seatRow.size()!=0){
	for(int i=0; i<seatRow.size(); i++){ %>
	<input type="hidden" name="seatRow" value=<%=seatRow.get(i) %>>
	<input type="hidden" name="seatCol" value=<%=seatCol.get(i) %>>
	<%} 
	}%>
	</div>
	<div class="selectPeopleNum">
	<div>
	<span>성인 </span>
		
			<select name="adult">
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
		</div>
		<div>
		<span>청소년  </span> 
		
			<select name="teenager">
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
		</div>
		<div>
		<span>시니어 </span> 
	
			<select name="senior">
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
		</div>
	<em>* 최대 8자리</em>
	</div>
	<hr>	
	<!-- 시간 부족시 삭제? -->
	<div class="selectPeopleNum2">
	<div>좌석 붙임 설정 </div>
		<div>
			<input type="radio" id="one" name="seating" value="1"><span>1자리</span>
		</div>
		<div>
			<input type="radio" id="two" name="seating" value="2"><span>2자리</span>
		</div>
		<div>
			<input type="radio" id="four" name="seating" value="4"><span>4자리</span>
		</div>
	</div>
	<hr>
	
	<!-- 좌석선택 -->
	<!--
	 cinema에 받아둔 좌석의 행,열을 이용해
	 for문으로 배열해 둠
	 후에 수정하실분은 유의할 것
	 -->
	 <div class="seatform">
	 <div class="seatform-chd1">
	 <table class="seatRow">
	 	<tr>
		 	<td>
		 	<%
		 	Character alpChar = 65;
		 	for(int i=1;i<=row;i++){
		 		String alpStr = String.valueOf(alpChar); 
		 		%>
		 		<a class="seatbg" name="seat<%=alpStr %>"><%=alpStr %></a><br>
		 		<%
		 		alpChar++;
		 	}
		 	%>
		 	</td>
	 	</tr>
	 </table>
	 </div>
	 
	 <div class="seatform-chd2">
	 <table class="seatTable">
	 <tr>
	 		<!-- 열 번호 -->
	 		<!-- 좌석열에 대등해서 아스키코드 A=65값 부터 늘려서 뿌려줌 -->

		<td><!-- 좌석 배치 칸 -->
		<!-- 아스키코드 초기화후 i증가에 따라 증가 -->
	<%
	alpChar = 65;
	int cnt=1;
	for(int i=1;i<=row;i++){
		String alpStr = String.valueOf(alpChar); 
			for(int j=1;j<=col;j++){
				int grNum=3;
					//행:12 열:18 좌우 3개
					if(col==18){
						if(j<=3){
							grNum=grNum*(i-1)+1;
						%>
						<input class="seat grNum<%=grNum %>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
						<%
						}else if(j>=16){
							grNum=grNum*(i-1)+3;
						%>
						<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
						<%
						}else{
							grNum=grNum*(i-1)+2;
							if(cnt==12*i-11){
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}
							}else if(cnt==12*i){
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}
							}else{
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>"  type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}
							}
							cnt++;
						}
					}else if(col==20){//행:14 열:20 좌우 4개
						if(j<=4){
							grNum=grNum*(i-1)+1;
						%>
						<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
						<%
						}else if(j>=17){
							grNum=grNum*(i-1)+3;
						%>
						<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
						<%
						}else{
							grNum=grNum*(i-1)+2;
							if(cnt==12*i-11){
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>"  type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}
							}else if(cnt==12*i){
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}
							}else{
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}
							}
							cnt++;
						}	
					}else if(col==22){//행:16 열:22 좌우 5개
						if(j<=5){
							grNum=grNum*(i-1)+1;
						%>
						<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
						<%
						}else if(j>=18){
							grNum=grNum*(i-1)+3;
						%>
						<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
						<%
						}else{
							grNum=grNum*(i-1)+2;
							if(cnt==12*i-11){
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-left: 15px;">
									<%
								}
							}else if(cnt==12*i){
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" 
									value="<%=j %>" style="margin-right: 15px;">
									<%
								}
							}else{
								if(row==12 && i>=row-4&&i<=row-1){//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else if(row==14 && i>=row-6&&i<=row-2){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else if(row==16 && i>=row-7&&i<=row-3){
									%>
									<input class="seat grNum<%=grNum%> sweet" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}else{//sweetpot지정
									%>
									<input class="seat grNum<%=grNum%>" group="grNum<%=grNum %>" seat-line="<%=grNum %>" type="button" name="seat<%=alpStr%><%=j %>" value="<%=j %>">
									<%
								}
							}
							cnt++;
						}	
					}
			}%>
	<!-- <br> -->
	<%
		
		alpChar++;
	} %>
			</td>
		</tr>
	</table>
		</div>
	</div>
	
	<!-- /좌석선택 -->
	<hr>
	<input type="button" class="prevButton" value="영화선택" onclick="location.href='Ticketing.ti'">
	<input type="submit" class="payButton" value="결제하기">
	<hr>
	
	<!-- 예약 정보 -->
	<!-- 테이블 형식은 후에 css중 변경 가능 -->
	<table class="seatTable2">
		<tr>
			<td>
				<table class="innerTable">
				<tr>
					<th colspan="2"><span>영화</span></th>
				</tr>
				<tr>
					<td class="tdSpan" rowspan="4"><img src="./upload/<%=mdto.getPoster() %>" ></td>
					<td ><input type="text" class="SeatTitle" name="movie_title" value="<%=mdto.getTitle() %>" readonly="readonly"></td>
				</tr>
				<tr>
					<td><%=mdto.getGenre() %></td>
				</tr>
				<tr>
					<td><input type="hidden" name="movie_num" value="<%=mdto.getMovie_num() %>"></td>
				</tr>
				<tr>
					<td><%=mdto.getGrade() %>세 이상</td>
				</tr>
				</table>
			</td>
			<td class="tdLine">
				<table class="innerTable2">
					<tr>
						<th colspan="2"><span>예매정보</span></th>
					</tr>
					<tr>
						<td>상영일</td>
						<td><input type="text" name="running_date" value="<%=running_date %>(<%=week %>)" readonly></td>
					</tr>
					<tr>
						<td>상영시간</td>
						<td><input type="text" name="running_time" value="<%=running_time %>" readonly></td>
					</tr>
					<tr>
						<td>상영관</td>
						<td>
							<input type="text" name="room_num" value="<%=cdto.getName()%> <%=roomNum %>관" readonly>
							<input type="hidden" name="cinema_num" value="<%=cdto.getCinema_num() %>"  readonly>
							<input type="hidden" name="roomNum" value="<%=roomNum %>"  readonly>
						</td>
					</tr>
					<tr>
						<td>좌석</td>
						<td><input type="text" name="seat" readonly></td>
					</tr>
				</table>
			</td>
			<td>
				<table class="innerTable3">
					<tr>
						<th colspan="2"><span>총 결제 금액</span></th>
					</tr>
					<tr>
						<td>영화예매</td>
						<td><input type="text" class="totalPrice1"  name="price"> 원</td>
					</tr>
					<tr>
						<td></td><td></td>
					</tr>
					<tr>
						<td></td><td></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="text" class="totalPrice2" name="price"> 원</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

	</form>
	</div>
</fieldset>
</div>
<%@ include file="../../include/footer.jsp" %>
</body>
</html>