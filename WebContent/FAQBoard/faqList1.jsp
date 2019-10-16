<%@page import="java.util.List"%>
<%@page import="com.admin.service.FAQ.db.AdminFAQDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
<!--바디  -->

	<%
	int count = (Integer) request.getAttribute("count");
	List<AdminFAQDTO> FAQList = (List<AdminFAQDTO>)request.getAttribute("FAQList");
	String pageNum = (String)request.getAttribute("pageNum");
	// String id = (String)request.getAttribute("id");
	int pageCount = (Integer) request.getAttribute("pageCount");
	int pageBlock = (Integer) request.getAttribute("pageBlock");
	int startPage = (Integer) request.getAttribute("startPage");
	int endPage = (Integer) request.getAttribute("endPage");
	System.out.println("FAQList :"+FAQList.toString());
		
	%>
	
	<%@ include file="../include/header.jsp" %>
	
	<jsp:include page="../service/serviceMain.jsp"/>

<h1> 게시판 글 목록 [ 전체 글 개수 : <%=count %> 개] </h1>

	<h3><a href="./FAQWrite.af">글쓰기</a></h3>

<table >
  <!--    <tr>
       <td>번호</td>
       <td>카테고리</td>
       <td>제목</td>
       <td>내용</td>
		<td>이미지</td>
	</tr> -->

<% 
		 for(int i=0;i<FAQList.size();i++){
			 AdminFAQDTO afdto = FAQList.get(i);
		 
		%>
	  	
	  	<tr>
			<%-- <td><%=afdto.getNum()%></td>
			<td><%=afdto.getCategory() %></td> --%>
			<%-- <td><a href="./FAQContent.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum%>">
           
           </a></td> --%>
			
			
			
			
		
<h6>FAQ</h6>

<button class="accordion"><%=afdto.getSubject() %></button>
<div class="panel">
  <p><%=afdto.getContent()%></p>
  <%-- <%if(id.equals("admin")){
   %> --%>
  <a href="./FAQContent.af?num=<%=afdto.getNum() %>&pageNum=<%=pageNum%>">
            글수정
           </a>
  <%-- <a href="./FAQContent.af?Num=<%=afdto.getNum()%>">글수정</a> --%>
 <%--  <%} %> --%>
</div>
<!-- <button class="accordion">Section 2</button>
<div class="panel">
  <p>
</p>
</div>

<button class="accordion">Section 3</button>
<div class="panel">
<p></p>
</div> -->
<%} %> 
		
<script>
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
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
</table>

	<%@ include file="../include/footer.jsp" %>
</body>
</html>




