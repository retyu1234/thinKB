<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	width: 15%;
	background-color: #FFFFFF;
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
}

.section3, .section4 {
	background-color: #FFFFFF;
	color: #000000;
	font-family: Arial;
	font-size: 13pt;
	font-weight: regular;
	margin-bottom: 25px;
}

.section2 {
	background-color: #FFFFFF;
	color: #000000;
	font-family: Arial;
	font-size: 13pt;
	font-weight: regular;
	margin-bottom: 15px;
	text-align: center;
	padding: 10px;
	margin-left: -5px;
}

.section3 .sub-section1, .section4 .sub-section1 {
	font-size: 15pt;
	font-weight: bold;
	margin-bottom: 10px;
}

.section3 .sub-section2, .section4 .sub-section2 {
	font-size: 13pt;
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
	font-size: 13pt;
	cursor: pointer;
	margin-top: 10px;
}

.sub-section2 a {
	display: block;
	text-decoration: none;
	color: #000000;
}

.sidebar-icon {
	size: 24px;
	margin-right: 10px;
}

/* 모달창 */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 40%;
	border-radius: 10px;
	text-align: center;
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

.modal-title {
	font-size: 1.5em;
	font-weight: bold;
}

.modal-message-box {
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: #f9f9f9;
	padding: 100px;
	font-size: 1.2em;
	margin-bottom: 20px;
}

.modal-footer {
	text-align: center;
}

.modal-button {
	background-color: #ffc107;
	color: black;
	border: none;
	padding: 15px 20px;
	font-size: 1em;
	border-radius: 5px;
	cursor: pointer;
	width: 30%;
	margin-top: 30px;
	margin-bottom: 20px;
}

.modal-button:hover {
	background-color: #e0a800;
}
</style>
</head>

<body>
	<div class="sidebar">
		<div class="section section1">아이디어 회의방 제목</div>
		<c:choose>
			<c:when
				test="${empty yesPickIdeaList or empty yesPickIdeaList[0].title}">
				<div class="section section2">
					<span class="sidebar-icon">📝</span>아이디어 선택 전
				</div>
			</c:when>
			<c:otherwise>
				<div class="section section2">
					<c:forEach var="idea" items="${yesPickIdeaList}">
						<div>
							<span class="sidebar-icon">📌</span>${idea.title}</div>
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>
		<div class="section section3">
			<div class="sub-section1">회의방 알림</div>
			<c:choose>
				<c:when test="${empty roomMessage}">
					<div class="section section2">
						<span class="sidebar-icon">📝</span>받은 알림이 없습니다.
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="message" items="${roomMessage}">
						<div class="notification-box" data-message="${message.message}" data-id="${message.notificationID}">
							<span class="sidebar-icon">📌</span>${message.message}</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- 방장 sideBar -->
		<c:if test="${userId == meetingRoom.roomManagerId}">
			<div class="section section4">
				<div class="sub-section1">회의방관리자</div>
				<div class="sub-section2">
					<a href="./roomManagement?roomId=${roomId}">회의방 관리</a>
				</div>
				<div class="sub-section2">
					<a href="./userManagement?roomId=${roomId}">참여자 관리</a>
				</div>
			</div>
		</c:if>
	</div>

	<!-- 모달 창 -->
	<div id="notificationModal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<h2 class="modal-title">알림 내용</h2>
			<div class="modal-message-box">
				<p id="modalMessage" class="modal-message"></p>
			</div>
			<div class="modal-footer">
				<button id="closeModal" class="modal-button">닫기</button>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function() {
			let currentNotificationId;
			
			// 알림 클릭 시 모달 창 띄우기
			$('.notification-box').click(function() {
				const message = $(this).data('message');
				currentNotificationId = $(this).data('id');
				$('#modalMessage').text(message);
				$('#notificationModal').show();
			});

			// 모달 창 닫기
			$('.close, #closeModal').click(function() {
			    $('#notificationModal').hide();
			 // 알림을 읽음 상태로 업데이트
		        window.location.href = `./updateRead/\${currentNotificationId}`;
			});

			// 모달 창 바깥 클릭 시 닫기
			$(window).click(function(event) {
			    if (event.target.id === 'notificationModal') {
			        $('#notificationModal').hide();
			     // 알림을 읽음 상태로 업데이트
			        window.location.href = `./updateRead/\${currentNotificationId}`;
			    }
			});
		});
	</script>
</body>
</html>
