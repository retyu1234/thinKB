<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	caret-color: transparent;
}

.content {
	padding: 20px;
	color: black;
	margin-left: 15%;
	margin-right: 15%;
}
        .button-container {
            position: relative;
            text-align: right;
            margin-top: 10%;
        }

        .yellow-button {
            background-color: #60584C; /* 진한 노란색 배경색 */
            width: 100%;
            min-height: 150px;
            height: 100%;
            color: white; /* 텍스트 색상 */
            padding: 10px 20px; /* 버튼의 여백 */
            border: none; /* 테두리 없음 */
            border-radius: 10px; /* 라운드 처리 */
            font-size: 20px; /* 텍스트 크기 */
            cursor: pointer; /* 마우스 커서를 포인터로 변경 */
            font-weight: bold;
            position: relative;
            z-index: 1; /* 버튼의 z-index 설정 */
        }

        .yellow-button:hover {
            background-color: #696969;
            color: white;
        }

        .button-container img {
            position: absolute;
            top: 50%;
            right: -25px; /* 버튼 외부에 걸치도록 설정 */
            transform: translateX(100%), translateY(-30%);
            width: 300px; /* 이미지 크기 조정 */
            height: auto;
            z-index: 2; /* 이미지의 z-index 설정 (버튼보다 위에 위치) */
        }
.section-header {
    display: flex;
    justify-content: start;
    align-items: center;
    margin-bottom: 10px;
}

.section-title {
    font-size: 30px;
    font-weight: bold;
    color: black;
}

.more-button {
    background-color: #f0f0f0;
    border: none;
    padding: 5px ;
    cursor: pointer;
    font-size: 14px;
    margin-top:20px;
}

.more-button:hover {
    background-color: #e0e0e0;
}

.section-wrapper {
    margin-top: 20px;
    width: 100%;
}

.room-container-wrapper, .notifications-wrapper, .reports-wrapper {
    background-color: #ffffff;
    border-radius: 30px;
    padding: 30px;
    margin-bottom: 40px;
    height: auto;
    display: flex;
    flex-direction: column;
}

.room-container {
	display: flex;
	gap: 20px; /* 작은 네모칸 간격 */
	flex-wrap: nowrap; /* 줄바꿈하지 않도록 설정 */
	justify-content: space-between; /* 공간을 균등하게 배치 */
	flex: 1;       
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
	gap: 3%;
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
	margin-bottom: 10px;
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
	cursor: pointer; /* 커서를 손 모양으로 변경 */
}

