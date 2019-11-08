<%@page import="com.admin.service.notice.db.AdminNoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 공지사항 내용 수정</title>

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
	<div id="updatewrap">
	<%
	AdminNoticeDTO andto =(AdminNoticeDTO) request.getAttribute("andto");
	String pageNum = (String) request.getAttribute("pageNum");
	
	String image = andto.getImage();
	%>

	<fieldset>
		<form action="./NoticeUpdateAction.an?pageNum=<%=pageNum %>" enctype="multipart/form-data" method="post" > 
			<table>
			   	<tr>
			   		<td>글쓴이</td>
			   		<td>
			   			<input type="hidden" name="num" value="<%=andto.getNum()%>">
			   			<input type="text" name="name" value="<%=andto.getName()%>" readonly><br>
			   		</td>
			   		<td>
			   		비밀번호 :<input type="password" name="pass"> 
			   		</td>
			   		<td>카테고리</td>
			   		<td>
			   			<select name="category">
			   				<option value="전체" <%if (andto.getCategory().equals("전체")) {%>selected<%}%>>전체</option>
			   				<option value="서울" <%if (andto.getCategory().equals("서울")) {%>selected<%}%>>서울</option>
			   				<option value="경기/인천" <%if (andto.getCategory().equals("경기/인천")) {%>selected<%}%>>경기/인천</option>
			   				<option value="충청/대전" <%if (andto.getCategory().equals("충청/대전")) {%>selected<%}%>>충청/대전</option>
			   				<option value="강원" <%if (andto.getCategory().equals("강원")) {%>selected<%}%>>강원</option>
			   				<option value="전라/광주" <%if (andto.getCategory().equals("전라/광주")) {%>selected<%}%>>전라/광주</option>
			   				<option value="경북/대구" <%if (andto.getCategory().equals("경북/대구")) {%>selected<%}%>>경북/대구</option>
			   				<option value="경남/부산/울산" <%if (andto.getCategory().equals("경남/부산/울산")) {%>selected<%}%>>경남/부산/울산</option>
			   				<option value="제주" <%if (andto.getCategory().equals("제주")) {%>selected<%}%>>제주</option>
			   			</select>
			   		</td>
				
				</tr>
				<tr>
			   		<td>제목</td>
			   		<td colspan="3"><input type="text" name="subject" value="<%=andto.getSubject()%>"></td>
				</tr>
				<tr>
			   		<td>내용</td>
			   		<td colspan="3">
			   			<textarea id="summernote" name="content">
			   				<%=andto.getContent()%>
			   				<br>
			   				<%-- <%
			   				if (image != null) {
			   				 %>
			   					<img alt="image" src="./upload/<%=image%>">
			   				<%
			   				}
			   				%>  --%>
			   			</textarea>
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
			   		<td colspan="1"><input type="file" name="image" value="<%=andto.getImage()%>"></td>
				</tr>
				<tr>
			   		
			   		
			   		
			   		
			   		<td>
			   			<input type="submit" value="공지사항 수정하기">
			   		</td>
				</tr>
			</table>	
		
		</form>
	</fieldset>
	
		</div>
		</div>
	<%@ include file="../../include/footer.jsp" %>
	

</body>
</html>