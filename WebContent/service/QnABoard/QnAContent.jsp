<%@page import="com.service.QnA.db.QnADTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA</title>

<!-- CSS -->
<style type="text/css">
#contentsWrap {
	width: 900px;
	margin: 20px auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid #1c1c1c;
	margin: 20px 0;
}

tr:NTH-CHILD(1)>td, tr:NTH-CHILD(2)>td {
	width: 25%;
	text-align: center;
}

td:NTH-CHILD(1) {
	text-align: center;
}

td {
	border: 1px solid #1c1c1c;
	padding: 10px;
	height: 35px;
}

input[type=button] {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 120px;
	height: 50px;
	border: 1px solid #1c1c1c;
	background-color: #ffffff;
	font-family: inherit;
	font-size: 14px;
	color: #1c1c1c;
	letter-spacing: 2px;
}
</style>

</head>
<body>
	<%@ include file="../../include/header.jsp" %>
	<%
		// 이전 페이지에서 전달해준 정보를 저장 -> 사용
		QnADTO qadto = (QnADTO)request.getAttribute("qadto");
		String pageNum = (String)request.getAttribute("pageNum");
		System.out.println("카테고리 : " + qadto.getCategory());
	%>
	
	<div id="contentsWrap">

	<table>
		<tr>
			<td>글번호</td><td><%=qadto.getNum() %></td>
			<td>조회수</td><td><%=qadto.getReadcount() %></td>
		</tr>
		<tr>
			<td>글쓴이</td><td><%=qadto.getName() %></td>
			<td>작성일</td><td><%=qadto.getDate() %></td>
		</tr>
		<tr>
			<td>카테고리</td><td colspan="3"><%=qadto.getCategory() %></td>
		</tr>
		<tr>
			<td>제목</td><td colspan="3"><%=qadto.getSubject() %></td>
			
		</tr>
		<tr>
			<td>내용</td><td colspan="3"><%=qadto.getContent() %></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td colspan="3">
				<%
				if (qadto.getImage() != null) {
				%>
				<img src="./upload/<%=qadto.getImage()%>">
				<%
				} else {
				%>
				첨부파일 없음
				<%
				}
				%>
			</td>
		</tr>

		<tr>
			<td colspan="4">
				<input type="button" id="button" value="수정하기" onclick="location.href='./QnAUpdate.sq?num=<%=qadto.getNum() %>&pageNum=<%=pageNum%>'">
				<input type="button" id="button" value="삭제하기" onclick="location.href='./QnADeleteAction.sq?num=<%=qadto.getNum() %>&pageNum=<%=pageNum%>'">
				<input type="button" id="button" value="목록보기" onclick="location.href='./QnAUserList.sq?pageNum=<%=pageNum%>'">
				<%
				if (id != null) {
					if (id.equals("admin")) {
				%>
					<input type="button" id="button" value="답변하기" onclick="location.href='./QnAReWrite.sq?num=<%=qadto.getNum() %>&pageNum=<%=pageNum%>'">
				<%
					}
				}
				%>
			</td>
		</tr>

	</table>

	</div>

	<%@ include file="../../include/footer.jsp" %>
</body>
</html>