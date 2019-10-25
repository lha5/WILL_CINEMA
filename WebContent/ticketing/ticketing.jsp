<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script src="./js/jquery-3.4.1.min.js"></script>

<style type="text/css">
/* 예매 Content Ticket*/
.cont_ticket {
	width: 100%;
	min-height: 100px;
	background: #f9f6ec;
}

.cont_ticket_Area {
	width: 980px;
	min-height: 100px;
	margin: 0 auto;
	padding-top: 30px;
}
/* 예매 Content Ticket*/

/* 0805 예매 */
.ticket_wrap {
	width: 100%;
	background: #f6f6ea
}

</style>

<script type="text/javascript">
	var today = new Date(); 
	function prevCal(){
		today = new Date(today.getFullYear(), today.getMonth(), today.getDate() - 1);
	}
	function nextCal(){
		today = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);
		//calendar2(8);
	}
	function calendar(){
		var nMonth = new Date(today.getFullYear(), today.getMonth(), 1);  // 이번 달의 첫째 날
		var lastDate = new Date(today.getFullYear(), today.getMonth()+1, 0); // 이번 달의 마지막 날
		var calArea= document.getElementsByClassName("month-picker-fieldset");
		alert(calArea);
	}
	
	$(function (){
		var monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 
			'August', 'September', 'October', 'November', 'December'];
		var dayNames = ["일", "월", "화", "수", "목", "금", "토"];
		var calendar=$('.calendar'); 
		var showDate=8; //보여줄 날짜
		var startDate=0;
		
		var monthData = today.getMonth()+1; //1자리수 0을 붙여줌 ex)08,09
		monthData = monthData >= 10 ? monthData : '0' + monthData;
		
		$('.prev').click(function(){
			calendar2(-8);
		});
		
		$('.next').click(function(){
			calendar2(8);
		});
		
		calendar.find('fieldset').append('<span class="month" style="top:-47px; left:47px;"><em>'
		+ monthData + '</em><span>' + today.getFullYear()
		+ ' ' + monthNames[today.getMonth()] + '</span></span>');
		function calendar2(data2,todayDate){
			showDate=Number(showDate)+Number(data2);
			startDate=Number(startDate)+Number(data2);
			var html=''; //본문에 붙일 내용
			calendar.find('.calendarArea').empty();
			for(var i = startDate; i<showDate; i++){
				var day = today.getDate(); //오늘 일
				var d = new Date(); //오늘 날짜
				d.setDate(day+i); //보여줄 일
				var monData = d.getMonth()+1; //8,9,10월 형식
				monData = monData >= 10 ? monData : '0' + monData; //1자리수 0을 붙여줌 ex)08,09월
				var dayData = d.getDate();
				dayData = dayData >= 10 ? dayData : '0' + dayData;
				var playData=d.getFullYear()+'-'+monData+'-'+dayData; //ex)2019-10-25 형식
	
				//라디오
				html = '<input type="radio" name="day" value="'
				+ playData + '" id="' + monthNames[d.getMonth()] + dayData + '">';
				
				//라벨
				html += '<label for="' + monthNames[d.getMonth()] + dayData 
				+ '" class="month-picker-label" style="left:' + (i * 60) + 'px"><span>' 
				+ dayNames[d.getDay()] + '</span><em>' + dayData + '</em></label>';
				
				calendar.find('.calendarArea').append(html);
				
				if(d.getFullYear()==todayDate.getFullYear()
						&&monthNames[d.getMonth()] == monthNames[todayDate.getMonth()]
						&&d.getDate()==todayDate.getDate()){
					alert('today');
				}
				if(dayNames[d.getDay()]=='토'){
					calendar.find('.calendarArea').find('label').eq(Number(i)-Number(startDate)).addClass('sat');
				}else if(dayNames[d.getDay()]=='일'){
					calendar.find('.calendarArea').find('label').eq(Number(i)-Number(startDate)).addClass('sun');
				}
			}
		}

		calendar2(0,today);
	});


</script>


</head>
<body>

<div class="cont_ticket">
 <div class="cont_ticket_Area">
  <div class="calendar"> <!-- 달력 -->
		<a href="javascript:void(0);" class="month-picker-nav prev nodata">이전</a>
		<fieldset class="month-picker-fieldset">
			<div class="calendarArea">
			</div>
		</fieldset>
		<a href="javascript:void(0);" class='next'>다음</a>
  </div>
  <div class="ticket_inner">
   <div class="ticket_left">
    <dl class="cinema_header">
     <dt>영화관</dt>
     <dd>최대 2개까지 선택가능</dd>
    </dl>
    <div class="cinema_cont">
     <div class="cinema_top"><h4>전체영화관</h4></div>
     <div class="tab_scroll"> <!-- 영화관 목록 -->
      <div class="tab_cont on">
       <ul class="cinema_zone">
        <li>
         <span class="area_zone">
          <a href="javascript:void(0);"><h4>서울(20)</h4></a>
         </span>
         <div class="area_cont on">
          <ul>
           <li><a href="javascript:void(0);">가산디지털</a></li>
          </ul>
         </div>
        </li>
       </ul>
      </div>
     </div>
    </div>
   </div>
   <div class="ticket_right">
    <dl class="cinema_header">
     <dt>영화</dt>
     <dd>최대 2편까지 선택가능</dd>
    </dl>
    <div class="movie_cont">
     <ul>
      <li>예매순</li>
      <li>평점순</li>
     </ul>
     <div class="scroll_bar">
     	<ul class="movie_list">
     	 <li>
     	  <a href="javascript:void(0);">
     	   <span>15</span>
     	   <em>조커</em>
     	  </a>
     	 </li>
     	</ul>
     </div>
    </div>
   </div>
  </div>
 </div>
 <div class="selectMv">
  <div class="selectMv_Area">
   <div class="txtdate"><dl><dt>상영일</dt><dd>2019.10.22(화)</dd></dl></div>
   <div class="txtCin"><dl><dt>영화관</dt><dd>영화관을 선택하세요</dd></dl></div>
   <div class="txtName"><dl><dt>영화</dt><dd>영화를 선택하세요</dd></dl></div>
  </div>
 </div>
 <div class="time_inner">
  <div class="time_stop">
  	<h3 class="sub_tit02">상영시간</h3>
  	<div class="time_fr">
  	 <ul>
  	  <li>영화관별 조회</li>
  	  <li>영화별 조회</li>
  	 </ul>
  	</div>
  </div>
 
 
 </div>
</div>

</body>
</html>