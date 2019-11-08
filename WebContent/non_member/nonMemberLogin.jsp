<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 비회원 정보 조회</title>

<!-- CSS -->
<style type="text/css">
#inin {
	letter-spacing: 2px;
	color: #240e04;
	font-family: NanumGothic;
	font-size: 2em;
}

fieldset {
	border-style: none;
	width: 500px;
	margin: 50px auto;
	text-align: center;
}

table {
	border-collapse: collapse;
	border-top: 2px solid #240e04;
	border-bottom: 2px solid #240e04;
	margin: 50px auto 25px auto;
	width: 400px;
	height: 310px;
	color: #240e04;
}

tr:NTH-CHILD(1)>td:NTH-CHILD(1), tr:NTH-CHILD(2)>td:NTH-CHILD(1)
	{
	font-size: 16px;
	text-align: left;
	padding-left: 25px;
}

td {
	position: relative;
}

input[type=text], input[type=password] {
	width: 240px;
	height: auto;
	line-height: normal;
	padding: .8em .5em;
	font-family: inherit;
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border: 1px solid #240e04;
	/* border-radius: 2px; */
	/* background-color: #ffefa3; */
	color: #240e04;
	font-size: 16px;
}

input[type=submit] {
	width: 150px;
	height: 55px;
	outline-style: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border: 1px solid #d7282d;
	background-color: #d7282d;
	font-family: inherit;
	font-size: 19px;
	color: #ffffff;
	letter-spacing: 2px;
}
</style>

</head>
<body>

	<div id="wrap">

	<%@ include file="../include/header.jsp" %>

	<fieldset>
		<span id="inin">비회원 로그인</span>
		<form method="post" action="././NonMemberLoginAction.me">
			<table>
				<tr>
					<td>성함</td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input type="text" name="birth"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="비회원 로그인">
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
	<%@ include file="../include/footer.jsp" %>
	
	</div>

</body>
</html>