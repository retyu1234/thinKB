<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 사이드 메뉴 스타일 */
.side-menu {
	position: fixed;
	top: 60%; /* 헤더 아래에 위치 */
	left: 1%; /* 왼쪽에 고정 */
	width: 10%;
	background: white;
	padding: 1%;
	box-shadow: 2px 4px 8px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	z-index: 1000;
}

.side-menu a {
	display: block;
	padding: 10px;
	color: #333;
	text-decoration: none;
	font-weight: bold;
	margin-bottom: 10px;
}

.side-menu a:hover {
	background-color: #f0f0f0;
}

.content-wrapper {
	margin-left: 10%; /* 사이드 메뉴 너비만큼 여백 추가 */
}
</style>
</head>
<body>

	<div class="side-menu">
		<h4>Room Manager</h4>
		<hr />
		<a href="./roomManagement?roomId=${roomId}">회의방 관리</a> <a href="./userManagement?roomId=${roomId}">참여자 관리</a>
	</div>
</body>
</html>