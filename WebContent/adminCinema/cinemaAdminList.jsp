<%@page import="com.cinema.db.CineDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 영화관 지점</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<link rel="stylesheet" href="././css/qnalist2.css">

<style type="text/css">
	table{
		
	}
 	input[type=button]{
		border:none;
		padding: 0;
		background:none;
	} 
	
</style>

</head>
<body>
	
	
	<%@ include file="../include/header.jsp" %>
	
	<%
		request.setCharacterEncoding("UTF-8");
	
	//관리자 확인

	
	//저장된 request값 가져오기
	List<CineDTO> cineList = (List<CineDTO>)request.getAttribute("cineList");
	
	int count = (Integer) request.getAttribute("count");
	String pageNum = (String)request.getAttribute("pageNum");
	int pageCount = (Integer) request.getAttribute("pageCount");
	int pageBlock = (Integer) request.getAttribute("pageBlock");
	int startPage = (Integer) request.getAttribute("startPage");
	int endPage = (Integer) request.getAttribute("endPage");
	int pageSize = (Integer) request.getAttribute("pageSize");
	%>
	
	<div id="contentsWrap">
	<table>
		<tr>
			<td colspan="8" class="cinemaWrite"><a href="./CinemaAdd.ci">등록</a></td>
		</tr>
 		
		
 		
	<% //리스트 갯수 
	for (int i = 0; i<cineList.size(); i++) {
		
		CineDTO cdto = cineList.get(i);
		String room = cdto.getRoom();
		int room_num = Integer.parseInt(room);
		
	%>	
		<tr>
 			<td>지점 번호</td>
 			<td>지역</td>
		 	<td>지점명</td>
		 	<td>관 수</td>
		 	<td>주소</td>
		 	<td>전화번호</td>
		 	<td>수정/삭제</td>
		 	<td rowspan="2">
		 		<input type="button" name="detail<%=i %>" value="상세보기" onclick="detail('<%=i%>')">
		 	</td>
		 </tr>
		<tr>
			<td><%=cdto.getRegion_num()%>-<%=cdto.getCinema_num() %></td>
			<td><%=cdto.getRegion() %></td>
		 	<td><%=cdto.getName() %></td>
		 	<td><%=room %></td>
		 	<td><%=cdto.getAddr() %></td>
		 	<td><%=cdto.getTel() %></td>
		 	<td>
		 		<a href="./CinemaModify.ci?cinema_num=<%=cdto.getCinema_num() %>">
		 		관 추가 및 수정</a>
		 		/ <a href="./CinemaDelete.ci?cinema_num=<%=cdto.getCinema_num() %>">지점,관 삭제</a>
		 	</td>
		 	
		 </tr>	
		 
		<tr >
		<td colspan="8">
		<table border="1" id="detail_part<%=i %>" style="display:none">
		 <%//관 나누기
			for(int j=0;j<room_num;j++){
				int room_findnum = j+1; 
				String movie_num = cdto.getMovie_num().split(",")[j];
				String seat = cdto.getSeat().split(",")[j];
				String start_times = cdto.getStart_times().split(",")[j];
				String end_times = cdto.getEnd_times().split(",")[j];
				String start_priod = cdto.getStart_priod().split(",")[j];
				String end_priod = cdto.getEnd_priod().split(",")[j]; 
		%>
		 
		 
		 <tr>
		 	<td>영화번호(영화로 변경)</td>
		 	<td>관 번호</td>
		 	<td>좌석 수</td>
		 	<td>상영 시작 시간</td>
		 	<td>상영 종료 시간</td>
		 	<td>상영 시작 일</td>
		 	<td>상영 종료 일</td>
		 	
 		</tr>		
		
		 <tr>
		 	<td><%=movie_num %></td>
		 	<td><%=room_findnum %>관</td>
		 	<td><%=seat %>좌석</td>
		 	<td><%=start_times %></td>
		 	<td><%=end_times %></td>
		 	<td><%=start_priod %></td>
		 	<td><%=end_priod %></td>
		 	
		</tr>
		
		
	<%} %>
		</table>
		</td>
		</tr>
		<!-- <tr>
			<td colspan="8">-----------------------------------------
			---------------------------------------------------------
			</td>		
		</tr>	 -->
		
	<%
	}
	%>	
	
		
	</table>
		
	<div id="pagingNumber">
	<%
		if(count != 0) {
			// 이전
			if (startPage > pageBlock) {
			%>
			<a href="./CinemaAdminDetail.ci?pageNum=<%=startPage - pageBlock%>">[이전]</a>
			<%
			}

			// 1...10  11..20  21...30
			for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="./CinemaAdminDetail.ci?pageNum=<%=i%>">[<%=i%>]
			</a>
			<%
			}

			// 다음
			if (endPage < pageCount) {
			%>
			<a href="./CinemaAdminDetail.ci?pageNum=<%=startPage + pageBlock%>">[다음]</a>
			<%
				}
		}
	%>
	</div>
		</div>
	
<script>
	
	var list_num = $('input[name=list_num]').val();

	var switch_num = 0;
	
	function detail(num){
		switch_num = num;
		
		if($('#detail_part'+switch_num).is(":visible")){
        	//alert("열림");
            $('#detail_part'+switch_num).css("display","none");
        }else{
        	//alert("닫힘");
            $('#detail_part'+switch_num).css("display","block");
        }
	}
	
	
	$(document).ready(function(){
		
		
	    //$("input[name=detail"+switch_num+"]").click(function(){
	    	 
	    	
	        
	    //});
		
		
	});


</script>

	<%@ include file="../include/footer.jsp" %>



</body>
</html>