<%@page import="com.cinema.db.CineDTO"%>
<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@page import="com.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 결제 진행</title>
</head>
<body>
<h1>WebContent/ticketing/ticketOrderProc.jsp</h1>
<%
	// 세션값(아이디값) 받아오기
	String id = (String) request.getAttribute("id");
	
	String person_num=request.getParameter("person_num");
	String running_date=request.getParameter("running_date");
	String running_time=request.getParameter("running_time");
	String region_name=request.getParameter("region_name");
	int cinema_num=Integer.parseInt(request.getParameter("cinema_num"));
	int movie_num=Integer.parseInt(request.getParameter("movie_num"));
	String seat=request.getParameter("seat");
	String roomNum=request.getParameter("roomNum");
	int realPri=Integer.parseInt(request.getParameter("realPri"));
	String week=request.getParameter("week");
	//결제 보여주기용
	String movie_title=request.getParameter("movie_title");
	
	
	String buyer_name = request.getParameter("buyer_name");
	String email = request.getParameter("email");
	String tel = request.getParameter("tel");
	/* System.out.println("영화관: "+cinema_num +" 가격 : "+realPri+" 좌석 : "+seat+" 인원 : "+person_num+" 상영일:"+running_date
			+" 상영시간 : "+running_time+" 영화명 : "+movie_title+" 구매자 : "+buyer_name+" 관 번호: "+roomNum); */
	
	%>
	<!-- 결제 모듈 -->
	<script type="text/javascript">
		$(document).ready(function() {
			// var IMP = window.IMP;

			IMP.init('imp30527297');
			var msg;
			
			IMP.request_pay({
				pg : 'Kakaopay',
				pay_method : 'card',
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : '<%=movie_title%> (<%=person_num%>) - <%=region_name%>(<%=roomNum%>관)  - 예매 테스트',
			    amount : <%=realPri%>,
			    buyer_name : '<%=buyer_name%>',
			    buyer_email : '<%=email%>',
			    buyer_tel : '<%=tel%>'
			}, function(rsp) {
				if (rsp.success) {
					jQuery.ajax({
						url: './TicketOrderAddAction.ti',
						type: 'POST',
						dataType: 'text',
						// contentType : "application/json; charset=UTF-8",
						async: false,
						//영화번호, 영화관번호, 좌석, 상영관,실제가격,상영일,상영시간,요일
						data: '<%=movie_num%>,<%=cinema_num%>,<%=seat%>,<%=roomNum%>,<%=person_num%>,<%=realPri%>,<%=running_date%>,<%=running_time%>,<%=week%>,'+'KakaoPay'
					}).done(function(data) {
						/* if (everythings_fine) {							
							msg = '결제가 완료되었습니다.';
					        msg += '고유ID : ' + rsp.imp_uid;
					        msg += '상점 거래ID : ' + rsp.merchant_uid;
					        msg += '결제 금액 : ' + rsp.paid_amount;
					        msg += '카드 승인번호 : ' + rsp.apply_num;

					        console.log(msg);
						
						} else {
							msg = '결제가 정상적으로 처리되지 못하였습니다.';
							alert(msg);
						} */
					});
					// 성공했을 시 이동할 페이지
					location.href = './TicketOrderDone.ti';
				} else {
					msg = '결제를 정상적으로 처리하지 못하였습니다.';
					msg += '에러 내용 : ' + rsp.error_msg;

					console.log(msg);
					location.href = './Ticketing.ti';
				}
			});
		});
	</script>
</body>
</html>