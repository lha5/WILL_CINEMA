<%@page import="com.movie.db.MovieDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no">
<title>WILL CINEMA</title>

<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- CSS 연결 -->
<link rel="stylesheet" href="css/main.css">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<style type="text/css">
<!--
	body {font-size:11pt; padding:0; margin:0; text-align: center;}
	h3 {color: #85144b; font-size: 14pt; margin:10 auto; padding: 10px;}
	.contents {width: 1100px; height: 430px; background-color: #d6d6d6; margin: 0 auto;}
	
	/* banner */
	.banner {position: relative; width: 1100px; height: 430px;   margin:0 auto; padding:0; overflow: hidden;}
	.banner ul {position: absolute; margin: 0px; padding:0; list-style: none; }
	.banner ul li {float: left; width: 1100px; height: 430px; margin:0; padding:0;}

//-->
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
		rollingId = setInterval(function() { rollingStart(); }, 8000);//다음 이미지로 롤링 애니메이션 할 시간차

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
			//alert(bannerHeight);
			//배너의 좌측 위치를 옮겨 준다.
			$banner.animate({left: - $bannerWidth + "px"}, 4500, function() { //숫자는 롤링 진행되는 시간이다.
				//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
				$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
				//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
				$(this).find("li:first").remove();
				//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
				$(this).css("left", 0);
				//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
			});
		}
	}); 

</script>

</head>
<body>
<%
		//String id = (String)session.getAttribute("id");
		
		int count = (Integer) request.getAttribute("count");
		
		List<MovieDTO> boardList = (List<MovieDTO>) request.getAttribute("boardList");
		
	%>



	<%@ include file="../include/header.jsp" %>

	<div id="wrap">

	<!-- 수정완료 -->
	
		<section>

			<div id="center">
				<article id="list">
					예매 순위
				</article>
				<article id="image">
					<div class="contents">

		<div class="banner">
			
		
			<ul>
				  <%
     	for (int i=0;i<4;i++) {
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
			</div>
		
			<div id="service">
				멤버십이나 포인트 같은 서비스 모음
			</div>
			
			<div id="notice">
				공지사항
			</div>
		</section>
	
	</div>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>