<%@page import="com.admin.service.notice.db.AdminNoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.admin.service.notice.db.AdminNoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>WebContent/notice/NoticeList.jsp</h1>


	<%
	int count = (Integer) request.getAttribute("count");
	List<AdminNoticeDTO> boardList = (List<AdminNoticeDTO>)request.getAttribute("boardList");
	String pageNum = (String)request.getAttribute("pageNum");
	
	int pageCount = (Integer) request.getAttribute("pageCount");
	int pageBlock = (Integer) request.getAttribute("pageBlock");
	int startPage = (Integer) request.getAttribute("startPage");
	int endPage = (Integer) request.getAttribute("endPage");
	System.out.println("boardList :"+boardList.toString());
	
	
	%>
	<h1> 게시판 글 목록 [ 전체 글 개수 : <%=count %> 개] </h1>

	<h3><a href="./NoticeWrite.an">글쓰기</a></h3>


	
   <table border="1">
     <tr>
       <td>번호</td>
       <td>제목</td>
       <td>글쓴이</td>
       <td>날짜</td>
		
	</tr>
	
		<% 
		 for(int i=0;i<boardList.size();i++){
			 AdminNoticeDTO andto = boardList.get(i);
		 
		
		 
		%>
	  	
	  	<tr>
			<td><%=andto.getNum()%></td>
			<td><a href="./NoticeContent.an?num=<%=andto.getNum()%>"><%=andto.getSubject()%></a></td>
			<td><%=andto.getName()%></td>
			<td><%=andto.getDate()%></td>
			
			
		<%} %> 
		
	
	
	</table>
 <%
		if(count != 0) {
			// 이전
			if (startPage > pageBlock) {
			%>
			<a href="./NoticeList.an?pageNum=<%=startPage - pageBlock%>">[이전]</a>
			<%
			}

			// 1...10  11..20  21...30
			for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="./NoticeList.an?pageNum=<%=i%>">[<%=i%>]
			</a>
			<%
			}

			// 다음
			if (endPage < pageCount) {
			%>
			<a href="./NoticeList.an?pageNum=<%=startPage + pageBlock%>">[다음]</a>
			<%
				}
		}
	%>


</body>
</html>