<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>thinKB - 알림함 목록</title>
<style>
html, body {
    max-width: 100%;
    overflow-x: hidden;
}
.notiList-body {
	font-family: KB금융 본문체 Light;
}

.notiList-banner {
	margin-top: 45px;
	margin-left: 15%;
	margin-right: 15%;
}

.notiList-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
}
.noticeListBody {
    padding: 20px;
    font-family: KB금융 본문체 Light;
    width: 60%;
    margin: 0 auto; /* 가운데 정렬을 위한 설정 */
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
}

.tab {
    padding: 15px 30px; /* 탭 두께 증가 */
    cursor: pointer;
    font-size: 15pt;
    /* background-color: #f0f0f0; /* 기본 탭 색상 */ */
    margin-right: 5px; /* 탭 간격 */
    border-radius: 5px;
    /* border: 1px solid #ddd; */
    transition: background-color 0.3s;
    font-family: KB금융 제목체 Light;
    font-weight: bold;
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
    border-radius: 20px;
    background-color: #fff8e1;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    font-size: 13pt;
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
	font-size: 15pt;
    font-weight: bold; 
    color : #333333;
    display: flex;
    align-items: center;
    font-family: KB금융 제목체 Light;
}
/* 날짜 */
.notification-date  {
	font-size: 10pt;
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
.notiListModal {
    display: none;
    position: fixed;
    z-index: 1;
    padding-top: 250px;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgb(0, 0, 0);
    background-color: rgba(0, 0, 0, 0.4);
}

.notiListModal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 30%;
    border-radius: 10px;
    text-align: center;
}

.notiListModal-title {
    font-size: 1.5em;
    font-weight: bold;
}

.notiListModal-room {
    font-size: 1.2em;
    color: #555;
    margin-bottom: 20px;
}

.notiListModal-message-box {
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
    height: 200px;
    font-size: 1.2em;
    margin-bottom: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    padding: 10px;
}

.notiListModal-message {
    max-width: 100%;
    word-wrap: break-word;
}

.notiListModal-footer {
    text-align: center;
}

.notiListModal-button {
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

.notiListModal-button:hover {
    background-color: #e0a800;
}

/* 모두 읽음 버튼 */
.btn-allRead {
	background-color: #FFCC00;
	color: #000;
	padding: 10px 20px; /* 버튼의 여백 */
	border: none; /* 테두리 없음 */
	border-radius: 10px; /* 라운드 처리 */
	font-size: 13pt; 
	cursor: pointer; /* 마우스 커서를 포인터로 변경 */
	font-weight: bold;
	font-family: KB금융 본문체 Light;
}
.btn-allRead:hover {
	background-color: #D4AA00;
}
.idea-title {
    font-size: 0.8em;
    color: #666;
    margin-left: 10px;
}
 .notiPagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
.notiPagination a {
    color: black;
    float: left;
    padding: 8px 16px;
    text-decoration: none;
    transition: background-color .3s;
    margin: 0 4px;
}
.notiPagination a.notiActive {
    background-color: #FFCC00;
    color: white;
    border: 1px solid #FFCC00;
    border-radius:100px;
    font-family: KB금융 본문체 Light
}
.notiPagination a:hover:not(.notiActive) {background-color: #ddd;}
</style>
</head>
<body class="notiList-body">
<%@ include file="../header.jsp"%>
<div class="notiList-content">
    <div class="notification-container">
        <%-- <div class="noticeListheader">
            <div>
                <img src="./resources/bell.png" alt="알림">
            </div>
            <c:set var="userName" value="${sessionScope.userName}" />
            <div class="user">${userName}님</div> <!-- 세션의 userName 출력 -->
        </div> --%>
     <!-- 모두읽음 버튼 추가 -->   
     <div style="display:flex; justify-content:space-between">
     <h2 style="margin:0; margin-top:20px;">알림함</h2> 
	<div style="margin: 20px;">
        <form id="allReadForm" action="./allRead" method="post">
		    <input type="hidden" name="userId" value="${userId}">
		    <div style="text-align: right;">
		        <button type="submit" class="btn-allRead">모두 읽음</button>
		    </div>
		</form>
	</div></div>
	<hr style="border:1px solid lightgrey"/>
	<c:if test="${not empty message}">
	    <script>
	        alert("${message}");
	    </script>
	</c:if>
        
        <div class="tabs">
         	<div id="allTab" class="tab active">전체</div>
            <div id="unreadTab" class="tab">미확인</div>
        </div>
    </div>

       <div class="notification-list">
            <c:forEach var="notification" items="${notifications}">
                <div class="notification ${notification.read ? 'read' : 'unread'}" data-id="${notification.notificationID}">
                    <div class="notification-content">
                        <div class="title">
                            <img src="./resources/meeting.png" style="width:35px; height:35px; margin-right:10px;" alt="회의방제목"> 
                            ${notification.roomTitle}
                            <c:if test="${notification.getIdeaID() != 0}">
                                <span class="idea-title">(아이디어: ${notification.idea.title})</span>
                            </c:if>
                        </div>
                        <div style="margin-left: 40px;">${notification.message}</div>
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
                <div class="notiPagination">
            <c:if test="${currentPage > 1}">
                <a href="?page=${currentPage - 1}&pageSize=${pageSize}">&laquo;</a>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${currentPage eq i}">
                        <a class="notiActive" href="#">${i}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="?page=${i}&pageSize=${pageSize}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}&pageSize=${pageSize}">&raquo;</a>
            </c:if>
        </div>
</div>

<!-- 모달 창 -->
<div id="notiListModal" class="notiListModal">
    <div class="notiListModal-content">
        <span class="close">&times;</span>
        <h2 id="modalTitle" class="notiListModal-title"></h2>
        <p id="modalRoom" class="notiListModal-room"></p>
        <div class="notiListModal-message-box">
            <p id="modalMessage1" class="notiListModal-message"></p>
        </div>
        <div class="notiListModal-footer">
            <button id="closeModal" class="btn-allRead">닫기</button>
        </div>
    </div>
</div>

<!-- 하단 간격조정 -->
	<div style="margin-bottom: 200px;"></div>

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
        $('#modalMessage1').text(message);
        $('#modalRoom').text(room);
        $('#notiListModal').show();
        
        // 알림을 읽음 상태로 업데이트
        // window.location.href = `./updateRead/\${notificationId}`;
        
     	// 화면 유지하기 위해 스크롤 위치 저장
        localStorage.setItem('scrollPosition', $(window).scrollTop());
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
    	$('#notiListModal').hide(); 
        
        // 알림을 읽음 상태로 업데이트
        window.location.href = `./updateRead/\${currentNotificationId}`;
    });

    // 모달 창 바깥 클릭 시 닫기
    $(window).click(function(event) {
    	 if (event.target.id === 'notiListModal') {
             $('#notiListModal').hide();
            
            // 알림을 읽음 상태로 업데이트
            window.location.href = `./updateRead/\${currentNotificationId}`;
        }
    });
    
 	// 스크롤 위치 복원
    if (localStorage.getItem('scrollPosition') !== null) {
        $(window).scrollTop(localStorage.getItem('scrollPosition'));
        localStorage.removeItem('scrollPosition');
    }
 	
});
</script>
</body>
</html>
