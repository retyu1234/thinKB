<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 변경</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<style>
.password-body {
	font-family: Arial, sans-serif;
	background-color: #f8f8f8;
	margin: 0;
	padding: 0;
}
.password-container {
	max-width: 1000px;
	margin: 100px auto;
	background-color: #ffffff;
	padding: 20px;
	width: 100%;
	height: 100%;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
.password-h1 {
	font-size: 24px;
	font-weight: bold;
	text-align: center;
	margin-bottom: 20px;
}
.form-group {
	margin-bottom: 5px;
	position: relative;
	display: flex;
	align-items: center;
	padding: 10px;
	border: none;
	border-radius: 4px;
	cursor: text;
	transition: background-color 0.3s;
	background-color: #FFFFE4;
}
.form-group:hover {
	background-color: #FFFFD2;
}
.form-group label {
	font-weight: bold;
	margin-right: 10px;
	padding-left: 10px;
	caret-color: transparent;
}
.form-group input[type="text"], .form-group input[type="date"],
	.form-group input[type="password"] {
	border: none;
	outline: none;
	flex: 1;
	font-size: 16px;
	background-color: transparent;
	margin-left: 10px;
}
.form-group1 {
	display: flex;
	justify-content: center;
}
.form-group1 input[type="submit"] {
	margin-top: 30px;
	width: 100%;
	background-color: #ffcc00;
	color: #fff;
	border: none;
	padding: 12px;
	font-size: 16px;
	border-radius: 20px;
	cursor: pointer;
	transition: background-color 0.3s;
	width: 30%;
}
.form-group1 input[type="submit"]:hover {
	background-color: #ffcd50;
}
.back-button {
	display: inline-block;
	margin-bottom: 20px;
}
.back-button a {
	text-decoration: none;
	color: #000;
	font-size: 18px;
}
.back-button a i {
	margin-right: 8px;
}
</style>
</head>
<body class="password-body">
	<div class="password-container">
		<div class="back-button">
			<a href="./passwordChange"><i class="fas fa-arrow-left"></i> </a>
		</div>
		<h1 class="password-h1">비밀번호 변경</h1>
		<p>개인정보확인 </p>
		<p>${user.userName}님/(${user.userId}) </p><br>
		<hr/><br>
		<form id="passwordChangeForm" action="./updatePassword" method="post" onsubmit="return validatePassword()">
			<div class="form-group">
				<label for="newPassword">새 비밀번호</label>
				<input type="password" id="newPassword" name="newPassword" required>
			</div>
			<div class="form-group">
				<label for="confirmPassword">비밀번호 확인</label>
				<input type="password" id="confirmPassword" name="confirmPassword" required>
			</div>
			<div class="form-group1">
				<input type="hidden" id="userId" name="userId" value="${user.userId}">
				<input type="submit" value="변경">
			</div>
		</form>
	</div>
	<script>
		// 비밀번호 변경 폼 제출 시 유효성 검사
		function validatePassword() {
			var newPassword = document.getElementById("newPassword").value;
			var confirmPassword = document.getElementById("confirmPassword").value;
			if (newPassword !== confirmPassword) {
				alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
				return false;
			}
			return true;
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
