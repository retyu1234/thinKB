<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<title>Home</title>
<style>
.main-body {
	margin: 0;
	padding: 0;
    font-family: KB금융 본문체 Light;
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
	font-size: 20pt;
	font-weight: bold;
	color: black;
		font-family: KB금융 제목체 Light;
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

.room-container-wrapper {
	position: relative;
	overflow: hidden;
	padding: 0 40px; /* 버튼을 위한 공간 확보 */
}

.room-slider {
	overflow: hidden;
}

.room-container {
	display: flex;
	width: 100%;
}

.room:hover {
	background-color: #e0e0e0; /* 호버 시 배경색 변경 */
}

.room-link {
	text-decoration: none;
	color: inherit;
	display: block;
}

.room-placeholder {
	flex: 0 0 calc(33.33% - 20px);
	visibility: hidden; /* 보이지 않게 설정 */
}

.notifications-reports-wrapper {
	margin-top: 3%;
	display: flex;
	gap: 3%;
	display: flex;
}

.notifications {
	flex: 1;
	background-color: white;
	padding: 20px;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.todo-wrapper {
	display: flex;
	gap: 2%;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #ffffff;
	padding: 20px;
}

.notifications p, .reports p {
	font-size: 15px;
	color: #666;
	margin-bottom: 10px;
	margin-left: 10px;
}

.notiTruncate-text {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	display: inline;
	max-width: 100%;
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
	overflow: hidden;
	transition: background-color 0.3s ease;
}

.notification.unread {
	/* background-color: #cce5ff; */ /* 읽지 않은 알림의 파란색 배경 */
	background-color: #fffde7; /* 연노랑색 */
}

.notification.unread:hover {
	background-color: #AB9A80;
}

.notification.read {
	background-color: #f0f0f0; /* 읽은 알림의 회색 배경 */
}

.notification.read:hover {
	background-color: #e0e0e0;
}

.notification-time {
	font-weight: bold;
	margin-bottom: 5px;
		font-family: KB금융 제목체 Light;
}

.notification-content {
	margin: 5px 0 0 0;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.notiRoomTitle {
	margin: 0;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
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
.footer-content {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    max-width: 1200px;
    margin: 0 auto;
}

.footer-section {
    flex: 1;
    margin: 0 15px;
    min-width: 200px;
}

.footer-section h4 {
    color: #333;
    font-size: 18px;
    margin-bottom: 15px;
}

.footer-section p {
    color: #666;
    font-size: 14px;
    line-height: 1.6;
}

.social-icons {
    display: flex;
    justify-content:center;
    gap: 10px;
}

.social-icon {
    color: #fff;
    background-color: #D9D9D9;
    width: 36px;
    height: 36px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    transition: background-color 0.3s;
}

.social-icon:hover {
    background-color: #BCBCBC;
}

.footer hr {
    border: none;
    border-top: 1px solid #ddd;
    margin: 20px 0;
}

.footer-bottom {
    text-align: center;
    color: #666;
    font-size: 14px;
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
	height: 490px;
}

.calendar {
	flex: 1;
	max-width: 50%;
	height: 490px;
}

.todo-list-container {
	flex: 1;
	display: flex;
	flex-direction: column;
	max-height: 400px;
	overflow-y: auto;
}

.selected-date {
	font-size: 18px;
	margin-bottom: 15px;
	padding-bottom: 5px;
	border-bottom: 2px solid #e0e0e0;
}

.todo-list {
	list-style-type: none;
	padding: 0;
	margin: 0;
}

.todo-item {
	padding: 10px 15px;
	border-bottom: 1px solid #e0e0e0; /* 항목 간 구분선 */
	transition: background-color 0.3s ease;
	display: flex;
	flex-direction: column;
}

.todo-item h4 {
	margin-top: 0;
	margin-bottom: 0;
}

.todo-item p {
	margin-bottom: 0;
}

.todo-item:last-child {
	border-bottom: none; /* 마지막 항목의 하단 구분선 제거 */
}

.todo-item:hover {
	background-color: #f9f9f9; /* 호버 시 배경색 변경 */
}

.todo-item.completed {
	background-color: #f0f0f0; /* 완료된 항목 배경색 */
	text-decoration: line-through; /* 완료된 항목에 취소선 추가 */
}

.todo-date {
	font-weight: bold;
	margin-bottom: 5px;
		font-family: KB금융 제목체 Light;
}

.fc-event {
	border: none;
	border-radius: 3px;
	padding: 2px 5px;
}

.todo-content {
	margin: 0;
}

.no-todos {
	text-align: center;
	color: #888;
	font-style: italic;
	padding: 20px;
	background-color: #f9f9f9;
	border-radius: 8px;
}

.fc-day-other .fc-daygrid-day-number {
	opacity: 0.5;
}

.fc-daygrid-day-number {
	font-weight: bold;
	color: #495057;
		font-family: KB금융 제목체 Light;
}

.fc-scrollgrid-sync-table {
	height: 100% !important;
}

.fc-daygrid-body {
	height: auto !important;
}

.fc-daygrid-body table {
	height: 100% !important;
}

.fc .fc-daygrid-body-unbalanced .fc-daygrid-day-events {
	position: relative !important;
	min-height: 0 !important;
}

.fc-daygrid-day-frame {
	height: 100% !important;
	min-height: auto !important;
}

.fc-button-primary {
	background-color: transparent !important;
	border: none !important;
	box-shadow: none !important;
	color: #ffffff !important; /* 아이콘 색상 */
	font-weight: bold;
	font-size: 25pt;
	transition: all 0.3s ease;
		font-family: KB금융 제목체 Light;
}

.fc-button-primary:hover {
	background-color: transparent !important;
	border: none !important;
	transform: scale(1.2); /* 호버 시 아이콘 크기 20% 증가 */
}

.fc-day-header {
	font-weight: bold;
	text-transform: uppercase;
	padding: 10px 0 !important;
	background-color: #f1f3f5;
		font-family: KB금융 제목체 Light;
}

.fc-day {
	transition: background-color 0.3s ease;
}

.fc-day:hover {
	background-color: #f8f9fa;
}

#calendar {
	height: 100%;
	max-height: 490px; /* 부모 요소의 높이에 맞춤 */
}

.fc-daygrid-day {
	height: 76px;
	!
	important; /* 일자별 높이 조정 */
}

.fc-header-toolbar {
	background-color: #978A8F;
	padding: 15px;
}

.fc-toolbar-title {
	font-size: 1.1em !important;
	font-weight: bold;
	color: #ffffff;
		font-family: KB금융 제목체 Light;
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

.fc {
    font-family: KB금융 본문체 Light;
	background-color: #ffffff;
	border-radius: 15px;
	overflow: hidden;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
	transition: opacity 0.8s ease, transform 0.8s
		cubic-bezier(0.175, 0.885, 0.32, 1.275);
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
	aspect-ratio: 16/9; /* 16:9 비율 유지 */
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

@media ( max-width : 768px) {
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
	border: none;
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
	width: 100%;
	gap: 10px;
}

.button {
	display: inline-block;
	width: auto;
	min-width: 120px; /* 최소 너비 설정 */
	max-width: 80%; /* 최대 너비를 팝업의 80%로 제한 */
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	font-weight: bold;
	text-align: center;
	text-decoration: none;
	cursor: pointer;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.yellow-button {
	background-color: #FFCC00;
	color: black;
}

.yellow-button:hover {
	background-color: #D4AA00;
}

.grey-button {
	background-color: #978A8F;
	color: white;
}

.grey-button:hover {
	background-color: #60584C;
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
		font-family: KB금융 제목체 Light;
}

.best-description {
	font-size: 12px;
	color: #666;
}

.room-container {
	display: flex;
	transition: transform 0.3s ease;
}

.room-slide {
	flex: 0 0 25%;
	max-width: 25%;
	padding: 0 10px;
	box-sizing: border-box;
	display: none;
	transition: transform 0.3s ease;
}

.slider-button {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	background-color: transparent !important;
	border: none !important;
	color: black;
	font-size: 26pt;
	padding: 10px;
	cursor: pointer;
	z-index: 10;
	padding-top: 0;
}

.slider-button:hover {
	font-size: 1.5em;
}

.slider-button.prev {
	left: 10px;
}

.slider-button.next {
	right: 10px;
}

.room {
	background-color: #f0f0f0;
	padding: 20px;
	border-radius: 30px;
	height: 200px; /* 고정 높이 설정 */
	display: flex;
	flex-direction: column;
}

.room h2 {
	font-size: 18px;
	margin-bottom: 10px;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
	height: 2.6em; /* 대략 2줄의 높이 */
	line-height: 1.3em; /* 줄 간격 설정 */
}

.room-content {
	margin-top: 20px;
	flex-grow: 0.5;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	flex-grow: 0.5;
}

.room p {
	font-size: 14px;
	margin-bottom: 2px;
	margin-top: 0;
}

.no-rooms-message {
	width: 100%;
	text-align: center;
	padding: 20px;
}

.no-rooms-message img {
	width: 100px;
	height: auto;
	margin-bottom: 10px;
}

.pagination-indicators {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.pagination-indicator {
	width: 10px;
	height: 10px;
	border-radius: 50%;
	background-color: #ccc;
	margin: 0 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.pagination-indicator.active {
	background-color: #333;
}
.team-icon {
	font-size: 30px;
}

.profile-container {
	position: relative;
	width: 60px;
	height: 60px;
	margin: 0 auto 10px;
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #f8f9fa;
	border-radius: 50%;
}

.rank-number {
	position: absolute;
	top: -5px;
	left: -5px;
	width: 25px;
	height: 25px;
	background-color: #007bff;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	font-weight: bold;
	font-size: 14px;
	color: #ffffff;
		font-family: KB금융 제목체 Light;
}

.gold {
	color: #FFD700;
}

.silver {
	color: #C0C0C0;
}

.bronze {
	color: #CD7F32;
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
    // 'today'를 실제 오늘 날짜 문자열로 변환
    if (date === 'today') {
        date = new Date().toISOString().split('T')[0];
    }

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

    var todoListContainer = document.querySelector('.todo-list-container');
    var todoListElement = todoListContainer.querySelector('.todo-list');
    var selectedDateElement = todoListContainer.querySelector('.selected-date');

    // 선택된 날짜가 없으면 오늘 날짜로 설정
    if (!selectedDate) {
        selectedDate = new Date();
    } else {
        selectedDate = new Date(selectedDate);
    }

    // 선택된 날짜 업데이트
    selectedDateElement.textContent = selectedDate.toLocaleDateString('ko-KR', { 
        year: 'numeric', month: 'long', day: 'numeric' 
    });

    // 기존 리스트 내용 지우기
    todoListElement.innerHTML = '';

    if (todoList.length === 0) {
        var noTodoItem = document.createElement('li');
        noTodoItem.className = 'no-todos';
        noTodoItem.textContent = '오늘은 할일이 없습니다.';
        todoListElement.appendChild(noTodoItem);
    } else {
        todoList.forEach(function(todo) {
            var todoItem = document.createElement('li');
            todoItem.className = 'todo-item';
            
            var title = document.createElement('h4');
            title.textContent = "🚪"+todo.roomTitle;
            
            var status = document.createElement('p');
            status.textContent = "단계 : "+todo.stageStatus;
            
            todoItem.appendChild(title);
            todoItem.appendChild(status);
            
            // 클릭 이벤트 추가
            todoItem.style.cursor = 'pointer';
            todoItem.onclick = function() {
                window.location.href = './roomDetail?roomId=' + todo.roomId + '&stage=' + todo.stageId;
            };
            
            todoListElement.appendChild(todoItem);
        });
    }
}
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        height: 'auto',
        aspectRatio: 1.35,
        headerToolbar: {
            left: 'prev',
            center: 'title',
            right: 'next'
        },
        dayMaxEvents: 0,
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
<script>
document.addEventListener('DOMContentLoaded', function() {
    const slider = document.querySelector('.room-container');
    const slides = document.querySelectorAll('.room-slide');
    const prevButton = document.querySelector('.slider-button.prev');
    const nextButton = document.querySelector('.slider-button.next');
    const paginationContainer = document.querySelector('.pagination-indicators');
    
    const slidesToShow = 4; // 한 번에 보여줄 슬라이드 수
    const totalSlides = slides.length;
    const totalGroups = Math.ceil(totalSlides / slidesToShow);
    let currentIndex = 0;

    // 페이지네이션 인디케이터 생성
    for (let i = 0; i < totalGroups; i++) {
        const indicator = document.createElement('div');
        indicator.classList.add('pagination-indicator');
        indicator.addEventListener('click', () => goToSlide(i * slidesToShow));
        paginationContainer.appendChild(indicator);
    }

    function updateSliderPosition() {
        slides.forEach((slide, index) => {
            if (index >= currentIndex && index < currentIndex + slidesToShow) {
                slide.style.display = 'block';
            } else {
                slide.style.display = 'none';
            }
        });
        updatePaginationIndicators();
    }

    function updatePaginationIndicators() {
        const indicators = document.querySelectorAll('.pagination-indicator');
        const activeGroup = Math.floor(currentIndex / slidesToShow);
        indicators.forEach((indicator, index) => {
            if (index === activeGroup) {
                indicator.classList.add('active');
            } else {
                indicator.classList.remove('active');
            }
        });
    }

    function showNextSlides() {
        currentIndex = (currentIndex + slidesToShow) % totalSlides;
        updateSliderPosition();
    }

    function showPrevSlides() {
        currentIndex = (currentIndex - slidesToShow + totalSlides) % totalSlides;
        updateSliderPosition();
    }

    function goToSlide(index) {
        currentIndex = index;
        updateSliderPosition();
    }

    nextButton.addEventListener('click', showNextSlides);
    prevButton.addEventListener('click', showPrevSlides);

    // 초기 위치 설정
    updateSliderPosition();

    // 슬라이드가 4개 미만일 경우 버튼과 페이지네이션 숨기기
    if (totalSlides <= slidesToShow) {
        prevButton.style.display = 'none';
        nextButton.style.display = 'none';
        paginationContainer.style.display = 'none';
    }
});
</script>
</head>
<body class="main-body">
	<%@ include file="./header.jsp"%>
	<div class="content">
		<div class="fade-in">
			<img class="makeRoomImg"
				style="width: 100%; margin-top: 6%; caret-color: transparent;"
				onclick="location.href='./newIdeaRoom'"
				src="<c:url value='/resources/mainBBanner.png' />" alt="no Img" />
		</div>
		<div class="section-wrapper fade-in">
			<div class="section-header">
				<div class="section-title">🧷진행중인 회의방</div>
				<button class="more-button" onclick="location.href='./meetingList'">+
					더보기</button>
			</div>
			<div class="room-container-wrapper">
				<button class="slider-button prev"><img src="<c:url value='./resources/left1.png' />"style="height:40px;"/></button>
				<div class="room-slider">
					<div class="room-container">
						<c:choose>
							<c:when test="${empty roomList}">
								<div class="no-rooms-message">
									<img src="<c:url value='/resources/noContents.png' />"
										alt="no Img" />
									<p>진행중인 회의가 없습니다!</p>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach var="li" items="${roomList}" varStatus="status">
									<c:set var="bgColor" value="white" />
									<!-- 기본 배경색 -->
									<c:choose>
										<c:when test="${li.getParticipationStatus() == 0}">
											<c:set var="bgColor" value="#007aff" />
											<!-- 미참여 상태 배경색 -->
										</c:when>
										<c:when test="${li.getParticipationStatus() == 1}">
											<c:set var="bgColor" value="#9f9f9f" />
											<!-- 참여 상태 배경색 -->
										</c:when>
									</c:choose>
									<div class="room-slide">
										<c:choose>
											<c:when test="${li.getStageId() >= 3}">
												<c:set var="ideasList" value="${roomIdeasMap[li.roomId]}" />
												<c:if test="${not empty ideasList}">
													<c:set var="firstIdea" value="${ideasList[0]}" />
													<a
														href="./roomDetail?roomId=${li.getRoomId()}&stage=${li.getStageId()}&ideaId=${firstIdea.getIdeaID()}"
														class="room-link">
														<div class="room" style="">
															<c:choose>
																<c:when test="${li.getParticipationStatus() == 0}">
																	<div style="background-color: ${bgColor}; width:30%; border-radius: 30px;"><p style=" padding:3px;font-weight:bold; text-align:center;color:white; font-size:13px;">참여필요</p></div>
																	<h2>${li.getRoomTitle()}</h2>																	
																	<!-- 미참여 상태 배경색 -->
																</c:when>
																<c:when test="${li.getParticipationStatus() == 1}">
																	<div style="background-color: ${bgColor}; width:30%; border-radius: 30px;"><p style="padding:3px; font-weight:bold; text-align:center;color:white; font-size:13px;">참여완료</p></div>
																	<h2>${li.getRoomTitle()}</h2>												
																	<!-- 참여 상태 배경색 -->
																</c:when>
															</c:choose>
															<div class="room-content">
																<p>방장 :${li.getRoomManagerName()}(${li.getRoomManagerId()})</p>
																<p>종료일 : ${li.getEndDate()}</p>
																<p>
																	단계 :
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
														</div>
													</a>
												</c:if>
											</c:when>
											<c:otherwise>
												<a
													href="./roomDetail?roomId=${li.getRoomId()}&stage=${li.getStageId()}"
													class="room-link">
													<div class="room">
														<c:choose>
															<c:when test="${li.getParticipationStatus() == 0}">
															<div style="background-color: ${bgColor}; width:30%; border-radius: 30px;"><p style="padding:3px; text-align:center;color:white; font-size:13px;">참여필요</p></div>
																<h2>${li.getRoomTitle()}</h2>
																
																<!-- 미참여 상태 배경색 -->
															</c:when>
															<c:when test="${li.getParticipationStatus() == 1}">
															<div style="background-color: ${bgColor}; width:30%; border-radius: 30px;"><p style="padding:3px; text-align:center;color:white; font-size:13px;">참여완료</p></div>
																<h2>${li.getRoomTitle()}</h2>
																
																<!-- 참여 상태 배경색 -->
															</c:when>
														</c:choose>
														<div class="room-content">
															<p>방장 : ${li.getRoomManagerName()}(${li.getRoomManagerId()})</p>
															<p>종료일 : ${li.getEndDate()}</p>
															<p>
																단계 :
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
													</div>
												</a>
											</c:otherwise>
										</c:choose>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<button class="slider-button next"><img src="<c:url value='./resources/right1.png' />"style="height:40px;"/></button>
				<div class="pagination-indicators"></div>
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
									<span class="notiTruncate-text">${notification.message}</span>
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
					<div class="todo-list-container">
						<h3 class="selected-date"></h3>
						<ul class="todo-list">
							<!-- Todo 리스트 아이템들이 여기에 동적으로 추가됩니다 -->
						</ul>
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
					<c:forEach var="employee" items="${bestEmployees}"
						varStatus="status">
						<div class="best-item">
							<div class="profile-container">
								<c:url var="profileImgUrl"
									value="/upload/${employee.profileImg}" />
								<img src="${profileImgUrl}" alt="${employee.userName}"
									class="profile-image">

								<c:choose>
									<c:when test="${status.index == 0}">
										<img src="<c:url value='/resources/gold-medal.png' />"
											alt="금메달" class="medal">
									</c:when>
									<c:when test="${status.index == 1}">
										<img src="<c:url value='/resources/silver-medal.png' />"
											alt="은메달" class="medal">
									</c:when>
									<c:otherwise>
										<img src="<c:url value='/resources/bronze-medal.png' />"
											alt="동메달" class="medal">
									</c:otherwise>
								</c:choose>

							</div>
							<p class="best-name">${employee.userName}</p>
							<p class="best-description">기여도:
								${employee.totalContribution}</p>
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
								<img
									src="<c:url value='/resources/department${status.index + 1}.png' />"
									alt="${usage.teamName}" class="profile-image">
							</div>
							<p class="best-name">${usage.teamName}</p>
							<p class="best-description">사용 횟수: ${usage.teamCount}</p>
						</div>
					</c:forEach>
				</div>
			</div>
				<div class="best-section">
					<div class="section-header">
						<div class="section-title">👥 베스트 팀</div>
					</div>
					<div class="best-content">
						<c:set var="prevRank" value="0" />
						<c:set var="displayRank" value="0" />
						<c:forEach var="team" items="${bestTeams}" varStatus="status">
							<c:choose>
								<c:when test="${team.teamRank > prevRank}">
									<c:set var="displayRank" value="${team.teamRank}" />
								</c:when>
								<c:otherwise>
									<c:set var="displayRank" value="${prevRank}" />
								</c:otherwise>
							</c:choose>
							<div class="best-item">
								<div class="profile-container">
									<span class="rank-number">${displayRank}</span>
									<c:choose>
										<c:when test="${displayRank == 1}">
											<i class="fas fa-trophy team-icon gold"></i>
										</c:when>
										<c:when test="${displayRank == 2}">
											<i class="fas fa-award team-icon silver"></i>
										</c:when>
										<c:otherwise>
											<i class="fas fa-medal team-icon bronze"></i>
										</c:otherwise>
									</c:choose>
								</div>
								<p class="best-name">${team.teamName}</p>
								<p class="best-description">${team.departmentName}</p>
								<p class="best-description">
									채택률:
									<fmt:formatNumber value="${team.teamAdoptionPercentage}"
										pattern="#,##0.0" />
									%
								</p>
							</div>
							<c:set var="prevRank" value="${team.teamRank}" />
						</c:forEach>
					</div>
				</div>
		</div>


		<!-- 팝업창 추가 -->
		<div class="popup-overlay">
			<div class="popup">
				<div class="delete"></div>
				<img id="popup-image" src=""
					style="display: none; width: 180px; height: 150px;">
				<p class="popup-message"></p>
				<div class="popup-buttons">
					<a href="./noticeList" class="button yellow-button">알림함 바로가기</a>
					<button class="button grey-button">오늘 하루 보지 않기</button>
				</div>
			</div>
		</div>
	</div>
	<div style="height: 200px;"></div>

<footer class="footer">
<hr>
    <div class="footer-content">
        <div class="footer-section">
            <h4>About Us</h4>
            <p>DigiCampus 3rd FourSideOut Team은 혁신적인 디지털 솔루션을 제공합니다.</p>
        </div>
        <div class="footer-section">
            <h4>Contact</h4>
            <p>Email: contact@fourdsideout.com</p>
            <p>Phone: +82 02-1234-5678</p>
        </div>
        <div class="footer-section">
            <h4>Follow Us</h4>
            <div class="social-icons">
                <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>
    </div>
    
    <div class="footer-bottom">
        &copy; 2024 DigiCampus 3rd FourSideOut Team. All rights reserved.
    </div>
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
    $('.grey-button').click(function() {
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
