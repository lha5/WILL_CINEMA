<%@page import="com.cinema.db.CineDTO"%>
<%@page import="com.admin.service.event.db.AdminEventDTO"%>
<%@page import="com.admin.service.FAQ.action.FAQListAction"%>
<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
<%@page import="com.movie.db.MovieDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
.mySlides {display:none;}
</style>

<title>WILL CINEMA</title>

<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- CSS 연결 -->
<link rel="stylesheet" href="css/main.css">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<style type="text/css">

	body {font-size:11pt; padding:0; margin:0; text-align: center;}
	h3 {color: #85144b; font-size: 14pt; margin:10 auto; padding: 10px;}
	.contents {width: 900px; height: 500px; background-color: #d6d6d6; margin: 0 auto;}
	
	/* banner */
	.banner {position: relative; width: 900px; height: 500px;   margin:0 auto; padding:0; overflow: hidden;}
	.banner ul {position: absolute; margin: 0px; padding:0; list-style: none; }
	.banner ul li {float: left; width: 900px; height: 500px; margin:0; padding:0;}

.movie_list {
  display: none;
}

.movie_cont a.active{
	font-weight: bold;
}

.movie_list a.on{
	font-weight: bold;
}
.accordion {
  background-color: #eee;
  color: #444;
  cursor: pointer;
  padding: 20px;
  margin-top : 20px;
  width: 100%;
  border: none;
  text-align: center;
  outline: none;
  font-size: 15px;
  transition: 1s;
}

.active, .accordion:hover {
  background-color: #ccc; 
}

.panel {
  /* padding: 0 18px; */
   margin-top : 30px;
  display: none;
  background-color: white;
  overflow: hidden;
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
		rollingId = setInterval(function() { rollingStart(); }, 6000);//다음 이미지로 롤링 애니메이션 할 시간차

		//마우스 오버시 롤링을 멈춘다.
		banner.mouseover(function(){
			//중지
			clearInterval(rollingId);
			$(this).css("cursor", "pointer");
		});
		//마우스 아웃되면 다시 시작
		banner.mouseout(function(){
			rollingId = setInterval(function() { rollingStart(); }, 4500);
			$(this).css("cursor", "default");
		});
		
		function rollingStart() {
			$banner.css("width", $bannerWidth * $bannerLength + "px");
			$banner.css("height", $bannerHeight + "px");
		
			//배너의 좌측 위치를 옮겨 준다.
			$banner.animate({left: - $bannerWidth + "px"}, 4500, function() { //숫자는 롤링 진행되는 시간이다.
				
				$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
				
				$(this).find("li:first").remove();
				//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
				$(this).css("left", 0);
				//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
			});
		}
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


</head>
<body>
<%
		//String id = (String)session.getAttribute("id");
		
int count = (Integer) request.getAttribute("count");
int faqcount =(Integer)request.getAttribute("faqcount");
List<MovieDTO> boardList = (List<MovieDTO>) request.getAttribute("boardList");
List<AdminFAQDTO> FAQList =(List<AdminFAQDTO>)request.getAttribute("FAQList");		
List eventMovieList = (List)request.getAttribute("eventMovieList");
List eventPreviewList = (List)request.getAttribute("eventPreviewList");
List eventNeventList = (List)request.getAttribute("eventNeventList");
List eventCollaboList = (List)request.getAttribute("eventCollaboList");
	
List<CineDTO> cineList = (List)request.getAttribute("cineList");//모든 영화관 정보

List<MovieDTO> bookRatingList= (List)request.getAttribute("bookRatingList");
List<MovieDTO> totalRatingList= (List)request.getAttribute("totalRatingList");

	
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
      <li><h5><a href="javascript:void(0);" class="ratingLink" onclick="openMovie(event,'book')">예매순</a>
      <a href="javascript:void(0);" class="ratingLink" onclick="openMovie(event,'total')">평점순</a></h5></li>
     </ul>
     </div>
     <!-- 예매순 -->
     <div class="scroll_bar">
     	<ul id="book" class="movie_list">
     	<!-- 영화 반복문 -->
     	<%for(int i=0; i<8; i++){
     		MovieDTO mdto=bookRatingList.get(i);
     	%>
     	 <li class="booking">
     	  <a href="javascript:void(0);" class="mov<%=mdto.getMovie_num() %>" 
     	  onclick='selectMov(event);'>
     	   
     	   <span><%=i+1 %></span>
     	   <span><%=mdto.getGrade() %>세</span>
     	   <span><%=mdto.getTitle() %></span>
     	  </a>
     	 </li>
     	  <li><span class="booking1">예매율 : <%=mdto.getBooking_ration() %></span>
     	  </li>
     	  
     	 <%} %>
     	 <!-- 영화 반복문 -->
     	</ul>
    	 <!-- 평점순 -->
     	<ul id="total" class="movie_list">
     	<!-- 영화 반복문 -->
     	<%for(int i=0; i<8; i++){ 
     		MovieDTO mdto=totalRatingList.get(i);
     		
     	%>
     	 <li class="booking">
     	  <a href="javascript:void(0);" class="mov<%=mdto.getMovie_num() %>">
     	   <span><%=i+1 %></span>
     	   <span><%=mdto.getGrade() %>세</span>
     	   <span><%=mdto.getTitle() %></span>
     	 </a>
     	 
     	 </li>	
     	 <li>
     	 <span class="booking1">평점 : <%=mdto.getTotal_rating() %></span>
     	 </li>
     	 
     	 
     	  
     	 <%} %>
     	 <!-- 영화 반복문 -->
     	</ul>
     </div>
    </div>
				</article>
				<article id="image">
					
					
	<div class="contents">
		<div class="banner">
			
		
			<ul>
				  <%
     	for (int i=0;i<3;i++) {
    		MovieDTO mdto = boardList.get(i);
		%>
		<li><img src ="./upload/<%=mdto.getPoster()%>"></li>
					<%} %>
					</ul>
		
		
		</div>
	</div>
					
				</article>
			</div>
		
			<div id="clear"><!-- 구역 분리를 위한 태그 --></div>
			<div id="clear"><!-- 구역 분리를 위한 태그 --></div>
		
			<div id="event">
				이벤트
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
					<p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p>
				</il>
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
					<p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p>
				</il>
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
					<p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p>
				</il>
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
					<p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p>
				</il>
				<%} %>
			</ul>
				</div>
			</div>
		
			<div id="service">
				멤버십이나 포인트 같은 서비스 모음
		
		<div style="width:700px; margin:0 auto;">
<a href="#"><img style="width:24%" src="./img/main/discount.gif" alt ="할인내역"></a>
<a href="#"><img style="width:24%" src="./img/main/point.gif" alt="포인트내역"></a>
<a href="#"><img style="width:24%" src="./img/main/VIP.gif" alt="VIP"></a>
<a href="#"><img style="width:24%" src="./img/main/tintin.gif" alt="어린이"></a>
</div>
		
			</div>
			
			<div id="notice">
			
		<div class="w3-content w3-display-container">
 	
 	<ul>
			
		<li><a href="./FAQList.af" style="color:blue" ><h2>FAQ</h2></a></li>	  <%
     	for (int i=0;i<FAQList.size();i++) {
			AdminFAQDTO afdto = FAQList.get(i);
		%>
		
		<li class="mySlides">
		
		<button class="accordion"> 주제 : <%=afdto.getSubject() %></button>
		
		<div class="panel">

 카테고리: <%=afdto.getCategory() %><br>
 제목:  <%=afdto.getSubject() %><br>
 이미지: <img src="./upload/<%=afdto.getImage()%>" width="100" height="100"><br>
 내용:<%=afdto.getContent()%><br>
 
</div>

		</li>
					<%} %>
					</ul>

 
 
  
   <button class="w3-button w3-black w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
  <button class="w3-button w3-black w3-display-right" onclick="plusDivs(1)">&#10095;</button>
  
</div>
		
			
		
		</div>
		
		
			</div>
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