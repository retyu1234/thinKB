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
	caret-color: transparent;
}

.content {
	padding: 30px; /* content 영역의 여백 설정 */
	margin-left: 20%;
	margin-right: 20%;
	caret-color: transparent;
}

.title {
	font-size: 18pt;
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
	border: 3px solid #666;
	border-radius: 8px;
	font-size: 16px;
	box-sizing: border-box;
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

.timer-input.disabled {
	background-color: #f0f0f0;
	color: #888;
	cursor: not-allowed;
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



.error-message {
	color: red;
	margin-left: 10px;
	font-size: 0.9em;
}

.ideaTimer-card {
	background-color: #fff;
	border: 1px solid #ccc;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
	padding: 20px;
	transition: box-shadow 0.3s ease;
	width: 40%;
}

.ideaTimer-card:hover {
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
}

.card-header {
	border-bottom: 1px solid #ddd;
	margin-bottom: 15px;
	padding-bottom: 10px;
}

.card-header h3 {
	font-size: 24px;
	margin: 0;
}

.card-header p {
	font-size: 14px;
	margin: 5px 0 0 0;
	color: #888;
	font-weight: bold;
}

.card-body p {
	margin: 10px 0;
	font-size: 15px;
	font-weight: bold;
}

.card-body .timer-settings {
	display: flex;
	align-items: center;
}

.card-body .timer-input {
	width: 30%;
	padding: 8px;
	border: 2px solid #666;
	border-radius: 5px;
	font-size: 16px;
	text-align: center;
	margin-right: 10px;
}

.card-body .error-message {
	color: red;
	font-size: 0.9em;
}
#timer-section, #timer, #timer-message {
    display: none;
}
.manageTop{
	display: flex;
	justify-content: space-between;
}
#backButton{
	border: none;
	background-color: #ffffff;
	font-size: 26pt;
	transition: font-size 0.3s ease; 
}
#backButton:hover{
	font-size: 30pt;
}
</style>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    var roomId = '${meetingRoom.roomId}';
    var links = document.querySelectorAll('.side-menu a');
    links.forEach(function(link) {
        var url = new URL(link.href);
        url.searchParams.set('roomId', roomId);
        link.href = url.toString();
    });

    document.getElementById('backButton').addEventListener('click', function() {
        var roomId = '${meetingRoom.roomId}';
        var stageId = '${meetingRoom.stageId}';
        window.location.href = './roomDetail?roomId=' + roomId + '&stage=' + stageId;
    });
});
</script>
</head>
<body>

	<div class="newRoom-body">
		<%@ include file="../header.jsp"%>
	</div>

		<%@ include file="../leftSideBar.jsp"%>
		<%@ include file="../rightSideBar.jsp"%>
	

	<div class="content">
	<div class="manageTop">
	<h2 style="font-size:20pt">⚙️회의방 관리</h2>
	<button id="backButton">🔙</button></div><hr>
		<form action="./updateRoomInfo" method="post"
			onsubmit="return validateForm()">
			<input type="hidden" name="roomId" value="${meetingRoom.roomId}" />
			<input type="hidden" name="departmentId" value="${departmentId}" />
			<input type="hidden" name="teamId" value="${teamId}" />

			<div class="title">주제 변경</div>
			<input type="text" class="custom-input" name="title"
				value="${meetingRoom.roomTitle}" placeholder="여기에 입력하세요">

			<div class="title" style="margin-top: 70px;">회의 상세설명 변경</div>
			<input type="text" class="custom-input" style="height: 70px;"
				name="content" value="${meetingRoom.description}"
				placeholder="회의 주제에 대한 상세한 설명을 적어주세요 ex)참고할 수 있는 관련문서, 보고서 경로 등">

			<div class="title" style="margin-top: 70px;">회의 종료일 변경</div>
			<div class="date-input-container">
				<div class="date-input-wrapper">
					<input type="text" class="date-input" name="endDate"
						id="datepicker" placeholder="YYYYMMDD"
						value="${meetingRoom.endDate}"> <span
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
					<table id="calendarTable" class="calendar-table">
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

			<div class="title" style="margin-top: 70px;">타이머 설정 변경</div>

			<c:set var="hasNonZeroIdea" value="false" />
			<c:forEach var="timer" items="${timers}">
				<c:if test="${timer.ideaId > 0}">
					<c:set var="hasNonZeroIdea" value="true" />
				</c:if>
			</c:forEach>

			<c:choose>
				<c:when test="${hasNonZeroIdea}">
					<c:forEach var="timer" items="${timers}">
						<c:if test="${timer.ideaId > 0}">
							<div class="ideaTimer-card">
								<div class="card-header">
									<h3>${timer.ideaTitle}</h3>
									<p>방 ID: ${timer.roomId}</p>
								</div>
								<div class="card-body">
									<p>종료 시간: ${timer.endTime}</p>
									<p>
										남은 시간: <span class="timer" data-end="${timer.endTime}"></span>
									</p>
									<div class="timer-settings" data-idea-id="${timer.ideaId}">
										<input type="hidden" name="currentEndTime_${timer.ideaId}"
											value="${timer.endTime}"> <input type="hidden"
											name="ideaId_${timer.ideaId}" value="${timer.ideaId}">
										<input type="number" class="timer-input"
											name="timer_hours_${timer.ideaId}" placeholder="HH">&nbsp;시&nbsp;&nbsp;&nbsp;
										<input type="number" class="timer-input"
											name="timer_minutes_${timer.ideaId}" placeholder="MM">&nbsp;분&nbsp;&nbsp;&nbsp;
										<input type="number" class="timer-input"
											name="timer_seconds_${timer.ideaId}" placeholder="SS">&nbsp;초&nbsp;&nbsp;&nbsp;
										<span class="error-message" id="timerError_${timer.ideaId}"></span>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="timer" items="${timers}">
						<c:if test="${timer.ideaId == 0}">
							<div class="ideaTimer-card">
								<div class="card-header">
									<h3>${timer.ideaId == 0 ? '초안작성' : timer.ideaTitle}</h3>
									<p>방 ID: ${timer.roomId}</p>
								</div>
								<div class="card-body">
									<p>종료 시간: ${timer.endTime}</p>
									<p>
										남은 시간: <span class="timer" data-end="${timer.endTime}"></span>
									</p>
									<div class="timer-settings" data-idea-id="${timer.ideaId}">
										<input type="hidden" name="currentEndTime_${timer.ideaId}"
											value="${timer.endTime}"> <input type="hidden"
											name="ideaId_${timer.ideaId}" value="${timer.ideaId}">
										<input type="number" class="timer-input"
											name="timer_hours_${timer.ideaId}" placeholder="HH">&nbsp;시&nbsp;&nbsp;&nbsp;
										<input type="number" class="timer-input"
											name="timer_minutes_${timer.ideaId}" placeholder="MM">&nbsp;분&nbsp;&nbsp;&nbsp;
										<input type="number" class="timer-input"
											name="timer_seconds_${timer.ideaId}" placeholder="SS">&nbsp;초&nbsp;&nbsp;&nbsp;
										<span class="error-message" id="timerError_${timer.ideaId}"></span>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>

			<div style="margin: 70px; text-align: center;">
				<button class="yellow-button" type="submit">수정하기</button>
			</div>
		</form>
	</div>

	<script>
	document.addEventListener('DOMContentLoaded', function() {
		  const timerElements = document.querySelectorAll('.timer');
		  function updateTimers() {
		    const now = new Date().getTime();
		    timerElements.forEach(timerElement => {
		      const endTimeString = timerElement.dataset.end;
		      const endTime = new Date(endTimeString).getTime();
		      const remainingTime = endTime - now;
		      if (remainingTime > 0) {
		        const hours = Math.floor(remainingTime / (1000 * 60 * 60));
		        const minutes = Math.floor((remainingTime % (1000 * 60 * 60)) / (1000 * 60));
		        const seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);
		        const formattedHours = String(hours).padStart(2, '0');
		        const formattedMinutes = String(minutes).padStart(2, '0');
		        const formattedSeconds = String(seconds).padStart(2, '0');
		        timerElement.innerHTML = formattedHours + ":" + formattedMinutes + ":" + formattedSeconds;
		      } else {
		        timerElement.textContent = "시간 종료";
		      }
		    });
		  }
		  
		  // 초기 타이머 업데이트
		  updateTimers();
		  // 1초마다 타이머 업데이트
		  setInterval(updateTimers, 1000);
		});


	// 문서 로드 시 모든 라디오 버튼의 상태를 확인하고 입력 필드의 초기 상태를 설정합니다.
	document.addEventListener('DOMContentLoaded', function() {
	    var radios = document.querySelectorAll('input[type=radio][name^="endNow_"]');
	    radios.forEach(radio => {
	        radio.addEventListener('change', function() {
	            var ideaId = this.name.split('_')[1];
	            toggleInputs(ideaId, this.value === 'true');
	        });
	    });
	});
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

        // 폼 유효성 검사 함수
        function validateForm() {
            var title = document.querySelector('input[name="title"]').value;
            var content = document.querySelector('input[name="content"]').value;
            var endDate = document.querySelector('input[name="endDate"]').value;
            var timerHours = document.querySelector('input[name="timer_hours"]').value;
            var timerMinutes = document.querySelector('input[name="timer_minutes"]').value;
            var timerSeconds = document.querySelector('input[name="timer_seconds"]').value;

            var isValid = true;

            // 제목 검사
            if (!title) {
                isValid = false;
                document.getElementById("titleError").textContent = "제목을 입력하세요.";
            }

            // 내용 검사
            if (!content) {
                isValid = false;
                document.getElementById("contentError").textContent = "내용을 입력하세요.";
            }

            // 종료일 검사
            if (!endDate) {
                isValid = false;
                document.getElementById("endDateError").textContent = "종료일을 입력하세요.";
            }

            // 타이머 검사
            if (!timerHours && !timerMinutes && !timerSeconds) {
                isValid = false;
                document.getElementById("timerError").textContent = "타이머를 설정하세요.";
            }

            return isValid;
        }
    </script>
</body>
</html>
