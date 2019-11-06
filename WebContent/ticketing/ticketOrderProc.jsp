<%@page import="com.cinema.db.CineDTO"%>
<%@page import="com.admin.movie.db.AdminMovieDTO"%>
<%@page import="com.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/ticketing/ticketOrderProc.jsp</h1>
<%
	// 세션값(아이디값) 받아오기
	String id = (String) request.getAttribute("id");



	MemberDTO memdto=(MemberDTO)request.getAttribute("memdto");//사용자정보
	AdminMovieDTO mdto=(AdminMovieDTO)request.getAttribute("mdto");//영화정보
	String roomNum=(String)request.getAttribute("roomNum");//상영관
	CineDTO cdto=(CineDTO)request.getAttribute("cdto");//영화관 정보
	String running_date=(String)request.getAttribute("running_date");//상영날짜
	String running_time=(String)request.getAttribute("running_time");//상영시간
	String week=(String)request.getAttribute("week");//요일
	//String price= (String)request.getAttribute("price");//10,000형식
	int realPri=(Integer)request.getAttribute("realPri");//DB넣을 가격
	String seat=(String)request.getAttribute("seat"); //좌석
	String person_num=(String)request.getParameter("person_num");//인원수

	System.out.println("영화관 : "+cdto.getCinema_num()+" 영화정보 : "+mdto.getMovie_num()+" 상영관 : "+roomNum+" 상영날짜 : "+running_time+
			" 상영시간 : "+running_date+" 요일 : "+week+" 실제 가격 : "+realPri+" 인원수: "+person_num+
			" 좌석 : "+seat+" 구매자: "+memdto.getName()+" 전화번호 : "+memdto.getMobile());
	/* String buyer_name = request.getParameter("buyer_name");
	int goods_amount = Integer.parseInt(request.getParameter("goods_amount"));
	String goods_name = request.getParameter("goods_name");
	int goods_num = Integer.parseInt(request.getParameter("goods_num"));
	
	String email = request.getParameter("email");

	String tel = request.getParameter("tel"); */
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
				name : '<%=mdto.getTitle()%> - 예매 테스트',
			    amount : <%=realPri%>,
			    buyer_name : '<%=memdto.getName()%>',
			    buyer_email : '<%=memdto.getEmail()%>',
			    buyer_tel : '<%=memdto.getMobile()%>'
			}, function(rsp) {
				if (rsp.success) {
					jQuery.ajax({
						url: './TicketOrderAddAction.ti',
						type: 'POST',
						dataType: 'text',
						// contentType : "application/json; charset=UTF-8",
						async: false,
						//영화번호, 영화관번호, 좌석, 상영관,실제가격,상영일,상영시간
						data: '<%=mdto.getMovie_num()%>,<%=cdto.getCinema_num()%>,<%=seat%>,<%=roomNum%>,<%=person_num%>,<%=realPri%>,<%=running_date%>,<%=running_time%>,<%=week%>,'+'KakaoPay'
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
					location.href = './ticketOrderDone.mor';
				} else {
					msg = '결제를 정상적으로 처리하지 못하였습니다.';
					msg += '에러 내용 : ' + rsp.error_msg;

					console.log(msg);
					location.href = './GoodsList.ml';
				}
			});
		});
	</script>
</body>
</html>