<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Notification Panel</title>
<style>
.noticeListBody {
    padding: 20px;
    font-family: Arial, sans-serif;
    width: 60%;
    margin: 0 auto; /* 가운데 정렬을 위한 설정 */
    margin-top: 120px;
}

.notification-container {
    margin-bottom: 20px;
}

.noticeListheader {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background-color: #ffc107;
    padding: 20px; /* 패딩 두께 증가 */
    border-radius: 5px;
    font-size: 1.2em; /* 글자 크기 증가 */
}

.noticeListheader img {
    width: 50px; /* 이미지 크기 증가 */
    height: 50px; /* 이미지 크기 증가 */
}

.noticeListheader .user {
    font-weight: bold;
}

.tabs {
    display: flex;
    margin-top: 15px;
}

.tab {
    padding: 15px 30px; /* 탭 두께 증가 */
    cursor: pointer;
    font-size: 1.2em; /* 글자 크기 증가 */
    /* background-color: #f0f0f0; /* 기본 탭 색상 */ */
    margin-right: 5px; /* 탭 간격 */
    border-radius: 5px;
    /* border: 1px solid #ddd; */
    transition: background-color 0.3s;
}

.tab:hover {
    background-color: #f0f0f0; /* 마우스 오버 시 색상 */
}

.tab.active {
    border-bottom: 3px solid #ffeb3b; /* 클릭된 탭에 밑줄 */
    /* background-color: transparent; /* 배경색 투명 */ */
    border: none; /* 기본 테두리 제거 */
    padding-bottom: 12px; /* 밑줄과 텍스트 사이의 간격 조정 */
}

.notification-list {
    margin-top: 10px;
}

.notification {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px; /* 패딩 두께 증가 */
    margin-bottom: 10px;
    border-radius: 5px;
    background-color: #fff8e1;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    font-size: 1.1em; /* 글자 크기 증가 */
    cursor: pointer;
}

.notification.unread {
    background-color: #fffde7;
}

.notification.read {
    background-color: #f0f0f0; /* 클릭된 알림 색상 */
}

.notification-content {
    display: flex;
    flex-direction: column;
    color : #696969;
}

/* 아이디어 제목 */
.title {
    font-weight: bold; 
    font-size: 1.3em; 
    margin-bottom: 20px;
    color : #333333;
}
/* 날짜 */
.notification-date  {
    right: 10px; /* 오른쪽 여백 설정 */
    text-align: right;
	align-self: flex-end;
	justify-content: flex-end;
	display: flex;
	flex-direction: column;
}

/* 삭제버튼 */
.notification-date .delete {
    cursor: pointer;
    display: flex;
    align-items: right; /* 세로로 가운데 정렬 */
    justify-content: right; /* 가로로 가운데 정렬 */
    margin-bottom: 40px;
    filter: invert(30%) sepia(100%) saturate(1000%) hue-rotate(-50deg) brightness(100%) contrast(100%); /* 빨간색 */
	/* filter: invert(30%) sepia(100%) saturate(1000%) hue-rotate(-50deg) brightness(80%) contrast(120%); */ /* 더 어두운 빨간색 */
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

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

.modal-title {
    font-size: 1.5em;
    font-weight: bold;
}

.modal-room {
    font-size: 1.2em;
    color: #555;
    margin-bottom: 20px;
}

.modal-message-box {
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
    padding: 100px;
    font-size: 1.2em;
    /* width: 80%; */
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
<%@ include file="../header.jsp"%>
<div class="noticeListBody">
    <div class="notification-container">
        <div class="noticeListheader">
            <div>
                <img src="./resources/bell.png" alt="알림">
            </div>
            <c:set var="userName" value="${sessionScope.userName}" />
            <div class="user">${userName}님</div> <!-- 세션의 userName 출력 -->
        </div>
        <div class="tabs">
         	<div id="allTab" class="tab active">전체</div>
            <div id="unreadTab" class="tab">미확인</div>
        </div>
    </div>

    <div class="notification-list">
	    <c:forEach var="notification" items="${notifications}">
	        <div class="notification ${notification.read ? 'read' : 'unread'}" data-id="${notification.notificationID}">
	            <div class="notification-content">
	            <c:if test="${notification.getIdeaID() != 0}">
	                <div class="title">대상 아이디어: [${notification.idea.title}]</div>
	            </c:if>
	                <div><p>${notification.message}</p></div>
	                <div>회의방 제목: ${notification.roomTitle}</div>
	            </div>
	            <div class="notification-date">
	            	<div class="delete" data-id="${notification.notificationID}">
					    <img src="./resources/delete.png" alt="Delete" style="width: 40px; height: 40px;">
					</div>
	                <div class="date">${notification.createdAt}</div>
	            </div>
	        </div>
	    </c:forEach>
	</div>
</div>

<!-- 모달 창 -->
<div id="notificationModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2 id="modalTitle" class="modal-title"></h2>
        <p id="modalRoom" class="modal-room"></p>
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
    $('.date').each(function() {
        const timestamp = $(this).text().trim();
        $(this).text(formatTimestamp(timestamp));
    });

    $('.tab').click(function() {
        $('.tab').removeClass('active');
        $(this).addClass('active');

        if ($(this).attr('id') === 'unreadTab') {
            $('.notification').hide();
            $('.notification.unread').show();
        } else {
            $('.notification').show();
        }
    });


    // 알림 클릭 시 모달 창 띄우기 및 읽음 상태 업데이트
    $('.notification').click(function() {
        currentNotificationId = $(this).data('id'); // 알림 ID 가져오기
        const title = $(this).find('.title').text();
        const message = $(this).find('.notification-content div:nth-child(2)').text();
        const room = $(this).find('.notification-content div:nth-child(3)').text();
        $('#modalTitle').text(title);
        $('#modalMessage').text(message);
        $('#modalRoom').text(room);
        $('#notificationModal').show();
        
        // 알림을 읽음 상태로 업데이트
        // window.location.href = `./updateRead/\${notificationId}`;
    });
    
	 // 알림 삭제 기능
    $('.delete').click(function(event) {
        event.stopPropagation(); // 클릭 이벤트가 부모 요소로 전파되는 것을 방지
        const notificationId = $(this).data('id'); // 알림 ID 가져오기
        window.location.href = './deleteNotification?notificationID=' + notificationId;
    });

    let currentNotificationId; // 클릭된 알림 ID를 저장할 변수(isRead 컬럼 값 변경하기 위해)
    
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
