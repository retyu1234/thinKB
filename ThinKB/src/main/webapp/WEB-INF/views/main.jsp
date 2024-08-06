<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	padding: 5px;
	cursor: pointer;
	font-size: 14px;
	margin-top: 20px;
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
	gap: 20px;
	flex-wrap: wrap; /* wrap으로 변경 */
	justify-content: flex-start; /* 왼쪽 정렬로 변경 */
}

.room {
	flex: 0 0 calc(25% - 15px); /* 고정 너비로 변경 */
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
	gap: 3%;
}

.notifications, .todo-wrapper {
	flex: 1;
	background-color: white;
	padding: 20px;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.notifications p, .reports p {
	font-size: 15px;
	color: #666;
	margin-bottom: 10px;
	margin-left: 10px;
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

.notiRoomTitle {
	margin: 0;
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
    transform: translate(-50%, -50%);
    background: white;
    padding: 30px;
    min-width: 280px; /* 최소 너비를 줄임 */
    min-height: 250px;
    width: 60%; /* 화면 너비의 60%로 줄임 */
    max-width: 400px; /* 최대 너비를 줄임 */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    z-index: 1001;
    color: #000;
    text-align: center;
    border-radius: 20px;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

/* 삭제버튼 */
.delete {
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
    font-size: 28px; /* X 버튼 크기 증가 */
    width: 40px; /* 크기 증가 */
    height: 40px; /* 크기 증가 */
    display: flex;
    align-items: center;
    justify-content: center;
    background: none;
    border: none;
    transition: color 0.3s ease;
}

.delete::before {
    content: "\00d7"; /* X 문자 */
    color: #333;
}

.delete:hover::before {
    color: #ff0000;
}

.popup img {
	display: block;
	margin: 0 auto 20px; /* 가운데 정렬 및 아래쪽 마진 추가 */
	/* max-width: 100%; */ /* 이미지가 팝업창을 넘지 않도록 설정 */
	height: 100px; /* 이미지 비율 유지 */
	width: auto;
}

.popup-message {
	font-size: 15pt;
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
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.calendar {
	flex: 1;
	background-color: #f0f0f0;
	border-radius: 15px;
	padding: 15px;
	margin: 25px;
	height: 400px; /* 고정 높이 설정 */
	overflow: hidden; /* 내용이 넘치면 숨김 */
}

.todo-list {
	flex: 1;
	display: flex;
	flex-direction: column;
	gap: 3px;
	margin: 25px;
	max-height: 400px; /* calendar의 높이와 맞춤 */
	overflow-y: auto; /* 내용이 넘치면 스크롤 표시 */
}

.todo-item {
	background-color: #f0f0f0;
	padding: 10px;
	border-radius: 15px;
	margin-bottom: 10px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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
	margin: 0;
}

#calendar {
	height: 100%; /* 부모 요소의 높이에 맞춤 */
}

.fc-daygrid-day {
	height: 5% !important; /* 일자별 높이 조정 */
}

.fc-toolbar-title {
	font-size: 1.2em !important; /* 월 표시 글자 크기 축소 */
}

.fc-day-today {
	background-color: #fffde7 !important; /* 오늘 날짜 배경색 */
}

.fc-day-selected {
	background-color: #fff59d !important; /* 선택된 날짜 배경색 */
}

/* 헤더와 요일 표시 줄의 높이 조정 */
.fc-header-toolbar, .fc-col-header {
	margin-bottom: 0.5em !important;
}

.fc-col-header-cell {
	padding: 2px 0 !important;
}
/* Guide 섹션 스타일 */
#guide-section {
    padding: 100px 0;
    background-color: #ffffff;
    overflow-x: hidden; /* 가로 스크롤 방지 */
}

#guide-container {
    width: 70%;
    margin: 0 auto;
}

.guide-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 100px; /* 간격 증가 */
    opacity: 0;
    transform: translateY(50px) rotate(-5deg) scale(0.9);
    transition: opacity 0.8s ease, transform 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.guide-item:nth-child(even) {
    transform: translateY(50px) rotate(5deg) scale(0.9);
}

.guide-item.visible {
    opacity: 1;
    transform: translateY(0) rotate(0) scale(1);
}

.guide-image-container, .guide-text {
    width: 45%;
    transition: transform 0.5s ease;
}

.guide-item:hover .guide-image-container {
    transform: scale(1.05);
}

.guide-item:hover .guide-text {
    transform: translateY(-5px);
}
.guide-image-container, .guide-text {
    width: 45%;
}

.guide-image-container {
    aspect-ratio: 16 / 9; /* 16:9 비율 유지 */
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #ffffff;
}

.guide-image {
    width: 100%;
    height: 100%;
    object-fit: contain;
}

.guide-text {
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 0 2%;
    box-sizing: border-box;
}

.guide-item:nth-child(even) {
    flex-direction: row-reverse;
}

.guide-item:nth-child(even) .guide-text {
    text-align: left;
}

#guide-section h2 {
    font-size: 18pt;
    margin-bottom: 1vw;
}

