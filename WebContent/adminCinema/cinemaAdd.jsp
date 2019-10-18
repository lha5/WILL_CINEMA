<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - (관리자 전용 - 영화관 등록)</title>
</head>
<body>
	<form action="./CinemaAddAction.ci" method="post" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>지역</td>
				<td>
					<select name="region">
					 <option value="1">서울</option>
					 <option value="2">경기/인천</option>
					 <option value="3">충청/대전</option>
					 <option value="4">전라/광주</option>
					 <option value="5">경북/대구</option>
					 <option value="6">경남/부산/울산</option>
					 <option value="7">강원</option>
					 <option value="8">제주</option>
					</select>
				</td>
				<td>지점명</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>주소</td> <!-- 다음 API ? -->
				<td><input type="text" name="addr"></td>
				<td>전화번호</td>
				<td><input type="text" name="tel"></td>
			</tr>
			<tr>
				<td>상영관 수</td>
				<td><input type="text" name="room"></td>
				<td>좌석 수</td>
				<td><input type="text" name="count_seat"></td>
			</tr>
			<tr>
				<td>사진</td>
				<td colspan="3"><input type="file" name="image"></td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="submit" value="지점 등록 하기">
				</td>
			</tr>
		</table>	
	</form>
</body>
</html>