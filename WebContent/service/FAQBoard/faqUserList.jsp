<%@page import="java.util.List"%>
<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>WILL CINEMA - 자주 묻는 질문</title>

<style>
.accordion {
  background-color: #eee;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
}

.active, .accordion:hover {
  background-color: #ccc; 
}

.panel {
  padding: 0 18px;
  display: none;
  background-color: white;
  overflow: hidden;
}
</style>
</head>
<body>

		<%@ include file="../../include/header.jsp" %>

	<%
		// String id = (String)request.getAttribute("id");
		int count = (Integer) request.getAttribute("count");
		List<AdminFAQDTO> FAQList = (List<AdminFAQDTO>) request.getAttribute("FAQList");
		String pageNum = (String)request.getAttribute("pageNum");
		int pageCount = (Integer)request.getAttribute("pageCount");
		int pageBlock = (Integer)request.getAttribute("pageBlock");
		int startPage = (Integer)request.getAttribute("startPage");
		int endPage = (Integer)request.getAttribute("endPage");
		
		System.out.println("FAQList :" + FAQList.toString());
	%>

	<h1> 게시판 글 목록 [ 전체 글 개수 : <%=count %> 개] </h1>

	<%-- <%
		if (id.equals("admin")) {
	%>
			<a href="./FAQWrite.af">글쓰기</a>
	<%
		}
	%> --%>
	<h6>FAQ</h6>
  		
		<% 
		 for(int i=0;i<FAQList.size();i++){
			 AdminFAQDTO afdto = FAQList.get(i);
		%>
	  	
			
			
			<%-- <td><a href="./FAQContent.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum%>"></a></td> 
			 --%>
<button class="accordion"><%=afdto.getSubject() %></button>
<div class="panel">

 카테고리: <%=afdto.getCategory() %><br>
 제목: <%=afdto.getSubject() %><br>
 이미지: <img src="./upload/<%=afdto.getImage()%>" width="100" height="100"><br>
 내용:<%=afdto.getContent()%><br>
수정: <h4><a href="./FAQContent.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum%>">글수정</a></h4>
</div>
<%}%>
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
		
		<h5><a href="./FAQWrite.af">임시 글 쓰기</a></h5>
		
	 <%-- <%
  			if (id.equals("admin")) {
  			%>
  				<a href="./FAQContent.af?num=<%=afdto.getNum() %>">글수정</a>
  				<h6><a href="./FAQWrite.af">글 쓰기</a></h6>
  			<%
  			}
  			%>  --%>


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
			<a href="./FAQList.af?pageNum=<%=i%>">[<%=i%>]
			</a>
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




	<%@ include file="../../include/footer.jsp" %>
	
</body>
</html>