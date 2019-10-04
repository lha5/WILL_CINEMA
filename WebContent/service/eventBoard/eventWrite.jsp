<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>이벤트 작성 페이지</h1>
<fieldset>
	<form action="./EventWriteAction.ae" method="post"  enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>카테고리</td> 
				<td><select name="category">
						<option value="movie">영화</option>
						<option value="preview">시사회/무대인사</option>
						<option value="nevent">윌시NOW</option>
						<option value="collabo">제휴 할인</option>
				</select></td>
			<tr>
			<tr>
				<td>제목</td><td><input type="text" name="subject"></td>
			</tr>
			<tr>
				<td>날짜</td><td><input type="text" name="fDate"> ~ <input type="text" name="eDate"></td>
			</tr><!-- 날짜 선택 드롭박스 -->
			<tr>
				<td>썸네일 이미지</td><td><input type="file" name="img1"></td>
			</tr>
			<tr>
				<td>본문 이미지 1</td><td><input type="file" name="img2"></td>
			</tr>
			<tr>
				<td>본문 이미지 2</td><td><input type="file" name="img3"></td>
			</tr>
			<tr>
				<td>본문 이미지 3</td><td><input type="file" name="img4"></td>
			</tr>
		</table>
		<input type="submit" value="글 쓰기"> <input type="reset" value="취소">
	</form>
</fieldset>
</body>
</html>