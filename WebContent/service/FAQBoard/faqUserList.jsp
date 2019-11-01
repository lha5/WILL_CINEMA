<%@page import="java.util.List"%>
<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>WILL CINEMA - 자주 묻는 질문</title>

<!-- jQuery -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" href="././css/faqList.css">

</head>
<body>

	<div id="wrap">

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

	
		
		<div id="faq_contents">
			<span id="subj">FAQ</span>
			<% 
			for(int i=0;i<FAQList.size();i++){
				AdminFAQDTO afdto = FAQList.get(i);
			%>
		  
				<button class="accordion"><%=afdto.getSubject() %></button>
				<div class="panel">
					<%--
					카테고리: <%=afdto.getCategory() %><br>
					제목: <%=afdto.getSubject() %><br> 
					--%>
					<%
					if (afdto.getImage() != null) {
					%>
						<img src="./upload/<%=afdto.getImage()%>">
						<br>
					<%
					}
					%>
					<p>
					<%=afdto.getContent()%>
					</p>
					<%
					if (id != null) {
						if (id.equals("admin")) {
					%>
						<a href="./FAQContent.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum%>">글수정</a>	
					<%
						}
					}
					%>
				</div>
			<%
			}
			%>
			
			<%
			if (id != null) {
			  	if (id.equals("admin")) {
			%>
			  		<h6><a href="./FAQWrite.af">FAQ 글쓰기</a></h6>
			<%
			  	}
			}
		  	%>
	
	
			<!-- 페이징 처리 -->
			<div id="paging">
			<%
			if(count != 0) {
				// 이전
				if (startPage > pageBlock) {
			%>
				<a href="./FAQList.af?pageNum=<%=startPage - pageBlock%>">[이전]</a>
			<%
				}
				// 1...10  11..20  21...30
				for (int i = startPage; i <= endPage; i++) {
			%>
				<a href="./FAQList.af?pageNum=<%=i%>"><%=i%></a>
			<%
				}
	
				// 다음
				if (endPage < pageCount) {
			%>
				<a href="./FAQList.af?pageNum=<%=startPage + pageBlock%>">[다음]</a>
			<%
				}
			}
			%>
			</div>
		</div>
		
		<!-- 자바스크립트 -->
		<script>
			var acc = document.getElementsByClassName("accordion");
			
			for (var i = 0; i < acc.length; i++) {
 				acc[i].addEventListener("click", function() {
    				this.classList.toggle("active");
    				var panel = this.nextElementSibling;
    				if (panel.style.display === "block") {
      					panel.style.display = "none";
    				} else {
      					panel.style.display = "block";
    				}
  				});
			}
		</script>	

		<%@ include file="../../include/footer.jsp" %>
	
	</div>
	
</body>
</html>