#guide-section p {
    font-size: 15pt;
    margin-bottom: 0.5vw;
}

@media (max-width: 768px) {
    #guide-container {
        width: 90%;
    }
    .guide-item {
        flex-direction: column;
    }
    .guide-image-container, .guide-text {
        width: 100%;
        margin-bottom: 5%;
    }
    .guide-item:nth-child(even) {
        flex-direction: column;
    }
    #guide-section h2 {
        font-size: 4vw;
    }
    #guide-section p {
        font-size: 3vw;
    }
}
.makeRoomImg {
	width: 100%;
	margin-top: 3%;
	caret-color: transparent;
	border:none;
	cursor: pointer; /* 커서가 포인터로 변경 */
	transition: transform 0.3s ease, box-shadow 0.3s ease; /* 부드러운 변환 효과 */
}

/* 호버 시 효과 */
.makeRoomImg:hover {
	transform: scale(1.03); /* 약간 확대 */
}

/* 클릭 시 효과 */
.makeRoomImg:active {
	transform: scale(0.95); /* 약간 축소 */
}
.fade-in {
    opacity: 0;
    transform: translateY(20px);
    transition: opacity 0.8s ease, transform 0.8s ease;
}

.fade-in.visible {
    opacity: 1;
    transform: translateY(0);
}
.popup-buttons {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 20px;
}
/* 노란색 버튼 */
.yellow-button {
	background-color: #FFCC00;
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	cursor: pointer;
	font-weight: bold;
	text-decoration: none;
	max-width: 200px;
}

.yellow-button:hover {
	background-color: #D4AA00;
	text-decoration: none;
}

.grey-button {
	background-color: #978A8F;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	cursor: pointer;
	font-weight: bold;
	max-width: 200px;
}

.grey-button:hover {
	background-color: #60584C;
}

/* 버튼 스타일 수정 */
.grey-button, .yellow-button {
    width: 80%; /* 버튼 너비 조정 */
    max-width: 200px;
    margin: 5px 0; /* 상하 여백 추가 */
}




/* 세번째 줄 */
.best-sections-wrapper {
    display: flex;
    justify-content: space-between;
    margin-top: 40px;
}

