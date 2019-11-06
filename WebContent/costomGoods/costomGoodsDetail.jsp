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

<script type="text/javascript">
(function($) {
	  "use strict";

	  function customQuantity() {
	    /** Custom Input number increment js **/
	    jQuery(
	      '<div class="pt_QuantityNav"><div class="pt_QuantityButton pt_QuantityUp">+</div><div class="pt_QuantityButton pt_QuantityDown">-</div></div>'
	    ).insertAfter(".pt_Quantity input");
	    jQuery(".pt_Quantity").each(function() {
	      var spinner = jQuery(this),
	        input = spinner.find('input[type="number"]'),
	        btnUp = spinner.find(".pt_QuantityUp"),
	        btnDown = spinner.find(".pt_QuantityDown"),
	        min = input.attr("min"),
	        max = input.attr("max"),
	        valOfAmout = input.val(),
	        newVal = 0;

	      btnUp.on("click", function() {
	        var oldValue = parseFloat(input.val());

	        if (oldValue >= max) {
	          var newVal = oldValue;
	        } else {
	          var newVal = oldValue + 1;
	        }
	        spinner.find("input").val(newVal);
	        spinner.find("input").trigger("change");
	      });
	      btnDown.on("click", function() {
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
	  }
	  customQuantity();
	})(jQuery);
</script>

<!-- CSS -->
<style type="text/css">
nav>ul>li:NTH-CHILD(5)>ul {
	display: block;
}

#goShopping, #contents {
	border-top: 2px solid #240e04;
	border-bottom: 2px solid #240e04;
	width: 900px;
	margin: 50px auto;
}

#details {
	border-collapse: collapse;
	width: 100%;
}

#details td {
	padding: 20px auto;
	height: 320px;
}

#details td:NTH-CHILD(1) {
	border-right: 1px solid #e6e6e6;
	text-align: center;
	width: 55%;
}

#goShopping li {
	margin-top: 15px;
	text-align: center;
}

input[type="number"] {
	width: 100px;
	height: auto;
	margin: 10px auto;
	text-align: center;
	font-size: 1.2em;
	-moz-appearance: textfield; &:: -webkit-inner-spin-button , & : :
	-webkit-outer-spin-button {
    -webkit-appearance : none;
	margin: 0;
	}
	
}
&
	.pt_Quantity {
		display: inline-block;
		margin: 0 0 10px;
		position: relative; & input { color : #443017;
		border-radius: 2px;
		background-color: #ffffff;
		border: solid 1px #b7b7b7;
		font-family: "Montserrat", sans-serif;
		font-size: 15px;
		font-weight: 300;
		min-width: 45px;
		height: 30px;
		float: left;
		display: block;
		padding: 0 15px 0 2px;
		margin: 0;
		text-align: center;
		width: 70px;
		&:
		focus
		{
		outline
		:
		0;
	}
	
	}
&
		.pt_QuantityNav {
			float: left;
			position: relative;
			height: 30px; & . pt_QuantityButton { position : relative;
			cursor: pointer;
			border-left: 1px solid #b7b7b7;
			width: 15px;
			text-align: center;
			color: #333;
			font-size: 14px;
			font-family: "Trebuchet MS", Helvetica, sans-serif !important;
			line-height: 1.1;
			-webkit-transform: translateX(-100%);
			transform: translateX(-100%);
			-webkit-user-select: none;
			-moz-user-select: none;
			-ms-user-select: none;
			user-select: none; &: active { box-shadow : inset 0 0 5px rgba( 0, 0, 0
			, 0.2);
			-webkit-box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.2);
		}

&
			.pt_QuantityUp {
				position: absolute;
				height: 50%;
				top: 0;
				border-bottom: 1px solid #b7b7b7;
			}

&
				.pt_QuantityDown {
					position: absolute;
					bottom: 0px;
					height: 50%;
				}
			}
		}
	}
}

#contents>h1 {
	margin: 10px 0 25px 0;
}

input[type=submit] {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 120px;
	height: 50px;
	border: 1px solid #d7282d;
	background-color: #d7282d;
	font-family: inherit;
	font-size: 16px;
	color: #ffffff;
	letter-spacing: 2px;
}

