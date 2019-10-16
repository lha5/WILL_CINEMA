<%@page import="java.util.ArrayList"%>
<%@page import="com.admin.service.event.db.AdminEventDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function chk(num){
		if(confirm("삭제하시겠습니까?")){
			location.href="./EventDelete.ae?num="+num;
		}else{
			return false;
		}
	}
</script>
</head>
<body>

<%@ include file="../../include/header.jsp" %>

<%
	List<AdminEventDTO> eventList = (ArrayList<AdminEventDTO>)request.getAttribute("eventList");
	String keyward=(String)request.getAttribute("keyward");
	if(keyward==null){
		keyward="";
	}
	String item=(String)request.getAttribute("item");
	if(item==null){
		item="";
	}

	int cnt = (Integer)request.getAttribute("cnt");
	String pageNum= (String)request.getAttribute("pageNum");
	int pageCount= (Integer)request.getAttribute("pageCount");
	int pageBlock= (Integer)request.getAttribute("pageBlock");
	int startPage= (Integer)request.getAttribute("startPage");
	int endPage= (Integer)request.getAttribute("endPage");

%>


<h1>상품 리스트</h1>
<h3><a href="./EventSummary.ae">이벤트 페이지</a></h3>

<form action="EventList.ae" method="post">
<select name="category">
	<option value="" <%if(item.equals("")){%>selected<%} %>>전체보기</option>
	<option value="movie" <%if(item.equals("movie")){%>selected<%} %>>영화</option>
	<option value="preview" <%if(item.equals("preview")){%>selected<%} %>>시사회/무대인사</option>
	<option value="nevent" <%if(item.equals("nevent")){%>selected<%} %>>윌시NOW</option>
	<option value="collabo" <%if(item.equals("collabo")){%>selected<%} %>>제휴 할인</option>
</select>
<input type="text" name="keyward" value="<%=keyward%>"><input type="submit" value="검색">
</form>

<br><br>
<!-- 카테고리 만들기 -->
<table border="1">
	<tr><td>번호</td><td>카테고리</td><td>제목</td>
	<td>이미지</td><td>이벤트 기간</td><td>수정/삭제</td></tr>
<%
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage -1)*5 +1;//->1 4 7

if(eventList.size()!=0){
	for(int i=0; i<eventList.size(); i++){
		AdminEventDTO aedto=eventList.get(i);
		%>
		<tr>
		<td><%=i+startRow %></td>
		<td><%=aedto.getCategory() %></td>
		<td><%=aedto.getSubject() %></td>
		<td>
			<img src="./upload/<%=aedto.getImage().split(",")[0] %>" width="120" height="80">
		</td>
		<td><%=aedto.getF_date() %>~<%=aedto.getE_date() %></td>
		<td><input type="button" value="수정" onclick="location.href='./EventUpdate.ae?num=<%=aedto.getNum()%>'"> 
		<input type="button" value="삭제" onclick="chk(<%=aedto.getNum()%>);"></td></tr>
	<%} 
}%>
</table>

<%
/*****************페이징 처리********************/
//이전
	if(cnt != 0){
		if(startPage>pageBlock){
			//if(keyward!=null){
			%>
			<a href="./EventList.ae?category=<%=item %>&pageNum=<%=startPage-pageBlock%>
			&keyward=<%=keyward %>">[이전]</a>
			<%
			//}
		}
		//1...3 4...6
		for(int i=startPage; i<=endPage; i++){
			%>
			<a href="./EventList.ae?category=<%=item %>&pageNum=<%=i%>
			&keyward=<%=keyward %>">[<%=i%>]</a>
			
			<%
		}
		//다음
		if(endPage<pageCount){
			%>
			<a href="./EventList.ae?&category=<%=item %>&pageNum=<%=startPage+pageBlock%>
			&keyward=<%=keyward %>"">[다음]</a>
			<%
		}
	}
/********************************************/
%>

<%@ include file="../../include/footer.jsp" %>

</body>
</html>