.notification.unread {
	/* background-color: #cce5ff; */ /* 읽지 않은 알림의 파란색 배경 */
	background-color: #fffde7; /* 연노랑색 */
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

/* 읽지 않은 메세지 팝업 스타일 */
.popup-overlay {
    display: none; /* 기본적으로 숨김 */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 1000;
}

.popup {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); /* 화면의 가운데에 뜨게끔 설정 */
    background: white;
    padding: 40px;
    min-height: 150px; /* 팝업창의 최소 높이 설정 */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    z-index: 1001;
    color: #000; /* 텍스트 색상 검정으로 설정 */
    text-align: center;
    border: 4px solid #ffc107; /* 굵은 노란색 테두리 추가 */
    box-sizing: border-box; /* 패딩과 테두리를 포함한 전체 크기 계산 */
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

/* 삭제버튼 */
.delete {
	position: absolute;
    top: 1px; /* 팝업창 상단에서의 거리 */
    right: 1px; /* 팝업창 오른쪽에서의 거리 */
    cursor: pointer;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    display: flex;
    align-items: center; /* 세로로 가운데 정렬 */
    justify-content: center; /* 가로로 가운데 정렬 */
}

.popup img {
    display: block;
    margin: 0 auto 20px; /* 가운데 정렬 및 아래쪽 마진 추가 */
    max-width: 100%; /* 이미지가 팝업창을 넘지 않도록 설정 */
    height: auto; /* 이미지 비율 유지 */
}


.popup-message {
    font-size: 1.3em;
    margin-bottom: 40px;
    /* font-weight: bold; */ /* 글자를 두껍게 설정 */
}
.popup-footer {
    display: flex;
    justify-content: space-between;
    width: 100%;
    padding: 10px 0;
}

.popup-dont-show, .popup-close {
    background: #808080;
    color: #ffffff;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
    display: inline-block; /* 버튼을 인라인 블록 요소로 설정 */
}

.popup-close {
    background: #ffc107;
    color: #ffffff;
    border: none;
    padding: 10px 50px;
    cursor: pointer;
    border-radius: 5px;
    display: inline-block; /* 추가: 버튼을 인라인 블록 요소로 설정 */
}

.popup-dont-show:hover {
	background-color: #606060;
}
.popup-close:hover {
	background-color: #e0a800;
}
/*  */

.footer {
	/* background-color: white; */
	padding: 20px;
	text-align: center;
	color: black;
}

.footer hr {
	border: none;
	height: 3px;
	background-color: #000000; /* 푸터 가로 줄 색상 */
	margin: 20px 0;
}

.no-rooms-message {
    color: grey;
    font-size: 15pt;
    text-align: center;
    display: flex;
    flex-direction: column; /* 수직으로 정렬되도록 설정 */
    justify-content: center;
    align-items: center;
    height: 100%; /* 높이 설정을 유지하고 */
    width: 100%;
}

.no-rooms-message img {
    width: 100px; /* 이미지 너비 조정 */
    height: auto; /* 높이 자동 조정 */
    margin-bottom: 10px; /* 이미지와 텍스트 사이 여백 */
}
.todo-wrapper {
    display: flex;
    gap: 2%;
    flex-wrap: wrap;
}

.calendar {
    flex: 1;
    background-color: #f0f0f0;
    border-radius: 15px;
    padding: 15px;
    margin: 25px;
    
}

.todo-list {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 3px;
    margin:25px;
}

.todo-item {
    background-color: #f0f0f0;
    padding: 10px;
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.todo-item.completed {
    background-color: #e0e0e0;
    text-decoration: line-through;
}

.todo-date {
    font-weight: bold;
    margin-bottom: 5px;
}

.todo-content {
    color: #333;
    margin-bottom: 0;
}
</style>
<!-- FullCalendar CSS -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.css' rel='stylesheet' />

<!-- FullCalendar JS -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.js'></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        height: 'auto'

    });
    calendar.render();
});
</script>
</head>
<body class="main-body">
	<%@ include file="./header.jsp"%>
	<div class="content">

		<img style="width: 100%; margin-top: 13%; caret-color: transparent;"
			src="<c:url value='/resources/mainBanner.png' />" alt="no Img" />
		<div class="section-wrapper">
			<div class="section-header">
				<div class="section-title">🧷진행중인 회의방</div>
				<button class="more-button" onclick="location.href='./meetingList'">+
					더보기</button>
			</div>
			<div class="room-container-wrapper" style="margin: 0 auto;">

				<div class="room-container" style="text-align: center;">
					<c:choose>
						<c:when test="${empty roomList}">
							<div class="no-rooms-message">
								<div style="text-align: center;">
									<img src="<c:url value='/resources/noContents.png' />"
										alt="no Img" style="width: 100px; height: auto;" />
								</div>
								<div style="text-align: center;">
									<p style="font-size: 15pt; color: black;">진행중인 회의가 없습니다!</p>
								</div>
							</div>
						</c:when>

						<c:otherwise>
							<c:forEach var="li" items="${roomList}">
								<div class="room">
									<h2>${li.getRoomTitle()}</h2>
									<p>방장 : ${li.getRoomManagerId() }</p>
									<p>종료일 : ${li.getEndDate() }</p>
									<p>
										단계 :
										<c:choose>
											<c:when test="${li.getStageId() == 1}">아이디어 초안 작성중</c:when>
											<c:when test="${li.getStageId() == 2}">아이디어 투표 진행중</c:when>
											<c:when test="${li.getStageId() == 3}">1차 의견 작성중</c:when>
											<c:when test="${li.getStageId() == 4}">1차 의견 투표중</c:when>
											<c:when test="${li.getStageId() == 5}">2차 의견 작성중</c:when>
											<c:when test="${li.getStageId() == 6}">2차 의견 투표중</c:when>
											<c:when test="${li.getStageId() == 7}">최종보고서 작성중</c:when>
											<c:when test="${li.getStageId() == 8}">아이디어 회의 완료</c:when>
										</c:choose>
									</p>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div class="notifications-reports-wrapper">

			<!-- 알림함 -->
			<div class="section-wrapper" style="width: 37%;">
				<div class="section-header">
					<div class="section-title">📥알림함</div>
					<button class="more-button"
						onclick="location.href='<c:url value="/noticeList"/>';">+
						더보기</button>
				</div>
				<div class="notifications">
					<c:forEach var="notification" items="${notifications}">
						<div class="notification ${notification.read ? 'read' : 'unread'}"
							onclick="location.href='<c:url value="/noticeList"/>';">
							<p class="notification-time">
								<fmt:formatDate value="${notification.createdAt}"
									pattern="yyyy-MM-dd HH:mm" />
							</p>
							<p class="notification-content">
								<c:if test="${notification.getIdeaID() != 0}">
                        *${notification.idea.title}*&nbsp;&nbsp;
                    </c:if>
								${notification.message}
							</p>
						</div>
					</c:forEach>
				</div>
			</div>

			<!-- 팝업창 추가 -->
			<div class="popup-overlay">
				<div class="popup">
					<div class="delete">
						<img src="./resources/delete.png" alt="Delete"
							style="width: 40px; height: 40px;">
					</div>
					<img id="popup-image" src=""
						style="display: none; width: 200px; height: 170px;">
					<p class="popup-message"></p>
					<button class="popup-dont-show">오늘 하루 보지 않기</button>
					<button class="popup-close">닫기</button>
				</div>
			</div>
			<!-- 내 보고서 -->
