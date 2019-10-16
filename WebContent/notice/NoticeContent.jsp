<%@page import="com.admin.service.notice.db.AdminNoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/notice/NoticeContent.jsp</h1>

<%

//이전페이지에서 전달해준 정보를 저장 -> 사용
// 정보 저장 (글정보,pageNum)
//		request.setAttribute("andto", andto);
// 		request.setAttribute("pageNum", pageNum);
	AdminNoticeDTO andto = (AdminNoticeDTO) request.getAttribute("andto");
	String pageNum = (String) request.getAttribute("pageNum");

	


%>

<h1>글 내용 보기</h1>
<table border="1">

	<tr>
	<td>공지번호</td><td><%=andto.getNum() %></td>
	<td>조회수</td><td><%=andto.getReadcount() %></td>
</tr>
	<tr>	
	<td>글쓴이</td><td><%=andto.getName() %></td>
	<td>작성일</td><td><%=andto.getDate() %></td>
</tr>
	<tr>
	<td>제목</td><td colspan="3"><%=andto.getSubject() %></td>
	</tr>
	
	<tr>
	<td>이미지</td>
	<td colspan="3">
	<a href="./upload/<%=andto.getImage() %>">
	<%=andto.getImage() %>
	
	</a>
	</td>
</tr> 

<tr>
	<td>공지 내용</td><td colspan="3"><%=andto.getContent() %></td>
</tr>
<tr>
	   <td colspan="4">
	    <input type="button" value="수정하기"
	           onclick="location.href='./NoticeUpdate.an?num=<%=andto.getNum() %>&pageNum=<%=pageNum %>'"
	    >
	    <input type="button" value="삭제하기"
	           onclick="location.href='./NoticeDelete.an?num=<%=andto.getNum() %>&pageNum=<%=pageNum %>'"
	    		
	    >
	    <input type="button" value="목록보기" onclick="location.href='./NoticeList.an?pageNum=<%=pageNum%>'">
	    </td>	  
	  </tr>


</table>

</body>
</html>