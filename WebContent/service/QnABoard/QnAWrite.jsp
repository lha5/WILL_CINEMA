<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 1:1 문의</title>

<!-- include libraries(jQuery) -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 

<!-- include summernote css/js -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>

<!-- include summernote-ko-KR -->
<script src="./summernote/lang/summernote-ko-KR.js"></script>

</head>
<body>
	

	<%@ include file="../../include/header.jsp" %>

	<%
		String name = (String) session.getAttribute("name");
		System.out.println("유저 이름 : " + name);	
	
		// String id = (String) session.getAttribute("id");
		if (id == null) {
			response.sendRedirect("./MemberLogin.me");
		} else if (id == "admin") {
			response.sendRedirect("./QnAList.sq");
		}
	%>
	
	<fieldset>
		<legend>1:1 문의 하기</legend>
		<form action="./QnAWriteAction.sq" method="post" enctype="multipart/form-data">
		
			<table>
				<tr>
					<td>작성자</td>
					<td>
						<input type="text" name="name" value="<%=name%>"><!-- readonly 설정 주기 -->
						<input type="hidden" name="pass" value="<%=id%>"><!-- 비밀번호 저장 -->
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
						<textarea id="summernote" name="editordata"></textarea>
						
						<script type="text/javascript">
							$(document).ready(function() {
								$('#summernote').summernote({
									placeholder: 'Hello stand alone ui',
									height: 300,
									minHeight: 100,
									maxHeight: 700,
									lang: 'ko-KR'
								});
							});
						</script>
						
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
	
	<%@ include file="../../include/footer.jsp" %>
</body>
</html>