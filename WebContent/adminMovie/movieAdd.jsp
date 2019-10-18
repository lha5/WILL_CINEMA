<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>영화추가 페이지(관리자)</h1>
<form action="./MovieAddAction.am" method="post">
	<fieldset>
		<legend>영화 추가</legend>
			<table>
				<tr>
					<td>영화 제목</td>
					<td>
						<input type="text" name="name" value="">
						<input type="hidden" value=""><!-- 비밀번호 저장 -->
					</td>
					<td>장르</td>
					<td>
						<select name="genre">
						<option value="#">#</option>
						<option value="$">$</option>
						<option value="&">&</option>
						<option value="*">*</option>
					</select>
					</td>
				</tr>
				<tr>
					<td>상영 국가</td>
					<td>
						<input type="text" name="country" value="">
					</td>
				</tr>
				<tr>
					<td>상영 시간</td>
					<td>
						<input type="text" name="running_time" value="">
					</td>
				</tr>
				<tr>
					<td>감독</td>
					<td colspan="3">
						<input type="text" name="director">
					</td>
				</tr>
				<tr>
					<td>스토리</td>
					<td colspan="3">
						<textarea name="story" row="10" cols="50">summernote넣기</textarea>
					</td>
				</tr>
				<tr>
					<td>배우</td>
					<td>
						<input type="text" name="actor">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="submit" value="영화 추가">
					</td>
				</tr>
			</table>

	</fieldset>
	
</form>
</body>
</html>