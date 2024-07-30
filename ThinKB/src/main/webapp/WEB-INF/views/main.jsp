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

.yellow-button:hover {
	background-color: #696969;
	color: white;
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
	height: 250px;
	display: flex;           /* 추가 */
    flex-direction: column;  /* 추가 */
}

.room-container {
    display: flex;
    gap: 20px;
    flex-wrap: wrap; /* wrap으로 변경 */
    justify-content: flex-start; /* 왼쪽 정렬로 변경 */
}

.room {
    flex: 0 0 calc(33.33% - 20px); /* 고정 너비로 변경 */
    background-color: #f0f0f0;
    padding: 20px;
    border-radius: 30px;
    box-sizing: border-box; /* 패딩을 너비에 포함 */
    cursor: pointer; /* 마우스 오버 시 커서 변경 */
    transition: background-color 0.3s ease; /* 부드러운 배경색 변경 효과 */
}

.room:hover {
    background-color: #e0e0e0; /* 호버 시 배경색 변경 */
}

.room-link {
    text-decoration: none;
    color: inherit;
    display: contents; /* 이 설정은 링크가 레이아웃에 영향을 주지 않게 합니다 */
}

.room-placeholder {
    flex: 0 0 calc(33.33% - 20px);
    visibility: hidden; /* 보이지 않게 설정 */
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
    margin-bottom: 15px;
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
	color: white;
}

.footer hr {
	border: none;
	height: 3px;
	background-color: #f0f0f0; /* 푸터 가로 줄 색상 */
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
</style>

</head>
<body class="main-body">
	<%@ include file="./header.jsp"%>
	<div style="text-align: right; margin-top: 6%; margin-right: 15%;">
		<button class="yellow-button" onclick="location.href='./newIdeaRoom'">+
			아이디어 회의방 만들기</button>
	</div>
	<div style="height: 400px;"></div>

	<div class="content">
		<div class="section-wrapper">
			<div class="section-title">진행중인 회의방</div>
			<div class="room-container-wrapper" style="margin: 0 auto;">
				<div style="text-align: right;">
					<button class="more-button" onclick="location.href='./meetingList'">
						+ 더보기</button>
				</div>
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
							<a href="./roomDetail?roomId=${li.getRoomId()}&stage=${li.getStageId()}" class="room-link">
								<div class="room">
									<h2>${li.getRoomTitle()}</h2>
									<p>방장 : ${li.getRoomManagerId() }</p>
									<p>종료일 : ${li.getEndDate() }</p>
									<p>단계 : 
										<c:choose>
											<c:when test="${li.getStageId() == 1}">아이디어 초안 작성중</c:when>
											<c:when test="${li.getStageId() == 2}">아이디어 투표 진행중</c:when>
											<c:when test="${li.getStageId() == 3}">1차 의견 작성중</c:when>
											<c:when test="${li.getStageId() == 4}">2차 의견 작성중</c:when>
											<c:when test="${li.getStageId() == 5}">최종보고서 작성중</c:when>
											<c:when test="${li.getStageId() == 6}">아이디어 회의 완료</c:when>
										</c:choose>
									</p>
								</div>
								</a>
							</c:forEach>
							
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div class="notifications-reports-wrapper">
		
			<!-- 알림함 -->
			<div class="section-wrapper" style="width: 43%;">
    <div class="section-title">알림함</div>
    <div class="notifications">
        <div style="text-align: right;">
            <button class="more-button" onclick="location.href='<c:url value="/noticeList"/>';">+ 더보기</button>
        </div>
        <c:forEach var="notification" items="${notifications}">
            <div class="notification ${notification.read ? 'read' : 'unread'}" onclick="location.href='<c:url value="/noticeList"/>';">
                <p class="notification-time">
                    <fmt:formatDate value="${notification.createdAt}" pattern="yyyy-MM-dd HH:mm" />
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
			    		<img src="./resources/delete.png" alt="Delete" style="width: 40px; height: 40px;">
			    	</div>
			    	<img id="popup-image" src="" style="display: none; width: 200px; height: 170px;">
			        <p class="popup-message"></p>
			        <div style="text-align: right; margin-bottom: 5px;"><a href="./noticeList">알림함 바로가기</a></div>
			        <button class="popup-dont-show">오늘 하루 보지 않기</button>
			        <button class="popup-close">닫기</button>
			    </div>
			</div>
			
			<!-- 내 보고서 -->
			<div class="section-wrapper" style="width: 50%;">
				<div class="section-title">내 보고서</div>
				<div class="reports-wrapper">
					<div style="text-align: right;">
						<button class="more-button"
							onclick="location.href='<c:url value="/more-reports"/>';">
							+ 더보기</button>
					</div>
					
					<div class="reports">
						<c:forEach var="report" items="${reportList}">
							<p>${report.getReportTitle()}</p>
						</c:forEach>
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

document.addEventListener('DOMContentLoaded', function() {
    var container = document.querySelector('.room-container');
    var rooms = container.querySelectorAll('.room');
    var placeholdersNeeded = 3 - (rooms.length % 3);
    
    if (placeholdersNeeded < 3) {
        for (var i = 0; i < placeholdersNeeded; i++) {
            var placeholder = document.createElement('div');
            placeholder.className = 'room-placeholder';
            container.appendChild(placeholder);
        }
    }
});
</script>
</body>
</html>

