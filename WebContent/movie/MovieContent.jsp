<%@page import="com.movie.db.MovieDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상세보기</title>
</head>
<body>

<h1>WebContent/movie/MovieContent.jsp</h1>


<%MovieDTO mdto = (MovieDTO) request.getAttribute("mdto");
String pageNum = (String) request.getAttribute("pageNum");

%>
		<table border="1">
			<tr>
				<td>제목</td>
				<td colspan="5"><%=mdto.getTitle() %></td>
			</tr>
		
			<tr>
				
				<td>예매순위</td>
				<td><%=mdto.getBooking_ration() %></td>
				<td>개봉일</td>
				<td><%=mdto.getOpen_date() %></td>
				<td>장르</td>
				<td><%=mdto.getGenre() %></td>
			</tr>
			
			<tr>	
				<td>이미지</td>
				<td colspan="5">
					<a href="./upload/<%=mdto.getImage() %>"><%=mdto.getImage() %></a>
				
				
				</td>
			</tr>
			<tr>
				<td>줄거리 내용</td>
				<td colspan="5"><%=mdto.getStory() %>
				</td>	
			</tr>
			<tr>
				<td>감독 및 출연</td>
				<td colspan="5"><%=mdto.getDirector() %><%=mdto.getActor() %>
				</td>		
			</tr>
			<tr>
				<td colspan="6">
					<input type="button" value="수정하기" onclick="location.href='./MovieModify.am?movie_num=<%=mdto.getMovie_num() %>&pageNum=<%=pageNum%>'">
					<input type="button" value="삭제하기" onclick="location.href='./MovieDelete.am?movie_num=<%=mdto.getMovie_num() %>&pageNum=<%=pageNum%>'">
				</td>
			</tr>
		</table>










</body>
</html>