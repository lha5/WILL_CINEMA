<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 회원 가입</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</head>
<body>
	<fieldset>
		<legend>회원 가입</legend>
		<form action="./MemberJoinAction.me" method="post">
			<table border="1">
				<tr>
					<td>*아이디</td>
					<td><input type="text" name="id"></td>
				</tr>
				<tr>
					<td>*비밀번호</td>
					<td><input type="password" name="pass"></td>
				</tr>
				<tr>
					<td>*비밀번호 재입력</td>
					<td><input type="password" name="pass2"></td>
				</tr>
				<tr>
					<td>*성명</td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>*생년월일</td>
					<td></td>
				</tr>
				<tr>
					<td>*전화번호</td>
					<td><input type="text" name="mobile"></td>
				</tr>
				<tr>
					<td>*이메일</td>
					<td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td>
						주소<br>
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
					</td>
					<td>
						<input type="text" id="sample6_postcode" name="zipcode" placeholder="우편번호"><br>
						<input type="text" id="sample6_address" name="addr" placeholder="주소"><br>
						<input type="text" id="sample6_detailAddress" name="detailaddr" placeholder="상세주소">
					</td>
				</tr>
				<tr>
					<td>
						*이벤트 안내 수신 체크
						<br>
						(예매 내역에 관련된 안내는<br>
						수신 여부에 상관없이 발송됩니다.)
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
						<input type="button" value="뒤로 가기">
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
</body>
</html>