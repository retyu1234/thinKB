<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>투표 하기</title>
<style>
html, body {
    max-width: 100%;
    overflow-x: hidden;
}
.vote-body {
	font-family: Arial, sans-serif;
}

.vote-content {
	padding: 20px;
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

.calendar-icon {
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


.modal-footer {
    padding-top: 20px;
    margin-top: 20px;
    text-align: center;
}

.modal-body {
    flex-grow: 1;
    overflow-y: auto;
}

.table-container {
    max-height: 350px;
    overflow-y: auto;
}

.close {
    color: #aaa;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
    position: absolute;
    top: 10px;
    right: 20px;
    z-index: 1;
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

.search-container {
    display: flex;
    margin-bottom: 20px;
    border: 2px solid #ccc;
    border-radius: 20px;
    overflow: hidden;
}

.search-input {
    flex-grow: 1;
    padding: 10px;
    font-size: 16px;
    border: none;
    outline: none;
}

.search-button {
    padding: 10px 15px;
    font-size: 16px;
    background: none;
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
}

.search-button:hover {
    background-color: #f0f0f0;
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

.error-message {
	color: red;
	margin-left: 10px;
	font-size: 0.9em;
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

.add-option-btn {
    text-decoration: none;
    font-size: 13pt;
    font-weight: bold;
    transition: color 0.3s ease;
}

.add-option-btn:hover {
    color: black;
}

.vote-option {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
}

.vote-option-bullet {
    margin-right: 10px;
    font-size: 18px;
}

.vote-option-input {
    flex-grow: 1;
    border: none;
    border-bottom: 3px solid #ccc;
    font-size: 13pt;
    padding: 5px 0;
    background-color: transparent;
    transition: border-color 0.3s ease;
}

.vote-option-input:focus {
    outline: none;
    border-bottom-color: #FFD700;
}

.vote-option-input::placeholder {
    color: #999;
}

/* 새로 추가된 스타일 */
.date-input-and-error {
    display: flex;
    align-items: center;
    width: 100%;
}

</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="vote-body">

	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>

	<!-- 콘텐츠 시작 -->
	<div class="vote-content">
		<form action="./makeVote" method="post" onsubmit="return validateForm()">
			<input type="hidden" name="id" value="${userId}" /> <input
				type="hidden" name="departmentId" value="${departmentId}" />

			<!-- 투표 주제 -->
			<div class="titleAndDetail" style="margin-top: 50px;">
				<div class="titleAndDetail-title">투표 주제</div>
				<div class="titleAndDetail-detail">투표 하고싶은 주제를 입력해주세요.</div>
			</div>
			<input type="text" class="new-subject" name="title"
				placeholder="여기에 입력하세요">

			<div class="titleAndDetail" style="margin-top: 50px;">
				<div class="titleAndDetail-title">투표 항목</div>
				<div class="titleAndDetail-detail">선택지 추가를 통해 투표할 항목을 추가해주세요.</div>
			</div>
			<div id="optionsContainer">
			    <div class="vote-option">
			        <span class="vote-option-bullet">◾</span>
			        <input type="text" class="vote-option-input" name="optionText" placeholder="투표 항목을 입력해주세요">
			    </div>
			</div>
			<div style="text-align: center; margin-top: 20px;">
				<a href="#" class="add-option-btn"
					onclick="addOption(); return false;">➕ 선택지 추가</a>
			</div>

			<!-- 투표종료일 -->
			<div class="title" style="margin-top: 70px;">투표 종료일</div>
			<div class="date-input-container">
				<div class="date-input-and-error">
        <div class="date-input-wrapper">
            <input type="text" class="date-input" name="endDate" id="datepicker" placeholder="YYYYMMDD">
            <span class="calendar-icon" onclick="toggleCalendar()">📅</span>
        </div>
        <div class="error-message-container">
            <span class="error-message" id="endDateError"></span>
        </div>
    </div>
				
				<div class="calendar-popup" id="calendarPopup">
					<div class="calendar-nav">
						<span onclick="prevMonth()">&lt;</span> <span id="calendarYear"></span>
						<span id="calendarMonth"></span> <span onclick="nextMonth()">&gt;</span>
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
						<tbody id="calendarBody"></tbody>
					</table>
				</div>
			</div>
			
			<!-- 투표 참여자 선택 -->
			<div style="padding: 30px;"></div>
			<div class="userList">
				<div class="userList-left">
					<div class="userList-title">참여자 선택</div>
					<div class="grey-button" id="openModalBtn">직원 목록 조회</div>
				</div>
				<div class="userList-detail">함께 투표를 진행할 직원을 목록에서 선택해주세요.</div>
			</div>

			<div id="selectedEmployees"></div>
			<input type="hidden" id="selectedEmployeeIds" name="users">
			<div style="margin: 70px; text-align: center;">
				<button class="yellow-button" type="submit">만들기</button>
			</div>


		</form>


		<!-- 모달창 -->
		<!-- 직원 목록 모달 -->
		<div id="employeeModal" class="modal">
			<div class="modal-content">
				<span class="close" id="closeModalBtn">&times;</span>
				<div class="modal-header">
					<h5>참여자 선택</h5>
				</div>
				<div class="modal-body">
					<div class="search-container">
						<input type="text" id="employeeSearch"
							placeholder="직원이름, 직원번호로 검색" class="search-input">
						<button id="searchBtn" class="search-button">
							<i class="fas fa-search"></i>
						</button>
					</div>
					<div class="table-container">
						<table class="table">
							<thead>
								<tr>
									<th>선택</th>
									<th>이름(직원번호)</th>
								</tr>
							</thead>
							<tbody id="employeeTableBody">
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
					<button class="yellow-button" id="submitBtn"
						style="font-size: 13pt;">선택 완료</button>
				</div>
			</div>
		</div>
		
	</div>
	<script>
		// 투표 항목 추가하기
		function addOption() {
		    var optionsContainer = document.getElementById('optionsContainer');
		    var newOptionDiv = document.createElement('div');
		    newOptionDiv.className = 'vote-option';
		    
		    var bulletSpan = document.createElement('span');
		    bulletSpan.className = 'vote-option-bullet';
		    bulletSpan.textContent = '◾';
		    
		    var newOptionInput = document.createElement('input');
		    newOptionInput.type = 'text';
		    newOptionInput.className = 'vote-option-input';
		    newOptionInput.name = 'optionText';
		    newOptionInput.placeholder = '추가 투표 항목을 입력해주세요';
		    
		    newOptionDiv.appendChild(bulletSpan);
		    newOptionDiv.appendChild(newOptionInput);
		    optionsContainer.appendChild(newOptionDiv);
		}

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
		function openModal() {
		    var modal = document.getElementById('employeeModal');
		    modal.style.display = 'block';
		    document.body.style.overflow = 'hidden'; // 배경 스크롤 막기
		    addEmployeeCheckboxListeners();
		}
		
		function closeModal() {
		    var modal = document.getElementById('employeeModal');
		    modal.style.display = 'none';
		    document.body.style.overflow = ''; // 배경 스크롤 다시 활성화
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
		    var selectedEmployeesDiv = document.getElementById('selectedEmployees');
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

		function validateForm() {
		    let isValid = true;

		    // 투표 주제 검증
		    const titleInput = document.querySelector('input[name="title"]');
		    if (!titleInput.value.trim()) {
		        showError(titleInput, '(필수) 투표 주제를 입력해주세요');
		        isValid = false;
		    } else {
		        clearError(titleInput);
		    }

		    // 투표 항목 검증
		    const optionInputs = document.querySelectorAll('input[name="optionText"]');
		    if (optionInputs.length < 2) {
		        showError(document.getElementById('optionsContainer'), '(필수) 최소 2개의 투표 항목이 필요합니다');
		        isValid = false;
		    } else {
		        let filledOptions = 0;
		        optionInputs.forEach(input => {
		            if (input.value.trim()) {
		                filledOptions++;
		            }
		        });
		        if (filledOptions < 2) {
		            showError(document.getElementById('optionsContainer'), '(필수) 최소 2개의 투표 항목을 입력해주세요');
		            isValid = false;
		        } else {
		            clearError(document.getElementById('optionsContainer'));
		        }
		    }

		    // 투표 종료일 검증
		    const endDateInput = document.querySelector('input[name="endDate"]');
		    if (!endDateInput.value.trim()) {
		        showError(endDateInput, '(필수) 투표 종료일을 선택해주세요');
		        isValid = false;
		    } else {
		        clearError(endDateInput);
		    }

		    // 참여자 선택 검증
		    const selectedEmployeeIdsInput = document.getElementById('selectedEmployeeIds');
		    if (!selectedEmployeeIdsInput.value.trim()) {
		        showError(selectedEmployeeIdsInput, '(필수) 참여할 직원을 선택해주세요');
		        isValid = false;
		    } else {
		        clearError(selectedEmployeeIdsInput);
		    }

		    return isValid;
		}

		function showError(input, message) {
		    let errorElement;
		    if (input.id === 'datepicker') {
		        errorElement = document.getElementById('endDateError');
		    } else {
		        errorElement = input.nextElementSibling;
		        if (!errorElement || !errorElement.classList.contains('error-message')) {
		            errorElement = document.createElement('span');
		            errorElement.classList.add('error-message');
		            input.parentNode.insertBefore(errorElement, input.nextSibling);
		        }
		    }
		    errorElement.textContent = message;
		    errorElement.style.color = 'red';
		}

		// 오류 제거 함수 (수정됨)
function clearError(input) {
    let errorElement;
    if (input.id === 'datepicker') {
        errorElement = document.getElementById('endDateError');
    } else {
        errorElement = input.nextElementSibling;
    }

    if (errorElement && errorElement.classList.contains('error-message')) {
        errorElement.textContent = '';
    }
}

		// 이벤트 리스너 설정 (새로 추가)
		document.addEventListener('DOMContentLoaded', function() {

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
							
							// 새로운 검색 기능 추가
						    const searchInput = document.getElementById('employeeSearch');
						    const searchBtn = document.getElementById('searchBtn');
						    const employeeTableBody = document.getElementById('employeeTableBody');
						    const allRows = Array.from(employeeTableBody.getElementsByTagName('tr'));

						    function performSearch() {
						        const searchTerm = searchInput.value.trim().toLowerCase();

						        allRows.forEach(row => {
						            const employeeInfo = row.cells[1].textContent.toLowerCase();
						            if (searchTerm === '' || employeeInfo.includes(searchTerm)) {
						                row.style.display = '';
						            } else {
						                row.style.display = 'none';
						            }
						        });
						    }

						    // 검색 버튼 클릭 이벤트
						    searchBtn.addEventListener('click', performSearch);

						    // 검색 입력 필드에서 키 입력 이벤트
						    searchInput.addEventListener('input', performSearch);

						    // 모달이 열릴 때마다 검색 입력 필드를 초기화하고 모든 행을 표시
						    document.getElementById('openModalBtn').addEventListener('click', function() {
						        searchInput.value = '';
						        allRows.forEach(row => row.style.display = '');
						    });

						    // 모달 닫기 버튼 이벤트 (변경 없음)
						    document.getElementById('closeModalBtn').addEventListener('click', closeModal);

						    // 선택 완료 버튼 이벤트 (변경 없음)
						    document.getElementById('submitBtn').addEventListener('click', closeModal);
						});

		// 모달 외부 영역 클릭 시 모달 닫기 (변경 없음)
		window.onclick = function(event) {
			var modal = document.getElementById('employeeModal');
			if (event.target == modal) {
				closeModal();
			}
		};
	</script>


</body>
</html>
