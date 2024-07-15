<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
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
	max-width: 400px; /* 최대 너비 설정 */
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
</style>
</head>
<body>
	<div class="newRoom-body">
		<%@ include file="../header.jsp"%>
	</div>
	<div class="content">
		<form action="" method="post">
			<div class="title">아이디어 회의 주제</div>
			<input type="text" class="custom-input" name="title"
				placeholder="여기에 입력하세요">
			<div class="title" style="margin-top: 70px;'">회의 종료일</div>
			<div class="date-input-container">
				<input type="text" class="date-input" id="datepicker"
					placeholder="날짜를 선택하세요"> <span class="calendar-icon"
					onclick="toggleCalendar()">📅</span>
			</div>
		</form>
	</div>

	<div class="calendar-popup" id="calendarPopup">
		<table id="calendarTable">
			<thead>
				<tr>
					<th colspan="7"><span id="calendarMonth"></span> <span
						id="calendarYear"></span></th>
				</tr>
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

    // 초기 달력 생성 함수 (현재 달 기준)
    function createCalendar() {
        var now = new Date();
        var year = now.getFullYear();
        var month = now.getMonth();
        var firstDay = new Date(year, month, 1);
        var lastDay = new Date(year, month + 1, 0);
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
                    row.appendChild(cell);
                    date++;
                }
            }
            calendarBody.appendChild(row);
        }

        // 달력 상단에 년도와 월 표시
        document.getElementById("calendarMonth").textContent = (month + 1) + "월";
        document.getElementById("calendarYear").textContent = year;
    }

    // 날짜 선택 함수
    function selectDate(cell) {
        var selectedDate = cell.textContent;
        var selectedMonth = document.getElementById("calendarMonth").textContent.replace("월", "");
        var selectedYear = document.getElementById("calendarYear").textContent;
        document.getElementById("datepicker").value = selectedYear + "-" + selectedMonth.padStart(2, '0') + "-" + selectedDate.padStart(2, '0');
        document.getElementById("calendarPopup").style.display = "none";
    }

    // 페이지 로드 시 초기 달력 생성
    window.onload = function() {
        createCalendar();
    };
</script>
</body>
</html>