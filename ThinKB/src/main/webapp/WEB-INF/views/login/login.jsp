<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.login-body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	font-family: KB금융 제목체 Light;
	position: relative;
	overflow: hidden;
}

.login-body::before {
	content: "";
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: url('./resources/23013.jpg') no-repeat center center fixed;
	/* 백그라운드 이미지 추가 */
	background-size: cover; /* 이미지 크기 조정 */
	filter: blur(2.5px); /* 블러 효과 추가 */
	z-index: -1; /* 배경이 다른 요소 뒤에 오도록 설정 */
}

.login-container {
	background-color: rgba(255, 255, 255, 0.85);
	padding: 20px 40px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	width: 300px;
}

.logo {
	width: 170px; /* 로고 크기 조정 */
	margin-bottom: 20px; /* 로그인 텍스트와 간격 */
}

.login-container h2 {
	margin-bottom: 20px;
	font-size: 24px;
	color: #333;
}

.input-group {
	margin-bottom: 15px;
	text-align: left;
}

.input-group label {
	display: block;
	margin-bottom: 5px;
	font-size: 14px;
	color: #555;
}

.input-group input {
	width: 100%;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

button {
	width: 100%;
	padding: 10px;
	font-size: 16px;
	color: #fff;
	background-color: #ffc000;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin-top: 10px;
}

.loginBtn:hover {
	background-color: #ffc010;;
}

.forgot-password {
	display: block;
	margin-top: 15px;
	font-size: 14px;
	color: #007bff;
	text-decoration: none;
}

.forgot-password:hover {
	text-decoration: underline;
}
</style>
<script>
	// 페이지 로드 시 실행되는 함수
	window.onload = function() {
		// loginSuccess 변수를 JavaScript에서 사용할 수 있도록 초기화
		var loginSuccess = '${loginSuccess}';

		// loginSuccess 변수가 비어있지 않고 'true'인 경우에만 팝업을 띄우고 메인 페이지로 이동하는 함수
		function showLoginPopup() {
			var loginSuccess = "${loginSuccess}";

			if (loginSuccess === 'true') { // 로그인 성공일 경우

				var isAdmin = "${isAdmin}";

				if (isAdmin === 'true') {
					window.location.href = './adminMain'; // 관리자 페이지로 이동
				} else {
					window.location.href = './main'; // 일반 사용자 페이지로 이동
				}
			} else if (loginSuccess === 'false') { // 로그인 실패일 경우
				alert("로그인 실패. 다시 시도해주세요.");
			}
			// loginSuccess가 비어있는 경우에는 아무런 작업도 하지 않음
		}

		// showLoginPopup 함수 호출
		showLoginPopup();
	};
</script>
<title>로그인</title>
</head>
<body class="login-body">
	<div class="login-container">
		<img src="./resources/logo1.png" alt="로고" class="logo">
		<h2>로그인</h2>
		<form action="./login" method="post">
			<div class="input-group">
				<label for="userId">아이디</label> <input type="text" id="userId"
					name="userId" required>
			</div>
			<div class="input-group">
				<label for="password">비밀번호</label> <input type="password"
					id="password" name="password" required>
			</div>
			<button type="submit" class="loginBtn">로그인</button>
			<a href="./passwordChange" class="forgot-password">비밀번호 변경</a>
		</form>
	</div>
</body>
</html>