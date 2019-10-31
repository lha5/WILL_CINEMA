<%@page import="com.movie.db.MovieDTO"%>
<%@page import="com.cinema.db.CineDTO"%>
<%@page import="java.util.List"%>
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

.calendar { 
	position:relative; 
	clear:both;
	width:980px; 
	padding:0 0 0 0;  
	color:#231f20;
}

.calendar fieldset .month-picker-label {
	/* position: absolute; */
	width: 30px;
	padding: 0 15px;
	text-align: center;
}

.calendar .month-picker {
	margin: 100px auto;
	width: 600px;
	text-align: center;
}

.calendar .month-picker-label span {
	display: block;
	font-size: 13px;
	padding-bottom: 5px;
}

.calendar .month-picker-label em {
	display: inline-block;
	width: 100%;
	height: 30px;
	line-height: 30px;
	font-size: 14px;
	font-weight: bold;
}

.calendar .month-picker-fieldset {
	overflow: hidden;
	position: relative;
	display: block;
	width: 840px;
	height: 49px;
	padding: 47px 70px 0;
}

.calendar .month-picker-fieldset div.calendarArea {
	position: relative;
	display: inline-block;
	overflow: hidden;
	width: 100%;
	height: 100%;
}

.calendar .month-picker-fieldset div input {
	position: absolute;
	clip: rect(1px, 1px, 1px, 1px);
}

.calendar span.month {
	position: absolute;
	padding: 0 40px;
	text-align: left;
	font-weight: bold;
	top: 0 !important;
	color: #666;
	font-size: 12px;
}

.calendar span.month em {
	width: 13px;
	font-size: 34px;
	margin: 0 15px 0 0;
	border-bottom: 2px solid #231f20;
	font-family: 'Linux Libertine';
	color: #231f20;
	font-weight: bold;
}

.calendar span.month.noDate {
	color: #806a42;
}

.calendar span.month.noDate em {
	color: #806a42;
	border-color: #806a42;
}

.calendar span.month span {
	white-space: nowrap
}

.calendar .month-picker-fieldset>.month-picker-label.month em {
	padding: 0;
	font-size: 30px;
	line-height: 30px;
}

.calendar .month-picker-fieldset .month-picker-label.sun {
	color: #cd190b
}

.calendar .month-picker-fieldset .month-picker-label.sat {
	color: #407bbb
}

.calendar .month-picker-fieldset .month-picker-label.noDate {
	color: #A7A2A2 !important;
	cursor: default;
}

.calendar .month-picker-label, .month-picker-nav {
	display: inline-block;
	vertical-align: top;
	cursor: pointer;
}

.calendar .month-picker-label.ckon em {
	opacity: 1;
	filter: alpha(opacity = 100);
	opacity: 1.0;
	-moz-opacity: 1.0;
	background: url('./img/bg/bg_cal_check.png') no-repeat center
		center !important;
	color: #fff;
}

.calendar .month-picker-label.month.ckon em {
	background: none;
	color: #231f20
}

.calendar input:checked+.month-picker-label em {
	opacity: 1;
	filter: alpha(opacity = 100);
	opacity: 1.0;
	-moz-opacity: 1.0;
	background: url('./img/bg/bg_cal_check.png') no-repeat center
		center;
	color: #fff;
}

.calendar input:checked+.month-picker-label.month em {
	background: none;
	color: #231f20
}

.calendar input:focus+.month-picker-label {
	outline: 1px dotted #000;
} /* 2016.05.04 포커스 추가*/
.calendar .month-picker-nav {
	position: absolute;
	top: 41px;
	z-index: 10;
	width: 19px;
	height: 50px;
	font-size: 0;
	text-align: center;
}

.calendar .month-picker-nav.next {
	right: 0;
	background: url('./img/btn/btn_m_next_on.png') no-repeat center
		center;
}

.calendar .month-picker-nav.prev {
	left: 0;
	background: url('./img/btn/btn_m_prev_on.png') no-repeat center
		center;
}

.calendar .month-picker-nav.nodata {
	opacity: 0.3;
	filter: alpha(opacity = 30);
	opacity: 0.3;
	-moz-opacity: 0.3;
	cursor: default;
}


.movie_list {
  display: none;
}

.movie_cont a.active{
	font-weight: bold;
}

.movie_list a.on{
	font-weight: bold;
}

.area_list a.on{
	font-weight: bold;
}

</style>

