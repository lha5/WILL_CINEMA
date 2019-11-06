<%@page import="com.mall.db.MallDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 상품 상세 보기</title>

<!-- jQuery -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- input[type=number] 꾸미기 -->
<script type="text/javascript">
jQuery('<div class="quantity-nav"><div class="quantity-button quantity-up">+</div><div class="quantity-button quantity-down">-</div></div>').insertAfter('.quantity input');
jQuery('.quantity').each(function() {
  var spinner = jQuery(this),
    input = spinner.find('input[type="number"]'),
    btnUp = spinner.find('.quantity-up'),
    btnDown = spinner.find('.quantity-down'),
    min = input.attr('min'),
    max = input.attr('max');

  btnUp.click(function() {
    var oldValue = parseFloat(input.val());
    if (oldValue >= max) {
      var newVal = oldValue;
    } else {
      var newVal = oldValue + 1;
    }
    spinner.find("input").val(newVal);
    spinner.find("input").trigger("change");
  });

  btnDown.click(function() {
    var oldValue = parseFloat(input.val());
    if (oldValue <= min) {
      var newVal = oldValue;
    } else {
      var newVal = oldValue - 1;
    }
    spinner.find("input").val(newVal);
    spinner.find("input").trigger("change");
  });

});
</script>

<!-- CSS -->
<style type="text/css">
nav>ul>li:NTH-CHILD(5)>ul {
	display: block;
}

#goShopping, #contents {
	border: 1px solid red;
	width: 900px;
	margin: 50px auto;
}

#details {
	border-collapse: collapse;
	width: 100%;
}

#goShopping li {
	margin-top: 15px;
}

.quantity {
  position: relative;
}

input[type=number]::-webkit-inner-spin-button,
input[type=number]::-webkit-outer-spin-button
{
  -webkit-appearance: none;
  margin: 0;
}

input[type=number]
{
  -moz-appearance: textfield;
}

.quantity input {
  width: 45px;
  height: 42px;
  line-height: 1.65;
  float: left;
  display: block;
  padding: 0;
  margin: 0;
  padding-left: 20px;
  border: 1px solid #eee;
}

.quantity input:focus {
  outline: 0;
}

.quantity-nav {
  float: left;
  position: relative;
  height: 42px;
}

.quantity-button {
  position: relative;
  cursor: pointer;
  border-left: 1px solid #eee;
  width: 20px;
  text-align: center;
  color: #333;
  font-size: 13px;
  font-family: "Trebuchet MS", Helvetica, sans-serif !important;
  line-height: 1.7;
  -webkit-transform: translateX(-100%);
  transform: translateX(-100%);
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  -o-user-select: none;
  user-select: none;
}

.quantity-button.quantity-up {
  position: absolute;
  height: 50%;
  top: 0;
  border-bottom: 1px solid #eee;
}

.quantity-button.quantity-down {
  position: absolute;
  bottom: -1px;
  height: 50%;
}
</style>

</head>
<body>

	<%@ include file="../include/header.jsp" %>

	<%
	request.setCharacterEncoding("UTF-8");

	//DTO 객체 저장
	MallDTO mdto = (MallDTO) request.getAttribute("mdto");
	
	%>

	<form action="./MallOrderStar.mor" method="post" id="goShopping">
		<input type="hidden" name="goods_num" value="<%=mdto.getGoods_num()%>">
		<table id="details">
			<tr>
				<td><img src="./upload/<%=mdto.getImage()%>" width="300" height="300"></td>
				<td>
					<ul>
						<li><h2><%=mdto.getName()%></h2></li>
						<li><%=mdto.getPrice()%> 원</li>
						<hr>
						<li>구성<br><%=mdto.getContent()%></li>
						<li>유효기간<br>관람권 6개월 / 상품권 6개월</li>
						<li>
							<div class="quantity">
								<input type="number" min="1" max="2" step="1" value="1">
							</div>
							&nbsp;
							<input type="submit" value="구매 하기">
						</li>
						<li><input type="button" value="상품 목록" id="goList"></li>
					</ul>
				</td>
			</tr>
		</table>
	</form>
	
	<div id="contents">
		<span>상세정보</span>
	</div>
	
	<script type="text/javascript">
		document.querySelector('#goList').addEventListener('click', function() {
			location.href = './GoodsList.ml';
		});
	</script>

	<%@ include file="../include/footer.jsp" %>
</body>
</html>