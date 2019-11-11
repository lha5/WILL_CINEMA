<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 1:1 문의 작성</title>

<!-- summernote 적용시키기 위한 준비 -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<script src="./summernote/lang/summernote-ko-KR.js"></script>

<!-- 글쓰기 오류 방지 -->
<script type="text/javascript">

	function QnANonCheck() { 
		if(document.QnAWritefr.subject.value == ""){
			alert("문의할 제목을 입력해 주십시오.");
			document.reviewAddfr.subject.focus();
			return false;
		}
		if(document.QnAWritefr.content.value == ""){
			alert("문의할 내용을 입력해 주십시오.");
			document.reviewAddfr.content.focus();
			return false;
		}
		
	}
</script>

<!-- CSS -->
<style type="text/css">
fieldset {
	width: 900px;
	border: none;
	margin: 20px auto;
}

legend {
	font-weight: bold;
	font-size: 1.5em;
	text-align: center;
	margin-bottom: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
	/* border: 1px solid #1c1c1c; */
}

td {
	padding-top: 12px;
	padding-bottom: 12px;
}

td:NTH-CHILD(1) {
	width: 120px;
	text-align: center;
}

td:NTH-CHILD(3) {
	width: 120px;
	text-align: center;
}

input[type=text] {
	width: 170px;
	height: auto;
	line-height: normal;
	padding: .8em .5em;
	font-family: inherit;
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border: 1px solid #e6e6e6;
	color: #1c1c1c;
	font-size: 12px;
}

input#sbj {
	width: 100%;
}

input[type=submit] {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 90px;
	height: 40px;
	border: 1px solid #1c1c1c;
	background-color: #1c1c1c;
	font-family: inherit;
	font-size: 16px;
	color: #ffffff;
	letter-spacing: 2px;
}
</style>
</head>
<body>

	<div id="wrap">
	
	<%@ include file="../../include/header.jsp" %>
	
	<%
	if(id == null){
		response.sendRedirect("./MemberLogin.me");
	}
	
	String name = (String) session.getAttribute("name");
	System.out.println("name : "+session.getAttribute("name"));
	%>

	<fieldset>
		<legend>1:1 문의 작성</legend>
		<form action="./QnAWriteAction.sq" method="post" name="QnAWritefr" enctype="multipart/form-data"
			onsubmit="return QnANonCheck()">
			<table>
				<tr>
					<td>작성자</td>
					<td>
						<input type="text" name="name" value="<%=name%>" readonly>
						<input type="hidden" name="pass" value="<%=id%>">
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
					<td colspan="3"><input type="text" name="subject" id="sbj"></td>
				</tr>
				<tr>
					<td>문의 내용</td>
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
					<td>첨부 파일</td>
					<td colspan="3"><input type="file" name="image"></td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="submit" value="문의하기">
					</td>
				</tr>
			</table>
		</form>		
	</fieldset>


	<%@ include file="../../include/footer.jsp" %>
	
	</div>
	
</body>
</html>