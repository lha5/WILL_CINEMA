<%@page import="java.util.List"%>
<%@page import="com.service.QnA.db.QnADTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 1:1 문의하기</title>

<!-- CSS -->
<style type="text/css">
#contentsWrap {
	width: 900px;
	margin: 20px auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid #1c1c1c;
	margin: 20px 0;
}

td {
	border: 1px solid #1c1c1c;
	padding: 10px;
}

tr:NTH-CHILD(1) td {
	background-color: #1c1c1c;
	color: #ffffff;
	text-align: center;
}

td:NTH-CHILD(1), td:NTH-CHILD(2), td:NTH-CHILD(4), td:NTH-CHILD(5), td:NTH-CHILD(6) {
	text-align: center;
}

#bttns {
	width: 100%;
	text-align: right;
}

input[type=text] {
	width: 170px;
	height: auto;
	line-height: normal;
	padding: .8em .5em;
	font-family: inherit;
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border: 1px solid #1c1c1c;
	color: #1c1c1c;
	font-size: 12px;
}

input[type=button] {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 120px;
	height: 50px;
	border: 1px solid #1c1c1c;
	background-color: #ffffff;
	font-family: inherit;
	font-size: 14px;
	color: #1c1c1c;
	letter-spacing: 2px;
}

input[type=submit] {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 70px;
	height: 36px;
	border: 1px solid #1c1c1c;
	background-color: #1c1c1c;
	font-family: inherit;
	font-size: 16px;
	color: #ffffff;
	letter-spacing: 2px;
}
</style>

</head>
<body>

	<%@ include file="../../include/header.jsp" %>
	
	<%
		String name = String.valueOf(request.getAttribute("name"));		
		session.setAttribute("name", name);
		
		// int count = (Integer) request.getAttribute("count");
		List<QnADTO> boardList = (List<QnADTO>) request.getAttribute("boardList");
		String pageNum = (String)request.getAttribute("pageNum");
		System.out.println("boardLis : "+boardList);
		int pageCount = (Integer) request.getAttribute("pageCount");
		int pageBlock = (Integer) request.getAttribute("pageBlock");
		int startPage = (Integer) request.getAttribute("startPage");
		int endPage = (Integer) request.getAttribute("endPage");
	%>

	<div id="contentsWrap">	
		<h2>내 1:1 문의</h2>
   		<table>
		     <tr>
		       <td>번호</td>
		       <td>카테고리</td>
		       <td>제목</td>
		       <td>글쓴이</td>
		       <td>날짜</td>
		       <td>조회수</td>
		     </tr>
		<%
     	for (int i=boardList.size()-1;i>-1;i--) {
    		QnADTO qadto = boardList.get(i);
    		//System.out.println("pass : "+qadto.getPass());
    		if (id.equals(qadto.getPass())) {
		%>
			<tr>
				<td><%=qadto.getNum() %></td>
				<td><%=qadto.getCategory()%></td>
				<td>
					<a href="./QnAContent.sq?num=<%=qadto.getNum() %>&pageNum=<%=pageNum%>">
					<%=qadto.getSubject() %>
					</a>
				</td>
				<td><%=qadto.getName() %></td>
				<td><%=qadto.getDate() %></td>
				<td><%=qadto.getReadcount() %></td>
			</tr>
		<%
			}
		}
		%>
	</table>

	<div id="pagingNumber">
		<%-- 
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
		--%>
	</div>	
	
	<div id="bttns">
		<input type="button" value="문의하기" id="goWrite">
		<br><br>
		<form action="./QnASearchAction.sq" method="post" id="goSearch">
			<input type="text" name="search">
			<input type="submit" value="검색">
		</form>
	</div>
	
	<!-- 문의하기 버튼 -->
	<script type="text/javascript">
		document.querySelector('#goWrite').addEventListener('click', function() {
			location.href = './QnAWrite.sq';
		});
	</script>
	<%@ include file="../../include/footer.jsp" %>
</body>
</html>