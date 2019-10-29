<%@page import="com.mall.order.db.MallOrderDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 구매 확인</title>
<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- 비동기 처리 -->
<script>
function acyncMovePage(url){
    // ajax option
    var ajaxOption = {
            url : url,
            async : true,
            type : "POST",
            dataType : "html",
            cache : false
    };
    
    $.ajax(ajaxOption).done(function(data){
        // #wrap 영역 삭제
        $('#wrap').children().remove();
        // #wrap 영역 교체
        $('#wrap').html(data);
    });
}
</script>
</head>
<body>
	
	<%
	String id = (String) request.getAttribute("id");
	
	List<MallOrderDTO> orderList = (List<MallOrderDTO>) request.getAttribute("orderList");
	%>

	<%-- <%@ include file="../include/header.jsp" %> --%>

	<div id="wrap">
	
		<h2>주문한 내역</h2>
		
		<table border="1">
			<tr>
				<td>주문 번호</td>
				<td>구매 상품</td>
				<td>주문 갯수</td>
				<td>금액</td>
				<td>주문 일시</td>
			</tr>
			<%
			for (int i = 0; i < orderList.size(); i++) {
				MallOrderDTO modto = orderList.get(i);
			%>
				<tr>
					<td><a href="./MallOrderDetail.mor?trans_num=<%=modto.getTrans_num()%>"><%=modto.getTrans_num()%></a></td>
					<td><%=modto.getGoods_name()%></td>
					<td><%=modto.getGoods_amount()%></td>
					<td><%=modto.getPrice() %>원</td>
					<td><%=modto.getOrder_date()%></td>
				</tr>			
			<%
			}
			%>
		</table>
	
	</div>
	
	<%-- <%@ include file="../include/footer.jsp" %> --%>
</body>
</html>