<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Left Sidebar</title>
<style>
.LeftSideBar_body {
	/* display: flex; */
	margin: 10px;
	padding: 0;
	margin-top: 150px;
}

.leftSidebar {
	position: fixed;
	top: 180px; /* 나중에 수정 */
	left: 0;
	width: 15%;
	height: 100%;
	padding: 20px;
	overflow-y: auto;
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
.section21 {
	background-color: #FFFFFF;
	color: #000000;
	font-family: Arial;
	font-size: 13pt;
	font-weight: regular;
	text-align: center;
	padding: 5px;
	margin-left: -5px;
	cursor: pointer;
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
	height: 22px;
	overflow: hidden; /* 내용이 넘칠 때 숨김 */
	white-space: nowrap; /* 텍스트를 한 줄로 표시 */
	text-overflow: ellipsis; /* 넘치는 텍스트에 "..." 표시 */
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
.modal-notification {
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
.modal-content-notification {
	background-color: #FEFEFE;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 40%;
	border-radius: 10px;
	text-align: center;
}
.close-notification {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}
.close-notification:hover, .close-notification:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}
.modal-title-notification {
	font-size: 1.5em;
	font-weight: bold;
}
.modal-message-box-notification {
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: #F9F9F9;
	padding: 100px;
	font-size: 1.2em;
	margin-bottom: 20px;
}
.modal-footer-notification {
	text-align: center;
}
.modal-button-notification {
	background-color: #FFC107;
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
.modal-button-notification:hover {
	background-color: #E0A800;
}
</style>
</head>
<body class="LeftSideBar_body">
	<div class="leftSidebar">
		<div class="section section1">${meetingRoom.roomTitle}</div>
		<c:choose>
			<c:when test="${empty yesPickList or empty yesPickList[0].title}">
				<div class="section section2">
					<span class="sidebar-icon">:메모:</span>아이디어 선택 전
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach var="idea" items="${yesPickList}">
					<div class="section section21" data-room-id="${idea.roomID}"
						data-idea-id="${idea.ideaID}" data-stage-id="${idea.stageID}">
						<span class="sidebar-icon">:압정:</span>${idea.title} <input
							type="hidden" name="ideaId" value="${idea.ideaID}" /> <input
							type="hidden" name="stageId" value="${idea.stageID}" />
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<div class="section section3">
			<div class="sub-section1">회의방 알림</div>
			<c:choose>
				<c:when test="${empty roomMessage}">
					<div class="section section2">
						<span class="sidebar-icon">:이메일2:</span>받은 알림이 없습니다.
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="message" items="${roomMessage}">
						<div class="notification-box" data-message="${message.message}"
							data-id="${message.notificationID}">${message.message}</div>
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
	<!-- 숨겨진 폼 -->
	<form id="ideaForm" method="post" action="./roomDetail">
		<input type="hidden" name="roomId" id="formRoomId" /> <input
			type="hidden" name="stage" id="formStage" /> <input type="hidden"
			name="ideaId" id="formIdeaId" />
	</form>
	<!-- 모달 창 -->
	<div id="notificationModal" class="modal-notification">
		<div class="modal-content-notification">
			<span class="close-notification">&times;</span>
			<h2 class="modal-title-notification">알림 내용</h2>
			<div class="modal-message-box-notification">
				<p id="modalMessage" class="modal-message"></p>
			</div>
			<div class="modal-footer-notification">
				<button id="closeModal" class="modal-button-notification">닫기</button>
			</div>
		</div>
	</div>
	<form id="updateReadForm" method="post" action="./updateReadSide">
		<input type="hidden" id="notificationId" name="notificationId">
	</form>
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
			$('.close-notification, #closeModal').click(function() {
				console.log('닫기 버튼 클릭됨');
				$('#notificationModal').hide();
				updateNotificationReadStatus();
			});
			// 모달 창 바깥 클릭 시 닫기
			$(window).click(function(event) {
				if (event.target.id === 'notificationModal') {
					$('#notificationModal').hide();
					updateNotificationReadStatus();
				}
			});
			function updateNotificationReadStatus() {
				$('#notificationId').val(currentNotificationId);
				$('#updateReadForm').submit();
			}
			// section21 클릭 시 roomDetail로 이동
			$('.section21').on('click', function() {
				const roomId = $(this).data('room-id');
				const ideaId = $(this).data('idea-id');
				const stage = $(this).data('stage-id');
				console.log(ideaId);
				// 폼에 값 설정
				$('#formRoomId').val(roomId);
				$('#formIdeaId').val(ideaId);
				$('#formStage').val(stage);
				// 폼 제출
				$('#ideaForm').submit();
			});
		});
	</script>


</body>
</html>

