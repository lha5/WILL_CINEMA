<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 결제</title>

<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- 아임포트 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</head>
<body>
	<h1>WebContent/goodsOrder/orderProc.jsp</h1>
	<%
	int price = Integer.parseInt(request.getParameter("price"));
	String email = request.getParameter("email");
	String id = (String) request.getAttribute("id");
	String tel = request.getParameter("tel");
	%>
	<!-- 결제 모듈 -->
	<script type="text/javascript">
		$(function() {
			var IMP = window.IMP;
			IMP.init('imp30527297');
			var msg;
			
			IMP.request_pay({
				pg : 'Kakaopay',
				pay_method : 'card',
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : '윌시네마 상품 구매 - 테스트',
			    amount : <%=price%>,
			    buyer_email : '<%=email%>',
			    buyer_name : '<%=id%>',
			    buyer_tel : '<%=tel%>'
			}, function(rsp) {
				if (rsp.success) {
					jQuery.ajax({
						url: './MallOrderAddAction.mor',
						type: 'POST',
						dataType: 'json',
						data: {
							imp_uid : rsp.imp_uid
						}
					}).done(function(data) {
						if (everythings_fine) {
							msg = '결제가 완료되었습니다.';
					        msg += '고유ID : ' + rsp.imp_uid;
					        msg += '상점 거래ID : ' + rsp.merchant_uid;
					        msg += '결제 금액 : ' + rsp.paid_amount;
					        msg += '카드 승인번호 : ' + rsp.apply_num;
					        
					        alert(msg);
						} else {
							msg = '결제가 정상적으로 처리되지 못하였습니다.';
							
							alert(msg);
						}
						location.href='./Main.me';
					});
				} else {
					msg = '결제를 정상적으로 처리하지 못하였습니다.';
					msg += '에러 내용 : ' + rsp.error_msg;
					location.href='./index.jsp'
				}
			});
		});
	</script>
</body>
</html>