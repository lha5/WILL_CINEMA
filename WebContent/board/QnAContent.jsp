<%@page import="com.service.QnA.db.QnADTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA</title>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<%@ include file="../service/serviceMain.jsp" %>
	<%
		// 이전 페이지에서 전달해준 정보를 저장 -> 사용
		QnADTO qadto = (QnADTO)request.getAttribute("qadto");
		String pageNum = (String)request.getAttribute("pageNum");
		System.out.println("카테고리 : " + qadto.getCategory());
	%>


	<h1>글 내용 보기</h1>
	<table border="1">
		<tr>
			<td>글번호</td><td><%=qadto.getNum() %></td>
			<td>조회수</td><td><%=qadto.getReadcount() %></td>
		</tr>
		<tr>
			<td>글쓴이</td><td><%=qadto.getName() %></td>
			<td>작성일</td><td><%=qadto.getDate() %></td>
		</tr>
		<tr>
			<td>글 제목</td><td colspan="3"><%=qadto.getSubject() %></td>
			
		</tr>
		<tr>
			<td>카테고리</td><td colspan="3"><%=qadto.getCategory() %></td>
		</tr>
		<tr>
			<td>첨부파일</td><td colspan="3"><img src="./upload/<%=qadto.getImage()%>"></td>
		</tr>
		<tr>
			<td>글 내용</td><td colspan="3"><%=qadto.getContent() %></td>
		</tr>
		
		<tr>
			<td colspan="4">
				<input type="button" value="수정하기" onclick="location.href='./QnAUpdate.sq?num=<%=qadto.getNum() %>&pageNum=<%=pageNum%>'">
				<input type="button" value="삭제하기" onclick="location.href='./QnADelete.sq?num=<%=qadto.getNum() %>&pageNum=<%=pageNum%>'">
				<input type="button" value="목록보기" onclick="location.href='./QnAList.sq?pageNum=<%=pageNum%>'">
			</td>
		</tr>
		
	</table>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>