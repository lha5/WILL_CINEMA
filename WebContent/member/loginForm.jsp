<%@page import="java.math.BigInteger"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.security.SecureRandom"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- google config -->
<meta name="google-signin-client_id" content="452891226409-vk0dsanrs6cinjac56cvmd04ndtk6aid.apps.googleusercontent.com">

<title>WILL CINEMA - 로그인</title>

<!-- CSS -->
<link rel="stylesheet" href="./css/login.css">

<!-- Material Design Theming -->
<link rel="stylesheet" href="https://code.getmdl.io/1.1.3/material.orange-indigo.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script defer src="https://code.getmdl.io/1.1.3/material.min.js"></script>

<!-- Firebase -->
<script src="https://cdn.firebase.com/libs/firebaseui/3.5.2/firebaseui.js"></script>
<link type="text/css" rel="stylesheet" href="https://cdn.firebase.com/libs/firebaseui/3.5.2/firebaseui.css" />

<!-- Google Sign In -->
<script src="https://apis.google.com/js/platform.js" async defer></script>

<!-- Firebase App (the core Firebase SDK) is always required and must be listed first -->
<script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-firestore.js"></script>

<script type="text/javascript">
	// 구글 콜백
	function onSignIn(googleUser) {
		console.log('Google Auth Response', googleUser);
		
		var unsubscribe = firebase.auth().onAuthStateChanged(function(firebaseUser) {
			unsubscribe();
			
			if (!isUserEqual(googleUser, firebaseUser)) {
				var credential = firebase.auth.GoogleAuthProvider.credential(
					googleUser.getAuthResponse().id_token);
				
				firebase.auth().signInWithCredential(credential).catch(function(error) {
					var errorCode = error.code;
					var errorMessage = error.message;
					var email = error.email;
					var credential = error.credential;
					
					if (errorCode === 'auth/account-exists-with-different-credential') {
						alert('이미 동일한 이메일로 다른 서비스에 로그인 중입니다.');
					} else {
						console.error(error);
					}
				});
			} else {
				console.log('firebase에 이미 로그인 중입니다.');
			}
		});
	}
	
	// 로그아웃 제어
	function handleSignOut() {
		var googleAuth = gapi.auth2.getAuthInstance();
		googleAuth.signOut().then(function() {
			firebase.auth().signOut();
		});
	}
	
	var uid = '';
	// 초기화 제어
	function initApp() {
		firebase.auth().onAuthStateChanged(function(user) {
			if (user) {
				// 로그인 상태
				var displayName = user.displayName;
				var email = user.email;
				var emailVerified = user.emailVerified;
				var photoURL = user.photoURL;
				var isAnonymous = user.isAnonymous;
				uid = user.uid;
				var providerData = user.providerData;
				
				document.getElementById('quickstart-sign-in-status').textContent = 'Signed in';
		        document.getElementById('signout').disabled = false;
		        
			} else {
				// 로그아웃 상태
				document.getElementById('quickstart-sign-in-status').textContent = 'Signed out';
		        document.getElementById('signout').disabled = true;
			}
		});
		document.getElementById('signout').addEventListener('click', handleSignOut, false);
	}
	
	window.onload = function() {
		initApp();
	};
	
	/* if (uid != null) {
		location.href = './Main.me';
	} */
</script>

</head>
<body>
	<%@ include file="../include/header.jsp" %>
	
	<%
	if (id != null) {
		response.sendRedirect("./Main.me");
	}
	%>
	
	<fieldset>
		<legend>로그인</legend>
		<form action="./MemberLoginAction.me" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id"></td>
					<td rowspan="2"><input type="submit" value="로그인"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pass"></td>
				</tr>
			</table>
		</form>
	</fieldset>
	
	<!-- --------------------------------------------------------------------------- -->
	
	<div id="socialLogin">
		<div class="g-signin2" data-onsuccess="onSignIn" data-theme="light"></div>
		<br>
        <button disabled class="mdl-button mdl-js-button mdl-button--raised" id="signout" name="signout">
        	Sign Out
        </button>
	</div>
	
	<!-- --------------------------------------------------------------------------- -->
	
	<div id="signup">
		아직 회원이 아니신가요?
		<br><br>
		<input type="button" value="회원 가입" id="signUpBtn">
	</div>
	
	<!-- 회원 가입 버튼 연결 -->
	<script type="text/javascript">
		const upBtn = document.querySelector('#signUpBtn');
		
		upBtn.addEventListener('click', function() {
			location.href='./MemberJoin.me';
		});
	</script>
	
	<!-- --------------------------------------------------------------------------- -->
	
	<!-- The core Firebase JS SDK is always required and must be listed first -->
	<script src="https://www.gstatic.com/firebasejs/7.2.1/firebase-app.js"></script>

	<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->
	<script src="https://www.gstatic.com/firebasejs/7.2.1/firebase-analytics.js"></script>
	
	
	<script>
		var firebaseConfig = {
			apiKey: "AIzaSyBGMLPY1OzBp_va2nYDX8l9fYLm9eSiieo",
			authDomain: "will-cinema.firebaseapp.com",
			databaseURL: "https://will-cinema.firebaseio.com",
			projectId: "will-cinema",
			storageBucket: "will-cinema.appspot.com",
			messagingSenderId: "452891226409",
			appId: "1:452891226409:web:bb4b87b9c9db03a04cc738",
			measurementId: "G-XZ40JP75ZJ"
		};
		firebase.initializeApp(firebaseConfig);
		
		var provider = new firebase.auth.GoogleAuthProvider();
				
		firebase.auth().signInWithPopup(provider).then(function(result) {
			var token = result.credential.accessToken;
			var user = result.user;
		}).catch(function(error) {
			var errorCode = error.code;
			var errorMessage = error.message;
			var email = error.email;
			var credential = error.credential;
		});
	</script>
	
	<%@ include file="../include/footer.jsp" %>
</body>
</html>