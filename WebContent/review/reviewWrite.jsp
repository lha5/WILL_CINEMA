
<%@page import="com.movie.db.MovieDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="././css/review.css">
<script type="text/javascript">
	function reviewNonCheck() { 
		if(document.reviewAddfr.content.value == ""){
			alert("리뷰를 입력해 주십시오.");
			document.reviewAddfr.content.focus();
			return false;
		}
	}

</script>

</head>
<body>
	
	<%
	int movie_num = Integer.parseInt(request.getParameter("movie_num"));
	%>
	
	<div id="Wrap">
	
	<%-- <fieldset class="accordion">
		<form action="./MovieReviewWriteAction.mr?movie_num=<%=movie_num %>" name="reviewAddfr" method="post"
			onsubmit="return reviewNonCheck()">
			<div ><!-- class="table" -->
			<table>
				<tr>
					<td>
						<textarea id="textBox"  name="content" row="10" cols="50"
							placeholder="아름다운 말로 멋진 영화를 빛내주세요"></textarea>	
							<select name="rating">
								<option value=1>1</option>
								<option value=2>2</option>
								<option value=3>3</option>
								<option value=4>4</option>
								<option value=5>5</option>
		
							</select>  
							<input type="submit"  value="글쓰기" id="button2">
					</td>
				</tr>
			</table>

 


			</div>
		</form>
	</fieldset> --%>

		<fieldset>
			<h2>평점 및 영화 리뷰</h2>
			<form action="./MovieReviewWriteAction.mr?movie_num=<%=movie_num %>" method="post" id="rvwForm">
				<table>
					<tr>
						<td>
							<div class="rate">
							    <input type="radio" id="star5" name="rating" value="5" />
							    <label for="star5" title="text">5 stars</label>
							    <input type="radio" id="star4" name="rating" value="4" />
							    <label for="star4" title="text">4 stars</label>
							    <input type="radio" id="star3" name="rating" value="3" />
							    <label for="star3" title="text">3 stars</label>
							    <input type="radio" id="star2" name="rating" value="2" />
							    <label for="star2" title="text">2 stars</label>
							    <input type="radio" id="star1" name="rating" value="1" />
							    <label for="star1" title="text">1 star</label>
  							</div>
						</td>
						<td>
							<textarea id="right" name="content" row="5" cols="80" placeholder="로그인 후 이용 가능합니다."></textarea>
						</td>
						<td><input type="submit" value="리뷰 입력"></td>
					</tr>
				</table>
			</form>
		</fieldset>

	</div>

</body>
</html>