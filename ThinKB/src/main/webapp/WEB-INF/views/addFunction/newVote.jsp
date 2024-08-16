<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>thinKB - 투표 만들기</title>
<style>
html, body {
    max-width: 100%;
    overflow-x: hidden;
}
.vote-body {
	font-family: KB금융 본문체 Light;
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
	font-family: KB금융 제목체 Light;
}
.titleAndDetail-detail {
	font-size: 13pt;
}

.new-subject {
	font-size: 15pt;
	color: black;
	border: 3px solid #FFD700;
	border-radius: 20px;
	padding: 20px;
	background-color: white;
}

input.new-subject {
	font-size: 13pt;
	color: black;
	border: 3px solid lightgrey;
	border-radius: 10px;
	padding: 20px;
	width: 100%;
	box-sizing: border-box;
	font-family: KB금융 본문체 Light;
}

input.new-subject:focus {
	border-color: #FFD700;
	outline: none;
}

.date-input-container {
	display: flex;
	align-items: center;
	width: 100%;
	max-width: 600px;
	position: relative;
	font-family: KB금융 본문체 Light;
}

.date-input-wrapper {
	display: flex;
	align-items: center;
	width: 200px;
	margin-right: 10px;
}

.date-input {
	width: 100%;
	padding: 12px;
	border: 3px solid lightgrey;
	border-radius: 20px;
	font-size: 15pt;
	box-sizing: border-box;
	font-family: KB금융 본문체 Light;
}

.date-input:focus {
	border-color: #FFD700;
	outline: none;
}

.calendar-icon {
	margin-left: 10px;
	cursor: pointer;
}

