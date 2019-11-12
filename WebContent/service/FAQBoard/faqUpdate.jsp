<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 자주 묻는 질문 수정</title>

<!-- summernote 적용시키기 위한 준비 -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<script src="./summernote/lang/summernote-ko-KR.js"></script>

</head>
<body>

	<%
	AdminFAQDTO afdto =(AdminFAQDTO) request.getAttribute("afdto");
	System.out.println(afdto.getNum());
	String pageNum = (String) request.getAttribute("pageNum");	
	System.out.println("글 번호 : " + afdto.getNum());
	%>
	<%@ include file="../../include/header.jsp" %>
	
	<fieldset>
		<legend>자주 묻는 질문 내용 수정</legend>
<<<<<<< HEAD
		<form action="./FAQUpdateAction.af?pageNum=<%=pageNum %>&num=<%=afdto.getNum()%>" method="post">
=======
		<form action="./FAQUpdateAction.af?pageNum=<%=pageNum %>" method="post">
>>>>>>> branch 'master' of https://github.com/lha5/WILL_CINEMA.git
			<table>
				<tr>
					<td>작성자
<<<<<<< HEAD
						<%-- <input type="hidden" name="num" value="<%=afdto.getNum()%>"> --%>
						<input type="text" name="name" value="<%=id%>" readonly>
						<input type="password" name="pass">
=======
						<input type="hidden" name="num" value="<%=afdto.getNum()%>">
						<input type="text" name="name" value="<%=afdto.getName()%>" readonly>
						<input type="hidden" name="pass" value="<%=afdto.getName()%>">
>>>>>>> branch 'master' of https://github.com/lha5/WILL_CINEMA.git
					</td>
				</tr>
				<tr>
					<td>카테고리
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
							<input type="text" name="subject" value="<%=afdto.getSubject() %>">
						</td>
				</tr>
				<tr>
				<td>FAQ내용</td>
				<td colspan="2">
					<textarea id="summernote" name="content">
						<%-- <img alt="image" src="<%=afdto.getImage()%>"> --%>
						<%=afdto.getContent() %>
					</textarea>
					<!-- summernote -->
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
				
				<%-- <tr>
				<td>이미지</td>
				<td colspan="2">
				<input type="file" name="image" value="<%=afdto.getImage()%>"></td>
				</tr> --%>
								
				<tr><td colspan="5">
				<input type="submit" value="내용 수정하기">
				</td>
				</tr>
			</table>
		</form>
	</fieldset>

	<%@ include file="../../include/footer.jsp" %>
	
</body>
</html>