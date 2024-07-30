<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Left Sidebar</title>
<style>
body {
	display: flex;
	margin: 10px;
	padding: 0;
	margin-top: 150px;
}

.sidebar {
	width: 20%;
	background-color: FFFFFF;
	padding: 15px;
	display: flex;
	flex-direction: column;
}

.section {
	margin-bottom: 15px;
	padding: 10px;
}

.section1 {
	background-color: #60584C;
	color: #FFFFFF;
	font-family: Arial;
	font-size: 15pt;
	font-weight: bold;
	text-align: center;
	padding: 5%;
	box-sizing: border-box;
	margin-left: 0px;
}

.section2, .section3, .section4 {
	background-color: FFFFFF;
	color: #000000;
	font-family: Arial;
	font-size: 15pt;
	font-weight: regular;
	margin-bottom:25px;
}

.section3 .sub-section1, .section4 .sub-section1 {
	font-size: 20pt;
	font-weight: bold;
	margin-bottom: 10px;
}

.section3 .sub-section2, .section4 .sub-section2 {
	font-size: 15pt;
	font-weight: regular;
	margin-bottom: 10px;
}

.notification-box {
	background-color: #FFE297;
	border-radius: 10px;
	text-align: center;
	padding: 10px;
	color: #000000;
	font-family: Arial;
	font-size: 15pt;
}
.sub-section2 a {
	display: block;
	text-decoration: none;
}
</style>
</head>

<body>
	<div class="sidebar">
		<div class="section section1">아이디어 회의방 제목</div>
		<div class="section section2">아이디어 선택전</div>
		<div class="section section3">
			<div class="sub-section1">회의방 알림</div>
			<div class="sub-section2">받은 알림이 없습니다.</div>
			<div class="notification-box">[회의방제목] 알림내용</div>
		</div>
		<div class="section section4">
			<div class="sub-section1">회의방관리자</div>
			<div class="sub-section2"><a href="./roomManagement?roomId=${roomId}">회의방 관리</a></div>
			<div class="sub-section2"><a href="./userManagement?roomId=${roomId}">참여자 관리</a></div>
		</div>
	</div>
</body>
</html>