.best-section {
    flex: 1;
    background-color: #ffffff;
    border-radius: 30px;
    padding: 20px;
    margin: 0 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.best-content {
    display: flex;
    justify-content: space-around;
    margin-top: 40px;
}

.best-item {
    text-align: center;
    margin: 0 5px;
}

.profile-container {
    position: relative;
    width: 50px;
    height: 50px;
    margin: 0 auto 10px;
}

.profile-image {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    object-fit: cover;
}

.medal {
    position: absolute;
    bottom: -2px;
    left: -3px;
    width: 20px;
    height: 30px;
}

.best-name {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 5px;
}

.best-description {
    font-size: 12px;
    color: #666;
}

</style>
<!-- FullCalendar CSS -->
<link
	href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.css'
	rel='stylesheet' />

<!-- FullCalendar JS -->
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.js'></script>
<!-- todolist 달력 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function getTodoList(date) {
    $.ajax({
        url: '/star/getTodoList',
        type: 'GET',
        data: { date: date },
        dataType: 'json',
        contentType: 'application/json;charset=UTF-8',
        success: function(data) {
            updateTodoList(data, date);
        },
        error: function(xhr, status, error) {
            console.error("Error fetching todo list:", error);
        }
    });
}
function updateTodoList(todoList, selectedDate) {
    console.log("Received todo list:", todoList);

    var todoListContainer = document.querySelector('.todo-list');
    todoListContainer.innerHTML = ''; // 기존 내용 지우기

    var formattedDate = new Date(selectedDate).toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\. /g, '.').replace('.', '');

    if (todoList.length === 0) {
        var noTodoMessage = document.createElement('p');
        noTodoMessage.textContent = formattedDate + '에는 할 일이 없습니다.';
        todoListContainer.appendChild(noTodoMessage);
    } else {
        todoList.forEach(function(todo) {
            console.log("Processing todo item:", todo);
            var todoItem = document.createElement('div');
            todoItem.className = 'todo-item';
            
            var dueDate = todo.dueDate || 'No date';
            var roomTitle = todo.roomTitle || 'No title';
            var stageStatus = todo.stageStatus || 'No status';
            var roomId = todo.roomId || '';
            var stageId = todo.stageId || '';
            
            todoItem.innerHTML = 
                '<p class="todo-date">' + dueDate + '</p>' +
                '<p class="todo-content">' + roomTitle + ' - ' + stageStatus + '</p>';
            
            // 클릭 이벤트 추가
            todoItem.style.cursor = 'pointer'; // 커서 스타일 변경
            todoItem.onclick = function() {
                window.location.href = './roomDetail?roomId=' + roomId + '&stage=' + stageId;
            };
            
            todoListContainer.appendChild(todoItem);
            console.log("Added todo item to container:", todoItem.outerHTML);
        });
    }

    console.log("Final todo list container:", todoListContainer.innerHTML);
}
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        height: '100%',
        aspectRatio: 1,
        headerToolbar: {
            left: 'prev',
            center: 'title',
            right: 'next'
        },
        dateClick: function(info) {
            // 이전에 선택된 날짜의 클래스 제거
            var prevSelected = document.querySelector('.fc-day-selected');
            if (prevSelected) {
                prevSelected.classList.remove('fc-day-selected');
            }
            
            // 클릭된 날짜에 선택 클래스 추가
            info.dayEl.classList.add('fc-day-selected');
            
            // 선택된 날짜의 todo 리스트 가져오기
            getTodoList(info.dateStr);
        }
    });
    calendar.render();

    // 초기 로드 시 오늘 날짜의 todo 리스트 가져오기
    getTodoList('today');
});
//Guide 섹션 스크롤 효과
document.addEventListener('DOMContentLoaded', function() {
    const guideItems = document.querySelectorAll('.guide-item');
    
    function checkScroll() {
        guideItems.forEach((item, index) => {
            const itemTop = item.getBoundingClientRect().top;
            const itemBottom = item.getBoundingClientRect().bottom;
            
            if (itemTop < window.innerHeight * 0.8 && itemBottom > 0) {
                setTimeout(() => {
                    item.classList.add('visible');
                }, index * 100); // 각 항목마다 약간의 지연 추가
            }
        });
    }
    
    window.addEventListener('scroll', checkScroll);
    checkScroll(); // 초기 로드 시 체크
});
document.addEventListener('DOMContentLoaded', function() {
    const fadeElements = document.querySelectorAll('.content .fade-in');
    
    function showElements() {
        fadeElements.forEach((element, index) => {
            setTimeout(() => {
                element.classList.add('visible');
            }, index * 200); // 각 요소마다 200ms 지연
        });
    }
    
    // 페이지 로드 후 약간의 지연을 두고 애니메이션 시작
    setTimeout(showElements, 100);
});
</script>
</head>
<body class="main-body">
	<%@ include file="./header.jsp"%>
	<div class="content">
<div class="fade-in">
    <img class="makeRoomImg" style="width: 100%; margin-top: 6%; caret-color: transparent;" onclick="location.href='./newIdeaRoom'"
        src="<c:url value='/resources/mainBanner.png' />" alt="no Img" />
