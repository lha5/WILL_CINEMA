<%@page import="com.admin.movie.db.AdminMovieDTO"%>
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
<link rel="stylesheet" href="./css/ticketing.css">

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
		if(today.getDate()<10) var changeDay= '#'+monthNames[today.getMonth()]+"0"+today.getDate();
		else var changeDay= '#'+monthNames[today.getMonth()]+today.getDate();
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
		prev();
		calendar2(0);//웹 시작시
		
		$(document).on('click','input:radio',function(){ //버튼 클릭시
			$('.txtdate').find('dd').text(function(){// 상영일 날짜 바꿔줌
				var date=$('input[name="day"]:checked').val().split("-");//radio체크된 날짜
				var mon=Number(date[1])-1;
				//체크된 날짜의 요일
				var week=$('label[for="' +monthNames[mon]+date[2] +'"]').find('span').text();
				return date[0]+"."+date[1]+"."+date[2]+"("+week+")";
			});
			/* ajax관련 */
			clickEvent();
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
		$('.area_zone').find('a').eq(0).addClass(' active');
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
		
		/* ajax관련 */
		clickEvent();

		selectShow();
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
		console.log(event);
		var movClass=event.currentTarget.className;
		//다른 영화 선택시
		if($('.movie_list').find('.on').not($(event.currentTarget)).length>=1){ //자신 이외에 on class가 있는지
			$('.movie_list').find('.on').not($(event.currentTarget)).removeClass("on");
		}
		
		//현재 선택된 영화를 다시 클릭할때 선택 해제
		if($(event.currentTarget).is('.on')){
			//event.currentTarget.className=movClass.replace(" on","");
			$(event.currentTarget).removeClass('on');//영화 목록 비활성
			$('.txtName').find('dd').text('영화를 선택하세요');
			$('.txtName').find('dd').removeClass('on');
		}else{
			event.currentTarget.className+=" on";
			$('.txtName').find('dd').text($(event.currentTarget).find('em').text());
			$(event.currentTarget).addClass('on');//영화 목록 비활성
			$('.txtName').find('dd').addClass('on');
		}
		
		/* ajax관련 */
		clickEvent();
		selectShow();
	}
	
	//SeatSelect.ti로 이동
	function seatSelect(movie_num,saleTime,roomNum,cinema_num,running_date,running_time){
		var form = document.createElement("form");
		var parm = new Array();
		var input = new Array();
		var week=$('.txtdate').find('dd').text();
		
		alert(movie_num+" "+saleTime+" "+roomNum+" "
				+name+" "+running_date+" "+running_time+" 요일:"+week);
        form.action = "./SeatSelect.ti";
        form.method = "post";
        
        parm.push( ['movie_num', movie_num] ); //영화번호
        parm.push( ['saleTime', saleTime] ); //할인정보
        parm.push( ['roomNum', roomNum] ); //관 이름
        parm.push( ['cinema_num', cinema_num] ); //영화관 이름
        parm.push( ['running_date', running_date] ); //날짜
        parm.push( ['running_time', running_time] ); //상영시간
        parm.push( ['week', week] ); //요일
        for (var i = 0; i < parm.length; i++) {
            input[i] = document.createElement("input");
            input[i].setAttribute("type", "hidden");
            input[i].setAttribute('name', parm[i][0]);
            input[i].setAttribute("value", parm[i][1]);
            form.appendChild(input[i]);
        }
        document.body.appendChild(form);
        form.submit();
    }
	
	/* 클릭 ajax */
	function clickEvent(){
		var cinema='';
		var movie='';
		var date=$('input[name="day"]:checked').val();
		var selectDate=$('.txtdate').find('dd').text();
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
				console.log(data.length);
				//html초기화
				$('.time_inner').find('.time_list01').empty();
				document.getElementById('time_noData').style.display="none";

				if(data.length==0){
					document.getElementById('time_noData').style.display="block";
				}
				
				
				$.each(data,function(index,cdto){//영화관의 상영 영화 정보
					console.log(cdto);
					var runtimeS='';
					var runtimeE='';
					var saleTime='';
					var selectSeat='';
					html='';
					//처음 반복에만 영화관 이름 보여줌
					if(cnt==1 && cdto.runtimeS.length>=1) html="<h5 class='time_tit'>"+cdto.name+"</h5>";
					if(cdto.runtimeS.length>=1){
					html+="<dl class='time_line movie"+cdto.movie_num+"'>";
					html+="<dt><span class='grade_"+cdto.movie_grade+"'>"+cdto.movie_grade+"</span>"+cdto.movie_name+
					"<a href='#' class='btn_detail'><img src='./img/btn/btn_time_view.png'></a></dt>";
					html+="<dd><ul class='theater_time list"+cdto.movie_num+"'>"
					}else{
						document.getElementById('time_noData').style.display="block";
					}
					
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
					
					$.each(cdto.selectSeat,function(index,seat){
						selectSeat+=seat+",";
					});
					selectSeat=selectSeat.substr(0,selectSeat.length-1);
					selectSeat=selectSeat.split(",");
					
					//하루 일정
					for(var i=0; i<cdto.runtimeS.length; i++){
						html+="<li><a href='javascript:void(0)' onclick=seatSelect('"+cdto.movie_num+"','"
						+saleTime[i]+"','"+cdto.roomNum+"','"+cdto.cinema_num+"','"+date+"','"+runtimeS[i]+"~"+runtimeE[i]+"');>"
						+"<span class='cineD2'><em>"+cdto.roomNum+"관</em></span>";
						if(saleTime[i]=="조조") html+="<span class='clock'><em class='seat iri'>조조</em>";
						if(saleTime[i]=="심야") html+="<span class='clock'><em class='seat ini'>심야</em>";
						if(saleTime[i]=="") html+="<span class='clock'>";
						html+=runtimeS[i]+"<span> ~ "+runtimeE[i]+"</span></span>"+
						"<span class='ppNum'>"+(cdto.allSeat*1-selectSeat[i]*1)+"/"+cdto.allSeat+"</span></a></li>";
						
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
	/* 있는 목록 활성화 ajax */
	function selectShow(){
		var cinema='';
		var movie='';
		var date=$('input[name="day"]:checked').val();
		var selectDate=$('.txtdate').find('dd').text();
		var html='';
		
		if($('.txtCin').find('dd').is('.on')){
			cinema=$('.txtCin').find('dd').text();
		}
		
		if($('.txtName').find('dd').is('.on')){
			movie=$('.txtName').find('dd').text();
		}
		$('.movie_list').find('a').removeClass('disabled');
		$('.cinema_zone').find('a').removeClass('disabled');
		$.ajax({
			url:"./ShowMovie.ti",
			type:"post",
			dataType:"JSON",
			data:{cinema:cinema,movie:movie,date:date},
			success:function(data){
				if(data.movieList!=""){
					var movieNum=data.movieList;
					//movieNum=movieNum.split(',');
					for(var i=0; i<movieNum.length; i++){
						$(".mov"+movieNum[i]).addClass('disabled');
					}
				}else if(data.regionList!=null){
					//alert(data.regionList);
					var regionNum=data.regionList;
					//movieNum=movieNum.split(',');
					for(var i=0; i<regionNum.length; i++){
						$('.cinema_zone').find('.'+regionNum[i]).addClass('disabled');
					}
				}
			},
			error:function(request,status,error){
				alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
            }
		});
	}

</script>

<!-- 하위 메뉴 고정 -->
<style type="text/css">
	nav>ul>li:NTH-CHILD(1)>ul {
		display: block;
	}
</style>

</head>
<body class="ticketBody">
<%
	response.setCharacterEncoding("UTF-8");
	//List<String> allDay = (List)request.getAttribute("allDay");

	List<CineDTO> cineList = (List)request.getAttribute("cineList");//모든 영화관 정보
	List allRegion = (List)request.getAttribute("allRegion");//모든지역 
	
	List<AdminMovieDTO> bookRatingList= (List)request.getAttribute("bookRatingList");
	List<AdminMovieDTO> totalRatingList= (List)request.getAttribute("totalRatingList");
	//System.out.println(cineList.size());
	int[] cineCnt=(int[])request.getAttribute("cineCnt");

%>
<%@ include file="../../include/header.jsp" %>

<div class="ticketWrap">
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
   <div class="ticket_step">
   <div class="ticket_left">
    <dl class="cinema_header">
     <dt>영화관</dt>
     <dd>최대 2개까지 선택가능</dd>
    </dl>
    <dl class="ticket"></dl>
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
          <h4><%=name%>(<em><%=cineCnt[i]%></em>)</h4>
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
     		AdminMovieDTO mdto=bookRatingList.get(i);
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
     		AdminMovieDTO mdto=totalRatingList.get(i);
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
     </div>
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
  	<!-- <div class="time_fr">
  	 <ul>
  	  <li><a href="javascript:void(0);">영화관별 조회</a></li>
  	  <li><a href="javascript:void(0);">영화별 조회</a></li>
  	 </ul>
  	</div> -->
  </div>
  <div class="time_list01"></div><!-- 영화관별 -->
  <div class="time_list02"></div><!-- 영화 별 -->
  <div id='time_noData'>
	<span class='noData'>상영중인 정보가 없습니다.</span>
  </div>
 </div>
</div>
</div>

<%@ include file="../../include/footer.jsp" %>
</body>
</html>