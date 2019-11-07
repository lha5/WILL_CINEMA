<%@page import="com.mall.db.MallDTO"%>
<%@page import="com.mall.order.db.MallOrderDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 구매 내역 상세</title>

<!-- CSS -->
<style type="text/css">
#sec {
	/* border: 1px solid red; */
	width: 750px;
	margin: 50px auto;
}

#sec>table {
	border-collapse: collapse;
	border: 1px solid #1c1c1c;
	width: 700px;
	margin: 50px auto;
}

#sec>table td {
	border: 1px solid #1c1c1c;
}

/* 티켓 만들기
#tkSec {
	width: 500px;
	height: 200px;
	margin: 50px auto;
	border: 1px solid #d7282d;
	background-color: #d7282d;
}

#ttl {
	float: right;
	margin: 15px;
	font-family: Jalnan;
	font-size: 1.4em;
	color: #ffffff;
	letter-spacing: 1px;
}

#inf {
	margin: 50px 0px 10px 35px;
	color: #ffcf33;
}

#inf>span {
	font-family: NanumGothic;
	font-size: 1.2em;
	font-weight: 500;
} 
*/
</style>

</head>
<body>

	<%
	List mallOrderDetail = (List) request.getAttribute("mallOrderDetail");
	String imgSrc = "";
	%>


	<div id="wrap">
	
	<%@ include file="../include/header.jsp" %>
	
	<section id="sec">
	<h2>구매 상세 내역</h2>
	<table>
		<tr>
			<td>구매 번호</td>
			<td></td>
			<td>구매 일자</td>
			<td></td>
		</tr>
		<tr>
			<td>구매한 상품</td>
			<td colspan="3"></td>
		</tr>
		<tr>
			<td>교환권 번호</td>
			<td></td>
			<td>사용 여부</td>
			<td></td>
		</tr>
		<tr>
			<td>수량</td>
			<td></td>
			<td>총 가격</td>
			<td></td>
		</tr>
		<tr>
			<td>유의사항</td>
			<td colspan="3">
				벌레는 하나에 봄이 까닭입니다. 별 그리고 지나고 소녀들의 봅니다. 불러 북간도에 아이들의 멀리
				같이 별 계절이 무성할 계십니다. 봄이 겨울이 지나고 차 다하지 듯합니다. 내일 시와 이네들은 딴은 벌레는 지나가는
				버리었습니다. 나는 하늘에는 이제 멀듯이, 보고, 멀리 피어나듯이 마디씩 계십니다. 위에 소녀들의 릴케 불러 까닭입니다.
				무엇인지 것은 헤는 말 별 가슴속에 거외다. 마리아 내 내 별 소녀들의 비둘기, 멀리 계십니다. 별에도 무엇인지 걱정도
				쓸쓸함과 까닭입니다. 언덕 강아지, 청춘이 아이들의 지나고 이런 라이너 아무 버리었습니다. 언덕 나는 옥 오는 비둘기,
				하나에 봅니다. 내일 오면 까닭이요, 계십니다. 나의 별을 파란 하나 까닭이요, 덮어 봅니다. 지나고 나는 풀이 써 별
				헤일 다 까닭입니다. 불러 하나에 가난한 그리워 쓸쓸함과 아침이 버리었습니다. 멀리 애기 새겨지는 된 추억과 나의 말
				있습니다. 이름자 묻힌 같이 언덕 별이 내 프랑시스 까닭입니다. 무엇인지 남은 않은 하나에 아이들의 하나에 된 가난한
				듯합니다. 이름과, 남은 새겨지는 그리워 나는 까닭이요, 이런 나는 별을 계십니다. 까닭이요, 비둘기, 헤일 시인의 애기
				위에도 거외다.
			</td>
		</tr>
		<%-- <%
		for (int i = 0; i < mallOrderDetail.size(); i++) {
			MallOrderDTO modto = (MallOrderDTO) mallOrderDetail.get(i);
			//imgSrc = modto.getBarcode_img().substring(42);	// 주소 필요한 만큼 잘라내기
		%>
		<tr>
		
			<td><%=modto.getTrans_num()%></td>
			<td><%=modto.getOrder_date()%></td>
			<td><%=modto.getGoods_name() %></td>
			<td><%=modto.getGoods_amount()%></td>
			<td>카카오페이</td>
			<td><%=modto.getPrice()%>원</td>
			<td>
				<img alt="바코드 교환권" src=".<%=imgSrc%>">
				<br>
				<%=modto.getBarcode()%>
			</td>
		</tr>
		<%
		}
		%> --%>
	</table>
	</section>
	
	<!-- <div id="tkSec">
		<div id="ttl">WILL CINEMA</div>
		<div id="inf">
			<i class="ri-vidicon-2-line ri-5x"></i><br>
			<span>MOVIE TICKET</span><br>
			<span>영화관람권</span>
		</div>
	</div> -->
	
	<%@ include file="../include/footer.jsp" %>
	
	</div>
	
</body>
</html>