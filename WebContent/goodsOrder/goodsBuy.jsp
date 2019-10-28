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

<!-- Bpopup -->
<script src="js/plugins/bpopup/jquery.bpopup.min.js"></script>


<!-- 아임포트 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

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

		<form id="myForm">
			<%-- 
			<input type="hidden" name="order_id" value="<%=id%>">
			<input type="hidden" name="goods_num" value="<%=malldto.getGoods_num()%>">
			<input type="hidden" name="goods_name" value="<%=malldto.getName()%>">
			<input type="hidden" name="goods_amount" value="<%=amount%>">
			<input type="hidden" name="price" value="<%=total%>">
			<input type="hidden" name="email" value="<%=memdto.getEmail()%>">
			<input type="hidden" name="tel" value="<%=memdto.getMobile()%>">
			 --%>
			<h3>결제 방법</h3>
			
			<div id="kpay">

				<label>
					<input type="radio" value="Kakaopay" name="payment" checked>
					&nbsp;
					<img alt="카카오페이" src="./img/payment.png">
				</label>
			</div>
				
			
			<input type="button" value="결제하기" id="goPay">
			<!-- <input type="submit" value="결제하기"> -->
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
	
	<div id="paySection" style="display: none;">
		
	</div>
	
	<%@ include file="../include/footer.jsp" %>
	
	</div>
	
</body>
</html>