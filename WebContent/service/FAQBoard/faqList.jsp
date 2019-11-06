<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - FAQ</title>

<!-- CSS -->
<link rel="stylesheet" href="././css/faqList.css">

</head>
<body>

	<div id="wrap">

	<%@ include file="../../include/header.jsp" %>

	<%
	int count = (Integer) request.getAttribute("count");
	List<AdminFAQDTO> FAQList = (List<AdminFAQDTO>)request.getAttribute("FAQList");
	String pageNum = (String)request.getAttribute("pageNum");
	
	int pageCount = (Integer) request.getAttribute("pageCount");
	int pageBlock = (Integer) request.getAttribute("pageBlock");
	int startPage = (Integer) request.getAttribute("startPage");
	int endPage = (Integer) request.getAttribute("endPage");

	System.out.println("FAQList :"+FAQList.toString());
	%>
	  	
	<div id="faqList">자주 묻는 질문</div>
		
  	<div id="contentsWrap">	
		
		<% 
		 for (int i = 0; i < FAQList.size(); i++) {
			 AdminFAQDTO afdto = FAQList.get(i);
		%>
		 	<%-- <td><a href="./FAQContent.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum%>"></a></td> --%>
			<button class="accordion">[<%=afdto.getCategory()%>] <%=afdto.getSubject() %></button>
			<div class="panel">
				<br>
				<p>
					<%if(afdto.getImage()!= null){%>
					<img src="./upload/<%=afdto.getImage()%>" width="100" height="100">
					<br>
					<%}%>
					<%=afdto.getContent()%>
				</p>
				<br>
				<%if(id==null){}else if(id.equals("admin")){ %>
				<h4><a href="./FAQContent.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum%>">글수정(관리자)</a></h4>
				<h4><a href="./FAQWrite.af">글 쓰기(관리자)</a></h4>
				<%}%> 
			</div> 
		<%
		}
		%>
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

		<br>
		<br>		

		<div id="pagingNumber">
		<%
		if(count != 0) {
			// 이전
			if (startPage > pageBlock) {
		%>
			<a href="./FAQList.af?pageNum=<%=startPage - pageBlock%>">이전</a>
			&nbsp;&nbsp;
		<%
			}

			// 1...10  11..20  21...30
			for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="./FAQList.af?pageNum=<%=i%>"><%=i%></a>
			&nbsp;&nbsp;
			<%
			}

			// 다음
			if (endPage < pageCount) {
			%>
				&nbsp;&nbsp;
				<a href="./FAQList.af?pageNum=<%=startPage + pageBlock%>">다음</a>
			<%
			}
		}
		%>
		</div>
	</div>
	
	<table>
		<tr>
			<td>번호</td>
			<td>카테고리</td>
			<td>제목</td>
			<td>내용</td>
			<td>이미지</td>
		</tr>
		<% 
		 for(int i=0;i<FAQList.size();i++){
			 AdminFAQDTO afdto = FAQList.get(i);
		%>
		  	<tr>
				<td><%=afdto.getNum()%></td>
				<td><%=afdto.getCategory() %></td>
				<td>
					<a href="./FAQContent.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum%>"><%=afdto.getSubject() %></a>
		          	</td>
				<td><%=afdto.getContent()%></td>
				<td><img src="./upload/<%=afdto.getImage()%>" width="100" height="100"><br></td>
			</tr>	
		<%} %> 
	</table>
	
	<a href="./FAQWrite.af">자주 묻는 질문 글 작성하기</a>
	
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

	<%@ include file="../../include/footer.jsp" %>
	
	</div>
	
</body>
</html>