<div class="section-wrapper" style="width: 60%;">
    <div class="section-header">
        <div class="section-title">🗓️오늘의 할일</div>
    </div>
    <div class="todo-wrapper">
        <div class="calendar">
            <!-- 달력 컴포넌트가 들어갈 자리 -->
            <div id="calendar"></div>
        </div>
            <div class="todo-list">
                <div class="todo-item">
                    <p class="todo-date">2023-07-28</p>
                    <p class="todo-content">회의 준비하기</p>
                </div>
                <div class="todo-item completed">
                    <p class="todo-date">2023-07-29</p>
                    <p class="todo-content">프로젝트 보고서 작성</p>
                </div>
            </div>
    </div>
</div>
		</div>
	</div>

	<div style="height: 200px;"></div>

	<footer class="footer">
		<hr>
		<!-- 흰색 가로 줄 -->
		<div style="text-align: center;">&copy; 2024 DigiCampus 3rd
			FourSideOut Team. All rights reserved.</div>
	</footer>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    function formatTimestamp(timestamp) {
        const date = new Date(timestamp);
        const year = date.getFullYear();
        const month = date.getMonth() + 1;
        const day = date.getDate();
        const hours = date.getHours();
        const minutes = date.getMinutes();

        const formattedMonth = (month < 10 ? '0' + month : month);
        const formattedDay = (day < 10 ? '0' + day : day);
        const formattedHours = (hours < 10 ? '0' + hours : hours);
        const formattedMinutes = (minutes < 10 ? '0' + minutes : minutes);

        return year + '.' + formattedMonth + '.' + formattedDay + ' ' + formattedHours + ':' + formattedMinutes;
    }

    // 포맷된 날짜를 표시하기 위해 createdAt 값을 변환
    $('.notification-time').each(function() {
        const timestamp = $(this).text().trim();
        const date = new Date(timestamp);
        if (!isNaN(date.getTime())) {
            $(this).text(formatTimestamp(date));
        } else {
            $(this).text(timestamp);
        }
    });
    
    function setCookie(name, value, days) {
        const date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        const expires = "expires=" + date.toUTCString();
        document.cookie = name + "=" + value + ";" + expires + ";path=/";
    }

    function getCookie(name) {
        const decodedCookie = decodeURIComponent(document.cookie);
        const cookies = decodedCookie.split(';');
        name = name + "=";
        for (let i = 0; i < cookies.length; i++) {
            let cookie = cookies[i].trim();
            if (cookie.indexOf(name) == 0) {
                return cookie.substring(name.length, cookie.length);
            }
        }
        return "";
    }

    // 쿠키 확인
    if (getCookie("dontShowPopupToday") !== "true") {
        // 포맷된 날짜를 표시하기 위해 createdAt 값을 변환
        $('.notification-time').each(function() {
            const timestamp = $(this).text().trim();
            const date = new Date(timestamp);
            if (!isNaN(date.getTime())) {
                $(this).text(formatTimestamp(date));
            } else {
                $(this).text(timestamp);
            }
        });
    
	 	// 읽지 않은 알림이 있을 경우 팝업 표시
	    var unreadCount = ${unreadCount}; 
	    console.log("Unread Count:", unreadCount);
	    if (unreadCount > 0) {
	    	$('#popup-image').attr('src', './resources/bibi1.png').show(); // 이미지 URL 설정
	        $('.popup-message').text("읽지 않은 " + unreadCount + "개의 알림이 도착 !");
	        $('.popup-overlay').show();
	    }
	}

    // 팝업 닫기
    $('.popup-close, .delete').click(function() {
        $('.popup-overlay').hide();
    });
    
 	// "오늘 하루 보지 않기" 버튼 클릭 시
    $('.popup-dont-show').click(function() {
        setCookie("dontShowPopupToday", "true", 1); // 1일 동안 쿠키 설정
        $('.popup-overlay').hide();
    });
 	
});
</script>
</body>
</html>