.error-message-container {
	flex: 1;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.error-message {
	color: red;
	font-size: 0.9em;
	font-family: KB금융 본문체 Light;
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
	background-color: #f2f2f2;
	color: #ccc;
	cursor: not-allowed;
}

.yellow-button1 {
	background-color: #e6b800;
	color: black;
	padding: 10px 40px;
	border: none;
	border-radius: 20px;
	font-size: 20px;
	cursor: pointer;
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
    font-family: KB금융 본문체 Light;
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
	font-family: KB금융 본문체 Light;
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
	font-family: KB금융 본문체 Light;
}

.grey-button:hover {
	background-color: #60584C;
}

.userList {
    display: flex; 
    align-items: center; 
    margin-bottom: 10px;
    justify-content: space-between;
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
    font-family: KB금융 본문체 Light;
}

.vote-option-input:focus {
    outline: none;
    border-bottom-color: #FFD700;
}

.vote-option-input::placeholder {
    color: #999;
}

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

// 달력 관련 변수와 함수
var currentYear;
var currentMonth;

function toggleCalendar() {
    var calendarPopup = document.getElementById("calendarPopup");
    calendarPopup.style.display = calendarPopup.style.display === "block" ? "none" : "block";
}

function prevMonth() {
    currentMonth--;
    if (currentMonth < 0) {
        currentMonth = 11;
        currentYear--;
    }
    createCalendar();
}

function nextMonth() {
    currentMonth++;
    if (currentMonth > 11) {
        currentMonth = 0;
        currentYear++;
    }
    createCalendar();
}

function createCalendar() {
    var now = new Date();
    if (currentYear === undefined || currentMonth === undefined) {
        currentYear = now.getFullYear();
        currentMonth = now.getMonth();
    }

    var firstDay = new Date(currentYear, currentMonth, 1);
    var lastDay = new Date(currentYear, currentMonth + 1, 0);
    var startDay = firstDay.getDay();
    var totalDays = lastDay.getDate();

    var calendarBody = document.getElementById("calendarBody");
    calendarBody.innerHTML = "";

    var date = 1;
    for (var i = 0; i < 6; i++) {
        var row = document.createElement("tr");
        for (var j = 0; j < 7; j++) {
            if (i === 0 && j < startDay) {
                var cell = document.createElement("td");
                row.appendChild(cell);
            } else if (date > totalDays) {
                break;
            } else {
                var cell = document.createElement("td");
                cell.textContent = date;
                cell.onclick = function() {
                    selectDate(this);
                };

                var currentDate = new Date();
                if (currentYear > currentDate.getFullYear() ||
                    (currentYear === currentDate.getFullYear() && currentMonth > currentDate.getMonth()) ||
                    (currentYear === currentDate.getFullYear() && currentMonth === currentDate.getMonth() && date >= currentDate.getDate())) {
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

    document.getElementById("calendarMonth").textContent = (currentMonth + 1) + "월";
    document.getElementById("calendarYear").textContent = currentYear;
}

function selectDate(cell) {
    if (!cell.classList.contains('selectable')) {
        return;
    }

    var selectedDate = cell.textContent;
    var selectedMonth = document.getElementById("calendarMonth").textContent.replace("월", "");
    var selectedYear = document.getElementById("calendarYear").textContent;
    var datepicker = document.getElementById("datepicker");
    datepicker.value = selectedYear + selectedMonth.padStart(2, '0') + selectedDate.padStart(2, '0');
    document.getElementById("calendarPopup").style.display = "none";

    clearError(datepicker);
}

// 선택된 직원들을 저장할 배열
var selectedEmployees = [];

// 직원 선택 처리 함수
function toggleEmployeeSelection(employeeId, employeeName) {
    var index = selectedEmployees.findIndex(function(emp) {
        return emp.id === employeeId;
    });

    if (index === -1) {
        selectedEmployees.push({
            id: employeeId,
            name: employeeName
        });
    } else {
        selectedEmployees.splice(index, 1);
    }

    updateSelectedEmployeesDisplay();
    updateHiddenInput();
}

// 선택된 직원 목록을 화면에 업데이트하는 함수
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

// hidden input 업데이트 함수
function updateHiddenInput() {
    var hiddenInput = document.getElementById('selectedEmployeeIds');
    hiddenInput.value = selectedEmployees.map(function(emp) {
        return emp.id;
    }).join(',');
}

// 직원 선택 체크박스에 대한 이벤트 리스너
function addEmployeeCheckboxListeners() {
    document.querySelectorAll('input[name="employees"]').forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
            var employeeId = this.value;
            var employeeName = this.parentElement.nextElementSibling.textContent.trim().split('(')[0].trim();
            toggleEmployeeSelection(employeeId, employeeName);
        });
    });
}

// 모달 관련 함수들
function openModal() {
    var modal = document.getElementById('employeeModal');
    modal.style.display = 'block';
    document.body.style.overflow = 'hidden';
    addEmployeeCheckboxListeners();
}

function closeModal() {
    var modal = document.getElementById('employeeModal');
    modal.style.display = 'none';
    document.body.style.overflow = '';
}

// 폼 유효성 검사
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

// 이벤트 리스너 설정
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('closeModalBtn').addEventListener('click', closeModal);
    document.getElementById('openModalBtn').addEventListener('click', openModal);
    document.getElementById('submitBtn').addEventListener('click', closeModal);

    // 입력 필드에 대한 이벤트 리스너 추가
    document.querySelectorAll('input[name="title"], input[name="content"], input[name="endDate"]')
        .forEach(function(input) {
            input.addEventListener('input', function() {
                clearError(this);
            });
        });

    // 직원 선택 버튼에 대한 이벤트 리스너
    document.getElementById('openModalBtn').addEventListener('click', function() {
        clearError(document.getElementById('selectedEmployeeIds'));
    });

    // datepicker에 대한 이벤트 리스너 추가
    document.getElementById('datepicker').addEventListener('input', function() {
        clearError(this);
    });

    // 검색 기능
    const searchInput = document.getElementById('employeeSearch');
    const searchBtn = document.getElementById('searchBtn');
    const employeeTableBody = document.getElementById('employeeTableBody');
    const allRows = Array.from(employeeTableBody.getElementsByTagName('tr'));

    function performSearch() {
        const searchTerm = searchInput.value.trim().toLowerCase();
        allRows.forEach(row => {
            const employeeInfo = row.cells[1].textContent.toLowerCase();
            row.style.display = searchTerm === '' || employeeInfo.includes(searchTerm) ? '' : 'none';
        });
    }

    searchBtn.addEventListener('click', performSearch);
    searchInput.addEventListener('input', performSearch);

    document.getElementById('openModalBtn').addEventListener('click', function() {
        searchInput.value = '';
        allRows.forEach(row => row.style.display = '');
    });

    // 페이지 로드 시 초기 달력 생성
    createCalendar();
});

// 모달 외부 영역 클릭 시 모달 닫기
window.onclick = function(event) {
    var modal = document.getElementById('employeeModal');
    if (event.target == modal) {
        closeModal();
    }
};
</script>
</body>
</html>