</div>
		<div class="section-wrapper fade-in">
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
							    <c:choose>
                                    <c:when test="${li.getStageId() >= 3}">
                                        <c:set var="ideasList" value="${roomIdeasMap[li.roomId]}" />
                                        <c:if test="${not empty ideasList}">
                                            <c:set var="firstIdea" value="${ideasList[0]}" />
                                            <a href="./roomDetail?roomId=${li.getRoomId()}&stage=${li.getStageId()}&ideaId=${firstIdea.getIdeaID()}" class="room-link">
                                                <div class="room">
                                                    <h2>${li.getRoomTitle()}</h2>
                                                    <p>방장 : ${li.getRoomManagerId()}</p>
                                                    <p>종료일 : ${li.getEndDate()}</p>
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
                                                    <input type="hidden" name="ideaId" value="${firstIdea.getIdeaID()}" />
                                                </div>
                                            </a>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="./roomDetail?roomId=${li.getRoomId()}&stage=${li.getStageId()}" class="room-link">
                                            <div class="room">
                                                <h2>${li.getRoomTitle()}</h2>
                                                <p>방장 : ${li.getRoomManagerId()}</p>
                                                <p>종료일 : ${li.getEndDate()}</p>
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
                                    </c:otherwise>
                                </c:choose>
							</c:forEach>

						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div class="notifications-reports-wrapper fade-in">

			<!-- 알림함 -->
			<div class="section-wrapper" style="width: 37%;">
				<div class="section-header">
					<div class="section-title">📥알림함</div>
					<button class="more-button"
						onclick="location.href='<c:url value="/noticeList"/>';">+
						더보기</button>
				</div>
				<div class="notifications">
					<c:forEach var="notification" items="${notifications}" begin="0"
						end="3">
						<div class="notification ${notification.read ? 'read' : 'unread'}"
							onclick="location.href='<c:url value="/noticeList"/>';">
							<h4 class="notiRoomTitle">
								Title : ${notification.roomTitle}
								</h3>
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
			<!-- 오늘할일 -->
			<div class="section-wrapper" style="width: 60%;">
				<div class="section-header">
					<div class="section-title">🗓️오늘의 할일</div>
				</div>
				<div class="todo-wrapper">
					<div class="calendar">
						<div id="calendar"></div>
					</div>
					<div class="todo-list">
						<!-- Todo 리스트가 여기에 동적으로 추가됩니다 -->
					</div>
				</div>
			</div>
		</div>
		
		<!-- 3번째 줄 -->
		<div class="best-sections-wrapper fade-in">
		    <div class="best-section">
		        <div class="section-header">
		            <div class="section-title">🏆 베스트 직원</div>
		        </div>
		        <div class="best-content">
				    <c:forEach var="employee" items="${bestEmployees}" varStatus="status">
				        <div class="best-item">
				            <div class="profile-container">
				            	<c:url var="profileImgUrl" value="/upload/${employee.profileImg}" />
               					<img src="${profileImgUrl}" alt="${employee.userName}" class="profile-image">
				                
				                <c:choose>
				                    <c:when test="${status.index == 0}">
				                        <img src="<c:url value='/resources/gold-medal.png' />" alt="금메달" class="medal">
				                    </c:when>
				                    <c:when test="${status.index == 1}">
				                        <img src="<c:url value='/resources/silver-medal.png' />" alt="은메달" class="medal">
				                    </c:when>
				                    <c:otherwise>
				                        <img src="<c:url value='/resources/bronze-medal.png' />" alt="동메달" class="medal">
				                    </c:otherwise>
				                </c:choose>
				                
				            </div>
				            <p class="best-name">${employee.userName}</p>
				            <p class="best-description">기여도: ${employee.totalContribution}</p>
				        </div>
				    </c:forEach>
				</div>
		    </div>
		    <div class="best-section">
			    <div class="section-header">
			        <div class="section-title">📈 베스트 사용량</div>
			    </div>
			    <div class="best-content">
			        <c:forEach var="usage" items="${bestUsage}" varStatus="status">
			            <div class="best-item">
			                <div class="profile-container">
			                    <img src="<c:url value='/resources/department${status.index + 1}.png' />" alt="${usage.departmentName}" class="profile-image">
			                </div>
			                <p class="best-name">${usage.departmentName}</p>
			                <p class="best-description">사용 횟수: ${usage.departmentCount}</p>
			            </div>
			        </c:forEach>
			    </div>
			</div>
		    <div class="best-section">
		        <div class="section-header">
		            <div class="section-title">👥 베스트 팀</div>
		        </div>
		        <%-- <div class="best-content">
		            <div class="best-item">
		                <img src="<c:url value='/resources/team1.png' />" alt="1등 팀" class="profile-image">
		                <p class="best-name">혁신팀</p>
		                <p class="best-description">최고 성과</p>
		            </div>
		            <div class="best-item">
		                <img src="<c:url value='/resources/team2.png' />" alt="2등 팀" class="profile-image">
		                <p class="best-name">기획팀</p>
		                <p class="best-description">창의적 기획</p>
		            </div>
		            <div class="best-item">
		                <img src="<c:url value='/resources/team3.png' />" alt="3등 팀" class="profile-image">
		                <p class="best-name">개발팀</p>
		                <p class="best-description">빠른 실행력</p>
		            </div>
		        </div> --%>
		    </div>
		</div>
				
		
		<!-- 팝업창 추가 -->
			<div class="popup-overlay">
			    <div class="popup">
			        <div class="delete"></div>
			        <img id="popup-image" src="" style="display: none; width: 180px; height: 150px;">
			        <p class="popup-message"></p>
			        <div class="popup-buttons">
			        	<a href="./noticeList" class="yellow-button">알림함 바로가기</a>
			            <button class="grey-button">오늘 하루 보지 않기</button>
			        </div>
			    </div>
			</div>
	</div>
