<%@page import="com.movie.db.MovieDAOImpl"%>
<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@page import="com.movie.db.MovieDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>

<link rel="stylesheet" href="././css/modify.css">

</head>
<body>

<%@ include file="../include/header.jsp" %>
<h1>영화 수정 페이지</h1>
<%                                                                                                                                 
	int movie_num = Integer.parseInt(request.getParameter("movie_num"));
	System.out.println("movie_num : "+movie_num);
	MovieDAOImpl mdao = new MovieDAOImpl();
	AdminMovieDTO mdto = mdao.getBoard(movie_num);
	
%>


<form action="./MovieModifyAction.am?movie_num=<%=movie_num %>" method="post" enctype="multipart/form-data">
			<legend>영화 수정</legend>

	<fieldset>
			<legend>영화 추가</legend>
				<table>
					<tr>
						<td>영화 제목</td>
						<td>
							<input type="text" name="title" value="<%=mdto.getTitle()%>">
						</td>
						<td>장르</td>
						<td>
							<select name="genre">
							<%if(mdto.getGenre().equals("액션")){%>
								<option value="액션" selected="selected" >액션</option>
								<%}else if(mdto.getGenre().equals("SF")){ %>
								<option value="SF" selected="selected">SF</option><%}else if(mdto.getGenre().equals("드라마")){ %>
								<option value="드라마" selected="selected">드라마</option><%}else if(mdto.getGenre().equals("멜로")){ %>
								<option value="멜로" selected="selected">멜로</option><%}else if(mdto.getGenre().equals("가족")){ %>
								<option value="가족" selected="selected">가족</option><%}else if(mdto.getGenre().equals("스릴러")){ %>
								<option value="스릴러" selected="selected">스릴러</option><%}else if(mdto.getGenre().equals("판타지")){ %>
								<option value="판타지" selected="selected">판타지</option><%}else if(mdto.getGenre().equals("모험")){ %>
								<option value="모험" selected="selected">모험</option><%} %>
						</select>
						</td>
					</tr>
					<tr>
						<td>제작 국가</td>
						<td>
							<input type="text" name="country" value="<%=mdto.getCountry()%>">
						</td>
						<td>등급</td>
						<td>
							<select name="grade">
								<option value="all">전체관람가</option>
								<option value="12">12</option>
								<option value="15">15</option>
								<option value="18">18</option>
								<option value="limited">제한상영가(제한관람가)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>상영 시간</td>
						<td>
							<input type="text" name="running_time" value="<%=mdto.getRunning_time()%>">
						</td>
						<td>개봉일~마감일</td>
						<td>
							<input type="text" name="open_date" placeholder="yyyyMMdd" value="<%=mdto.getOpen_date()%>"> ~
							<input type="text" name="close_date" placeholder="yyyyMMdd" value="<%=mdto.getClose_date()%>" >
						</td>
					</tr>
					<tr>
						<td>스토리</td>
						<td colspan="3">
							<textarea id="summernote" name="story"><%=mdto.getStory()%></textarea>
							<script>
								$('#summernote').summernote({
									lang: 'ko-KR',
									height: 300,
									minHeight: 100,
									maxHeight: 500
								 });
							</script>
						</td>
					</tr>
					<tr>
						<td>감독</td>
						<td>
							<input type="text" name="director" value="<%=mdto.getDirector()%>">
						</td>
						<td>배우</td>
						<td>
							<input type="text" name="actor" value="<%=mdto.getActor()%>">
						</td>
					</tr>
					<tr>
						<td>포스터</td>
						<td colspan="3" class="filebox" >
							<label for="ex_file">파일추가 </label>
							<input type="file" name="poster" id="ex_file" value="<%=mdto.getPoster()%>">
						</td>
					</tr>
					 <tr>
						<td>이미지</td>
						<td colspan="3">
							<input type="file" name="image" value="<%=mdto.getImage()%>">
						</td>
					</tr>
									 
					 <tr>
						<td colspan="4">
							<input type="submit" value="영화 수정" class="modify" >
						</td>
					</tr>
				</table>
	
		</fieldset>
		
	</form>
	
	<%@ include file="../include/footer.jsp" %>

</body>
</html>