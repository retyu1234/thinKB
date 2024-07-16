<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<style>
.newRoom-body {
	margin: 0;
	padding: 0;
	background-image:
		url('${pageContext.request.contextPath}/resources/23029.jpg');
	background-size: cover; /* 이미지가 요소에 완전히 맞도록 비율을 조정 */
	background-position: center; /* 이미지를 가운데 정렬 */
	background-repeat: no-repeat;
	height: 400px; /* 요소의 높이를 400px로 고정 */
}

.content {
	padding: 20px; /* content 영역의 여백 설정 */
	margin-left: 25%;
	margin-right: 25%;
}

.title {
	font-size: 30px;
	font-weight: bold;
	color: black;
	margin-top: 30px;
	margin-bottom: 20px;
}

.custom-input {
	width: 100%; /* 화면 가로에 꽉 차도록 설정 (여백 20px 고려) */
	padding: 12px; /* 내부 여백 설정 */
	border: 3px solid #666; /* 테두리 두께와 색상 설정 */
	border-radius: 8px; /* 테두리 둥글기 설정 */
	transition: border-color 0.3s ease; /* 테두리 색 변화에 대한 transition 설정 */
	/* 기본 테두리 색상 */
	border-color: #666;
	font-size: 16px; /* 글자 크기 설정 */
}

/* 입력 중에는 노란색 테두리로 변경 */
.custom-input:focus {
	border-color: #ffcc00;
	outline: none; /* 포커스 효과 제거 */
}

.date-input-container {
	display: flex;
	align-items: center;
	width: 100%;
	max-width: 400px;
}

.date-input {
	flex: 1;
	padding: 12px;
	border: 3px solid #666;
	border-radius: 8px;
	font-size: 16px;
	box-sizing: border-box;
}

.calendar-icon {
	margin-left: 10px;
	cursor: pointer;
}

/* 달력 팝업 스타일 */
.calendar-popup {
	position: absolute;
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
	border: 2px solid #666;
	border-radius: 5px;
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
	color: white;
	background-color: blue;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.btn:hover {
	background-color: darkblue;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
	max-width: 600px;
	border-radius: 10px;
}

.modal-header, .modal-footer {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.modal-header {
	border-bottom: 1px solid #ddd;
}

.modal-footer {
	border-top: 1px solid #ddd;
}

.close {
	color: red;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.close:hover, .close:focus {
	color: darkred;
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
</style>
</head>
<body>

	<div class="newRoom-body">
		<%@ include file="../header.jsp"%>
	</div>

	<div class="content">
		<form action="./makeRoom" method="post">
			<input type="hidden" name="id" value="${userId}" />
			<input type="hidden" name="departmentId" value="${departmentId}" />
			<input type="hidden" name="teamId" value="${teamId}" />
			<div class="title">아이디어 회의 주제</div>
			<input type="text" class="custom-input" name="title"
				placeholder="여기에 입력하세요">

			<div class="title" style="margin-top: 70px;">회의 상세설명</div>
			<input type="text" class="custom-input" style="height: 70px;"
				name="content"
				placeholder="회의 주제에 대한 상세한 설명을 적어주세요 ex)참고할 수 있는 관련문서, 보고서 경로 등">

			<div class="title" style="margin-top: 70px;">회의 종료일</div>
			<div class="date-input-container">
				<input type="text" class="date-input" name="endDate" id="datepicker"
					placeholder="YYYYMMDD"> <span class="calendar-icon"
					onclick="toggleCalendar()">📅</span>
			</div>

			<div class="title" style="margin-top: 70px;">타이머 설정</div>
			<div>
				<input type="number" class="timer-input" name="timer_hours" min="0"
					max="23" placeholder="HH">&nbsp;시&nbsp;&nbsp;&nbsp; <input
					type="number" class="timer-input" name="timer_minutes" min="0"
					max="59" placeholder="MM">&nbsp;분&nbsp;&nbsp;&nbsp; <input
					type="number" class="timer-input" name="timer_seconds" min="0"
					max="59" placeholder="SS">&nbsp;초&nbsp;&nbsp;&nbsp;
			</div>

			<div class="title" style="margin-top: 70px;">참여자 선택</div>
			<div class="btn" id="openModalBtn">직원 조회</div>
			<div class="selected-employees" id="selectedEmployees">
				<!-- 선택된 직원들이 여기에 추가됩니다 -->
			</div>
			<input type="hidden" id="selectedEmployeeIds" name="users">

			<div style="margin: 70px; text-align: center;">
				<button class="yellow-button1" type="submit">만들기</button>
			</div>

		</form>
	</div>


	<!-- 모달창 -->
	<!-- 직원 목록 모달 -->
	<div id="employeeModal" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<h5>직원 목록</h5>
				<span class="close" id="closeModalBtn">&times;</span>
			</div>
			<div class="modal-body">
				<!-- 직원 목록 테이블 -->
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
			<div class="modal-footer">
				<button class="btn-secondary" id="closeModalFooterBtn">닫기</button>
				<button class="btn-primary" id="submitBtn">선택 완료</button>
			</div>
		</div>
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
			document.getElementById("datepicker").value = selectedYear
					+ selectedMonth.padStart(2, '0')
					+ selectedDate.padStart(2, '0');
			document.getElementById("calendarPopup").style.display = "none";
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
		}

		// 모달 창 닫기 함수
		function closeModal() {
			var modal = document.getElementById('employeeModal');
			modal.style.display = 'none';
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

		// 직원 선택 처리 함수
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
		}

		// 선택된 직원 목록을 화면에 업데이트하는 함수
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

		// 모달의 선택 완료 버튼 클릭 시 처리하는 함수
		document.getElementById('submitBtn').addEventListener('click',
				function() {
					closeModal(); // 모달 닫기
				});

		// 직원 선택 체크박스에 대한 이벤트 리스너
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
	</script>


</body>
</html>
