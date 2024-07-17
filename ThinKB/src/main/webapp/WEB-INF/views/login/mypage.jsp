<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<style>
.mypage-body {
	font-family: 'Arial', sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background: url('./resources/23030.jpg') no-repeat center center fixed;
	/* 백그라운드 이미지 추가 */
	background-size: cover; /* 이미지 크기 조정 */
}

.container {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	padding: 30px;
	width: 90%;
	max-width: 600px;
}

h1 {
	color: #333;
	text-align: center;
	margin-bottom: 30px;
}

.profile-section {
	text-align: center;
	margin-bottom: 30px;
}

.profile-pic {
	width: 150px;
	height: 150px;
	border-radius: 50%;
	object-fit: cover;
	border: 5px solid #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.change-pic-btn {
	background-color: #4CAF50;
	color: white;
	border: none;
	padding: 10px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 20px 2px;
	cursor: pointer;
	border-radius: 5px;
	transition: background-color 0.3s;
}

.change-pic-btn:hover {
	background-color: #45a049;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #f2f2f2;
	font-weight: bold;
	width: 40%;
}

tr:hover {
	background-color: #f5f5f5;
}

#profileUploadModal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
	max-width: 500px;
	border-radius: 8px;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}
</style>
<script>
        function openModal() {
            document.getElementById('profileUploadModal').style.display = 'block';
        }
        function closeModal() {
            document.getElementById('profileUploadModal').style.display = 'none';
        }
    </script>
</head>
<body class="mypage-body">
	<%@ include file="../header.jsp"%>
	<div class="container">
		<h1>마이페이지</h1>
		<div class="profile-section">
			<c:choose>
				<c:when test="${not empty user.profileImg}">
					<img src="./upload/${user.profileImg}" alt="Profile Picture"
						class="profile-pic">
				</c:when>
				<c:otherwise>
					<img src="./resources/profile1.png" alt="Profile Picture"
						class="profile-pic">
				</c:otherwise>
			</c:choose>
			<br>
			<button class="change-pic-btn" onclick="openModal()">프로필 변경</button>
		</div>
		<table>
			<tr>
				<th>사용자 ID</th>
				<td>${user.userId}</td>
			</tr>
			<tr>
				<th>사용자 이름</th>
				<td>${user.userName}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${user.email}</td>
			</tr>
			<tr>
				<th>생일</th>
				<td>${user.birth}</td>
			</tr>
			<tr>
				<th>부서</th>
				<td>${user.departmentName}</td>
			</tr>
			<tr>
				<th>팀</th>
				<td>${user.teamName}</td>
			</tr>
		</table>
	</div>

	<div id="profileUploadModal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<h2>프로필 사진 업로드</h2>
			<form action="./updateProfileImg" method="post"
				enctype="multipart/form-data">
				<input type="file" name="profileImg"> <input type="hidden"
					name="userId" value="${user.userId}" /> <br> <br>
				<button type="submit" class="change-pic-btn">업로드</button>
			</form>
		</div>
	</div>
</body>
</html>