<%@page import="com.service.QnA.db.QnADTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA</title>

<!-- CSS -->
<link rel="stylesheet" href="../css/qnalist.css">

</head>
<body>

	<%@ include file="../../include/header.jsp" %>
	
	<%
		// String id = (String)session.getAttribute("id");
		System.out.println("session id : "+id);
		
		int count = (Integer) request.getAttribute("count");
		
		List<QnADTO> boardList = (List<QnADTO>) request.getAttribute("boardList");
		
		String pageNum = (String)request.getAttribute("pageNum");
	
		int pageCount = (Integer) request.getAttribute("pageCount");
		int pageBlock = (Integer) request.getAttribute("pageBlock");
		int startPage = (Integer) request.getAttribute("startPage");
		int endPage = (Integer) request.getAttribute("endPage");
	%>
	
	

	<h1> 게시판 글 목록 [ 전체 글 개수 : <%=count %> 개] </h1>
   
   <table border="1">
     <tr>
       <td>번호</td>
       <td>카테고리</td>
       <td>제목</td>
       <td>카테고리</td>
       <td>글쓴이</td>
       <td>날짜</td>
     </tr>
     <%
     	for (int i=0;i<boardList.size();i++) {
    		QnADTO qadto = boardList.get(i);
		%>
			<tr>
				<td><%=qadto.getNum() %></td>
				<td>
					<a href="./QnAContent.sq?num=<%=qadto.getNum() %>&pageNum=<%=pageNum%>">
					<%=qadto.getSubject() %>
					</a>
				</td>
				<td><%=qadto.getCategory()%></td>
				<td><%=qadto.getName() %></td>
				<td><%=qadto.getDate() %></td>
				<td><%=qadto.getReadcount() %></td>
			</tr>
		<%}%>
	</table>
	
	<div id="paging">
	<%
		// 페이징 처리
		if(count != 0) {
			// 이전
			if (startPage > pageBlock) {
			%>
			<a href="./QnAList.sq?pageNum=<%=startPage - pageBlock%>">[이전]</a>
			<%
			}

			// 1...10  11..20  21...30
			for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="./QnAList.sq?pageNum=<%=i%>">[<%=i%>]
			</a>
			<%
			}

			// 다음
			if (endPage < pageCount) {
			%>
			<a href="./QnAList.sq?pageNum=<%=startPage + pageBlock%>">[다음]</a>
			<%
				}
		}
	%>
	</div>
	<h3><a href="./QnAWrite.sq">글 쓰기</a></h3>
	

	<form action="./QnASearchAction.sq" method="post">
		<input type="text" name="search">
		<button type="submit">검색</button>
	</form>
	
	<%@ include file="../../include/footer.jsp" %>
	
</body>
</html>