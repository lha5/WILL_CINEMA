<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WILL CINEMA - 회원 가입</title>

<!-- jQuery -->
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" href="./css/signup.css">

<!-- 우편번호 찾기 API -->
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

<!-- date picker -->
<script type="text/javascript">
	$('.input-group.date').datepicker({format: "yyyy.mm.dd"}); 
</script>

<!-- 뒤로 가기 버튼 -->
<script type="text/javascript">
	// 취소 버튼 클릭 시 메인 페이지로 이동
	function goMain() {
		var rslt = confirm("정말로 이 페이지를 나가시겠습니까?");
		if (rslt) {
			history.back();
		} else {
			return false;
		}
	}
	 function idchk(){
	        
	        if(document.upForm.id.value == ""){
	        	alert("ID를 입력하세요!");
	        	document.upForm.id.focus();
	        	return;
	        }
	        
	        var idck = document.upForm.id.value;
	        
	        window.open("./member/joinIdCheck.jsp?userid="+idck,"","width=600,height=200");
	        
	        
	    }
	
	
</script>



</head>
<body>

	<%@ include file="../include/header.jsp" %>

	<fieldset>
		<legend>회원 가입</legend>
		<form action="./MemberJoinAction.me" method="post" name="upForm" onsubmit="return willjoin6();">
			<table>
				<tr>
					<td>
						아이디
						&nbsp;
						<input type="button" value="중복 체크" class="dupCheck" onclick="idchk();" >
					</td>
					<td><input type="text" name="id" placeholder="2글자이상"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pass" class="pass" placeholder="4글자이상" ></td>
				</tr>
				<tr>
					<td>비밀번호 재입력</td>
					<td><input type="password" name="pass2" class="pass2" placeholder="비밀번호 확인"></td>
				</tr>
				<tr>
					<td>성명</td>
					<td><input type="text" name="name" class="name" placeholder="2글자이상"></td>
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
					<td><input type="text" name="mobile" placeholder="010-0000-0000" ></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email" placeholder="example@example.com"></td>
				</tr>
				<tr>
					<td>
						주소&nbsp;&nbsp;<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
					</td>
					<td>
						<input type="text" id="sample6_postcode" name="zipcode" placeholder="우편번호"><br>
						<input type="text" id="sample6_address" name="addr" placeholder="주소"><br>
						<input type="text" id="sample6_detailAddress" name="detailaddr" placeholder="상세주소"><br>
						<input type="text" id="sample6_extraAddress" name="refaddr" placeholder="참고항목">
					</td>
				</tr>
				<tr>
					<td>
						이벤트 안내 수신 체크
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
						<input type="button" value="뒤로 가기" id="main" onclick="goMain();">
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
	

	<!-- 가입 유효성 방지 -->
	<script type="text/javascript">
	function willjoin6(){
    	if(document.upForm.id.value.length<=2){
			  alert("아이디를 입력하시오");
			  document.upForm.id.focus();
			  return false;}
    
    	if( document.upForm.pass.value==""){
			  alert("비밀번호를 입력하시오");
			  document.upForm.pass.focus();
			  return false;}
		  //비밀번호
		  if( document.upForm.pass.value != document.upForm.pass2.value){
			  alert("비밀번호가 다릅니다. 다시 입력하시오");
			  document.upForm.pass2.focus();
			  return false;}
		//이름
		  if( document.upForm.name.value==""){
			  alert("이름을 입력하시오");
			  document.upForm.name.focus();
			  return false;}
		  //생년월일
		  if( document.upForm.birthday.value.length<=2 || document.upForm.email.value.indexOf('.',0) == -1){
			  alert("생년월일을 입력하시오");
			  document.upForm.birthday.focus();
			  return false;}
		  //전화번호 
		  if( document.upForm.mobile.value==""){
			  alert("전화번호를 입력하시오");
			  document.upForm.mobile.focus();
			  return false; }
		  //이메일
		  if(document.upForm.email.value.length <=4 || document.upForm.email.value.indexOf('@',0) == -1 ||
				  document.upForm.email.value.indexOf('.',0) == -1){
				  alert("EX)itwill@co.kr"); return false;}
		  //주소
		  if( document.upForm.zipcode.value==""){
			  alert("주소를 입력하시오");
			  document.upForm.zipcode.focus();
			  return false;}	
		  // 수신
		  if(document.upForm.receive[0].checked==false&&
			document.upForm.receive[1].checked==false){
			  alert("수신여부 체크");
				return false;}
		  //선호영화
		  if(document.upForm.preference.value == '선택하세요'){
		  alert('선호하는 영화를 선택해주세요');
		 return false; }
		 } 
		
		
		
		
		/* 	const MIN_USER_ID_LENGTH = 4;
		var inputId = document.querySelector('.id');
	
		function checkUserId(n) {
			if (inputId.value.length < n) {
				alert('아이디는 4자 이상 입력해주세요.');
			}
		
			if ((inputId.value < '0' || inputId.value > '9') && (inputId.value < 'A' || inputId.value > 'Z') && (inputId.value < 'a' || inputId.value > 'z')) {
				alert('아이디는 영문자 및 숫자만 가능합니다');
			}
		}
		
		
		inputId.addEventListener('blur', function () {
			// 이벤트 핸들러 내부에서 함수를 호출하면서 인수를 전달한다.
			checkUserId(MIN_USER_ID_LENGTH);
		});
		
		
		
		// 비밀번호 입력 오류 체크 -------------------------------
		var inputPass = document.querySelector('.pass');
		var inputPass2 = document.querySelector('.pass2');
		function checkUserPW(n) {
			if (inputPass.value.length < n) {
				alert('비밀번호는 4자 이상 입력해주세요.');
			}
		}
		
		inputPass.addEventListener('blur', function () {
			 checkUserPW(MIN_USER_ID_LENGTH);
		});
		
		inputPass2.addEventListener('blur', function() {
			if (!(inputPass.value == inputPass2.value)) {
				alert('동일한 비밀번호를 입력해주세요.');
			}
		});
		
		
		
		// 이름 미입력 오류 체크 ----------------------------------
		const MIN_NAME_LENGTH = 2;
		var inputName = document.querySelector('.name');
		function checkUserName(n) {
			if (inputName.value.length < n) {
				alert('이름은 최소 2자 이상 입력해주세요.');
			}
		}
	 */
	</script>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>