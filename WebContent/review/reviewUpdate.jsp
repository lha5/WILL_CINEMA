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
		int num = Integer.parseInt(request.getParameter("num"));
		int movie_num = Integer.parseInt(request.getParameter("movie_num"));
		String id = (String)session.getAttribute("id");
		System.out.println("id : "+id);
		if(id == null){
			response.sendRedirect("./MemberLogin.me");
		}

	%>
	
	<fieldset>
		<legend>리뷰 수정</legend>
		<form action="./MovieReviewUpadatAction.mr?movie_num=<%=movie_num %>&num=<%=num %>" method="post">
			<table>
				<tr>
					<td>평점</td>
					<td>
						<select name="rating">
							<option value=1>1</option>
							<option value=2>2</option>
							<option value=3>3</option>
							<option value=4>4</option>
							<option value=5>5</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3">
						<textarea name="content" row="10" cols="50">summernote넣기</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="submit" value="글수정">
					</td>
				</tr>
			</table>

		</form>
	</fieldset>
</body>
</html>