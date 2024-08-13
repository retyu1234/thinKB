<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 변경</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<style>
.password-body {
	font-family: Arial, sans-serif;
	background-color: #f8f8f8;
	margin: 0;
	padding: 0;
	caret-color: transparent;
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

/* 모달 스타일 */
.modal-content {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.modal-header {
	border-bottom: none;
}

.modal-title {
	font-size: 24px;
	font-weight: bold;
	text-align: center;
}

.modal-body {
	padding: 20px;
}

.modal-footer {
	border-top: none;
}
</style>
</head>
<body class="password-body">
	<div class="password-container">
		<div class="back-button">
			<a href="javascript:history.back()"><i class="fas fa-arrow-left"></i>
				</a>
		</div>
		<h1 class="password-h1">개인정보 확인</h1>
		<form id="passwordForm" action="./checkUser" method="post"
			target="_self">
			<div class="form-group">
				<label for="userId">직원번호</label> <input type="text" id="userId"
					name="userId" placeholder="직원번호를 입력하세요" required>
			</div>
			<div class="form-group">
				<label for="birth">생년월일</label> <input type="date" id="birth"
					name="birth" placeholder="생년월일을 입력하세요(6자리)" required>
			</div>
			<div class="form-group1">
				<input type="submit" value="본인확인">
			</div>
		</form>
	</div>
	<c:if test="${not empty error}">
		<script>
			alert('${error}');
		</script>
	</c:if>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
