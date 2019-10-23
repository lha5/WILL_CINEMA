<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 결제</title>

<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- 네이버 페이 -->
<!-- <script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script> -->

</head>
<body>
	<h1>WebContent/goodsOrder/orderProc.jsp</h1>
	<%
	
	%>

	<script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"
	    data-client-id="u86j4ripEt8LRfPGzQ8"
	    data-mode="development"
	    data-merchant-user-key="{#_merchantUserKey}"
	    data-merchant-pay-key="{#_merchantPayKey}"
	    data-product-name="{#_productName}"
	    data-total-pay-amount="{#_totalPayAmount}"
	    data-tax-scope-amount="{#_taxScopeAmount}"
	    data-tax-ex-scope-amount="{#_taxExScopeAmount}"
	    data-return-url="{#_returnUrl}">
	</script>
</body>
</html>