<!-- Guide 섹션 추가 -->

        <section id="guide-section">
       
            <div id="guide-container">
             <h1 style="font-size: 30pt;">👣Guide</h1>
                <div class="guide-item">
                    <div class="guide-image-container">
                        <img src="./resources/Component1.png" alt="의견 보장" class="guide-image">
                    </div>
                    <div class="guide-text">
                        <h2>자유롭게 아이디어를 나눠요!</h2>
                        <p>익명등록으로 편한 분위기로 아이디어를 낼수 있어요.</p>
                        <p>AI질문으로 내 생각을 보다 쉽게 정리해요.</p>
                    </div>
                </div>
                
                <div class="guide-item">
                    <div class="guide-image-container">
                        <img src="./resources/Component2.png" alt="의견 모아" class="guide-image">
                    </div>
                    <div class="guide-text">
                        <h2>모두의 의견을 모아 2개의 아이디어를 골라요!</h2>
                        <p>익명 투표를 진행해 제일 표를 많이 받은</p>
                        <p>2개의 아이디어를 뽑아 회의를 진행할 수 있어요.</p>
                    </div>
                </div>
<div class="guide-item">
			<div class="guide-image-container">
				<img src="./resources/Component3.png" alt="가이드" class="guide-image">
			</div>
			<div class="guide-text">
				<h2>다양한 방향에서 아이디어를 확장시켜봐요!</h2>
				<p>똑똑이, 긍정이, 걱정이, 깐깐이</p>
				<p>4가지 관점에서 아이디어에 대한 의견을 작성해요.</p>
			</div>
		</div>

		<div class="guide-item">
			<div class="guide-image-container">
				<img src="./resources/Component4.png" alt="의견 모아"
					class="guide-image">
			</div>
			<div class="guide-text">
				<h2>관점별 의견들을 모아 피드백을 진행해요!</h2>
				<p>관점별로 모인 의견들을</p>
				<p>피드백을 통해 아이디어를 구체화해요.</p>
			</div>
		</div>

		<div class="guide-item">
			<div class="guide-image-container">
				<img src="./resources/Component5.png" alt="최고의 의견"
					class="guide-image">
			</div>
			<div class="guide-text">
				<h2>'❤️좋아요'가 보여주는 최고의 의견을 확인해봐요!</h2>
				<p>가장 좋은 의견에 한표!</p>
				<p>팀원들이 생각하는 가장 좋은 의견을 확인할 수 있어요.</p>
			</div>
		</div>

		<div class="guide-item">
			<div class="guide-image-container">
				<img src="./resources/Component6.png" alt="의견 나눔"
					class="guide-image">
			</div>
			<div class="guide-text">
				<h2>다양한 추가기능!</h2>
				<p>A/B테스트, 추가 투표, 핀메모를 이용해</p>
				<p>회의뿐 아니라 간단한 의견 종합부터 피드백까지</p>
				<p>추가논의를 진행할 수 있어요.</p>
			</div>
		</div>

		<div class="guide-item">
			<div class="guide-image-container">
				<img src="./resources/Component7.png" alt="최종보고서"
					class="guide-image">
			</div>
			<div class="guide-text">
				<h2>THINKB와 함께 최종보고서 작성까지!</h2>
				<p>최종보고서 작성도 어렵지 않아요.</p>
				<p>논의가 완료되면 지금까지 알맞에 정리된 의견들과</p>
				<p>함께 제공되는 양식에 맞춰 최종보고서를 작성할 수 있어요.</p>
			</div>
		</div>
            </div>
        </section>
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
	    	$('#popup-image').attr('src', './resources/Alarm.png').show(); // 이미지 URL 설정
	        $('.popup-message').text("읽지 않은 알림이 " + unreadCount + "개 있어요!");
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
