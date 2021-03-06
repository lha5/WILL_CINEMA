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

#contents {
	/* border: 1px solid red; */
	width: 1000px;
	margin: 50px auto;
}

#contents li {
	border: 1px solid #e6e6e6;
	float: left;
	margin: 10px 20px 10px 53px;
	padding: 7px;
	text-align: center;
}

#clear {
	clear: both;
}

#searching {
	margin: 20px 0 10px 500px;
}

input[type=text] {
	width: 200px;
	height: auto;
	line-height: normal;
	padding: .8em .5em;
	font-family: inherit;
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border: 1px solid #e6e6e6;
	color: #1c1c1c;
	font-size: 13px;
}

input[type=button] {
	width: 90px;
	height: 35px;
  outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border: 1px solid #d7282d;
	background-color: #d7282d;
	font-family: inherit;
	font-size: 14px;
	color: #ffffff;
	letter-spacing: 2px;
}
input[type=submit] {
	width: 75px;
	height: 35px;
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border: 1px solid #d7282d;
	background-color: #d7282d;
	font-family: inherit;
	font-size: 14px;
	color: #ffffff;
	letter-spacing: 2px;
}

.writeData {
	/* border: 1px solid yellow; */
	width: 300px;
	clear: both;
	margin: 50px auto;
	text-align: center;
}

.js-load {
    display: none;
}
.js-load.active {
    display: block;
}
.is_comp.js-load:after {
    display: none;
}
.btn-wrap, .lists, .main {
    display: block;
}

.btn-wrap {
    text-align: center;
}

.btn-wrap a{
	display:inline-block;
	width: 100%;
	height: 50px;
	font-size:18px;
	font-weight:bold;
	text-align: center;
	line-height: 50px;
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	background-color: #5a5a5a;
	color:#000;
	background: #e0dfdf;
	margin:20px auto;
	border: 1px solid #dedede;
}

</style>

<script src="./js/jquery-3.4.1.min.js"></script>

<script type="text/javascript">
	$(function(){
		load('#js-load', '6');
		$("#js-btn-wrap .button").on("click", function () {
			load('#js-load', '6', '#js-btn-wrap');
		});
	});
	function load(id, cnt, btn) {
		var girls_list = id + " .js-load:not(.active)";
		var girls_length = $(girls_list).length;
		var girls_total_cnt;
		if (cnt < girls_length) {
			girls_total_cnt = cnt;
		} else {
			girls_total_cnt = girls_length;
			$('.button').hide()
		}
		$(girls_list + ":lt(" + girls_total_cnt + ")").addClass("active");
	}
</script>



</head>
<body>
		<%@ include file="../include/header.jsp" %>	
		<%
		int count = (Integer) request.getAttribute("count"); 
		List<AdminMovieDTO> boardList = (List<AdminMovieDTO>) request.getAttribute("boardList");
			
		String pageNum = (String) request.getAttribute("pageNum");
			
		System.out.println("이동성공");
		%>
	
	<div id="contents">
		<form action="./MovieSearchAction.mo" method="post" id="searching">
		    <select name="searchType">
		        <option value="title">제목</option>
		        <option value="genre">장르</option>
		        <option value="director">감독</option>
		    	<option value="actor">배우</option>
		    </select>
		   
		    <input type="text" name="searchText">
		    <input type="submit" value="검색">		
		</form>
		<div id="js-load">
		<ul>
			<%
			for (int i = 0; i < boardList.size(); i++) {
	     		AdminMovieDTO mdto = boardList.get(i);
			%>
				<li class="js-load">
					<a href="./DetailView.mo?movie_num=<%=mdto.getMovie_num() %>">
					<img src="./upload/<%=mdto.getPoster()%>" width="228px" height="334px">
					<br><br>
					<h4><%=mdto.getTitle() %></h4>
					</a>
					예매율 <%=mdto.getBooking_ration() %>% | <%=mdto.getGenre() %>
						<% System.out.println("예매율"+mdto.getBooking_ration());%>	
				</li>			
			<%
			}
			%>
		</ul>
		<div id="js-btn-wrap" class="btn-wrap"> <a href="javascript:;" class="button">더보기</a> </div>
		</div>
		
		
		
		<div class="writeData">
			<input type="button" value="목록으로" onclick="location.href='./MovieList.mo?pageNum=<%=pageNum%>'"/>
		</div>
		
		<%
		if (id != null) {
			if (id.equals("admin")) {
		%>
		<div class="writeData">
			<h3><a href="./MovieAdd.am">영화 데이터 작성하기</a></h3>
		</div>
		<%
			}
		}
		%>
	</div>
	<div id="clear"></div>
	   	
	<%@ include file="../include/footer.jsp" %>
	
</body>
</html>