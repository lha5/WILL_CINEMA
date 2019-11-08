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
<link rel="stylesheet" href="././css/qnalist2.css">

</head>
<body>
	<%@ include file="../../include/header.jsp" %>
	
	<%
		id = (String)session.getAttribute("id");
		System.out.println("session id : "+id);
		
		int count = (Integer) request.getAttribute("count");
		
		List<QnADTO> boardList = (List<QnADTO>) request.getAttribute("boardList");
		
		String pageNum = (String)request.getAttribute("pageNum");
	
		int pageCount = (Integer) request.getAttribute("pageCount");
		int pageBlock = (Integer) request.getAttribute("pageBlock");
		int startPage = (Integer) request.getAttribute("startPage");
		int endPage = (Integer) request.getAttribute("endPage");
	%>
	
	
	<div id="faqList"><center>질문 목록</center></div> 

	<div id="contentsWrap">	
   	<center>
   <table border="1" class="accordion">
     <tr>
       <td>번호</td>
       <td>제목</td>
       <td>카테고리</td>
       <td>글쓴이</td>
       <td>날짜</td>
       <td>조회수</td>
     </tr>
     <%
     	for (int i=boardList.size()-1;i>-1;i--) {
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
	</center>
	<div id="pagingNumber">
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
		<button type="submit" id="button">검색</button>
	</form>

	</div>
	<%@ include file="../../include/footer.jsp" %>

</body>
</html>