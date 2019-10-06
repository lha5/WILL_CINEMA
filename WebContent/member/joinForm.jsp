<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 회원 가입</title>
</head>
<body>
	<fieldset>
		<legend>회원 가입</legend>
		<form action="./MemberJoinAction.me" method="post">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pass"></td>
				</tr>
				<tr>
					<td>비밀번호 재입력</td>
					<td><input type="password" name="pass2"></td>
				</tr>
				<tr>
					<td>성명</td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="mobile"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td></td>
				</tr>
				<tr>
					<td>
						이벤트 안내 수신 체크
						<br>
						* 예매 내역에 관련된 안내는<br>
						수신 여부에 상관없이 발송됩니다.
					</td>
					<td>
						<input type="radio" name="receive" value="yes"> 예
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="receive" value="no"> 아니오
					</td>
				</tr>
				<tr>
					<td>선호하는 영화 장르</td>
					<td>
						
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="가입 하기">
						&nbsp;&nbsp;
						<input type="button" value="뒤로 가기">
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
</body>
</html>