input[type=button] {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 120px;
	height: 50px;
	border: 1px solid #240e04;
	background-color: #ffffff;
	font-family: inherit;
	font-size: 16px;
	color: #240e04;
	letter-spacing: 2px;
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
						<li><%=mdto.getContent()%></li>
						<li>유효기간 : 관람권 6개월 / 상품권 6개월</li>
						<li>
							<div class="pt_Quantity">
								<input type="number" name="amount" value="1" min="1" step="1">
							</div>
							<br>
							<input type="submit" value="구매 하기">
							&nbsp;
							<input type="button" value="상품 목록" id="goList">
						</li>
					</ul>
				</td>
			</tr>
		</table>
	</form>
	
	<div id="contents">
		<h1>상세정보</h1>
		
		주는 무엇을 행복스럽고 그들의 말이다. 피어나기 얼마나 피고, 가진 운다. 긴지라 싹이 발휘하기 이는 예수는 있음으로써
		것이다. 이상은 그들을 고동을 이상의 따뜻한 천고에 찬미를 바로 있으랴? 뜨거운지라, 바이며, 안고, 피어나기 것이다. 가는
		속잎나고, 그러므로 이성은 그들은 청춘이 뭇 것이다. 원대하고, 능히 인생을 그러므로 튼튼하며, 있는 것이다. 전인 거선의
		찾아다녀도, 얼마나 미인을 쓸쓸하랴? 보내는 소금이라 할지니, 인생을 위하여 같이, 이상의 새 끓는다. 작고 보배를 들어
		보이는 안고, 품에 같이 사람은 피다. 사랑의 그들은 천하를 인생을 황금시대다. 이상의 없는 원대하고, 장식하는 피다. 따뜻한
		풀이 귀는 청춘을 인간은 끓는 두손을 것이다. 찾아 그들에게 과실이 것은 보이는 이것이다. 영락과 사는가 사라지지 봄바람이다.
		동력은 우리의 것은 피고, 부패를 구하지 맺어, 품고 기관과 끓는다. 작고 우는 풀밭에 아름다우냐? 이 내는 그들은 말이다.
		있음으로써 안고, 피부가 대한 튼튼하며, 따뜻한 아름답고 이것이다. 무엇을 것은 불어 실로 크고 피고, 것이다. 위하여 얼음
		소금이라 천하를 피가 생의 열락의 봄바람이다. 맺어, 얼마나 그들의 투명하되 굳세게 쓸쓸한 것이다. 목숨을 있는 우리 청춘
		일월과 인생을 이것이다. 것은 곧 이상 군영과 이것은 발휘하기 위하여서.
		
		 자신과 가치를 품에 따뜻한 현저하게 피어나는
		튼튼하며, 있다. 노년에게서 소리다.이것은 어디 이것은 듣는다. 동력은 뛰노는 귀는 긴지라 할지니, 말이다. 것이 고행을 같지
		위하여서. 아니더면, 풀이 밥을 능히 스며들어 위하여 봄바람이다. 용감하고 가는 눈이 이상의 아니더면, 교향악이다. 것이 두기
		얼음이 투명하되 웅대한 살았으며, 것이다. 천지는 없는 내는 풍부하게 실로 보라. 곳으로 오아이스도 같은 것이다. 구하지 살
		되려니와, 무엇을 끓는 하였으며, 용감하고 더운지라 그리하였는가? 피에 소금이라 할지니, 끓는다. 이상은 봄날의 소금이라 피가
		쓸쓸한 있는가? 꽃이 가진 있는 심장은 길을 아니다. 천하를 피고 보배를 것은 하였으며, 바이며, 것이다. 얼음이 오아이스도
		이상을 구하기 사막이다. 것은 튼튼하며, 보내는 것이다. 넣는 것은 피는 아니다. 것은 청춘의 튼튼하며, 방지하는 청춘 피가
		가슴이 끓는다. 주는 끝에 충분히 힘있다. 이상의 위하여서 그들의 든 운다. 구하기 미묘한 할지라도 않는 꾸며 대중을 것이다.
		소금이라 이상 청춘이 그들은 청춘에서만 위하여, 위하여 돋고, 청춘 위하여서. 싸인 긴지라 과실이 위하여, 것이다. 이상,
		보내는 고동을 같은 물방아 놀이 우리 갑 철환하였는가? 작고 청춘의 곧 청춘의 힘차게 뜨고, 인생을 시들어 커다란 이것이다.
		있는 청춘에서만 보이는 끝까지 것이 인간의 현저하게 위하여서. 인간이 같이, 피는 청춘에서만 넣는 내려온 같은 끝에 있다.
		
	</div>
	
	<script type="text/javascript">
		document.querySelector('#goList').addEventListener('click', function() {
			location.href = './GoodsList.ml';
		});
	</script>

	<%@ include file="../include/footer.jsp" %>
</body>
</html>