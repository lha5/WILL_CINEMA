<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@page import="com.cinema.db.CineDTO"%>
<%@page import="com.admin.service.event.db.AdminEventDTO"%>
<%@page import="com.admin.service.FAQ.action.FAQListAction"%>
<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>WILL CINEMA</title>

<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- CSS 연결 -->
<link rel="stylesheet" href="./css/main.css">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


<!-- 랜덤 광고 이미지 -->
<script language = "javascript">
	var imgArray = new Array();
	imgArray[0] = "./upload/AngelHasFallen.jpg";
	imgArray[1] = "./upload/DoctorSleep.jpg";
	imgArray[2] = "./upload/Unalterable.jpg"
	imgArray[3] = "./upload/WeatheringWithYou.jpg";
	
	function showImage(){
		var imgNum = Math.round(Math.random()*3);
		var objImg = document.getElementById("introImg");
		objImg.src = imgArray[imgNum];
	}
</script>


<script language="JavaScript">

$(document).ready(function() {
	//사용할 배너
	var $banner = $(".banner").find("ul");

	var $bannerWidth = $banner.children().outerWidth();//배너 이미지의 폭
	var $bannerHeight = $banner.children().outerHeight(); // 높이
	var $bannerLength = $banner.children().length;//배너 이미지의 갯수
	var rollingId;

	//정해진 초마다 함수 실행
	rollingId = setInterval(function() { rollingStart(); }, 4000);//다음 이미지로 롤링 애니메이션 할 시간차


	
	function rollingStart() {
		$banner.css("width", $bannerWidth * $bannerLength + "px");
		$banner.css("height", $bannerHeight + "px");
		//alert(bannerHeight);
		//배너의 좌측 위치를 옮겨 준다.
		$banner.animate({left: - $bannerWidth + "px"}, 8000, function() { //숫자는 롤링 진행되는 시간이다.
			//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
			$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
			//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
			$(this).find("li:first").remove();
			//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
			$(this).css("left", 0);
			//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
		});
	}

	//마우스 오버시 롤링을 멈춘다.
	banner.mouseover(function(){
		//중지
		clearInterval(rollingId);
		$(this).css("cursor", "pointer");
	});
	//마우스 아웃되면 다시 시작
	banner.mouseout(function(){
		rollingId = setInterval(function() { rollingStart(); }, 6000);
		$(this).css("cursor", "default");
	});
	

}); 

</script>

<script>
	//FAQ 옆으로 클릭하기
	var slideIndex = 1;
	showDivs(slideIndex);
	
	function plusDivs(n) {
	  showDivs(slideIndex += n);
	}
	
	function showDivs(n) {
	  var i;
	  var x = document.getElementsByClassName("mySlides");
	  if (n > x.length) {slideIndex = 1}
	  if (n < 1) {slideIndex = x.length}
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none";  
	  }
	  x[slideIndex-1].style.display = "block";  
	}


	//예매순, 평점순 내용보여주기
	function openMovie(event,rating){
		var i, movie_list, ratingLink;
		movie_list = document.getElementsByClassName("movie_list");
		for(i=0;i<movie_list.length; i++){
			movie_list[i].style.display="none";
		}
		ratingLink=document.getElementsByClassName("ratingLink");
		for(i=0;i<ratingLink.length;i++){
			ratingLink[i].className=ratingLink[i].className.replace(" active","");
		}
		document.getElementById(rating).style.display="block";
		if(event!=null)
		event.currentTarget.className+=" active";
	}

</script>

<script type="text/javascript">
	$(function (){
		openMovie(event,'book');
	});
	
	$(function (){
		plusDivs(1);
	});
</script>

