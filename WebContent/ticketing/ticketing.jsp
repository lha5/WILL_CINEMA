<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
	}
	function calendar(){
		var nMonth = new Date(today.getFullYear(), today.getMonth(), 1);  // 이번 달의 첫째 날
		var lastDate = new Date(today.getFullYear(), today.getMonth()+1, 0); // 이번 달의 마지막 날
		var calArea= document.getElementsByClassName("month-picker-fieldset");
		alert(calArea);
	}


</script>


</head>
<body>

<div class="cont_ticket">
 <div class="cont_ticket_Area">
  <div class="calendar"> <!-- 달력 -->
		<a href="#">이전</a>
		<fieldset class="month-picker-fieldset">
			<div class="calendarArea"><a href="#" onclick="calendar()">달력</a></div>
		</fieldset>
		<a href="#">다음</a>
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