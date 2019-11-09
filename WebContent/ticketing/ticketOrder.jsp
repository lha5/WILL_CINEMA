<%@page import="com.member.db.MemberDTO"%>
<%@page import="com.cinema.db.CineDTO"%>
<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 티켓 결제</title>
<link rel="stylesheet" href="./css/eventWrite.css">
<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- 아임포트 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</head>
<body>
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

		<fieldset class="eventFieldset">
		<h1>주문/결제</h1>
		<form method="post" name="fr" class="eventform">
		<table>
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
				</form>
		</fieldset>
		
		<!-- 뒤로 가기 버튼 기능 추가 -->
		<script type="text/javascript">
			$('#before').click(function() {
				history.back();
			});
		</script>
		
		
	
		<!-- 비동기 처리 -->
		<script type="text/javascript">
		function acyncMovePage(putUrl) {
			var week='<%=week%>';
			var realPri=<%=payment%>;
			var seat='<%=seat%>';
			var person_num='<%=person_num%>';
			var running_date='<%=running_date%>';
			var running_time='<%=running_time%>';
			var region_name='<%=cdto.getName()%>';
			var cinema_num=<%=cdto.getCinema_num()%>;
			var movie_num=<%=mdto.getMovie_num()%>;
			var movie_title='<%=mdto.getTitle()%>';
			var roomNum='<%=roomNum%>';
			var email='<%=memdto.getEmail()%>';
			var tel='<%=memdto.getMobile()%>';
			var buyer_name='<%=memdto.getName()%>';
		    $.ajax({
	            url : putUrl,
	            async : true,
	            type : "POST",
	            dataType : "html",
	            data:{week:week,realPri:realPri,seat:seat,person_num:person_num,running_date:running_date,
	            	running_time:running_time,region_name:region_name,cinema_num:cinema_num,movie_num:movie_num,
	            	movie_title:movie_title,roomNum:roomNum,email:email,tel:tel,buyer_name:buyer_name},
	            cache : false,
				error:function(request,status,error){
					alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
	               }
	    	}).done(function(data){
		        // Contents 영역 삭제
		        $('#paySection').children().remove();
		        // Contents 영역 교체
		        $('#paySection').html(data);
		    });
		}
			
		/* 결제 모듈 */
		
		document.querySelector('#goPay').addEventListener('click', function() {
				//가격, mdto(영화명,영화번호),cdto(지점명) , 상영관, 상영일, 상영시간,가격,인원수
				acyncMovePage('./TicketOrderProc.ti');
		});
	
		</script>
		
		<div id="paySection" style="display: none;"></div>
		
		<%@ include file="../include/footer.jsp" %>

	</div>
</body>
</html>