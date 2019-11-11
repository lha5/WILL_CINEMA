
<%@page import="com.review.db.MovieReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 리뷰 및 평점</title>
<!-- Remix Icon -->
<link href="https://cdn.remixicon.com/releases/v2.1.0/remixicon.css" rel="stylesheet">

<!-- CSS -->
<style type="text/css">
#tbl {
	border-collapse: collapse;
	/* border: 1px solid #e6e6e6; */
	width: 900px;
	margin: 10px auto;
}

#tbl td {
	line-height: 2em;
	padding: 15px 20px;
	border-top: 1px solid #e6e6e6;
	border-bottom: 1px solid #e6e6e6;
}

#tbl td:NTH-CHILD(1) {
	width: 250px;
	text-align: center;
	border-right: 1px solid #e6e6e6;
}

#tbl td:NTH-CHILD(2) {
	text-align: left;
}

.ri-star-fill {
	color: #d7282d;
}

input[type=button] {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 70px;
	height: 40px;
	border: 1px solid #1c1c1c;
	background-color: #ffffff;
	font-family: inherit;
	font-size: 14px;
	color: #1c1c1c;
	letter-spacing: 2px;
}
</style>

</head>
<body>
	
	
	<%	
		String id = (String) session.getAttribute("id");
	
		int movie_num = (int) request.getAttribute("movie_num");
		
		int count = (Integer) request.getAttribute("count");
		
		List<MovieReviewDTO> boardList = (List<MovieReviewDTO>) request.getAttribute("boardList");
		
		System.out.println("boardList : "+boardList+" id : "+id);
	%>
	<div id="Wrap">	

	 <table id="table" border="0">
	 <%for(int i=0;i<boardList.size();i++){ 
	 	MovieReviewDTO mrdto = boardList.get(i);
	 %>
     <tr>
       <td>평점</td><td><%=mrdto.getRating() %></td><td><%=mrdto.getId() %></td>
     </tr>
     <tr>
       <td colspan="3"><%=mrdto.getContent() %></td>
     </tr>
	     <%
	     if (id != null) {
	     	if(id.equals(mrdto.getId())){ %>
	     <tr>
	     	<td colspan="8">
	     	<div class="rightloat">
		     	<input type="button" id="button1" value="수정하기" onclick="location.href='./MovieReviewUpdate.mr?movie_num=<%=movie_num %>&num=<%=mrdto.getNum() %>'">
				<input type="button" id="button1" value="삭제하기" onclick="location.href='./MovieReviewDeleteAction.mr?movie_num=<%=movie_num %>&num=<%=mrdto.getNum() %>'">
	     	</div>
	
	     	</td>
			<%
				}
			}
	     } 
		%>
		</tr>
	</table>
	
	</div>	

</body>
</html>