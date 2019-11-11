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
<link rel="stylesheet" href="./css/seat-ticketing.css">
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
	
<div class="bgColor">
 	
		<%@ include file="../include/header.jsp" %>
		<div class="ticketheader">
			<h1>주문/결제</h1>
		</div>
		<fieldset class="loginField">
		
		<form method="post" name="fr" class="seatForm">
		
		<table class="seatTable2">
		<tr>
			<td>
				<table class="innerTable">
				<tr>
					<th colspan="2"><span>영화</span></th>
				</tr>
				<tr>
					<td class="tdSpan" rowspan="4"><img src="./upload/<%=mdto.getPoster() %>" ></td>
					<td ><input type="text" class="SeatTitle" name="movie_title" value="<%=mdto.getTitle() %>" readonly="readonly"></td>
				</tr>
				<tr>
					<td><%=mdto.getGenre() %></td>
				</tr>
				<tr>
					<td><input type="hidden" name="movie_num" value="<%=mdto.getMovie_num() %>"></td>
				</tr>
				<tr>
					<td><%=mdto.getGrade() %>세 이상</td>
				</tr>
				</table>
			</td>
			<td class="tdLine">
				<table class="innerTable2">
					<tr>
						<th colspan="2"><span>예매정보</span></th>
					</tr>
					<tr>
						<td>상영일</td>
						<td><input type="text" name="running_date" class="totalPrice1" value="<%=running_date %>(<%=week %>)" readonly></td>
					</tr>
					<tr>
						<td>상영시간</td>
						<td><input type="text" name="running_time" class="totalPrice1" value="<%=running_time %>" readonly></td>
					</tr>
					<tr>
						<td>상영관</td>
						<td>
							<input type="text" name="room_num" class="totalPrice1" value="<%=cdto.getName()%> <%=roomNum %>관" readonly>
							<input type="hidden" name="cinema_num" value="<%=cdto.getCinema_num() %>"  readonly>
							<input type="hidden" name="roomNum" value="<%=roomNum %>"  readonly>
						</td>
					</tr>
					<tr>
						<td>좌석</td>
						<td><input type="text" name="seat" class="totalPrice1" value=<%=seat %> readonly></td>
					</tr>
				</table>
			</td>
			<td>
				<table class="innerTable3">
					<tr>
						<th colspan="2"><span>총 결제 금액</span></th>
					</tr>
					<tr>
						<td>영화예매</td>
						<td><input type="text" class="totalPrice1"  name="price" value="<%=price %>원"> </td>
					</tr>
					<tr>
						<td>관람인원</td><td><input type="text" class="totalPrice1"  name="person_num" value=<%=person_num %>></td>
					</tr>
					<tr>
						<td></td><td></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="text" class="totalPrice2" name="price"value=<%=price %>> 원</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<hr>		
	<div id="kpay">
	<h3>결제 방법</h3>
		<ul>
			<li>
				<label>
					<input type="radio" value="Kakaopay" name="payment" checked>
								&nbsp;
						<img alt="카카오페이" src="./img/payment.png">
				</label>
			</li>
			<li>
				<input type="button" class="payButton" value="결제하기" id="goPay">
				<input type="button" class="prevButton" value="이전 단계" id="before">
			</li>
		</ul>
	</div>
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