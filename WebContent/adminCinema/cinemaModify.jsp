<%@page import="com.cinema.db.CineDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - (관리자 전용 - 영화관 수정)</title>
</head>
<body>
<%

	//request 정보 저장
	CineDTO cdto = (CineDTO)request.getAttribute("cdto");

	String region = cdto.getRegion();
	int regionCode = 0;
	
	//지역 명칭을 코드로 변환
	//지역 분류
	//1-서울, 2-경기/인천, 3-충청/대전, 4-전라/광주, 5-경북/대구
	//6-경남/부산/울산, 7-강원, 8-제주
	if(region.equals("경기/인천")){regionCode=2;}
	else if(region.equals("충청/대전")){regionCode=3;}
	else if(region.equals("전라/광주")){regionCode=4;}
	else if(region.equals("경북/대구")){regionCode=5;}
	else if(region.equals("경남/부산/울산")){regionCode=6;}
	else if(region.equals("강원")){regionCode=7;}
	else if(region.equals("제주")){regionCode=8;}
	else{regionCode=1;}

%>

<form action="./CinemaModifyAction.ci" method="post" enctype="multipart/form-data">
	<input type="hidden" name="location_num" value="<%=cdto.getLocation_num()%>">
	<input type="hidden" name="prev_image" value="<%=cdto.getImage()%>">
		<table border="1">
			<tr>
				<td>지역</td>
				<td>
		<!-- //1-서울, 2-경기/인천, 3-충청/대전, 4-전라/광주, 5-경북/대구, 6-경남/부산/울산, 7-강원, 8-제주 -->
					<select name="region">
					 <option value="1" <%if(regionCode==1){%>selected<%} %>>
					  서울</option>
					 <option value="2" <%if(regionCode==2){%>selected<%} %>>
					  경기/인천</option>
					 <option value="3" <%if(regionCode==3){%>selected<%} %>>
					  충청/대전</option>
					 <option value="4" <%if(regionCode==4){%>selected<%} %>>
					  전라/광주</option>
					 <option value="5" <%if(regionCode==5){%>selected<%} %>>
					  경북/대구</option>
					 <option value="6" <%if(regionCode==6){%>selected<%} %>>
					  경남/부산/울산</option>
					 <option value="7" <%if(regionCode==7){%>selected<%} %>> 
					  강원</option>
					 <option value="8" <%if(regionCode==8){%>selected<%} %>>
					  제주</option>
					</select>
				</td>
				<td>지점명</td>
				<td><input type="text" name="name" value="<%=cdto.getName()%>"></td>
			</tr>
			<tr>
				<td>주소</td> <!-- 다음 API ? -->
				<td><input type="text" name="addr" value="<%=cdto.getAddr()%>"></td>
				<td>전화번호</td>
				<td><input type="text" name="tel" value="<%=cdto.getTel()%>"></td>
			</tr>
			<tr>
				<td>상영관 수</td>
				<td><input type="text" name="room" value="<%=cdto.getRoom() %>"></td>
				<td>사진</td>
				<td><input type="file" name="image"></td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="submit" value="지점 수정 하기">
					<input type="button" value="뒤로" onclick="history.back();">
				</td>
			</tr>
		</table>	
	</form>
</body>
</html>