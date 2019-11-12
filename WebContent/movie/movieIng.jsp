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
String movie =request.getParameter("mmovingnum");
System.out.print(movie);
%>




<!--  -->
<%if(movie.equals("Joker.jpg")) {%>
<video width="1000" height="600" controls><!--controls ,autoplay  -->
  <source src="http://caching.lottecinema.co.kr//Media/MovieFile/MovieMedia/201910/14879_301_1.mp4"
  type="video/mp4"></source>
 </video>
<%}else if(movie.equals("Mal2.jpg")){ %>
<video width="1000" height="600" controls><!--controls ,autoplay  -->
  <source src=
  "http://caching.lottecinema.co.kr//Media/MovieFile/MovieMedia/201910/14314_301_1.mp4"
  type="video/mp4"></source>
 </video>
<%}else if(movie.equals("summer.jpg")){ %>
<video width="1000" height="600" controls><!--controls ,autoplay  -->
  <source src=
  "http://caching.lottecinema.co.kr//Media/MovieFile/MovieMedia/201910/14853_301_1.mp4"
  type="video/mp4"></source>
 </video>

<%} %>



</body>
</html>