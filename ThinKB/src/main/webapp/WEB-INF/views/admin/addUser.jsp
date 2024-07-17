<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<title>회원 등록</title>
<style>
/* 전체 배경 설정 */
.userAdmin-body {
	margin: 0;
	padding: 0;
	background-image:
		url('${pageContext.request.contextPath}/resources/aguu.jpg');
	background-size: cover; /* 이미지가 요소에 완전히 맞도록 비율을 조정 */
	background-position: center; /* 이미지를 가운데 정렬 */
	background-repeat: no-repeat;
	height: 400px; /* 요소의 높이를 400px로 고정 */
}

/* 컨텐츠 컨테이너 설정 */
.employee-content {
	max-width: 800px;
	margin: 20px auto;
	background-color: rgba(255, 204, 0, 0.1);
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
	font-size: 28px;
	font-weight: bold;
	margin-bottom: 20px;
	color: #333;
}

.form-group {
	margin-bottom: 20px;
	margin-left: 10px;
}

.form-group label {
	font-weight: bold;
	display: block;
	margin-bottom: 8px;
}

.form-group input[type="text"], .form-group input[type="email"],
	.form-group input[type="date"],
	.form-group select {
	width: 95%;
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 16px;
}

.form-group select {
	appearance: none; /* 기본 스타일 제거 */
	-webkit-appearance: none;
	-moz-appearance: none;
	padding-right: 30px; /* 드롭다운 화살표 여백 추가 */
	background-image:
		url('data:image/svg+xml;utf8,<svg fill="%23333" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
	/* 드롭다운 화살표 이미지 추가 */
	background-repeat: no-repeat;
	background-position: right 10px center;
}

.form-group input[type="submit"] {
	background-color: #ffcc00;
	color: #fff;
	border: none;
	padding: 12px 20px;
	font-size: 16px;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.form-group input[type="submit"]:hover {
	background-color: #ffcd50;
}
</style>
<script>
function validateForm() {
    var userName = document.getElementById("userName").value;
    var email = document.getElementById("email").value;
    var birth = document.getElementById("birth").value;
    var userId = document.getElementById("userId").value;
    var team = document.getElementById("team").value;

    if (userName.trim() === '' || email.trim() === '' || birth.trim() === '' || userId.trim() === '' || team.trim() === '') {
        alert("모든 필드를 입력하세요.");
        return false;
    }

    return true;
}
function confirmSubmit() {
    return confirm("정말로 등록하시겠습니까?");
}
</script>
</head>
<body>
	<div class="userAdmin-body">
		<%@ include file="../headerAdmin.jsp"%>
	</div>
	<div class="employee-content">
		<h2>회원 등록</h2>
		<form action="./insertUser" method="post">
			 <input type="hidden" name="departmentId" value="${departmentId}" />
			<div class="form-group">
				<label for="userName">이름:</label> <input type="text" id="userName"
					name="userName" required>
			</div>
			<div class="form-group">
				<label for="email">이메일:</label> <input type="email" id="email"
					name="email" required>
			</div>
			<div class="form-group">
				<label for="birth">생년월일:</label> <input type="date" id="birth"
					name="birth" required>
			</div>
			<div class="form-group">
				<label for="password">직원번호(초기비밀번호):</label> <input type="text"
					id="userId" name="userId" required>
			</div>
			<div class="form-group">
				<label for="departmentName">부서:</label> <input type="text"
					id="departmentName" name="departmentName" value="${departmentName}"
					readonly>
			</div>
			<div class="form-group">
				<label for="team">팀:</label> <select id="team" name="team" required>
					<option value="">팀을 선택하세요</option>
					<!-- 여기에 부서에 해당하는 팀 목록 추가 -->
					<c:forEach var="team" items="${teamList}">
						<option value="${team.teamId}">${team.teamName}</option>
					</c:forEach>
				</select>
			</div>
			<br>
			<div class="form-group">
				    <input type="submit" value="등록" onclick="return confirmSubmit();">
			</div>
		</form>
	</div>
</body>
</html>
