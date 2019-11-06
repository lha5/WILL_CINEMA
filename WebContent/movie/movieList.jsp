<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@page import="com.movie.db.MovieDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 영화/상영작</title>

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
			// String id = (String)session.getAttribute("id");
			
			int count = (Integer) request.getAttribute("count"); 
			List<AdminMovieDTO> boardList = (List<AdminMovieDTO>) request.getAttribute("boardList");
			
			String pageNum = (String) request.getAttribute("pageNum");
			
			System.out.println("이동성공");
		%>
	
	

	<h1> 게시판 글 목록 [ 전체 글 개수 : <%=count %> 개] </h1>
   
 		 
  
	<form action="./MovieSearchAction.mo" method="post">
    <select name="searchType">
        <option value="title">제목</option>
        <option value="genre">장르</option>
        <option value="director">감독</option>
    	<option value="actor">배우</option>
    </select>
    <input type="text" name="searchText">
    <input type="submit" class="btn">
	</form>
   
   
   <table border="1">
     <tr>
       <td>영화 제목</td>
       <td>포스터</td>
       <td>장르</td>
       <td>감독</td>
       <td>상영시간</td>
       <td>내용</td>
        <td>배우</td>
     </tr>
     <% 
     	for (int i=0;i<boardList.size();i++) {
     		AdminMovieDTO mdto = boardList.get(i);
     		System.out.println(" 포스터 : "+mdto.getPoster());
    		%>
			<tr>
				<td>
					<a href="./DetailView.mo?movie_num=<%=mdto.getMovie_num() %>">
					<%=mdto.getTitle() %>
					</a>
				</td>
				<td>
					<img src="./upload/<%=mdto.getPoster()%>" height="50px" width="50px"></td>
				</td>
				<td><%=mdto.getGenre() %></td>
				<td><%=mdto.getDirector()%></td>
				<td><%=mdto.getRunning_time() %></td>
				<td><%=mdto.getStory() %></td>
				<td><%=mdto.getActor() %></td>
			</tr>
		<%}%>
	</table>
	<%
	if (id != null) {
		if (id.equals("admin")) {
	%>
		<h3><a href="./MovieAdd.am">영화 데이터 작성하기</a></h3>
	<%
		}
	}
	%>
	<%@ include file="../include/footer.jsp" %>
	
</body>
</html>