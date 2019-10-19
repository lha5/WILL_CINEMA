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
/* String id= (String)request.getAttribute("id");
if(!id.equals("admin")){
} */
%>


<fieldset>
		<legend>FAQ쓰기</legend>
		<form action="./FAQWriteAction.af" method="post">
		
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
		</form>
	</fieldset>

<fieldset>
<legend>FAQ 쓰기</legend>
<form action="./FAQWriteAction.af" method="post">

카테고리 <input type="text" name ="category"><br>
제목  <input type="text" name = "subject" > <br>
내용 <br>
<textarea name="content" rows="10" cols="10"></textarea>
이미지 <input type="file" name="image">
<input type="submit" value="FAQ 쓰기"> 
</form>

</fieldset>

</body>
</html>