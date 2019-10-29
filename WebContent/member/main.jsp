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

<!-- CSS 연결 -->
<link rel="stylesheet" href="./css/mypage.css">

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
	// String id = (String) session.getAttribute("id");
	List info = (List) session.getAttribute("info");
	// info.get(0) : 이름
	// info.get(1) : 등급
	// info.get(2) : 잔여 포인트

	if (id == null) {
		response.sendRedirect("./MemberLogin.me");
	}
	
	// 포인트
	int point = (int) info.get(2);
	
	// 회원 등급 처리
	String level = "";
	
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
	%>
	
	
	
	<section id="sec01">
		<table>
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
					<h3>W.POINT</h3>
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
						<li>남은 W.POINT가 100P 이상이면 즉시 사용할 수 있습니다.</li>
						<li>본인 카드에 한하여 등록 및 포인트 조회가 가능합니다.</li>
					</ul>
				</td>
				<td>
					<div id="ranking">
						<h2><%=info.get(0)%>님의<br>현재 등급은 <%=level%>입니다.</h2>
					</div>
				</td>
			</tr>
		</table>
	</section>
	
	
	
	<!-- 각 메뉴를 클릭하면 페이지가 달라지게 Ajax로 구현하기 -->
	<section id="sec02">
		<div id="my_menu">
			<ul>
				<li><a href="#">예매내역</a></li>
				<li><input type="button" value="매점 구매 내역" id="myMallOrderList"></li>
				<li><a href="#">멤버십</a></li>
				<li><a href="#">내가 본 영화</a></li>
				<li><input type="button" value="내 정보 관리" id="myInfoManagement"></li>
			</ul>
		</div>
		
		<div id="contents">
			
		</div>
		
	</section>
	
	<!-- 버튼을 클릭하면 아래에 페이지가 로드되게 하는 코드 -->
	<script type="text/javascript">
		
		// 구매 내역
		document.querySelector('#myMallOrderList').addEventListener('click', function() {
			acyncMovePage('./MallOrderList.mor');
		});
		
		// 내 정보 관리
		document.querySelector('#myInfoManagement').addEventListener('click', function() {
			acyncMovePage('./MyPage.me');
		});
	</script>

	<%@ include file="../include/footer.jsp" %>
	
	</div>
	
</body>
</html>