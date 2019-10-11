<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA</title>
</head>
<body>
<h1>WebContent/board/QnAWrite.jsp</h1>
	
	<fieldset>
		<legend>글쓰기</legend>
		<form action="./QnAWriteAction.sq" method="post">
		
			<table>
				<tr>
					<td>작성자</td>
					<td>
						<input type="text" name="name" value="">
						<input type="hidden" value=""><!-- 비밀번호 저장 -->
					</td>
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
					<td colspan="3">
						<input type="text" name="subject">
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3">
						<textarea name="content" row="10" cols="50">summernote넣기</textarea>
					</td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td colspan="3">
						<input type="file" name="image">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="submit" value="글쓰기">
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
	
</body>
</html>