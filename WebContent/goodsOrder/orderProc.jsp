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

	// 세션값(아이디값) 받아오기
	String id = (String) request.getAttribute("id");
	
	String buyer_name = request.getParameter("buyer_name");
	
	int goods_amount = Integer.parseInt(request.getParameter("goods_amount"));
	String goods_name = request.getParameter("goods_name");
	int goods_num = Integer.parseInt(request.getParameter("goods_num"));
	
	String email = request.getParameter("email");

	String tel = request.getParameter("tel");
	
	int usingPoint = Integer.parseInt(request.getParameter("usingPoint"));
	
	int price = Integer.parseInt(request.getParameter("price")) - usingPoint;
	%>
	<!-- 결제 모듈 
		https://smujihoon.tistory.com/m/103
	-->
	<script type="text/javascript">
		$(document).ready(function() {
			// var IMP = window.IMP;

			IMP.init('imp30527297');
			var msg;
			
			IMP.request_pay({
				pg : 'Kakaopay',
				pay_method : 'card',
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : '윌시네마 상품 구매 - 테스트',
			    amount : <%=price%>,
			    buyer_name : '<%=buyer_name%>',
			    buyer_email : '<%=email%>',
			    buyer_tel : '<%=tel%>'
			}, function(rsp) {
				if (rsp.success) {
					jQuery.ajax({
						url: './MallOrderAddAction.mor',
						type: 'POST',
						dataType: 'text',
						// contentType : "application/json; charset=UTF-8",
						async: false,
						data: '<%=goods_num%>,<%=goods_name%>,<%=goods_amount%>,<%=price%>,'+'KakaoPay'+',<%=tel %>,<%=usingPoint%>'
					}).done(function(data) {
												
					});
					// 성공했을 시 이동할 페이지
					location.href = './MallOrderDone.mor';
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