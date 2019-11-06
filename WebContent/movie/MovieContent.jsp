
<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@ page import="com.movie.db.MovieDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 영화 상세 보기</title>

<!-- 하위 메뉴 고정 -->
<style type="text/css">
	nav>ul>li:NTH-CHILD(2)>ul {
		display: block;
	}
</style>

</head>
<body>

	<%@ include file="../include/header.jsp" %>

<%
	int movie_num = Integer.parseInt(request.getParameter("movie_num"));
	request.setAttribute("movie_num", movie_num);
	System.out.println("Attribute : "+request.getAttribute("movie_num"));
	AdminMovieDTO mdto = (AdminMovieDTO) request.getAttribute("mdto");
	String pageNum = (String) request.getAttribute("pageNum");
	System.out.println(" id : "+session.getAttribute("id"));

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
			
			<%-- <tr>	
				<td>이미지</td>
				<td colspan="5">
					<img src="./upload/<%=mdto.getImage()%>" height="50px" width="50px"></td>
				
			</tr> --%>
			<tr>	
				<td>포스터</td>
				<td colspan="5">
					<img src="./upload/<%=mdto.getPoster()%>" height="50px" width="50px"></td>
				
			</tr>
			<tr>
				<td>줄거리 내용</td>
				<td colspan="5"><%=mdto.getStory() %>
				</td>	
			</tr>
			<tr>
				<td>감독</td>
				<td colspan="5"><%=mdto.getDirector() %>
				</td>		
			</tr>
			
			<tr>
				<td>출연진</td>
			<td colspan="5"><%=mdto.getActor() %>
			</td>
			</tr>
			<%
			if(session.getAttribute("id").equals("admin")){
			%>
			<tr>
				<td colspan="6">
					<input type="button" value="수정하기" onclick="location.href='./MovieModify.am?movie_num=<%=mdto.getMovie_num() %>&pageNum=<%=pageNum%>'">
					<input type="button" value="삭제하기" onclick="location.href='./MovieDelete.am?movie_num=<%=mdto.getMovie_num() %>&pageNum=<%=pageNum%>'">
				</td>
			</tr>
			<%
			}
			%>
		</table>

	<jsp:include page="../review/reviewList.jsp"/>

	<jsp:include page="../review/reviewWrite.jsp"/>

	<%@ include file="../include/footer.jsp" %>




</body>

</html>