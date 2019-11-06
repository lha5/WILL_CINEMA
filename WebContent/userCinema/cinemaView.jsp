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
		width: 600px;
		height: 200px;
		clear: both;
		margin: 10px auto 10px 25em;
		text-align: center;
	}
	
	nav>ul>li:NTH-CHILD(3)>ul:HOVER #sub_ul2 {
		display: block;
	}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script language="JavaScript">

	$(document).ready(function() {
		//사용할 배너
		var $banner = $(".banner").find("ul");

		var $bannerWidth = $banner.children().outerWidth();//배너 이미지의 폭
		var $bannerHeight = $banner.children().outerHeight(); // 높이
		var $bannerLength = $banner.children().length;//배너 이미지의 갯수
		var rollingId;

		//정해진 초마다 함수 실행
		rollingId = setInterval(function() { rollingStart(); }, 10000);//다음 이미지로 롤링 애니메이션 할 시간차

		//마우스 오버시 롤링을 멈춘다.
		banner.mouseover(function(){
			//중지
			clearInterval(rollingId);
			$(this).css("cursor", "pointer");
		});
		//마우스 아웃되면 다시 시작
		banner.mouseout(function(){
			rollingId = setInterval(function() { rollingStart(); }, 10000);
			$(this).css("cursor", "default");
		});
		
		function rollingStart() {
			$banner.css("width", $bannerWidth * $bannerLength + "px");
			$banner.css("height", $bannerHeight + "px");
		
			//배너의 좌측 위치를 옮겨 준다.
			$banner.animate({left: - $bannerWidth + "px"}, 10000, function() { //숫자는 롤링 진행되는 시간이다.
				
				$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
				
				$(this).find("li:first").remove();
				//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
				$(this).css("left", 0);
				//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
			});
		}
	}); 

	
	
	
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
	%>
	
	
<div class="banner">
			<ul>
				  <%
     	for (int i=0;i<3;i++) {
     		AdminMovieDTO mdto = boardList.get(i);
		%>
						
		<li><img src ="./upload/<%=mdto.getImage()%>"  class="movieing" onclick="movieing()"></li>
					<li><input type="hidden" id="moving" value="<%=mdto.getImage()%>"><li>
					<%} %>
					</ul>

		</div>
	
	
	<div class="contents">
		
		
	<div id="cinemaname">
	
	<table border="1">
	<%
	
	
		 %>
		<tr>
		<td>영화관 넘버 :<%=cdto.getCinema_num() %></td>
		<td><h2>영화관 이름 :<%=cdto.getName() %></h2></td>
		<td><input type="button" value="영화관위치" class="moviechk" onclick="moviechk();" ></td>
		</tr>
		<tr>
		<td>상영관 :<%=cdto.getRoom() %></td>
		<td>영화관 전화번호 :<%=cdto.getTel() %></td>
		<td>영화관주소 :<%=cdto.getAddr() %></td>
		<td><input type="hidden" id="cilocal" value="<%=cdto.getAddr() %>"></td>
		
		
		
	
		</tr>
		
	
	
	</table>
	
	</div>
	
	</div>
	
	
	<%@ include file="../include/footer.jsp" %>
	
	</div>
	
</body>
</html>