<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 상품 구매</title>
<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- I'mport -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
	
	<%
	String id = (String) session.getAttribute("id");
	int total = Integer.parseInt(request.getParameter("price"));
	int amount = Integer.parseInt(request.getParameter("goods_amount"));
	int goods_num = Integer.parseInt(request.getParameter("goods_num"));
	String goods_name = request.getParameter("goods_name");
	String order_id = request.getParameter("order_id");
	String payment = request.getParameter("payment");
	
	String email = request.getParameter("email");
	String tel = request.getParameter("tel");
	%>

	<script type="text/javascript">
		var IMP = window.IMP; // 현재 페이지에 표시되게 하기
		IMP.init('imp30527297');
		
		IMP.request_pay({
		    pg : 'kakao',
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '윌시네마 상품 구매',
		    amount : <%=total%>,
		    buyer_email : '<%=email%>',
		    buyer_name : '<%=order_id%>',
		    buyer_tel : '<%=tel%>',
		    m_redirect_url : './MallOrderAddAction.mor?goods_num=<%=goods_num%>&goods_name=<%=goods_name%>&goods_amount=<%=amount%>&payment=<%=payment%>'
		}, function(rsp) {
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);
		});
	</script>
</body>
</html>