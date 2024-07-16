<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Home</title>
<style>
.main-body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background: url('<c:url value="/resources/sf_24011.jpg"/>') no-repeat
		center center fixed;
	background-size: cover;
}

.content {
	padding: 20px;
	color: white;
	margin-left: 15%;
	margin-right: 15%;
}

.yellow-button {
	background-color: #e6b800; /* 진한 노란색 배경색 */
	color: black; /* 텍스트 색상 */
	padding: 10px 20px; /* 버튼의 여백 */
	border: none; /* 테두리 없음 */
	border-radius: 20px; /* 라운드 처리 */
	font-size: 20px; /* 텍스트 크기 */
	cursor: pointer; /* 마우스 커서를 포인터로 변경 */
	font-weight: bold;
}

.section-wrapper {
	margin-top: 20px;
}

.section-title {
	font-size: 30px;
	font-weight: bold;
	color: white;
	margin-bottom: 10px;
}

.room-container-wrapper, .notifications-wrapper, .reports-wrapper {
	background-color: #ffffff; /* 큰 네모칸의 흰색 배경 */
	border-radius: 30px; /* 라운드 처리 */
	padding: 30px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	margin-bottom: 20px;
}

.room-container {
	display: flex;
	gap: 20px; /* 작은 네모칸 간격 */
	flex-wrap: nowrap; /* 줄바꿈하지 않도록 설정 */
	justify-content: space-between; /* 공간을 균등하게 배치 */
}

.room {
	flex: 1 1 calc(33.33% - 20px); /* 작은 네모칸 너비 설정 */
	background-color: #f0f0f0; /* 연한 회색 배경색 */
	padding: 20px;
	border-radius: 30px; /* 라운드 처리 */
}

.room h2 {
	color: black;
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 10px;
}

.room p {
	font-size: 14px;
	color: #666;
	margin-bottom: 5px;
	text-align: right;
}

.notifications-reports-wrapper {
	display: flex;
	gap: 7%;
}

.notifications, .reports {
	flex: 1;
	background-color: white;
	padding: 20px;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.notifications p, .reports p {
	font-size: 14px;
	color: #666;
	margin-bottom: 10px;
}

.more-button {
	background: none;
	border: none;
	color: #007bff; /* #007bff */
	cursor: pointer;
	font-size: 15px;
	padding: 0;
	margin-left: 10px;
}

.notifications {
	display: grid;
	gap: 10px; /* 알림간 간격 조정 */
	border-radius: 30px;
}

.notification {
	background-color: #f0f0f0; /* 알림의 기본 배경색 */
	padding: 10px;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.notification.unread {
	background-color: #cce5ff; /* 읽지 않은 알림의 파란색 배경 */
}

.notification.read {
	background-color: #f0f0f0; /* 읽은 알림의 회색 배경 */
}

.notification-time {
	font-weight: bold;
	margin-bottom: 5px;
}

.notification-content {
	color: #333;
	margin-bottom: 0;
}

.footer {
	/* background-color: white; */
	padding: 20px;
	text-align: center;
	color: white;
}

.footer hr {
	border: none;
	height: 3px;
	background-color: #f0f0f0; /* 푸터 가로 줄 색상 */
	margin: 20px 0;
}
</style>
</head>
<body class="main-body">
	<%@ include file="./header.jsp" %>
	<div style="text-align: right; margin-top: 6%; margin-right: 15%;">
		<button class="yellow-button"
		onclick="location.href='./newIdeaRoom'">+ 아이디어 회의방 만들기</button>
	</div>
	<div style="height: 400px;"></div>

	<div class="content">
		<div class="section-wrapper">
			<div class="section-title">진행중인 회의방</div>
			<div class="room-container-wrapper">
				<div style="text-align: right;">
					<button class="more-button"
						onclick="location.href='<c:url value="/more-reports"/>';">
						+ 더보기</button>
				</div>
				<div class="room-container">
					<div class="room">
						<h2>회의방 제목</h2>
						<p>이름: 참여자1</p>
						<p>기간: 2024년 7월 15일 ~ 2024년 7월 30일</p>
						<p>진행상황: 진행중</p>
					</div>
					<div class="room">
						<h2>회의방 제목</h2>
						<p>이름: 참여자2</p>
						<p>기간: 2024년 8월 1일 ~ 2024년 8월 15일</p>
						<p>진행상황: 준비중</p>
					</div>
					<div class="room">
						<h2>회의방 제목</h2>
						<p>이름: 참여자3</p>
						<p>기간: 2024년 8월 20일 ~ 2024년 9월 5일</p>
						<p>진행상황: 완료</p>
					</div>
				</div>
			</div>
		</div>
		<div class="notifications-reports-wrapper">
			<div class="section-wrapper" style="width: 43%;">
				<div class="section-title">알림함</div>
				<div class="notifications">
					<div style="text-align: right;">
						<button class="more-button"
							onclick="location.href='<c:url value="/more-reports"/>';">
							+ 더보기</button>
					</div>
					<div class="notification unread">
						<p class="notification-time">2024년 7월 15일 12:00</p>
						<p class="notification-content">새로운 알림 내용</p>
					</div>
					<div class="notification read">
						<p class="notification-time">2024년 7월 16일 14:00</p>
						<p class="notification-content">또 다른 알림 내용</p>
					</div>
					<!-- 최대 5개까지 알림을 추가합니다 -->
				</div>
			</div>
			<div class="section-wrapper" style="width: 50%;">
				<div class="section-title">
					내 보고서
				</div>
				<div class="reports-wrapper">
					<div style="text-align: right;">
						<button class="more-button"
							onclick="location.href='<c:url value="/more-reports"/>';">
							+ 더보기</button>
					</div>
					<div class="reports">
						<p>보고서 제목 1</p>
						<p>보고서 제목 2</p>
						<!-- 추가 보고서 목록을 여기에 추가할 수 있습니다 -->
					</div>
				</div>
			</div>
		</div>
	</div>

	<div style="height: 200px;"></div>

	<footer class="footer">
		<hr>
		<!-- 흰색 가로 줄 -->
		<div style="text-align: center;">&copy; 2024 DigiCampus 3rd FourSideOut Team. All
			rights reserved.</div>
	</footer>
</body>
</html>

