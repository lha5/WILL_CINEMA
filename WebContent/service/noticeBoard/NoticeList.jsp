<%@page import="java.util.function.Function"%>
<%@page import="com.admin.service.notice.db.AdminNoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.admin.service.notice.db.AdminNoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 공지사항</title>

<!--CSS  -->
<link rel="stylesheet" href="././css/noticeWrite.css">

</head>
<body>
		<div id=Wrap2>
	<%@ include file="../../include/header.jsp" %>




	<%
		int count = (Integer) request.getAttribute("count");
		List<AdminNoticeDTO> boardList = (List<AdminNoticeDTO>) request.getAttribute("boardList");
		
		String pageNum = (String) request.getAttribute("pageNum");

		int pageCount = (Integer) request.getAttribute("pageCount");
		int pageBlock = (Integer) request.getAttribute("pageBlock");
		int startPage = (Integer) request.getAttribute("startPage");
		int endPage = (Integer) request.getAttribute("endPage");
		
	%>



		
		
		
		
		<div id="notiWrap">
		<h1>공지사항</h1>
		<div id="notiList">		
		
		<form action="./NoticeSearchAction.an" method="post" id="searching">
		<input type="text" name="search" placeholder="검색어를 입력하세요" title="검색어 입력" >
		<input type="submit" value="검색" />
		</form>
		
		</div>
		<br>
		<br>
		<br>
		<br>
				<% 
		 for (int i=0;i<boardList.size();i++) {
			AdminNoticeDTO andto = boardList.get(i);
		 
		%>
	  	
	  	<button class="notiaccordion" onclick="location.href='./NoticeContent.an?num=<%=andto.getNum()%>&pageNum=<%=pageNum%>' "><a href="./NoticeContent.an?num=<%=andto.getNum()%>&pageNum=<%=pageNum%>">[<%=andto.getCategory() %>]<%=andto.getSubject()%></a> </button>
	  	
	  	<div class ="notipanel">
	  	
	  	
	  	
	  	
	  	<%=andto.getContent() %>
	  	</div><!--공지사항 내용  -->
	  	
		<%
		}/* 반복문 */ 
		%> 	
	<script>
			/* var acc = document.getElementsByClassName("notiaccordion");
			
			for (var i = 0; i < acc.length; i++) {
	 			acc[i].addEventListener("click", function() {
	    			this.classList.toggle("notiactive");
	    			var panel = this.nextElementSibling;
	    			if (panel.style.display === "block") {
	     					panel.style.display = "none";
	    			} else {
	     					panel.style.display = "block";
	    			}
	  			});
			} */
		</script>	
	
	<div id="notipagingNumber">
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
	</div>
	</div>
	<%
	if (id != null) {
		if (id.equals("admin")) {
	%>
		
		<input type="button" value="공지사항 작성하기" id="noticlick1" onclick="location.href='./NoticeWrite.an?pageNum=<%=pageNum%>'">
	<%
	 }
	}
	%>
	</div>	
	<%@ include file="../../include/footer.jsp" %>
	

	
</body>
</html>