<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>thinKB - 회의방 만들기</title>
<style>
.content-banner {
	margin-top: 50px; /* content 영역의 여백 설정 */
	margin-left: 15%;
	margin-right: 15%;
	margin-bottom: 30px;
}

.content {
	padding: 20px; /* content 영역의 여백 설정 */
	margin-left: 20%;
	margin-right: 20%;
}

.title {
	font-size: 18pt;
	font-weight: bold;
	color: black;
	margin-top: 30px;
	margin-bottom: 20px;
}


.date-input-container {
	display: flex;
	align-items: center;
	width: 100%;
	max-width: 600px; /* 전체 컨테이너의 최대 너비를 늘림 */
	position: relative;
}

.date-input-wrapper {
	display: flex;
	align-items: center;
	width: 200px; /* 날짜 입력칸의 너비를 고정 */
	margin-right: 10px; /* 오른쪽 여백 추가 */
}

.date-input {
	width: 100%; /* 부모 요소의 전체 너비를 차지하도록 설정 */
	padding: 12px;
	border: 3px solid lightgrey;
	border-radius: 20px;
	font-size: 15pt;
	box-sizing: border-box;
}

.date-input:focus {
	border-color: #FFD700; /* 포커스 시 테두리 색상 */
	outline: none; /* 기본 포커스 스타일 제거 */
}

.new-subject {
	font-size: 15pt; /* 제목의 글자 크기 */
	color: black;
	border: 3px solid #FFD700; /* 진한 노란색 테두리 */
	border-radius: 20px; /* 라운드 처리 */
	padding: 20px; /* 내부 여백 */
	background-color: white; /* 배경색 */
}

input.new-subject {
	font-size: 13pt;
	color: black;
	border: 3px solid lightgrey;
	border-radius: 10px;
	padding: 20px;
	width: 100%;
	box-sizing: border-box;
}

input.new-subject:focus {
	border-color: #FFD700; /* 포커스 시 테두리 색상 */
	outline: none; /* 기본 포커스 스타일 제거 */
}
textarea.new-subject {
	font-size: 13pt;
	color: black;
	border: 3px solid lightgrey;
	border-radius: 10px;
	padding: 20px;
	width: 100%;
	box-sizing: border-box;
}

textarea.new-subject:focus {
	border-color: #FFD700; /* 포커스 시 테두리 색상 */
	outline: none; /* 기본 포커스 스타일 제거 */
}

.calendar-icon {
	font-size: 24px;
	margin-left: 10px;
	cursor: pointer;
}

.error-message-container {
	flex: 1; /* 남은 공간을 모두 차지하도록 설정 */
	white-space: nowrap; /* 텍스트가 줄바꿈되지 않도록 설정 */
	overflow: hidden; /* 내용이 넘칠 경우 숨김 */
	text-overflow: ellipsis; /* 내용이 넘칠 경우 ... 표시 */
}

.error-message {
	color: red;
	font-size: 0.9em;
}

.calendar-popup {
	position: absolute;
	top: 100%;
	left: 0;
	z-index: 1000;
	background-color: #fff;
	border: 1px solid #ccc;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	display: none;
}

/* 기존의 calendar-popup 관련 스타일들... */
.calendar-popup table {
	width: 100%;
	border-collapse: collapse;
}

.calendar-popup th, .calendar-popup td {
	padding: 8px;
	text-align: center;
	border: 1px solid #ccc;
}

.calendar-popup th {
	background-color: #f0f0f0;
}

.calendar-popup .selected {
	background-color: #ffcc00;
}

.calendar-nav {
	display: flex;
	justify-content: space-between;
	padding: 0 10px;
	margin-bottom: 10px;
}

.calendar-nav span {
	cursor: pointer;
}

.calendar-popup .disabled {
	background-color: #f2f2f2; /* 회색 배경색 */
	color: #ccc; /* 텍스트 색상 */
	cursor: not-allowed; /* 커서 모양 변경 */
}

.timer-container {
	margin-top: 30px;
	display: flex;
	align-items: center;
}

