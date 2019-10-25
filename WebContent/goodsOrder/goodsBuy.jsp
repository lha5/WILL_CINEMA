<%@page import="com.mall.db.MallDTO"%>
<%@page import="com.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 상품 구매</title>

<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- 네이버 페이 -->
<!-- <script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script> -->

</head>
<body>
	<div id="wrap">
	<%@ include file="../include/header.jsp" %>

	<%
	MemberDTO memdto = (MemberDTO) request.getAttribute("memdto");
	MallDTO malldto = (MallDTO) request.getAttribute("malldto");
	
	int amount = (int) request.getAttribute("amount");
	int total = malldto.getPrice() * amount;
	%>

	<h1>주문 내역</h1>
	<table border="1">
		<tr>
			<td>상품명</td>
			<td>사진</td>
			<td>수량</td>
			<td>가격</td>
		</tr>
		<tr>
			<td><%=malldto.getName() %></td>
			<td><img src="./goodsImageUpload/<%=malldto.getImage() %>" witdh="50" height="50"></td>
			<td><%=amount%></td>
			<td><%=total%>원</td>
		</tr>
	</table>

	<br>
	<br>
	<br>
	
	
	<fieldset>
		<form action="./MallOrderAddAction.mor" method="post">
			<input type="hidden" name="order_id" value="<%=id%>">
			<input type="hidden" name="goods_num" value="<%=malldto.getGoods_num()%>">
			<input type="hidden" name="goods_name" value="<%=malldto.getName() %>">
			<input type="hidden" name="goods_amount" value="<%=amount%>">
			<input type="hidden" name="price" value="<%=total%>">
			<input type="hidden" name="email" value="<%=memdto.getEmail()%>">
			<input type="hidden" name="tel" value="<%=memdto.getMobile()%>">
			
			<h3>결제 방법</h3>
			
			<table border="1">
				<tr>
					<td>간편 결제</td>
				</tr>
				<tr>
					<td>
						<label>
							<!-- <input type="radio" name="payment" value="Kakao" id="pay" checked> -->
							<script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"
							    data-client-id="u86j4ripEt8LRfPGzQ8"
							    data-mode="development"
							    data-merchant-user-key="{#_merchantUserKey}"
							    data-merchant-pay-key="{#_merchantPayKey}"
							    data-product-name="<%=malldto.getGoods_num()%>"
							    data-total-pay-amount="<%=total%>"
							    data-tax-scope-amount="{#_taxScopeAmount}"
							    data-tax-ex-scope-amount="{#_taxExScopeAmount}"
							    data-return-url="{#_returnUrl}">
							</script>
						</label>
					</td>
				</tr>
			</table>
			
			<input type="submit" value="결제하기">
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
	
	<script type="text/javascript">
		<%-- var IMP = window.IMP;
		IMP.init('imp30527297');
		
		IMP.request_pay({
		    pg : 'kakao',
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '윌시네마 상품 구매',
		    amount : <%=total%>,
		    buyer_email : '<%=memdto.getEmail()%>',
		    buyer_name : '<%=memdto.getName()%>',
		    buyer_tel : '<%=memdto.getMobile()%>'
		}, function(rsp) {
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		        
		        alert(msg);
		        
		    	location.href = './MallOrderAddAction.mor';
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    	alert(msg);
		    }
		}); --%>
	</script>
	
	<%@ include file="../include/footer.jsp" %>
	
	</div>
	
</body>
</html>