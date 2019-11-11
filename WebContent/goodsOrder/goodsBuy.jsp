<%@page import="com.mall.db.MallDTO"%>
<%@page import="com.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 상품 구매</title>
<!-- Remix Icon -->
<link href="https://cdn.remixicon.com/releases/v2.0.0/remixicon.css" rel="stylesheet">

<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- 아임포트 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<!-- CSS -->
<style type="text/css">
#bill {
	/* border: 1px solid lime; */
	width: 900px;
	margin: 50px auto;
}

#billInfo {
	border-collapse: collapse;
	width: 100%;
	text-align: center;
	margin-top: 20px;
}

#billInfo td {
	border-top: 1px solid #e6e6e6;
	border-bottom: 1px solid #e6e6e6;
	height: 70px;
}

#billInfo td:NTH-CHILD(1), #billInfo td:NTH-CHILD(3) {
	width: 100px;
}

#billInfo tr:NTH-CHILD(1) td {
	height: 100px;
}

#billInfo tr:NTH-CHILD(2) td {
	background-color: #e6e6e6;
}

#billInfo tr:NTH-CHILD(2) td:NTH-CHILD(2) {
	text-align: right;
	padding-right: 20px;
	font-size: 1.5em;
}

#ttl {
	width: 900px;
	margin: 50px auto 0 auto;
}

#howToPay {
	width: 900px;
	margin: 20px auto;
	line-height: 2.3em;
	text-align: center;
	padding-top: 30px;
	border: 1px solid #e6e6e6;
}

#goPay {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 120px;
	height: 50px;
	border: 1px solid #1c1c1c;
	background-color: #1c1c1c;
	font-family: inherit;
	font-size: 16px;
	color: #ffffff;
	letter-spacing: 2px;
	margin-top: 20px;
}

#before {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 120px;
	height: 50px;
	border: 1px solid #1c1c1c;
	background-color: #ffffff;
	font-family: inherit;
	font-size: 16px;
	color: #1c1c1c;
	letter-spacing: 2px;
	margin-top: 20px;
}

#applyPoint {
	width: 100%;
	height: 170px;
	/* border: 1px solid red; */
	background-color: #e6e6e6;
}

#applyPoint li {
	float: left;
	padding: 20px;
	margin: 20px 110px 20px 130px;
	width: 150px;
	height: 100px;
	border: 1px solid #e6e6e6;
}

#kpay {
	clear: both;
}
</style>

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
		<div id="bill">
		<h1>구매할 상품 정보</h1>
		<table id="billInfo">
			<tr>
				<td><img src="./upload/<%=malldto.getImage() %>" witdh="50" height="50"></td>
				<td>
					<%=malldto.getName() %>
					<br>
					<br>
					<%=amount%>개
				</td>
				<td>가격<br><%=malldto.getPrice()%>원</td>
			</tr>
			<tr>
				<td>총 주문 금액</td>
				<td colspan="2"><%=total%>원</td>
			</tr>
		</table>
		</div>
		
		
				
		<h1 id="ttl">결제 방법</h1>
		<fieldset id="howToPay">
			<div id="applyPoint">
				<ul>
					<li>
						잔여 포인트
						<br>
						<%=memdto.getPoint()%> POINT
					</li>
					<li>
						사용할 포인트
						<br>
						<input type="number" name="usingPnt" min="0" max="<%=total%>" step="100">
					</li>
				</ul>
			</div>
			<div id="kpay">
				<input type="hidden" value="Kakaopay" name="payment" checked>
				<img alt="카카오페이" src="./img/payment.png">
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
			// 결제 모듈
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
			
			// 결제 모듈 불러오기
			document.querySelector('#goPay').addEventListener('click', function() {
				acyncMovePage('./MallOrderProc.mor?price=<%=total%>&goods_amount=<%=amount%>&goods_name=<%=malldto.getName()%>&goods_num=<%=malldto.getGoods_num()%>&email=<%=memdto.getEmail()%>&tel=<%=memdto.getMobile()%>&buyer_name=<%=memdto.getName()%>');
			});
		</script>
		
		<div id="paySection" style="display: none;"></div>
		
		<%@ include file="../include/footer.jsp" %>
	
	</div>
	
</body>
</html>