.timer-label {
	margin-right: 10px;
	font-size: 20px;
	font-weight: bold;
}

.timer-input {
	width: 60px;
	padding: 8px;
	border: 3px solid lightgrey;
	border-radius: 10px;
	font-size: 16px;
	text-align: center;
}

.timer-input:hover {
	border-color: #ffcc00;
}

.yellow-button1 {
	background-color: #e6b800; /* 진한 노란색 배경색 */
	color: black; /* 텍스트 색상 */
	padding: 10px 40px; /* 버튼의 여백 */
	border: none; /* 테두리 없음 */
	border-radius: 20px; /* 라운드 처리 */
	font-size: 20px; /* 텍스트 크기 */
	cursor: pointer; /* 마우스 커서를 포인터로 변경 */
	font-weight: bold;
}

.container {
	margin: 20px;
}

.btn {
	display: inline-block;
	padding: 10px 20px;
	font-size: 16px;
	color: black;
	background-color: #e6b800;
	border: none;
	border-radius: 10px;
	cursor: pointer;
}

.btn:hover {
	background-color: #696969;
	color: white;
}

body.modal-open {
    overflow: hidden;
}

.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow-y: auto;
    background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
    background-color: #fefefe;
    margin: 5% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 600px;
    border-radius: 10px;
    position: relative;
    max-height: 80vh;
    overflow-y: auto;
}