<script type="text/javascript">
	$(function (){
		var monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 
			'August', 'September', 'October', 'November', 'December'];
		var dayNames = ["일", "월", "화", "수", "목", "금", "토"];
		var calendar=$('.calendar'); 
		var showDate=14; //보여줄 날짜
		var startDate=0;
		var clickDate=14;
		var today = new Date(); //오늘 날짜
		var changeDay= '#'+monthNames[today.getMonth()]+today.getDate();
		var allDay = "${allDay}"; //controller에서 가져온 attribute
		allDay=allDay.split('[')[1];
		allDay=allDay.split(']')[0];
		allDay=allDay.split(',');

		function prev(){
		$('.prev').click(function(){
			changeDay=$('.txtdate').find('dd').text().split('.');
			changeDate=changeDay[2].toString().split('(');
			changeDay='#'+monthNames[changeDay[1]*1-1]+changeDate[0];//선택된 radio의 id값 저장
			calendar.find('fieldset').find('span').remove();
			calendar2(-clickDate);
		});}
		
		function next(){
		$('.next').click(function(){
			changeDay=$('.txtdate').find('dd').text().split('.');
			changeDate=changeDay[2].toString().split('(');
			changeDay='#'+monthNames[changeDay[1]*1-1]+changeDate[0]; //선택된 radio의 id값 저장
			calendar.find('fieldset').find('span').remove();
			calendar2(clickDate);
		});}
		prev();

		function calendar2(data){
			var cnt=0;
			var cnt2=0;
			var yearData = today.getFullYear(); // 시작 년도 ,날짜 비교용
	        var monthData = today.getMonth(); // 시작달 ,날짜 비교용
			var html=''; //본문에 붙일 내용
			var spanMon = today.getMonth()+1; //보여줄 달, 1자리수 0을 붙여줌 ex)08,09
	        spanMon = spanMon >= 10 ? spanMon : '0' + spanMon;
			
			//재 호출시 비움
			calendar.find('.calendarArea').empty();

			calendar.find('fieldset').append('<span class="month" style="top:-47px; left:47px;"><em>'
					+ spanMon + '</em><span>' + today.getFullYear()
					+ ' ' + monthNames[today.getMonth()] + '</span></span>');
			
			//이동할 날짜 범위
			showDate=Number(showDate)+Number(data);
			startDate=Number(startDate)+Number(data);
			/* if(today.getHours()<=3){
				showDate=
			} */
			for(var i = startDate; i<showDate; i++){
				var day = today.getDate(); //오늘 일
				var d = new Date(); //변경될 날짜
				d.setDate(day+i); //보여줄 일
				var yearData2 = d.getFullYear();
				var monData = d.getMonth()+1; //8,9,10월 형식
				monData = monData >= 10 ? monData : '0' + monData; //1자리수 0을 붙여줌 ex)08,09월
				var dayData = d.getDate();
				dayData = dayData >= 10 ? dayData : '0' + dayData;
				var playData=d.getFullYear()+'-'+monData+'-'+dayData; //ex)2019-10-25 형식
				
				//달이 완전히 바뀐 경우 이번달을 지움
				if(d.getMonth()!=monthData && cnt==0){
					calendar.find('fieldset').find('span').remove();
				}
	
				if(allDay[showDate]&&i==startDate){
					next();
					calendar.find('.next').removeClass('nodata');
				}else if(!allDay[showDate]&&i==showDate-1){
					calendar.find('.next').off('click');
					calendar.find('.next').addClass('nodata');
				}
	
				if(allDay[i]){//영화가 있는 날
					if(allDay[0]==playData){//첫날 이전은 보여주지 않게
						calendar.find('.prev').off('click');
						calendar.find('.prev').addClass('nodata');
						//calendar.find('.next').addClass('nodata').siblings('a').removeClass('nodata');
					}else if(allDay[0]!=playData&&cnt2==0){//오늘 날짜가 포함 안된 날짜들 일때
						prev();
						calendar.find('.prev').removeClass('nodata');
					}
					//라디오
					html = '<input type="radio" name="day" value="'
					+ playData + '" id="' + monthNames[d.getMonth()] + dayData + '">';
					
					//라벨
					html += '<label for="' + monthNames[d.getMonth()] + dayData 
					+ '" class="month-picker-label" style="left:' + (i * 60) + 'px"><span>' 
					+ dayNames[d.getDay()] + '</span><em>' + d.getDate() + '</em></label>';
					cnt2++;
				}else{//영화가 없는 날
					if(cnt2!=0){
						calendar.find('.next').off('click');
						calendar.find('.next').addClass('nodata');
					}
					//라디오
					html = '<input type="radio" name="day" value="'
					+ playData + '" id="' + monthNames[d.getMonth()] + dayData +'disabled="disabled"'+'">';
					
					//라벨
					html += '<label for="' + monthNames[d.getMonth()] + dayData 
					+ '" class="month-picker-label noDate" style="left:' + (i * 60) + 'px"><span>' 
					+ dayNames[d.getDay()] + '</span><em>' + d.getDate() + '</em></label>';
				}
				
				
				calendar.find('.calendarArea').append(html);
				
				calendar.find('.calendarArea').find(changeDay).prop("checked", true);
				/*
				if(d.getFullYear()==today.getFullYear()
						&&monthNames[d.getMonth()] == monthNames[today.getMonth()]
						&&d.getDate()==today.getDate()&&changeDay==''){
					//alert('today');
					calendar.find('.calendarArea').find('input:radio').eq(Number(i)-Number(startDate)).prop("checked", true);
				}else{
					//$('input:radio[id="'+changeDay+'"])'.prop("checked", true);
				}*/
				if(dayNames[d.getDay()]=='토'){
					calendar.find('.calendarArea').find('label').eq(Number(i)-Number(startDate)).addClass('sat');
				}else if(dayNames[d.getDay()]=='일'){
					calendar.find('.calendarArea').find('label').eq(Number(i)-Number(startDate)).addClass('sun');
				}
				 
				if(d.getMonth()!=monthData){//달또는 년도가 바뀌었을 경우
					monthData=d.getMonth();
					yearData=yearData2;
					var pos = calendar.find('.calendarArea').find('label').last().position();

					calendar.find('fieldset').append('<span class="month" style="top:-47px; left:' + ((pos.left) + 47) + 'px"><em>' 
					+ monData + '</em><span>' + yearData2 + ' ' + monthNames[d.getMonth()] + '</span></span>');
				}
				//cnt++;
				//alert(d.getMonth() + ", " + monthData);
				//alert("달 일치 : "+d.getMonth()!=monthData);
				//alert(" 횟수 : " + cnt)
				
				cnt++;
			}
		}
		
		calendar2(0);//웹 시작시
		
		$(document).on('click','input:radio',function(){ //버튼 클릭시
			$('.txtdate').find('dd').text(function(){// 상영일 날짜 바꿔줌
				var date=$('input[name="day"]:checked').val().split("-");//radio체크된 날짜
				var mon=Number(date[1])-1;
				//체크된 날짜의 요일
				var week=$('label[for="' +monthNames[mon]+date[2] +'"]').find('span').text();
				return date[0]+"."+date[1]+"."+date[2]+"("+week+")";
			});
		});
		
		$('.txtdate').find('dd').text(function(){//웹 시작시 상영일 날짜 바꿔줌
			var date=$('input[name="day"]:checked').val().split("-"); //radio체크된 날짜
			var mon=Number(date[1])-1;
			//체크된 날짜의 요일
			var week=$('label[for="' +monthNames[mon]+date[2] +'"]').find('span').text();
			return date[0]+"."+date[1]+"."+date[2]+"("+week+")";

		});

		//openMovie(event,'book');
		openMovie(event,'book');
		$('.movie_cont').find('a').eq(0).addClass(' active');
		
		openArea(event,'area1');
		//$('.movie_cont').find('a').eq(0).addClass(' active');
	});
	
	//지역 선택
	function openArea(event,areaNum){// 이벤트, 보여줄 지역의 지점명 목록
		// 지점 ul 클래스, 선택지역 클래스명
		var area_list, region;
		area_list = document.getElementsByClassName("area_list");
		for(var i=0;i<area_list.length; i++){
			area_list[i].style.display="none";
		}
		region=document.getElementsByClassName("region");
		for(var i=0;i<region.length;i++){
			region[i].className=region[i].className.replace(" active","");
		}
		document.getElementById(areaNum).style.display="block";
		if(event!=null)event.currentTarget.className+=" active";
	}

	//지점명 선택
	function selectArea(event){
		var areaClass=event.currentTarget.className;
		//console.log($('.area_list').find('.on').not($(event.currentTarget)).length);

		//다른 지점 선택시
		if($('.area_list').find('.on').not($(event.currentTarget)).length>=1){
			$('.area_list').find('.on').not($(event.currentTarget)).removeClass("on");
		} 

		if($(event.currentTarget).hasClass('on')){
			event.currentTarget.className=areaClass.replace(" on","");
			$('.txtCin').find('dd').text('영화관 선택하세요');
			$('.txtCin').find('dd').removeClass('on');
		}else{
			event.currentTarget.className+=" on";
			$('.txtCin').find('dd').text($(event.currentTarget).text());
			$('.txtCin').find('dd').addClass('on');
		}
		
		var cinema='';
		var movie='';
		var date=$('input[name="day"]:checked').val();
		var html='';
		
		if($('.txtCin').find('dd').is('.on')){
			cinema=$('.txtCin').find('dd').text();
		}
		
		if($('.txtName').find('dd').is('.on')){
			movie=$('.txtName').find('dd').text();
		}
		$.ajax({
			url:"./ShowTime.ti",
			type:"post",
			dataType:"JSON",
			data:{cinema:cinema,movie:movie,date:date},
			success:function(data){
				var cnt=1;
				$.each(data,function(index,cdto){
					console.log(cdto);
					var runtimeS='';
					var runtimeE='';
					var saleTime='';
					html="<h5 class='time_tit'>"+cdto.name+"</h5>";
					html+="<dl class='time_line movie"+cdto.movie_num+"'>";
					html+="<dt><span class='grade_"+cdto.movie_grade+"'>"+cdto.movie_grade+"</span>"+cdto.movie_name+"</dt>";
					html+="<dd><ul class='theater_time list"+cdto.movie_num+"'>"
					
					$.each(cdto.runtimeS,function(index,sTime){
						runtimeS+=sTime+",";
					});
					$.each(cdto.runtimeE,function(index,eTime){
						runtimeE+=eTime+",";
					});
					$.each(cdto.saleTime,function(index,sale){
						saleTime+=sale+",";
					});
					runtimeS=runtimeS.substr(0, runtimeS.length-1);
					runtimeS=runtimeS.split(",");
					runtimeE=runtimeE.substr(0, runtimeE.length-1);
					runtimeE=runtimeE.split(",");
					saleTime=saleTime.substr(0, saleTime.length-1);
					saleTime=saleTime.split(",");
					for(var i=0; i<cdto.runtimeS.length; i++){
						html+="<li><a href='javascript:void(0)'>"+"<span class='cineD2'><em>"+cnt+"관</em></span>";
						if(saleTime[i]=="조조") html+="<span class='clock'><em class='seat iri'>조조</em>";
						if(saleTime[i]=="심야") html+="<span class='clock'><em class='seat ini'>심야</em>";
						if(saleTime[i]=="") html+="<span>";
						html+=runtimeS[i]+"<span> ~ "+runtimeE[i]+"</span></span>"+
						"<span class='ppNum'>"+"남은좌석/"+cdto.allSeat+"</span></a></li>";
						
					}
					html+="</ul>"
					$('.time_inner').find('.time_list01').append(html);
					cnt++;
				});
				
			},
			error:function(request,status,error){
				alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
               }
		});
	}
	
	
	//예매순, 평점순 내용보여주기
	function openMovie(event,rating){//클릭한 이벤트, (예매,평점)클래스명
		//영화 ul의 클래스 , (예매,평점)선택 클래스명
		var movie_list, ratingLink;
		movie_list = document.getElementsByClassName("movie_list");
		for(var i=0;i<movie_list.length; i++){
			movie_list[i].style.display="none";
		}
		ratingLink=document.getElementsByClassName("ratingLink");
		for(var i=0;i<ratingLink.length;i++){
			ratingLink[i].className=ratingLink[i].className.replace(" active","");
		}
		document.getElementById(rating).style.display="block";
		if(event!=null)
		event.currentTarget.className+=" active";
	}

	//영화 선택
	function selectMov(event){
		var movClass=event.currentTarget.className;

		//다른 영화 선택시
		if($('.movie_list').find('.on').not($(event.currentTarget)).length>=1){
			$('.movie_list').find('.on').not($(event.currentTarget)).removeClass("on");
		}
		
		//현재 선택된 영화를 다시 클릭할때 선택 해제
		if($(event.currentTarget).is('.on')){
			event.currentTarget.className=movClass.replace(" on","");
			$('.txtName').find('dd').text('영화를 선택하세요');
			$('.txtName').find('dd').removeClass('on');
		}else{
			event.currentTarget.className+=" on";
			$('.txtName').find('dd').text($('.'+movClass).eq(0).find('em').text());
			$('.txtName').find('dd').addClass('on');
		}	
	}
	

