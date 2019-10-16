<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 회원 가입</title>

<!-- jQuery -->
<script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>

<!-- 우편번호 찾기 API -->
<script>
	$(function() { $("#postcodify_search_button").postcodifyPopUp(); });
</script>

<!-- date picker -->
<script type="text/javascript">
	$('.input-group.date').datepicker({format: "yyyy.mm.dd"}); 
</script>

<!-- 뒤로 가기 버튼 및 가입 오류 방지 -->
<script type="text/javascript">
	// 취소 버튼 클릭 시 메인 페이지로 이동
	function goMain() {
		var rslt = confirm("정말로 이 페이지를 나가시겠습니까?");
		if (rslt) {
			location.href="./Main.me";
		} else {
			return false;
		}
	}


	// 가입 오류 방지
	function checkValue() {
		var form = document.upForm;
		
		if (!form.id.value) {
			alert("아이디를 입력하세요.");
			document.upForm.id.focus();
			return false;
		}
		if ((form.id.value < "0" || form.id.value > "9") && (form.id.value < "A" || form.id.value > "Z") && (form.id.value < "a" || form.id.value > "z")) {
			alert("아이디는 영문자 및 숫자만 사용 가능합니다.");
			document.form.id.focus();
			return false;
		}
		if (!form.pass.value) {
			alert("비밀번호를 입력하세요.");
			document.upForm.pass.focus();
			return false;
		}
		if (form.pass.value != form.pass2.value) {
			alert("동일한 비밀번호를 입력하세요.");
			document.upForm.pass2.focus();
			return false;
		}
		if (!form.birthday.value) {
			alert("생년월일을 입력하세요.");
			document.upForm.nickname.focus();
			return false;
		}
		if (!form.email.value) {
			alert("이메일을 입력하세요.");
			document.upForm.email.focus();
			return false;
		}
		if (!form.mobile.value) {
			alert("전화번호를 입력하세요.");
			document.upForm.email.focus();
			return false;
		}
		if (!form.addr.value) {
			alert("주소를 입력하세요.");
			document.upForm.email.focus();
			return false;
		}
		if (!form.receive.value) {
			alert("이벤트 안내 메일 수신 여부를 체크해주세요.");
			document.upForm.email.focus();
			return false;
		}
	}
</script>
</head>
<body>

	<%@ include file="../include/header.jsp" %>

	<fieldset>
		<legend>회원 가입</legend>
		<form action="./MemberJoinAction.me" method="post" name="upForm" onsubmit="return checkValue();">
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
					<td>
						<div class="input-group date" data-date-format="yyyy.mm.dd">
							<input type="text" class="form-control" placeholder="예) 2019.01.01" name="birthday">
							<div class="input-group-addon">
								<span class="glyphicon glyphicon-th"></span>
							</div>
						</div>
					</td>
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
					<td>
						주소<br>
						<button id="postcodify_search_button">주소 찾기</button>
					</td>
					<td>
						<input type="text" name="zipcode" class="postcodify_postcode5" value="" /><br>
						<input type="text" name="addr" class="postcodify_address" value="" /><br>
						<input type="text" name="detailaddr" class="postcodify_details" value="" /><br>
						<input type="text" name="refaddr" class="postcodify_extra_info" value="" />
					</td>
				</tr>
				<tr>
					<td>
						이벤트 안내 수신 체크
						<br>
						(예매 내역에 관련된 안내는 수신 여부에 상관없이 발송됩니다.)
					</td>
					<td>
						<input type="radio" name="receive" value="yes"> 예
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="receive" value="no"> 아니오
					</td>
				</tr>
				<tr>
					<td>선호하는 영화 장르</td>
					<td>
						<select name="preference">
							<option selected disabled>선택하세요</option>
							<option value="액션">액션</option>
							<option value="SF">SF</option>
							<option value="판타지">판타지</option>
							<option value="드라마">드라마</option>
							<option value="스릴러">스릴러</option>
							<option value="호러">호러</option>
							<option value="애니메이션">애니메이션</option>
							<option value="기타">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="가입 하기">
						&nbsp;&nbsp;
						<input type="button" value="뒤로 가기" onclick="goMain();">
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
	
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>