.modal-header {
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.modal-body {
    flex-grow: 1;
    overflow-y: auto; /* 내용이 넘칠 경우 스크롤 추가 */
}

.table-container {
    max-height: 350px; /* 약 7명의 직원이 표시될 수 있는 높이 */
    overflow-y: auto;
}

.table {
    width: 100%;
    border-collapse: collapse;
}

.table th {
    position: sticky;
    top: 0;
    background-color: #f8f8f8;
    z-index: 10;
}

.table td, .table th {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

.modal-footer {
    padding-top: 20px;
    margin-top: 20px;
    text-align: center;
}

/* 기존 스타일 유지 */
.close {
    color: #aaa;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
    position: absolute;
    top: 10px;
    right: 20px;
    z-index: 1;  /* 추가: 다른 요소 위에 표시되도록 함 */
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}

.modal-header h5 {
    font-size: 18pt;
    font-weight: bold;
    margin: 0;
}

.table {
	width: 100%;
	border-collapse: collapse;
	margin: 20px 0;
}

.table th, .table td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

.btn-secondary, .btn-primary {
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
}

.btn-secondary {
	background-color: gray;
	color: white;
}

.btn-primary {
	background-color: blue;
	color: white;
}

.btn-secondary:hover {
	background-color: darkgray;
}

.btn-primary:hover {
	background-color: darkblue;
}

.error-message {
	color: red;
	margin-left: 10px;
	font-size: 0.9em;
}
.titleAndDetail {
	display: flex; 
	justify-content: space-between; 
	align-items: center; 
	margin-bottom: 10px;
}
.titleAndDetail-title {
	margin: 0;
	font-size: 18pt;
	color: black;
	font-weight: bold;
}
.titleAndDetail-detail {
	font-size: 13pt;
}

.userList {
    display: flex; 
    align-items: center; 
    margin-bottom: 10px;
    justify-content: space-between; /* 추가 */
}

.userList-left {
    display: flex;
    align-items: center;
}

.userList-title {
    margin: 0;
    font-size: 18pt;
    color: black;
    font-weight: bold;
    margin-right: 20px;
}

.userList-detail {
    font-size: 13pt;
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
}

.yellow-button:hover {
	background-color: #D4AA00;
}

/* 회색버튼 */
.grey-button {
	background-color: #978A8F;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	cursor: pointer;
	font-weight: bold;
}

.grey-button:hover {
	background-color: #60584C;
}

</style>
</head>
<body>
<!-- 헤더영역 -->
	<div>
		<%@ include file="../header.jsp"%>
	</div>
	
<!-- 상단 배너영역 -->
	<div class="content-banner">
		<img src="<c:url value='./resources/newRoomBanner.png'/>" alt="newRoomBanner" 
		style="max-width: 100%; height: auto;">
	</div>

	<div class="content">
	<!-- 아이디어 회의 제목 -->
		<form action="./makeRoom" method="post"
			onsubmit="return validateForm()">
			<input type="hidden" name="id" value="${userId}" /> <input
				type="hidden" name="departmentId" value="${departmentId}" /> <input
				type="hidden" name="teamId" value="${teamId}" />

			<div class="titleAndDetail">
				<div class="titleAndDetail-title">아이디어 회의 주제</div>
				<div class="titleAndDetail-detail">구체화 하고싶은 주제를 입력해주세요. </div>
			</div>
			<input type="text" class="new-subject" name="title" style="margin-bottom: 50px;"
				placeholder="여기에 작성해주세요">

	<!-- 아이디어 회의 상세설명 -->
			<div class="titleAndDetail">
				<div class="titleAndDetail-title">아이디어 회의 상세설명</div><button type="button" id="autoCompleteBtn" class="yellow-button">자동완성</button>
				<div class="titleAndDetail-detail">회의 주제에 대한 상세한 설명을 입력해주세요. ex) 참고할 수 있는 관련문서, 보고서 등</div>
			</div>
<textarea id="content" class="new-subject" style="height: 400px; width: 100%; resize: vertical;" name="content" placeholder="여기에 작성해주세요"></textarea>
	<!-- 회의종료일 -->
			<div class="title" style="margin-top: 70px;">회의 종료일</div>
			<div class="date-input-container">
				<div class="date-input-wrapper">
					<input type="text" class="date-input" name="endDate"
						id="datepicker" placeholder="YYYYMMDD"> <span
						class="calendar-icon" onclick="toggleCalendar()">📅</span>
				</div>
				<div class="error-message-container">
					<span class="error-message" id="endDateError"></span>
				</div>

				<div class="calendar-popup" id="calendarPopup">
					<div class="calendar-nav">
						<span onclick="prevMonth()">&lt;</span> <span id="calendarMonth"></span>
						<span id="calendarYear"></span> <span onclick="nextMonth()">&gt;</span>
					</div>
					<table id="calendarTable">
						<thead>
							<tr>
								<th>일</th>
								<th>월</th>
								<th>화</th>
								<th>수</th>
								<th>목</th>
								<th>금</th>
								<th>토</th>
							</tr>
						</thead>
						<tbody id="calendarBody">
						</tbody>
					</table>
				</div>
			</div>
			
	<!-- 타이머 설정 -->
			<div style="padding: 30px;"></div>
			<div class="titleAndDetail">
				<div class="titleAndDetail-title">타이머 설정</div>
				<div class="titleAndDetail-detail">아이디어 초안을 받을 수 있는 시간을 정해주세요.</div>
			</div>
			<div>
				<input type="number" class="timer-input" name="timer_hours" min="0"
					max="23" placeholder="HH">&nbsp;시&nbsp;&nbsp;&nbsp; <input
					type="number" class="timer-input" name="timer_minutes" min="0"
					max="59" placeholder="MM">&nbsp;분&nbsp;&nbsp;&nbsp; <input
					type="number" class="timer-input" name="timer_seconds" min="0"
					max="59" placeholder="SS">&nbsp;초&nbsp;&nbsp;&nbsp; <span
					class="error-message" id="timerError"></span>
			</div>
			
	<!-- 참여자 선택  -->
		<div style="padding: 30px;"></div>
			<div class="userList">
				<div class="userList-left">
					<div class="userList-title">참여자 선택</div>
					<div class="grey-button" id="openModalBtn">직원 목록 조회</div>
				</div>
				<div class="userList-detail">함께 아이디어 회의를 진행할 직원을 목록에서 선택해주세요.</div>
			</div>

			<div id="selectedEmployees">
				<!-- 선택된 직원들이 여기에 표시됩니다 -->
			</div>
			<input type="hidden" id="selectedEmployeeIds" name="users">
			<div style="margin: 70px; text-align: center;">
				<button class="yellow-button" type="submit">만들기</button>
			</div>
		</form>
	</div>
	
	<!-- 모달창 -->
	<!-- 직원 목록 모달 -->
<div id="employeeModal" class="modal">
    <div class="modal-content">
        <span class="close" id="closeModalBtn">&times;</span>
        <div class="modal-header">    
            <h5>참여자 선택</h5>
        </div>
        <div class="modal-body">
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>선택</th>
                            <th>이름(직원번호)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="employee" items="${list}">
                            <tr>
                                <td><input type="checkbox" name="employees"
                                    value="${employee.getUserId()}"></td>
                                <td>${employee.getUserName()}(${employee.getUserId()})</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="modal-footer">
            <button class="yellow-button" id="submitBtn" style="font-size:13pt;">선택 완료</button>
        </div>
    </div>
</div>

	<script>
		// 달력 팝업 열고 닫기 함수
		function toggleCalendar() {
			var calendarPopup = document.getElementById("calendarPopup");
			if (calendarPopup.style.display === "block") {
				calendarPopup.style.display = "none";
			} else {
				calendarPopup.style.display = "block";
			}
		}

		// 이전 달 표시 함수
		function prevMonth() {
			currentMonth--;
			if (currentMonth < 0) {
				currentMonth = 11;
				currentYear--;
			}
			createCalendar();
		}

		// 다음 달 표시 함수
		function nextMonth() {
			currentMonth++;
			if (currentMonth > 11) {
				currentMonth = 0;
				currentYear++;
			}
			createCalendar();
		}

		var currentYear;
		var currentMonth;

		function createCalendar() {
			var now = new Date();
			if (currentYear === undefined || currentMonth === undefined) {
				currentYear = now.getFullYear();
				currentMonth = now.getMonth();
			}

			var firstDay = new Date(currentYear, currentMonth, 1);
			var lastDay = new Date(currentYear, currentMonth + 1, 0);
			var startDay = firstDay.getDay(); // 월의 첫째 날의 요일 (0: 일요일, 1: 월요일, ..., 6: 토요일)
			var totalDays = lastDay.getDate(); // 월의 총 날짜 수

			var calendarBody = document.getElementById("calendarBody");
			calendarBody.innerHTML = ""; // 기존 콘텐츠 초기화

			var date = 1;
			// 행을 생성하여 달력 날짜 채우기
			for (var i = 0; i < 6; i++) {
				var row = document.createElement("tr");
				for (var j = 0; j < 7; j++) {
					if (i === 0 && j < startDay) {
						// 첫 주에서 시작일 이전의 빈 셀 채우기
						var cell = document.createElement("td");
						row.appendChild(cell);
					} else if (date > totalDays) {
						// 날짜가 초과하면 빈 셀 채우기
						break;
					} else {
						// 정상적인 날짜 셀 생성
						var cell = document.createElement("td");
						cell.textContent = date;
						cell.onclick = function() {
							selectDate(this);
						};

						// 오늘 이후의 날짜만 선택 가능하도록 설정
						var currentDate = new Date();
						if (currentYear > currentDate.getFullYear()
								|| (currentYear === currentDate.getFullYear() && currentMonth > currentDate
										.getMonth())
								|| (currentYear === currentDate.getFullYear()
										&& currentMonth === currentDate
												.getMonth() && date >= currentDate
										.getDate())) {
							cell.classList.add('selectable');
						} else {
							cell.classList.add('disabled');
						}

						row.appendChild(cell);
						date++;
					}
				}
				calendarBody.appendChild(row);
			}

			// 달력 상단에 년도와 월 표시
			document.getElementById("calendarMonth").textContent = (currentMonth + 1)
					+ "월";
			document.getElementById("calendarYear").textContent = currentYear;
		}

		// 날짜 선택 함수
		function selectDate(cell) {
			if (!cell.classList.contains('selectable')) {
				return; // 선택 불가능한 날짜는 무시
			}

			var selectedDate = cell.textContent;
			var selectedMonth = document.getElementById("calendarMonth").textContent
					.replace("월", "");
			var selectedYear = document.getElementById("calendarYear").textContent;
			var datepicker = document.getElementById("datepicker");
			datepicker.value = selectedYear + selectedMonth.padStart(2, '0')
					+ selectedDate.padStart(2, '0');
			document.getElementById("calendarPopup").style.display = "none";

			// 오류 메시지 제거
			clearError(datepicker);
		}

		// 페이지 로드 시 초기 달력 생성
		window.onload = function() {
			createCalendar();
		};

		// 모달창 시작
		// 모달 창 열기 함수
		function openModal() {
		    var modal = document.getElementById('employeeModal');
		    modal.style.display = 'block';
		    document.body.classList.add('modal-open');
		    addEmployeeCheckboxListeners();
		}

		//모달 창 닫기 함수
		function closeModal() {
		    var modal = document.getElementById('employeeModal');
		    modal.style.display = 'none';
		    document.body.classList.remove('modal-open');
		}

		//모달 닫기 버튼 클릭 이벤트 핸들러
		document.getElementById('closeModalBtn').addEventListener('click',
				function() {
					closeModal();
				});

		// 모달 열기 버튼 클릭 이벤트 핸들러
		document.getElementById('openModalBtn').addEventListener('click',
				function() {
					openModal();
				});

		//모달 외부 영역 클릭 시 모달 닫기
		window.onclick = function(event) {
			var modal = document.getElementById('employeeModal');
			if (event.target == modal) {
				closeModal();
			}
		};

		//?
		// 선택된 직원들을 저장할 배열
		var selectedEmployees = [];

		//직원 선택 처리 함수
		function toggleEmployeeSelection(employeeId, employeeName) {
			var index = selectedEmployees.findIndex(function(emp) {
				return emp.id === employeeId;
			});

			if (index === -1) {
				// 직원이 선택되지 않았으면 배열에 추가
				selectedEmployees.push({
					id : employeeId,
					name : employeeName
				});
			} else {
				// 이미 선택된 직원이면 배열에서 제거
				selectedEmployees.splice(index, 1);
			}

			updateSelectedEmployeesDisplay();
			updateHiddenInput();
		}

		//선택된 직원 목록을 화면에 업데이트하는 함수
		function updateSelectedEmployeesDisplay() {
			var selectedEmployeesDiv = document
					.getElementById('selectedEmployees');
			selectedEmployeesDiv.innerHTML = '';

			if (selectedEmployees.length > 0) {
				var ul = document.createElement('ul');
				selectedEmployees.forEach(function(emp) {
					var li = document.createElement('li');
					li.textContent = emp.name + ' (' + emp.id + ')';
					ul.appendChild(li);
				});
				selectedEmployeesDiv.appendChild(ul);
			}
		}

		//hidden input 업데이트 함수
		function updateHiddenInput() {
			var hiddenInput = document.getElementById('selectedEmployeeIds');
			hiddenInput.value = selectedEmployees.map(function(emp) {
				return emp.id;
			}).join(',');
		}

		//직원 선택 체크박스에 대한 이벤트 리스너
		function addEmployeeCheckboxListeners() {
			document
					.querySelectorAll('input[name="employees"]')
					.forEach(
							function(checkbox) {
								checkbox
										.addEventListener(
												'change',
												function() {
													var employeeId = this.value;
													var employeeName = this.parentElement.nextElementSibling.textContent
															.trim();
													toggleEmployeeSelection(
															employeeId,
															employeeName);
												});
							});
		}

		//선택된 직원들의 ID를 담을 배열
		var selectedEmployeeIds = [];

		// 직원 선택 처리 함수 (employeeId 추가)
		function toggleEmployeeSelection(employeeId, employeeName) {
			var index = selectedEmployeeIds.indexOf(employeeId);

			if (index === -1) {
				// 선택되지 않은 경우 배열에 추가
				selectedEmployeeIds.push(employeeId);
			} else {
				// 이미 선택된 경우 배열에서 제거
				selectedEmployeeIds.splice(index, 1);
			}

			updateSelectedEmployeesDisplay();
			updateHiddenInput();
		}

		// 선택된 직원 목록을 화면에 업데이트하는 함수
		function updateSelectedEmployeesDisplay() {
			var selectedEmployeesDiv = document
					.getElementById('selectedEmployees');
			selectedEmployeesDiv.innerHTML = '';

			if (selectedEmployeeIds.length > 0) {
				var ul = document.createElement('ul');
				selectedEmployeeIds.forEach(function(employeeId) {
					var li = document.createElement('li');
					li.textContent = employeeId;
					ul.appendChild(li);
				});
				selectedEmployeesDiv.appendChild(ul);
			}
		}

		// hidden input 업데이트 함수
		function updateHiddenInput() {
			var hiddenInput = document.getElementById('selectedEmployeeIds');
			hiddenInput.value = selectedEmployeeIds.join(',');
		}

		// 유효성 검사 함수 (수정됨)
		function validateForm() {
			let isValid = true;

			const titleInput = document.querySelector('input[name="title"]');
			const contentInput = document
					.querySelector('input[name="content"]');
			const endDateInput = document
					.querySelector('input[name="endDate"]');
			const selectedEmployeeIdsInput = document
					.getElementById('selectedEmployeeIds');

			const timerHours = document
					.querySelector('input[name="timer_hours"]');
			const timerMinutes = document
					.querySelector('input[name="timer_minutes"]');
			const timerSeconds = document
					.querySelector('input[name="timer_seconds"]');
			const timerError = document.getElementById('timerError');

			// Validate title
			if (!titleInput.value.trim()) {
				showError(titleInput, '(필수)주제를 입력해주세요');
				isValid = false;
			} else {
				clearError(titleInput);
			}

			// Validate content
			if (!contentInput.value.trim()) {
				showError(contentInput, '(필수)설명을 입력해주세요');
				isValid = false;
			} else {
				clearError(contentInput);
			}

			// Validate end date
			if (!endDateInput.value.trim()) {
				document.getElementById('endDateError').textContent = '(필수)회의 종료일을 선택해주세요';
				isValid = false;
			} else {
				document.getElementById('endDateError').textContent = '';
			}

			// Validate selected employees
			if (!selectedEmployeeIdsInput.value.trim()) {
				showError(selectedEmployeeIdsInput, '(필수)참여할 직원을 선택해주세요');
				isValid = false;
			} else {
				clearError(selectedEmployeeIdsInput);
			}

			//타이머검증
			if (timerHours.value.trim() === ''
					&& timerMinutes.value.trim() === ''
					&& timerSeconds.value.trim() === '') {
				timerError.textContent = '(필수)타이머를 설정해주세요';
				valid = false;
			} else {
				timerError.textContent = '';
			}

			return isValid;
		}

		// 오류 표시 함수 (새로 추가)
		function showError(input, message) {
			let errorElement = input.nextElementSibling;
			if (!errorElement
					|| !errorElement.classList.contains('error-message')) {
				errorElement = document.createElement('span');
				errorElement.classList.add('error-message');
				input.parentNode.insertBefore(errorElement, input.nextSibling);
			}
			errorElement.textContent = message;
		}

		// 오류 제거 함수 (수정됨)
		function clearError(input) {
			let errorElement;
			if (input.id === 'datepicker') {
				errorElement = document.getElementById('endDateError');
			} else if (input.id === 'selectedEmployeeIds') {
				errorElement = input.nextElementSibling;
			} else {
				errorElement = input.nextElementSibling;
			}

			if (errorElement
					&& errorElement.classList.contains('error-message')) {
				errorElement.textContent = '';
			}
		}

		// 타이머 입력 오류 제거 함수
		function clearTimerError() {
			let timerHours = document
					.querySelector('input[name="timer_hours"]').value.trim();
			let timerMinutes = document
					.querySelector('input[name="timer_minutes"]').value.trim();
			let timerSeconds = document
					.querySelector('input[name="timer_seconds"]').value.trim();
			let errorElement = document.getElementById('timerError');

			if (timerHours !== '' || timerMinutes !== '' || timerSeconds !== '') {
				if (errorElement
						&& errorElement.classList.contains('error-message')) {
					errorElement.textContent = '';
				}
			}
		}

		// 이벤트 리스너 설정 (새로 추가)
		document
				.addEventListener(
						'DOMContentLoaded',
						function() {

							// 입력 필드에 대한 이벤트 리스너 추가
							document
									.querySelectorAll(
											'input[name="title"], input[name="content"], input[name="endDate"]')
									.forEach(
											function(input) {
												input.addEventListener('input',
														function() {
															clearError(this);
														});
											});

							// 타이머 입력 필드에 대한 이벤트 리스너 추가
							document
									.querySelectorAll(
											'input[name="timer_hours"], input[name="timer_minutes"], input[name="timer_seconds"]')
									.forEach(
											function(input) {
												input.addEventListener('input',
														function() {
															clearTimerError(); // 타이머 입력 필드에 입력이 있을 때마다 호출
														});
											});

							// 직원 선택 버튼에 대한 이벤트 리스너
							document
									.getElementById('openModalBtn')
									.addEventListener(
											'click',
											function() {
												clearError(document
														.getElementById('selectedEmployeeIds'));
											});

							// 기존의 이벤트 리스너들
							document.getElementById('closeModalBtn')
									.addEventListener('click', function() {
										closeModal();
									});

							document.getElementById('openModalBtn')
									.addEventListener('click', function() {
										openModal();
									});

							document.getElementById('submitBtn')
									.addEventListener('click', function() {
										closeModal();
									});

							// datepicker에 대한 이벤트 리스너 추가
							document.getElementById('datepicker')
									.addEventListener('input', function() {
										clearError(this);
									});

							document
									.querySelectorAll('input[name="employees"]')
									.forEach(
											function(checkbox) {
												checkbox
														.addEventListener(
																'change',
																function() {
																	var employeeId = this.value;
																	var employeeName = this.parentElement.nextElementSibling.textContent
																			.trim();
																	toggleEmployeeSelection(
																			employeeId,
																			employeeName);
																});
											});

							// 페이지 로드 시 초기 달력 생성
							createCalendar();
						});

		// 모달 외부 영역 클릭 시 모달 닫기 (변경 없음)
		window.onclick = function(event) {
			var modal = document.getElementById('employeeModal');
			if (event.target == modal) {
				closeModal();
			}
		};
	</script>
<script type="text/javascript">
document.getElementById('autoCompleteBtn').addEventListener('click', function(event) {
    event.preventDefault(); // 기본 동작 방지

    var title = document.querySelector('input[name="title"]').value;
    if (title.trim() === '') {
        alert('먼저 회의 주제를 입력해주세요.');
        return;
    }

    this.disabled = true;
    this.textContent = '로딩 중...';

    // URL 인코딩을 사용하여 한글 및 특수문자 처리
    var encodedTitle = encodeURIComponent(title);

    fetch('./getAiResponse?userInput=' + encodedTitle, {
        method: 'GET'
    })
    .then(response => response.text())
    .then(data => {
        // 받은 데이터가 이미 올바르게 인코딩되어 있다고 가정
        document.getElementById('content').value = data;
        this.disabled = false;
        this.textContent = '자동완성';
    })
    .catch(error => {
        console.error('Error:', error);
        this.disabled = false;
        this.textContent = '자동완성';
        alert('AI 응답을 가져오는 데 실패했습니다.');
    });
});

// textarea에서 엔터 키 눌렀을 때 폼 제출 방지
document.getElementById('content').addEventListener('keydown', function(event) {
    if (event.key === 'Enter') {
        event.preventDefault(); // 엔터 키의 기본 동작 방지
        var cursorPosition = this.selectionStart;
        var textBeforeCursor = this.value.substring(0, cursorPosition);
        var textAfterCursor = this.value.substring(cursorPosition);
        this.value = textBeforeCursor + '\n' + textAfterCursor;
        this.selectionStart = this.selectionEnd = cursorPosition + 1;
    }
});
</script>

</body>
</html>
