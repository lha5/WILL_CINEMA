<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 공지사항 작성</title>

<!--CSS  -->
<link rel="stylesheet" href="././css/noticeWrite.css">

<!-- summernote 적용시키기 위한 준비 -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<script src="./summernote/lang/summernote-ko-KR.js"></script>

	

</head>
<body>
	
	<%@ include file="../../include/header.jsp" %>
	
	
	
	<div id="wrap">
	
	
	
	<%
	if (id == null || !id.equals ("admin")) {
		response.sendRedirect("./Main.me");
	}
	%>
	
	<div id="sectionWrap">
		<form action="./NoticeWriteAction.an" enctype="multipart/form-data" method="post" > 
			<table>
			   	<tr>
			   		<td>글쓴이</td>
			   		<td><input type="text" name="name" value="<%=id%>"></td>
			   		<td>
			   		비밀번호 :<input type="password" name="pass"> 
			   		</td>
			   		
			   		<td>카테고리</td>
			   		<td>
			   			<select name="category">
			   				<option value="전체">전체</option>
			   				<option value="서울">서울</option>
			   				<option value="경기/인천">경기/인천</option>
			   				<option value="충청/대전">충청/대전</option>
			   				<option value="강원">강원</option>
			   				<option value="전라/광주">전라/광주</option>
			   				<option value="경북/대구">경북/대구</option>
			   				<option value="경남/부산/울산">경남/부산/울산</option>
			   				<option value="제주">제주</option>
			   			</select>
			   		</td>
				</tr>
				<tr>
			   		<td>제목</td>
			   		<td colspan="3"><input type="text" name="subject"></td>
				</tr>
				<tr>
			   		<td>내용</td>
			   		<td colspan="3">
			   			<textarea id="summernote" name="content"></textarea>
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
			   		<td>파일</td>
			   		<td colspan="3"><input type="file" name="image"></td>
				</tr>
				<tr>
			   		<td>
			   			<input type="submit" value="공지사항 작성하기" id="noticlick1">
			   		</td>
				</tr>
			</table>	
		</form>
	</div>
	
	<%@ include file="../../include/footer.jsp" %>
	
	</div>
	
</body>
</html>