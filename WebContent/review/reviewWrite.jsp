
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
	
	<fieldset class="accordion">
		<form action="./MovieReviewWriteAction.mr?movie_num=<%=movie_num %>" name="reviewAddfr" method="post"
			onsubmit="return reviewNonCheck()">
			<div ><!-- class="table" -->
			<table>
				<tr>
					<td id="font"> 리뷰</td>
					<td>
						<textarea id="right" name="content" row="10" cols="70" 
							placeholder="아름다운 말로 멋진 영화를 빛내주세요"></textarea>	
					</td>
				</tr>
				<tr>
					<td><select name="rating">
						<option value=1>1</option>
						<option value=2>2</option>
						<option value=3>3</option>
						<option value=4>4</option>
						<option value=5>5</option>

				</select>  <input type="submit"  value="글쓰기" id="button2"></td>
				</tr>
			</table>

 


			</div>
		</form>
	</fieldset>

	</div>

</body>
</html>