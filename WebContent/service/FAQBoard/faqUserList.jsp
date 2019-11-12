<%@page import="java.util.List"%>
<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>WILL CINEMA - 자주 묻는 질문</title>

<!-- CSS -->
<link rel="stylesheet" href="././css/faqList.css">
<style type="text/css">
.fqpanel {
	line-height: 2em;
}
</style>
</head>
<body>

	<%@ include file="../../include/header.jsp" %>

	<%
	int count = (Integer) request.getAttribute("count");
	List<AdminFAQDTO> FAQList = (List<AdminFAQDTO>) request.getAttribute("FAQList");
	String pageNum = (String)request.getAttribute("pageNum");
	int pageCount = (Integer)request.getAttribute("pageCount");
	int pageBlock = (Integer)request.getAttribute("pageBlock");
	int startPage = (Integer)request.getAttribute("startPage");
	int endPage = (Integer)request.getAttribute("endPage");
	
	System.out.println("FAQList :" + FAQList.toString());
	%>

  	
	<div id="faqList">자주 묻는 질문
	<div id="faqsearch">		
			<form action="./FAQSearchAction.af" method="post" id="faqsearch">
				<input type="text" name="search" placeholder="단어를 입력하세요" title="제목 입력" >
				<input type="submit" value="검색">
				<input type="button" value="목록으로" onclick="location.href='./FAQUserList.af?pageNum=<%=pageNum%>'"/>
			</form>	
	
	
	</div>
	</div>
		
  	<div id="faqWrap">	
		
		<% 
		 for (int i = 0; i < FAQList.size(); i++) {
			 AdminFAQDTO afdto = FAQList.get(i);
		%>
		 	<%-- <td><a href="./FAQContent.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum%>"></a></td> --%>
			<button class="fqaccordion">[<%=afdto.getCategory()%>] <%=afdto.getSubject() %></button>
			<div class="fqpanel">
				<br>
				<p>
					
					<%=afdto.getContent()%>
				</p>
				<br>
				<%if(id==null){}else if(id.equals("admin")){ %>
				<h4><a href="./FAQContent.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum%>">글수정(관리자)</a></h4>
				<h4><a href="./FAQWrite.af">글 쓰기(관리자)</a></h4>
				<%}%> 
			</div> <!--내용   -->
		<%
		}/*반복문  */
		%>
		<!-- 자바스크립트 -->
		<script>
			var acc = document.getElementsByClassName("fqaccordion");
			
			for (var i = 0; i < acc.length; i++) {
	 			acc[i].addEventListener("click", function() {
	    			this.classList.toggle("fqactive");
	    			var panel = this.nextElementSibling;
	    			if (panel.style.display === "block") {
	     					panel.style.display = "none";
	    			} else {
	     					panel.style.display = "block";
	    			}
	  			});
			}
		</script>	

		<br>
		<br>		

		<div id="fqpagingNumber">
		<%
		if(count != 0) {
			// 이전
			if (startPage > pageBlock) {
		%>
			<a href="./FAQUserList.af?pageNum=<%=startPage - pageBlock%>">이전</a>
			&nbsp;&nbsp;
		<%
			}

			// 1...10  11..20  21...30
			for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="./FAQUserList.af?pageNum=<%=i%>"><%=i%></a>
			&nbsp;&nbsp;
			<%
			}

			// 다음
			if (endPage < pageCount) {
			%>
				&nbsp;&nbsp;
				<a href="./FAQUserList.af?pageNum=<%=startPage + pageBlock%>">다음</a>
			<%
			}
		}
		%>
		</div>
	</div>

	<%@ include file="../../include/footer.jsp" %>
	
</body>
</html>