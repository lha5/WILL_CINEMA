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
		
		<table>
			<tr>
				<td>번호</td>
				<td>카테고리</td>
				<td>제목</td>
			</tr>
			<% 
			 for (int i = 0; i < FAQList.size(); i++) {
				 AdminFAQDTO afdto = FAQList.get(i);
			%>
		  	<tr>
				<td><%=afdto.getNum()%></td>
				<td><%=afdto.getCategory() %></td>
				<td>
					<a href="./FAQContent.af?num=<%=afdto.getNum()%>&pageNum=<%=pageNum%>"><%=afdto.getSubject()%></a>
		        </td>
			</tr>	
			<%
			} 
			%> 
		</table>
				<% if (id != null) {
					if(id.equals("admin")){
				%>
					<%-- <a href="./FAQContent.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum%>">(관리자) 내용 수정하기</a> --%>
					<a href="./FAQWrite.af">(관리자) 자주 묻는 질문 내용 쓰기</a>
				<%
					}
				}
				%> 
			</div>
			

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
	
	<%@ include file="../../include/footer.jsp" %>
	
	</div>
	
</body>
</html>