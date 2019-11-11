<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="com.member.db.MemberDAOImpl"%>
<%@page import="com.member.db.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 마이 페이지</title>

<!-- jQuery 연결 -->
<script src="./js/jquery-3.4.1.min.js"></script>

<!-- CSS -->
<style type="text/css">
section {
	width: 800px;
	margin: 10px auto;
}

#mypage {
	border-collapse: collapse;
	border: 1px solid #1c1c1c;
	width: 700px;
	margin: 50px auto;
}

td {
	border: 1px solid black;
	height: 45px;
	padding: 5px 10px;
}

tr:NTH-CHILD(1)>td {
	background-color: #1c1c1c;
	color: #ffffff;
	text-align: center;
}

#mypage>tr:NTH-CHILD(3)>td {
	height: 150px;
}

#mypage>tr:NTH-CHILD(1)>td:NTH-CHILD(1) {
	text-align: center;
	font-size: 1.5em;
	font-weight: bold;
	height: 45px;
	letter-spacing: 5px;
}

#mypage>tr:NTH-CHILD(3)>td:NTH-CHILD(1) {
	width: 60%;
}

#sec02 ul {
	/* border: 1px solid pink; */
	width: 700px;
	height: 60px;
	margin: 50px auto;
	padding: 15px 0 10px 20px;
}

#sec02 ul>li {
	/* border: 1px solid skyblue; */
	display: inline-block;
	margin: 5px 2px 5px 5px;
}
#sec02 ul>li>input[type=button] {
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 120px;
	height: 45px;
	border: 1px solid #240e04;
	background-color: #ffffff;
	font-family: inherit;
	font-size: 14px;
	color: #240e04;
	letter-spacing: 2px;
	margin-right: 5px;
}

#sec02>#contents {
	width: 700px;
	margin: 20px auto;
	text-align: center;
}

#point_info {
	margin-top: 20px;
	line-height: 2em;
	font-size: 14px;
	color: #1c1c1c;
}

#left_point {
	margin-bottom: 5px;
}

#ranking {
	text-align: center;
}
</style>

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
        // Contents 영역 삭제
        $('#contents').children().remove();
        // Contents 영역 교체
        $('#contents').html(data);
    });
}
</script>

</head>
<body>

	<div id="wrap">

	<%@ include file="../include/header.jsp" %>

	<%
	// 네이버 로그인 체크용 
	String SnSLogin = (String) session.getAttribute("SnSLogin");
	
	System.out.println(" info : "+session.getAttribute("info"));
	List info = (List) session.getAttribute("info");
	// info.get(0) : 이름
	// info.get(1) : 등급
	// info.get(2) : 잔여 포인트

	if (id == null) {
		response.sendRedirect("./MemberLogin.me");
	}
	
	// 회원 등급 처리
	String level = "";
	
	if(!info.get(0).equals("")){
	
		switch (String.valueOf(info.get(1))) {
			case "0":
				level = "관리자";
	   		break;
			case "1":
				level = "VVIP";
	   		break;
			case "2":
				level = "VIP";
	   		break;
			case "3":
				level = "우수";
	   		break;
			case "4":
				level = "일반";
	   		break;
			case "5":
				level = "신규";
			break;
			default :
				level = "신규";
	   		break;
		}
	
	}
	%>
	
	<%
	if(!info.get(0).equals("")){
		// 포인트
	    int point = (int) info.get(2);	
	%>
	
	<section id="sec01">
		<table id="mypage">
			<tr>
				<td colspan="2">마이시네마</td>
			</tr>
			<tr>
				<td colspan="2">
					<%=info.get(0)%>님, 환영합니다!
				</td>
			</tr>
			<tr>
				<td>
					<h3>W.POINT</h3><br>
					<div id="left_point">잔여 포인트 : <%=point%></div>
					<div id="availability">
						<%
						if (point >= 100) {
						%>
							사용 가능합니다.
						<%
						} else {
						%>
							사용 가능한 포인트량이 부족합니다.
						<%
						}
						%>
					</div>
					<ul id="point_info">
						<li>※ 본인 카드에 한하여 등록 및 포인트 조회가 가능합니다.</li>
						<li>※ 남은 W.POINT가 100P 이상이면 즉시 사용할 수 있습니다.</li>
					</ul>
				</td>
				<td>
					<div id="ranking">
						<%=info.get(0)%>님의 현재 등급은<br><%=level%>입니다.
					</div>
				</td>
			</tr>
		</table>
	</section>
	
	<%
	}
	%>
	
	<!-- 각 메뉴를 클릭하면 페이지가 달라지게 Ajax로 구현하기 -->
	<section id="sec02">
		<div id="my_menu">
			<ul>
				<li><input type="button" value="예매내역" id="bookingList"></li>
				<li><input type="button" value="매점 구매 내역" id="myMallOrderList"></li>
				<li><input type="button" value="멤버십" id="myMembership"></li>
				<li><input type="button" value="내 문의·질문" id="myQnA"></li>
				<li><input type="button" value="내 정보 관리" id="myInfoManagement">
					<input type="hidden" name="SnSLoginId_check" value="<%=SnSLogin %>">
				</li>
			</ul>
		</div>
		
		<div id="contents">
			
		</div>
		
	</section>
	
	<!-- 버튼을 클릭하면 아래에 페이지가 로드되게 하는 코드 -->
	<script type="text/javascript">
		// 예매 내역
		document.querySelector('#bookingList').addEventListener('click', function() {
			acyncMovePage('./TicketingList.ti');
		});
	
		// 구매 내역
		document.querySelector('#myMallOrderList').addEventListener('click', function() {
			acyncMovePage('./MallOrderList.mor');
		});
		
		// 멤버십
		document.querySelector('#myMembership').addEventListener('click', function() {
			acyncMovePage('./Membership.me');
		});
		
		// 내가 본 영화(준비중)
		document.querySelector('#myQnA').addEventListener('click', function() {
			location.href = './QnAUserList.sq';
		});
		
		var SnSLoginId_check = $('input[name=SnSLoginId_check]').val();
		// 내 정보 관리
		document.querySelector('#myInfoManagement').addEventListener('click', function() {
			
			if(SnSLoginId_check == 'SnSLogin'){
				alert("네이버 아이디 로그인 회원은 접근이 불가합니다.");
			}else{
				acyncMovePage('./MyPage.me');
			}
			
		});
	</script>

	<%@ include file="../include/footer.jsp" %>
	
	</div>
	
</body>
</html>