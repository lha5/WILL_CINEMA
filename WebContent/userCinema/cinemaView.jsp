<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.movie.db.MovieDTO"%>
<%@page import="com.cinema.db.CineDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 영화관 지점</title>
<!--CSS  -->
<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/ticketing.css">
<style type="text/css">

/*롯데 영화관   */
/* style="width:10000px; height:420px;
 background: url(http://caching2.lottecinema.co.kr/lotte_image/2019/KimJiyoung/1025/KimJiyoung_1920420.jpg) 50% 0px 
 no-repeat;display:table-cell;vertical-align:middle" */

 
	/* 하위 메뉴 고정 */
	nav>ul>li:NTH-CHILD(3)>ul {
		display: block;
	}
 	 
	.contents {
		border: 1px solid purple;
		width: inherit;
		height: 420px;
		/* background-color: #d6d6d6; */
		margin: 0 auto;
		display: table-cell;
		vertical-align: middle
	}
	
	/* banner */
	.banner {
		position: relative;
		border: 1px solid red;
		/* width: 10000px; */
		width: auto;
		height: 420px;
		margin: 0 auto;
		padding: 0;
		overflow: hidden;
	}
	
	.banner ul {
		position: absolute;
		margin: 0px;
		padding: 0;
		list-style: none;
	}
	
	.banner ul li {
		float: left;
		/* width: 10000px; */
		width: auto;
		height: 420px;
		margin: 0;
		padding: 0;
	}
	
	#cinemaname {
		border: 1px solid blue;
		width: 800px;
		height: 400px;
		clear: both;
		text-align: center;
		margin-left:25em; 
	}
	
	nav>ul>li:NTH-CHILD(3)>ul:HOVER #sub_ul2 {
		display: block;
	}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script language="JavaScript">
	var week='';	 //요일
	$(document).ready(function() {
		/* ------------------- 달력표시 ------------------ */
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
				cnt++;
			}
		}

		//날짜 버튼 클릭시
		$(document).on('click','input:radio',function(){
		/* 	var date=$('input[name="day"]:checked').val().split("-");//radio체크된 날짜
			var mon=Number(date[1])-1;
			//체크된 날짜의 요일
			week=$('label[for="' +monthNames[mon]+date[2] +'"]').find('span').text();
			week= date[0]+"."+date[1]+"."+date[2]+"("+week+")";
			alert(week); */
			clickEvent();
		});
		
		/* 클릭 ajax */
		function clickEvent(){
			var cinema=$('input[name="cinemaName"]').val();
			var movie='';
			var date=$('input[name="day"]:checked').val();
			var html='';
			
			var date2=$('input[name="day"]:checked').val().split("-");//radio체크된 날짜
			var mon=Number(date2[1])-1;
			//체크된 날짜의 요일
			week=$('label[for="' +monthNames[mon]+date2[2] +'"]').find('span').text();
			week= date2[0]+"."+date2[1]+"."+date2[2]+"("+week+")";
			alert("클릭체크 : "+week);
			
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
		
		
		prev();
		calendar2(0);//웹 시작시
		clickEvent();
		/* ------------------- 달력표시 ------------------ */
		
		
		
		/* ------------------- 사용할 배너 ------------------ */
		var $banner = $(".banner").find("ul");

		var $bannerWidth = $banner.children().outerWidth();//배너 이미지의 폭
		var $bannerHeight = $banner.children().outerHeight(); // 높이
		var $bannerLength = $banner.children().length;//배너 이미지의 갯수
		var rollingId;

		//정해진 초마다 함수 실행
		rollingId = setInterval(function() { rollingStart(); }, 8500);//다음 이미지로 롤링 애니메이션 할 시간차

		
		function rollingStart() {
			$banner.css("width", $bannerWidth * $bannerLength + "px");
			$banner.css("height", $bannerHeight + "px");
		
			//배너의 좌측 위치를 옮겨 준다.
			$banner.animate({left: - $bannerWidth + "px"}, 8500, function() { //숫자는 롤링 진행되는 시간이다.
				
				$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
				
				$(this).find("li:first").remove();
				//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
				$(this).css("left", 0);
				//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
			});
		}
	}); 

	/*-------------- 상영시간 클릭시 좌석 선택 페이지 이동 ------------------*/
	//SeatSelect.ti로 이동
	function seatSelect(movie_num,saleTime,roomNum,cinema_num,running_date,running_time){
		var form = document.createElement("form");
		var parm = new Array();
		var input = new Array();
		alert(week);
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
	/*-------------- 상영시간 클릭시 좌석 선택 페이지 이동 ------------------*/
	
	
	function moviechk() { 	        	        
		var ciadd = $('#cilocal').val();
			 
		window.open("./userCinema/cinemalocal.jsp?cinemaAdd="+ciadd,"","width=600,height=400");     
	}
	
	function movieing(){ 	        	        
	    var movieck = $('#moving').val();
	        
	    window.open("./userCinema/movingCheck.jsp?getimage="+movieck,"","width=600,height=400");    
	}
</script>

</head>
<body>


	<div id= wrap>

	<%@ include file="../include/header.jsp" %>

	<%
	CineDTO cdto = (CineDTO)request.getAttribute("cineList");
	int count = (Integer) request.getAttribute("count");
	List<AdminMovieDTO> boardList = (List<AdminMovieDTO>) request.getAttribute("boardList");
	
	/* List allRegion = (List)request.getAttribute("allRegion");//모든지역  */
	System.out.println(cdto.getName());
	%>
	
	
<div class="banner">
			<ul>
				  <%
     	for (int i=0;i<4;i++) {
     		AdminMovieDTO mdto = boardList.get(i);
		%>
						
		<li><a href="javascript:void(0);"><img src ="./upload/<%=mdto.getImage()%>"   onclick="movieing()">
					<input type="hidden" id="moving" value="<%=mdto.getImage()%>"></li></a>
					
					<%} %>
					
					</ul>

		</div>
	
	
	<div class="contents">
		
		
	<div id="cinemaname">
	
	<table border="1">
	<%
	
	
		 %>
		<tr>
		<td colspan="2"><h2>영화관 이름 :<%=cdto.getName() %></h2> <input type="hidden" name="cinemaName" value="<%=cdto.getName() %>"></td>
		<td><input type="button" value="영화관위치" class="moviechk" onclick="moviechk();" ></td>
		</tr>
		<tr>
		<td>상영관 :<%=cdto.getRoom() %></td>
		<td>영화관 전화번호 :<%=cdto.getTel() %></td>

		<td>영화관주소 :<%=cdto.getAddr() %> <input type="hidden" id="cilocal" value="<%=cdto.getAddr() %>"></td>
		
		

		</tr>
	</table>
	</div>
	<div class="calendar"> <!-- 달력 -->
			<a href="javascript:void(0);" class="month-picker-nav prev">이전</a>
			<fieldset class="month-picker-fieldset">
				<div class="calendarArea">
				</div>
			</fieldset>
			<a href="javascript:void(0);" class='month-picker-nav next'>다음</a>
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
	
	
	<%@ include file="../include/footer.jsp" %>
	
	</div>
	
</body>
</html>