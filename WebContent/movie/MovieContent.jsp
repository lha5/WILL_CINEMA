
<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@ page import="com.movie.db.MovieDTO"%>
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

#container {
	/* border: 1px solid lime; */
	width: 900px;
	margin: 0 auto 50px auto;
	padding: 15px;
}

#desc {
	/* border: 1px solid orange; */
	width: 100%;
	height: 300px;
}

#info {
	border-collapse: collapse;
	border-top: 2px solid #e6e6e6;
	border-bottom: 2px solid #e6e6e6;
	width: 100%;
	height: 300px;
}

#info td:NTH-CHILD(1) {
	width: 175px;
}

#info td:NTH-CHILD(2) {
	padding-left: 40px;
	text-align: left;
}

#info ul {
	line-height: 2em;
}

#info h1 {
	margin: 10px 2px;
}

.tag {
	border: 1px solid #e6e6e6;
	padding: 1px;
	margin: 2px;
	background-color: #e6e6e6;
	font-size: 14px;
}

#info li {
	font-size: 14px;
}

#synopsis, #director {
	/* border: 1px solid blue; */
	width: 100%;
	height: 250px;
	padding: 15px;
}

#synopsis {
	margin-top: 25px;
	margin-bottom: 20px;
}

#ctnt {
	margin: 20px 0;
}

hr {
	border-color: #e6e6e6;
}

#bttns {
	width: 100%;
	margin: 10px auto;
	text-align: center;
}
</style>
<link rel="stylesheet" href="././css/review.css">
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<%
	int movie_num = Integer.parseInt(request.getParameter("movie_num"));
	request.setAttribute("movie_num", movie_num);
	AdminMovieDTO mdto = (AdminMovieDTO) request.getAttribute("mdto");
	String pageNum = (String) request.getAttribute("pageNum");
	%>
		<div id="Wrap">
		
		<div id="container">
			
			<div id="desc">				
				<table id="info">
					<tr>
						<td><img src="./upload/<%=mdto.getPoster()%>" width="175px" height="250px"></td>
						<td>
							<h1><%=mdto.getTitle()%></h1>
							<ul>
								<li><span class="tag">예매율</span> <%=mdto.getBooking_ration() %> %</li>
								<li><span class="tag">관람평점</span></li>
								<li><span class="tag">등급</span> <%=mdto.getGrade()%></li>
								<li><span class="tag">개봉일</span> <%=mdto.getOpen_date() %></li>
								<li><span class="tag">기본정보</span> <%=mdto.getGenre() %></li>
								<li><span class="tag">타입</span> 2D | 3D | 4D</li>
							</ul>
						</td>
					</tr>
				</table>
			</div>
			
			<div id="synopsis">
				<h3>시놉시스</h3>
				<div id="ctnt">
					<%=mdto.getStory() %>
				</div>
			</div>
						
			<div id="director">
				<h3>감독</h3>
				<br>
				<%=mdto.getDirector() %>
				<br><br><br><br>
				<h3>배우</h3>
				<br>
				<%=mdto.getActor() %>
			</div>
		</div>
		
		
		
		<%
		if (id != null) {
			if (id.equals("admin")) {
		%>
		<div id="bttns">
			<input type="button" value="수정하기" id="button"   onclick="location.href='./MovieModify.am?movie_num=<%=mdto.getMovie_num() %>&pageNum=<%=pageNum%>'">
			<input type="button" value="삭제하기" id="button"   onclick="location.href='./MovieDelete.am?movie_num=<%=mdto.getMovie_num() %>&pageNum=<%=pageNum%>'">
		</div>
		<%
			}
		}
		%>
		</div>
		
		
		<hr>
		
		<jsp:include page="../review/reviewWrite.jsp"/>
		
		<jsp:include page="../review/reviewList.jsp"/>
		
		<%@ include file="../include/footer.jsp" %>
</body>
</html>