</script>


</head>
<body>
<%
	//List<String> allDay = (List)request.getAttribute("allDay");

	List<CineDTO> cineList = (List)request.getAttribute("cineList");//모든 영화관 정보
	List allRegion = (List)request.getAttribute("allRegion");//모든지역 
	
	List<MovieDTO> bookRatingList= (List)request.getAttribute("bookRatingList");
	List<MovieDTO> totalRatingList= (List)request.getAttribute("totalRatingList");
	//System.out.println(cineList.size());
	int[] cineCnt=(int[])request.getAttribute("cineCnt");

%>
<div class="cont_ticket">
 <div class="cont_ticket_Area">
  <div class="calendar"> <!-- 달력 -->
		<a href="javascript:void(0);" class="month-picker-nav prev">이전</a>
		<fieldset class="month-picker-fieldset">
			<div class="calendarArea">
			</div>
		</fieldset>
		<a href="javascript:void(0);" class='month-picker-nav next'>다음</a>
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
      <div class="tab_cont">
       <ul class="cinema_zone">
       <!-- 지역 반복문 -->
       <%
  		for(int i=0; i<allRegion.size(); i++){ 
    	 	//지역번호
    	   String temp=allRegion.get(i).toString().split(",")[0];
    	   temp=temp.substring(1);
    	   int num=Integer.parseInt(temp);
    	 	//지역명
    	   temp=allRegion.get(i).toString().split(",")[1];
    	   temp=temp.split("]")[0];
    	   String name=temp.substring(1);
       %>
        <li>
         <span class="area_zone">
          <a href="javascript:void(0);" class="region" onclick="openArea(event,'area<%=num%>')">
          <h4><%=name%></h4>(<em><%=cineCnt[i]%></em>)
          </a>
         </span>
         <div class="area_cont">
          <ul class="area_list" id="area<%=num%>">
          <!-- 지점명 반복문 -->
          <% for(int j=0; j<cineList.size(); j++){
        	  CineDTO cdto=cineList.get(j);
        	  //System.out.println(cdto.getRegion()+", " + name);
          		if(cdto.getRegion().equals(name)){
          %>
           <li><a href="javascript:void(0);" class=<%=cdto.getCinema_num() %> onclick='selectArea(event);'><%=cdto.getName() %></a></li>
           <%
          		}
          	} %>
           <!-- 지점명 반복문 -->
          </ul>
         </div>
        </li>
        <!-- 지역 반복문 -->
        <%} %>
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
      <li><a href="javascript:void(0);" class="ratingLink" onclick="openMovie(event,'book')">예매순</a></li>
      <li><a href="javascript:void(0);" class="ratingLink" onclick="openMovie(event,'total')">평점순</a></li>
     </ul>
     <!-- 예매순 -->
     <div class="scroll_bar">
     	<ul id="book" class="movie_list">
     	<!-- 영화 반복문 -->
     	<%for(int i=0; i<bookRatingList.size(); i++){
     		MovieDTO mdto=bookRatingList.get(i);
     	%>
     	 <li>
     	  <a href="javascript:void(0);" class="mov<%=mdto.getMovie_num() %>" 
     	  onclick='selectMov(event);'>
     	   <span class="grade_<%=mdto.getGrade() %>"><%=mdto.getGrade() %></span>
     	   <em><%=mdto.getTitle() %></em>
     	  </a>
     	 </li>
     	 <%} %>
     	 <!-- 영화 반복문 -->
     	</ul>
    	 <!-- 평점순 -->
     	<ul id="total" class="movie_list">
     	<!-- 영화 반복문 -->
     	<%for(int i=0; i<totalRatingList.size(); i++){ 
     		MovieDTO mdto=totalRatingList.get(i);
     	%>
     	 <li>
     	  <a href="javascript:void(0);" class="mov<%=mdto.getMovie_num() %>">
     	   <span class="grade_<%=mdto.getGrade() %>"><%=mdto.getGrade() %></span>
     	   <em><%=mdto.getTitle() %> , <%=mdto.getTotal_rating() %></em>
     	  </a>
     	 </li>
     	 <%} %>
     	 <!-- 영화 반복문 -->
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
  	  <li><a href="javascript:void(0);">영화관별 조회</a></li>
  	  <li><a href="javascript:void(0);">영화별 조회</a></li>
  	 </ul>
  	</div>
  </div>
  <div class="time_list01"></div><!-- 영화관별 -->
  <div class="time_list02"></div><!-- 영화 별 -->
 </div>
</div>

</body>
</html>