<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
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
AdminFAQDTO afdto =(AdminFAQDTO) request.getAttribute("afdto");
String pageNum = (String) request.getAttribute("pageNum");	
%>

<fieldset>
<legend>FAQ 글 수정하기</legend>
<form action="./FAQUpdateAction.af?pageNum=<%=pageNum %>" method="post">
<<<<<<< HEAD
 
		
			<table>
				<tr>
				<td>카테고리</td>
					<td>
						<select name="category">
						<option value="영화예매">영화 예매</option>
						<option value="매점구매">매점 구매</option>
						<option value="이용안내">사이트 이용 안내</option>
						<option value="이벤트">이벤트</option>
						<option value="멤버십">멤버십/포인트</option>
						<option value="쿠폰">쿠폰</option>
					</select>
					</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="2">
						<input type="text" name="subject">
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="2">
						<textarea name="content" row="10" cols="50">내용입력</textarea>
					</td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td colspan="2">
						<input type="file" name="image">
					</td>
				</tr>
				<tr>
					<td colspan="8">
						<input type="submit" value="FAQ쓰기">
					</td>
				</tr>
			</table>
	
=======
 <input type="hidden" name="num" value="<%= afdto.getNum()%>">
카테고리<input type="text" name ="category" value="<%=afdto.getCategory() %>">
제목:<input type="text" name = "subject" value="<%=afdto.getSubject()%>"><br>
내용:<textarea name="content" rows="10" cols="10"><%=afdto.getContent() %></textarea><br>

<input type="submit" value="FAQ 수정하기">
>>>>>>> branch 'master' of https://github.com/lha5/WILL_CINEMA.git
</form>
</fieldset>

</body>
</html>