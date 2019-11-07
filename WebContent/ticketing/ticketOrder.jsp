<%@page import="com.member.db.MemberDTO"%>
<%@page import="com.cinema.db.CineDTO"%>
<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- 아임포트 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</head>
<body>
<h1>WebContent/ticketing/ticketOrder.jsp</h1>
<%
		//회원정보
		MemberDTO memdto = (MemberDTO) request.getAttribute("memdto");

		AdminMovieDTO mdto=(AdminMovieDTO)request.getAttribute("mdto");//영화정보
		String roomNum=(String)request.getAttribute("roomNum");//상영관
		CineDTO cdto=(CineDTO)request.getAttribute("cdto");//영화관 정보
		String running_date=(String)request.getAttribute("running_date");//상영날짜
		String running_time=(String)request.getAttribute("running_time");//상영시간
		String week=(String)request.getAttribute("week");//요일
		String price= (String)request.getAttribute("price");//10,000형식
		int payment=(Integer)request.getAttribute("payment");//DB넣을 가격
		String seat=(String)request.getAttribute("seat"); //좌석
		String person_num=(String)request.getParameter("person_num");//인원수
		System.out.println("영화관 : "+cdto.getCinema_num()+"상영관 : "+roomNum+"상영날짜 : "+running_time+
				"상영시간 : "+running_date+"요일 : "+week+"가격 : "+price+"실제 가격 : "+payment+"인원수: "+person_num+
				"좌석 : "+seat+"구매자: "+memdto.getName()+"전화번호 : "+memdto.getMobile());
%>
	
<div id="wrap">
 	
		<%@ include file="../include/header.jsp" %>

		
		<h1>주문 내역</h1>
		<table border="1">
			<tr>
				<td>제목</td>
				<td>사진</td>
				<td>상영일</td>
				<td>상영관</td>
				<td>좌석</td>
				<td>상영시간</td>
				<td>관람인원</td>
				<td>가격</td>
			</tr>
			<tr>
				<td><%=mdto.getTitle() %></td>
				<td><img src="./upload/<%=mdto.getPoster() %>" width="65" height="94"></td>
				<td><%=running_date %></td>
				<td><%=cdto.getName() %> <%=roomNum %></td>
				<td><%=seat%></td>
				<td><%=running_time%></td>
				<td><%=person_num %></td>
				<td><%=price%>원</td>
			</tr>
		</table>
	
		<br>
		<br>
		<br>
		
		
		<fieldset>
	
				<h3>결제 방법</h3>
				
				<div id="kpay">
	
					<label>
						<input type="radio" value="Kakaopay" name="payment" checked>
						&nbsp;
						<img alt="카카오페이" src="./img/payment.png">
					</label>
				</div>
					
				
				<input type="button" value="결제하기" id="goPay">
				&nbsp;&nbsp;
				<input type="button" value="이전 단계" id="before">

		</fieldset>
		
		<!-- 뒤로 가기 버튼 기능 추가 -->
		<script type="text/javascript">
			$('#before').click(function() {
				history.back();
			});
		</script>
		
		
	
		<!-- 비동기 처리 -->
		<script>
			function acyncMovePage(url) {
			    var ajaxOption = {
			            url : url,
			            async : true,
			            type : "POST",
			            dataType : "html",
			            cache : false
			    };
			    
			    $.ajax(ajaxOption).done(function(data){
			        // Contents 영역 삭제
			        $('#paySection').children().remove();
			        // Contents 영역 교체
			        $('#paySection').html(data);
			    });
			}
		</script>

		<!-- 결제 모듈 -->
		<script type="text/javascript">
			document.querySelector('#goPay').addEventListener('click', function() {
				//가격, mdto(영화명,영화번호),cdto(지점명) , 상영관, 상영일, 상영시간,가격,인원수
				acyncMovePage('./TicketOrderProc.ti?week=<%=week%>&realPri=<%=payment%>&seat=<%=seat%>&person_num=<%=person_num%>&running_date=<%=running_date%>&running_time=<%=running_time%>&cdto=<%=cdto%>&mdto=<%=mdto%>&roomNum=<%=roomNum%>&memdto=<%=memdto%>');
			});
	
		</script>
		
		<div id="paySection" style="display: none;"></div>
		
		<%@ include file="../include/footer.jsp" %>

	</div>
</body>
</html>