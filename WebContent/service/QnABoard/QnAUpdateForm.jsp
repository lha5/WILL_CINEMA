<%@page import="com.service.QnA.db.QnADTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 1:1 문의 하기 수정</title>

<!-- summernote 적용시키기 위한 준비 -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<script src="./summernote/lang/summernote-ko-KR.js"></script>

</head>
<body>

	<div id="wrap">

	<%@ include file="../../include/header.jsp" %>
	
	<%
		QnADTO qadto = (QnADTO) request.getAttribute("qadto");
		String pageNum = (String) request.getAttribute("pageNum");
		System.out.println(" id : "+qadto.getPass());
	%>
	
	<fieldset>
		<legend>1:1 문의 수정</legend>
		<form action="./QnAUpdateAction.sq?num=<%=qadto.getNum() %>&pageNum=<%=pageNum%>" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td>작성자</td>
					<td>
						<input type="text" name="name" value="<%=qadto.getName()%>" readonly>
						<input type="hidden" name="pass" value="<%=qadto.getPass()%>">
					</td>
					<td>카테고리</td>
					<td>
						<select name="category">
							<option value="영화예매" <%if (qadto.getCategory().equals("영화예매")) {%>selected<%}%>>영화 예매</option>
							<option value="매점구매" <%if (qadto.getCategory().equals("매점구매")) {%>selected<%}%>>매점 구매</option>
							<option value="이용안내" <%if (qadto.getCategory().equals("이용안내")) {%>selected<%}%>>사이트 이용 안내</option>
							<option value="이벤트" <%if (qadto.getCategory().equals("이벤트")) {%>selected<%}%>>이벤트</option>
							<option value="멤버십" <%if (qadto.getCategory().equals("멤버십")) {%>selected<%}%>>멤버십/포인트</option>
							<option value="쿠폰" <%if (qadto.getCategory().equals("쿠폰")) {%>selected<%}%>>쿠폰</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><input type="text" name="subject" value="<%=qadto.getSubject()%>"></td>
				</tr>
				<tr>
					<td>문의 내용</td>
					<td colspan="3">
						<textarea id="summernote" name="content">
							<%=qadto.getContent()%>
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
					<td>첨부 파일</td>
					<td colspan="3"><input type="file" name="image" value="<%=qadto.getImage()%>"></td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="submit" value="수정 하기">
					</td>
				</tr>
			</table>
		</form>		
	</fieldset>
	
	<%@ include file="../../include/footer.jsp" %>
	
	</div>
	
</body>
</html>