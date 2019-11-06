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

<!-- 아임포트 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<!-- CSS -->
<style type="text/css">
#bill {
	/* border: 1px solid lime; */
	width: 700px;
	margin: 50px auto;
}

#billInfo {
	border-collapse: collapse;
	width: 100%;
	text-align: center;
	margin-top: 20px;
}

#billInfo td {
	border-top: 2px solid #1c1c1c;
	border-bottom: 2px solid #1c1c1c;
	height: 70px;
}

#ttl {
	width: 700px;
	margin: 50px auto;
}

#howToPay {
	width: 700px;
	margin: 50px auto;
	line-height: 2.3em;
}

#line {
	border-top: 2px solid #e6e6e6;
	width: 700px;
	margin: 10px auto;
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
				<td>상품명</td>
				<td>상품 가격</td>
				<td>수량</td>
				<td>합계</td>
			</tr>
			<tr>
				<td><img src="./upload/<%=malldto.getImage() %>" witdh="50" height="50"><%=malldto.getName() %></td>
				<td><%=malldto.getPrice()%>원</td>
				<td><%=amount%></td>
				<td><%=total%>원</td>
			</tr>
		</table>
		</div>
		
		<div id="line"></div>
				
		<h1 id="ttl">결제 방법</h1>
		<fieldset id="howToPay">
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
		</fieldset>
		
		<!-- 뒤로 가기 버튼 기능 추가 -->
		<script type="text/javascript">
			$('#before').click(function() {
				history.back();
			});
		</script>
		
		
	
		<!-- 비동기 처리 -->
		<script>
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
		</script>
		
		
		
		<!-- 결제 모듈 -->
		<script type="text/javascript">
			document.querySelector('#goPay').addEventListener('click', function() {
				acyncMovePage('./MallOrderProc.mor?price=<%=total%>&goods_amount=<%=amount%>&goods_name=<%=malldto.getName()%>&goods_num=<%=malldto.getGoods_num()%>&email=<%=memdto.getEmail()%>&tel=<%=memdto.getMobile()%>&buyer_name=<%=memdto.getName()%>');
			});
	
		</script>
		
		<div id="paySection" style="display: none;"></div>
		
		<%@ include file="../include/footer.jsp" %>
	
	</div>
	
</body>
</html>