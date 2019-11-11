<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 관리자 영화 등록 페이지</title>

<!-- summernote 적용시키기 위한 준비 -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<script src="./summernote/lang/summernote-ko-KR.js"></script>

</head>
<body>

	<%@ include file="../include/header.jsp" %>


	<form action="./MovieAddAction.am" method="post" enctype="multipart/form-data">
		<fieldset>
			<legend>영화 추가</legend>
				<table>
					<tr>
						<td>영화 제목</td>
						<td>
							<input type="text" name="title">
						</td>
						<td>장르</td>
						<td>
							<select name="genre">
								<option value="액션">액션</option>
								<option value="SF">SF</option>
								<option value="드라마">드라마</option>
								<option value="멜로">멜로</option>
								<option value="가족">가족</option>
								<option value="스릴러">스릴러</option>
								<option value="판타지">판타지</option>
								<option value="모험">모험</option>
						</select>
						</td>
					</tr>
					<tr>
						<td>제작 국가</td>
						<td>
							<input type="text" name="country">
						</td>
						<td>등급</td>
						<td>
							<select name="grade">
								<option value="all">전체관람가</option>
								<option value="12">12세관람가</option>
								<option value="15">15세관람가</option>
								<option value="19">청소년관람불가</option>
								<option value="limited">제한상영가(제한관람가)</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>상영 시간</td>
						<td>
							<input type="text" name="running_time">
						</td>
						<td>개봉일~마감일</td>
						<td>
							<input type="text" name="open_date" placeholder="yyyyMMdd"> ~
							<input type="text" name="close_date" placeholder="yyyyMMdd">
						</td>
					</tr>
					<tr>
						<td>스토리</td>
						<td colspan="3">
							<textarea id="summernote" name="story"></textarea>
							<script>
								$('#summernote').summernote({
									lang: 'ko-KR',
									height: 300,
									minHeight: 100,
									maxHeight: 500
								 });
							</script>
						</td>
					</tr>
					<tr>
						<td>감독</td>
						<td>
							<input type="text" name="director">
						</td>
						<td>배우</td>
						<td>
							<input type="text" name="actor">
						</td>
					</tr>
					<tr>
						<td>포스터</td>
						<td colspan="3">
							<input type="file" name="poster">
						</td>
					</tr>
					<tr>
						<td>스틸컷</td>
						<td colspan="3">
							<input type="file" name="image">
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
	
	<%@ include file="../include/footer.jsp" %>
	
</body>
</html>