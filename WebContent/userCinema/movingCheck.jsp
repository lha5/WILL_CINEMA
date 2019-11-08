<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String moving = request.getParameter("getimage");
System.out.println(moving);

%>

<%if(moving.equals("movieIm1.jpg")) {%>
<video width="1000" height="600" controls><!--controls ,autoplay  -->
  <source src="http://caching2.lottecinema.co.kr/lotte_image/2019/KeepSecret/KeepSecret_1280720_1.mp4"
  type="video/mp4"></source>
 </video>
<%}else if(moving.equals("movieIm2.jpg")){ %>
<video width="1000" height="600" controls><!--controls ,autoplay  -->
  <source src=
  "http://caching2.lottecinema.co.kr/lotte_image/2019/AngelHasFallen/1104/AngelHasFallen_1280720.mp4"
  type="video/mp4"></source>
 </video>
<%}else if(moving.equals("movieIm3.jpg")){ %>
<video width="1000" height="600" controls><!--controls ,autoplay  -->
  <source src=
  "http://caching2.lottecinema.co.kr/lotte_image/2019/Unalterable/Unalterable_1280720.mp4"
  type="video/mp4"></source>
 </video>
<%}else if(moving.equals("movieIm4.jpg")){ %>

<video width="1000" height="600" controls><!--controls ,autoplay  -->
  <source src="http://caching2.lottecinema.co.kr/lotte_image/2019/Wrathful/1023/Wrathful_1280720.mp4"
  type="video/mp4"></source>
 </video>
<%} %>





<!-- movieIm1.jpg  -캔 스크릿 1
movieIm2.jpg   -엔젤해즈폴른
movieIm3.jpg -얼 보스
movieIm4.jpg - 신의한수 -->


</body>
</html>