</head>
<body onload="showImage()">
	<%
	int count = (Integer) request.getAttribute("count");
	int faqcount =(Integer)request.getAttribute("faqcount"); 
	List<AdminMovieDTO> boardList = (List<AdminMovieDTO>) request.getAttribute("boardList"); // 영화관
	List<AdminFAQDTO> FAQList =(List<AdminFAQDTO>)request.getAttribute("FAQList"); //FAQ		
	List eventMovieList = (List)request.getAttribute("eventMovieList");// 이벤트1
	List eventPreviewList = (List)request.getAttribute("eventPreviewList");//이벤트2
	List eventNeventList = (List)request.getAttribute("eventNeventList");//이벤트3
	List eventCollaboList = (List)request.getAttribute("eventCollaboList");// 이벤트4
	List<CineDTO> cineList = (List)request.getAttribute("cineList");//모든 영화관 정보
	List<AdminMovieDTO> bookRatingList= (List)request.getAttribute("bookRatingList"); //예매율
	List<AdminMovieDTO> totalRatingList= (List)request.getAttribute("totalRatingList"); // 평점
	
	%>

	<%@ include file="../include/header.jsp" %>

	<div id="wrap">

	<!-- 수정완료 -->
	
		<section>

			<div id="center">
				<article id="list">
					
					<div class="movie_cont">
     <div class = "entry">
     <ul>
      <li><h5><a href="javascript:void(0);" class="ratingLink" onclick="openMovie(event,'book')">예매순</a> | 
      <a href="javascript:void(0);" class="ratingLink" onclick="openMovie(event,'total')">평점순</a></h5></li>
     
     </ul>
     </div>

       <!-- 예매순 -->
     <div class="scroll_bar">
     	<ul id="book" class="movie_list">
     	<!-- 영화 반복문 -->
     	<%for(int i=0; i<7; i++){
     		AdminMovieDTO mdto=bookRatingList.get(i);
     	%>
     	 <li>
     	  <a href="Ticketing.ti" id="booking" class="mov<%=mdto.getMovie_num() %>" 
     	  onclick='selectMov(event);'>
     	   <span  class="grade_<%=mdto.getGrade() %>"><%=mdto.getGrade() %></span>
     	   <span ><%=mdto.getTitle() %></span>
     	  	 
     	  </a>
      <span class="booking">예매율 <%=mdto.getBooking_ration() %>%</span> 
     	 </li>
     	 
     	 
     	 <%} %>
     	 <!-- 영화 반복문 -->
     	</ul>
    	 <!-- 평점순 -->
     	<ul id="total" class="movie_list">
     	<!-- 영화 반복문 -->
     	<%for(int i=0; i<7; i++){ 
     		AdminMovieDTO mdto=totalRatingList.get(i);
     		
     	%>
     	 <li>
     	 	<%=i+1 %>.
     	  <a href="Ticketing.ti" class="mov<%=mdto.getMovie_num() %>">
     	   <span class="grade_<%=mdto.getGrade() %>"><%=mdto.getGrade() %></span>
     	   <span><%=mdto.getTitle() %></span>
     	 
     	 </a>
     	 <span class="booking">평점 <%=mdto.getTotal_rating() %>점</span>
     	 </li>	
     	 
     	 
     	 
     	 <!-- 영화 반복문 --> 
     	 <%} %>
     	</ul>
     	<div id="goBook"><a href="./Ticketing.ti">예매하기</a></div>
     </div> <!--  스크롤바-->
    </div>
				</article>
				<article id="image">
					
	<div class="contents">
		<div class="banner">
			<ul>
				  <%
     	for (int i=0;i<7;i++) {
     		AdminMovieDTO mdto = boardList.get(i);
		%>
		<li><img src ="./upload/<%=mdto.getPoster() %>"></li>
					<%} %>
					</ul>
		</div>
	</div>
	
			<br>
			<br>
					
				</article>
			</div>
		
			<div id="clear"><!-- 구역 분리를 위한 태그 --></div>
			<div id="clear"><!-- 구역 분리를 위한 태그 --></div>
		
			<div id="event">
				<h3>EVENT</h3>
				<br>
			<div>
			<ul class="eventlist">
				<%for(int i=0; i<eventMovieList.size(); i++){ //영화 카테고리 리스트
					AdminEventDTO aedto=(AdminEventDTO)eventMovieList.get(i);
					if(i>1){break;}//4줄까지만 보여주기
				%>
				<li>
					<a href="./EventDetail.ae?eventId=<%=aedto.getNum() %>" >
						<img src="./upload/<%=aedto.getImage().split(",")[0]%>">
					</a>
					<%-- <p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p> --%>
				</li>
				<%} %>
			</ul>
			
			<ul class="eventlist">
				<%for(int i=0; i<eventPreviewList.size(); i++){ //시사회 카테고리 리스트
					AdminEventDTO aedto=(AdminEventDTO)eventPreviewList.get(i);
					if(i>1){break;}
				%>
				<li>
					<a href="./EventDetail.ae?eventId=<%=aedto.getNum() %>" >
						<img src="./upload/<%=aedto.getImage().split(",")[0]%>">
					</a>
					<%-- <p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p> --%>
				</li>
				<%} %>
			</ul>
		
		
			<ul class="eventlist">
				<%for(int i=0; i<eventNeventList.size(); i++){ //윌시NOW 카테고리 리스트
					AdminEventDTO aedto=(AdminEventDTO)eventNeventList.get(i);
					if(i>1){break;}
				%>
				<li>
					<a href="./EventDetail.ae?eventId=<%=aedto.getNum() %>" >
						<img src="./upload/<%=aedto.getImage().split(",")[0]%>">
					</a>
					<%-- <p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p> --%>
				</li>
				<%} %>
			</ul>
		
		
			<ul class="eventlist">
				<%
				for(int i=0; i<eventCollaboList.size(); i++){ //제휴할인 카테고리 리스트
					AdminEventDTO aedto=(AdminEventDTO)eventCollaboList.get(i);
					if(i>1){break;}
				%>
				<li>
					<a href="./EventDetail.ae?eventId=<%=aedto.getNum() %>" >
						<img src="./upload/<%=aedto.getImage().split(",")[0]%>">
					</a>
					<%-- <p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p> --%>
				</li>
				<%} %>
			</ul>
				</div>
			</div><!--이벤트 불러오기  -->
		
			<div id="service">
				<ul>
					<li><a href="#"><i class="ri-coupon-3-line ri-4x"></i><br>쿠폰 및 할인</a></li>
					<li><a href="#"><i class="ri-copper-coin-line ri-4x"></i><br>포인트</a></li>
					<li><a href="#"><i class="ri-user-star-line ri-4x"></i><br>멤버십</a></li>
					<li><a href="#"><i class="ri-user-5-line ri-4x"></i><br>청소년</a></li>
					<li><a href="#"><i class="ri-parent-line ri-4x"></i><br>패밀리</a></li>
				</ul>
			
			</div><!--서비스  -->
			
			
			
			<div id="notice"><!--공지사항  -->
				<div class="w3-content w3-display-container">
 					<ul>
 						<%
 						String notiSbj = (String) request.getAttribute("noticeSbj");
 						
 						%>
						<li>
							<div id="goNotice">
								<a href="./NoticeList.an">공지사항</a>
								<a hef="./NoticeList.an"><%=notiSbj%></a>
							</div>
						</li>
							<span id="goFAQ"><a href="./FAQUserList.af">자주 묻는 질문</a></span>
			  				<%
						     for (int i=0;i<FAQList.size();i++) {
								AdminFAQDTO afdto = FAQList.get(i);
							%>
								<li class="mySlides">
				 					<a href="./FAQUserList.af">
				 						<button class="accordion"><%=afdto.getSubject() %></button>
				 					</a>
				 					<button class="faqbut" onclick="plusDivs(-1)">&#10094;</button><button class="faqbut" onclick="plusDivs(1)">&#10095;</button>
								</li>
							<%
							} 
							%>
					</ul>
				</div>
			</div><!--공지사항  -->
		
		<div id="ad">
			<img id = "introImg" border="0">
		</div>
		
		
		</div><!--전체  -->
	</section>
	<script>
			var acc = document.getElementsByClassName("accordion");
			
			for (var i = 0; i < acc.length; i++) {
 				acc[i].addEventListener("click", function() {
    				this.classList.toggle("active");
    				var panel = this.nextElementSibling;
    				if (panel.style.display === "block") {
      					panel.style.display = "none";
    				} else {
      					panel.style.display = "block";
    				}
  				});
			}
		</script>	
	
	
	
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>