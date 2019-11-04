<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA</title>

<!-- CSS -->
<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/ticketing.css">

<!-- Remix Icon -->
<link href="https://cdn.remixicon.com/releases/v2.0.0/remixicon.css" rel="stylesheet">
<script type="text/javascript">
        function showHide(id) {
            var obj = document.getElementById(id);
            if (obj.style.display == 'none')
                obj.style.display = 'block';
            else
                obj.style.display = 'none';
        }
</script>
</head>
<body>

	<%
	String id = (String) session.getAttribute("id");
	%>



	<header>
		<div id="top_line">
		<div id="social">
			<ul>
				<li><i class="ri-smartphone-line"></i> 모바일 APP</li>
				<li><i class="ri-facebook-box-fill"></i> 페이스북</li>
				<li><i class="ri-youtube-fill"></i> 유튜브</li>
			</ul>
		</div>
		
		<div id="my">
			<ul>
				<%if (id != null) {%>
				<li><a href="./MemberLogout.me">로그아웃</a></li>
				<%} else {%>
				<li><a href="./MemberLogin.me">로그인</a></li>
				<%}%>
				<%if (id != null) {%>
				<li><a href="./Main.me">마이시네마</a></li>
				<%} else {%>
				<li><a href="./MemberJoin.me">회원가입</a></li>
				<%}%>
				<li>멤버십</li>
				<li id="forcustomer"><a href="./FAQList.af">고객센터</a>
					<ul id="dropdown">
						<li><a href="./FAQList.af">FAQ</a></li>
						<li><a href="./QnAList.sq">1:1 문의</a></li>
						<li><a href="./NoticeList.an">공지사항</a></li>
					</ul>
				</li>
				<li>ENGLISH</li>
			</ul>
		</div>
		</div>
		<div class="top_space"><!-- 구역 분리를 위한 태그 --></div>
		
		<div id="logo">
			<a href="Index.me" class="link-home"><i class="ri-film-line ri-lg"></i> <span>WILL CINEMA</span></a>
		</div>
		
		
		
		<nav>
			<ul>
				<li><a href="Ticketing.ti">예매</a>
					<ul>
						<li><a href="Ticketing.ti">예매하기</a></li>
						<li>상영시간표</li>
						<li>할인안내</li>
					</ul>
				</li>
				<li>영화
					<ul>
						<li>박스오피스</li>
						<li>기획전</li>
						<li>영화의전당</li>
					</ul>
				</li>



				<li><a href=javascript:;>영화관</a>
						
					<ul >
						<li><a onclick="showHide('cinema100')" onfocus="this.blur()" title="서울">서울</a>
						<div id=cinema100 style="display:none">
						<ul >
						<li><a href="./CinemaUserView.ci?cinema_num=1001">영등포 </a>
						<a href="./CinemaUserView.ci?cinema_num=1002">가산디지털</a></li>
						</ul></div></li>
						
						<li><a onclick="showHide('cinema200')" onfocus="this.blur()" title="경기/인천">경기/인천</a>
						<div id=cinema200 style="display:none">
						<ul >
						<li><a href="./CinemaUserView.ci?cinema_num=2001">안산 </a>
						<a href="./CinemaUserView.ci?cinema_num=2002">부천역</a></li>
						</ul></div></li>
						
						<li><a onclick="showHide('cinema300')" onfocus="this.blur()" title="충청/대전">충청/대전</a>
						<div id=cinema300 style="display:none">
						<ul >
						<li><a href="./CinemaUserView.ci?cinema_num=3001">서산</a>
						<a href="./CinemaUserView.ci?cinema_num=3002">대전(백화점)</a></li>
						</ul></div></li>
						
						<li><a onclick="showHide('cinema400')" onfocus="this.blur()" title="전라/광주">전라/광주</a>
						<div id=cinema400 style="display:none">
						<ul>
						<li><a href="./CinemaUserView.ci?cinema_num=4001">수완(아울렛)</a>
						<a href="./CinemaUserView.ci?cinema_num=4002">광주(백화점)</a></li>
						</ul></div></li>
						
						<li><a onclick="showHide('cinema500')" onfocus="this.blur()" title="경북/대구">경북/대구</a>
						<div id=cinema500 style="display:none">
						<ul>
						<li><a href="./CinemaUserView.ci?cinema_num=5001">경주</a>
						<a href="./CinemaUserView.ci?cinema_num=5002">포항</a></li>
						</ul></div></li>
						
						<li><a onclick="showHide('cinema600')" onfocus="this.blur()" title="경남/부산/울산">경남/부산/울산</a>
						<div id=cinema600 style="display:none">
						<ul >
						<li><a href="./CinemaUserView.ci?cinema_num=6001">서면(전포동)</a>
						<a href="./CinemaUserView.ci?cinema_num=6002">창원</a></li>
						</ul></div></li>
						<li>강원(오픈준비중)</li>
						<li>제주(오픈준비중)</li>
					
					</ul>
					</li>
				<li>
					<a href="./EventSummary.ae">이벤트</a>
					<ul>
						<li><a href="./EventContent.ae?item=movie">영화</a></li>
						<li><a href="./EventContent.ae?item=preview">시사회/무대인사</a></li>
						<li><a href="./EventContent.ae?item=nevent">윌시NOW</a></li>
						<li><a href="./EventContent.ae?item=collabo">제휴할인</a></li>
					</ul>
				</li>
				<li>
					<a href="./GoodsList.ml">매점</a>
					<ul>
						<li><a href="./GoodsList.ml">전체</a></li>
						<li><a href="./GoodsList.ml?item=ticket">관람권</a></li>
						<li><a href="./GoodsList.ml?item=snack">스낵/음료</a></li>
					</ul>
				</li>
				<li>VOD</li>
			</ul>
			<div id="sub_ul">
				
			</div>			
		</nav>
	</header>
	
</body>
</html>