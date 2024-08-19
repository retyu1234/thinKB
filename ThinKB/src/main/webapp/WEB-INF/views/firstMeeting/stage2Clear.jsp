<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - 아이디어 투표 결과</title>
<style>
body, html {
	margin: 0;
	padding: 0;
	font-family: KB금융 본문체 Light;
	overflow-x: hidden;
    width: 100%;
}

.stage2clear-header {
	position: relative;
	z-index: 1;
}

.room2-content {
	padding: 20px;
	margin-left: 20%;
	margin-right: 20%;
	z-index: 2;
	/* margin-top: 120px; */
}
.stages {
	display: flex;
	justify-content: space-between;
	padding: 30px 0;
	font-size: 12pt;
}

.stage {
	flex: 1;
	text-align: center;
	padding: 3px;
	margin: 0 2px;
	cursor: pointer;
	text-decoration: none;
	color: #000;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.active {
	color: #FFD700;
	font-weight: bold;
}

.inactive {
	color: #999;
	pointer-events: none;
}

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

.room1-title {
	font-size: 20pt;
	color: black;
	font-weight: bold;
	margin-top: 10px;
	margin-bottom: 20px;
	font-family: KB금융 제목체 Light;
}

.room1-title-detail {
	font-size: 15pt;
}

.line {
	margin-top: 15px;
	margin-bottom: 15px;
	border: 2px solid lightgrey;
}

table {
	width: 70%;
	margin-left: auto;
	margin-right: auto;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
	font-weight: bold;
	font-family: KB금융 제목체 Light;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

tr:hover {
	background-color: #f5f5f5;
}

.rank-1, .rank-2, .rank-3 {
	font-weight: bold;
}

.rank-1 {
	color: gold;
	font-weight: bold;
	font-size: 13pt;
}

.rank-2 {
	color: silver;
	font-weight: bold;
	font-size: 13pt;
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

.button {
	background-color: #4CAF50;
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
}
</style>

</head>
<body>
	<!-- 헤더영역 -->
	<header class="stage2clear-header">
		<%@ include file="../header.jsp"%>
	</header>

	<!-- 왼쪽 sideBar -->
	<%@ include file="../leftSideBar.jsp"%>

	<div class="room2-content">

		<!-- 5개 단계 표시 -->
		<%
		    String[] stages =  {"아이디어 초안", "초안 투표하기", "관점별 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
		    request.setAttribute("stages", stages);
		%>
		<div class="stages">
			<c:forEach var="stage" items="${stages}" varStatus="status">
				<c:choose>
					<c:when test="${meetingRoom.getStageId() >= status.index + 1}">
						<a
							href="roomDetail?roomId=${meetingRoom.getRoomId()}&stage=${status.index + 1}"
							class="stage ${meetingRoom.getStageId() == status.index + 1 ? 'active' : ''}">
							${status.index + 1}. ${stage} </a>
					</c:when>
					<c:otherwise>
						<div class="stage inactive">${status.index + 1}. ${stage}</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		
		<!-- 상단 회의방 이름, 단계 설명 -->
		<div class="room1-title">[${meetingRoom.getRoomTitle()}] 아이디어 투표결과</div>
		<div class="room1-title-detail">1, 2위 아이디어만 추가 의견 받기가 가능해요.</div>
			<div class="room1-title-detail">(동순위 발생 시 아이디어 제공자의 누적 기여도가 높은순으로 선택됩니다.)</div>
		<hr class="line">

		<div>
		<div class="room1-title" style="font-size: 18pt; margin-top: 30px;">투표 결과</div>
			<table>
				<tr>
					<th>순위</th>
					<th>아이디어 제목</th>
					<th>득표수</th>
				</tr>
				<c:forEach var="idea" items="${list}" varStatus="status">
					<tr>
						<td class="rank-${status.index + 1}"><c:choose>
								<c:when test="${status.index + 1 <= 2}">
                            ${status.index + 1}등
                        </c:when>
								<c:otherwise>
                            -
                        </c:otherwise>
							</c:choose></td>
						<td>${idea.getTitle()}</td>
						<td>${idea.getPickNum()}표</td>
					</tr>
				</c:forEach>
			</table>

			<form action="./goStage3" id="goStage3Form" method="post">
				<input type="hidden" name="roomId" value="${roomId}"> <input
					type="hidden" name="stage" value="${stage}"> <input
					type="hidden" name="firstIdeaId" value="${list[0].getIdeaID()}">
				<input type="hidden" name="secondIdeaId"
					value="${list[1].getIdeaID()}">

				<h2 style="text-align: left; margin-top: 50px; font-family: KB금융 제목체 Light;">
					의견 받기 타이머 설정</h2>

				<div>
					<input type="number" class="timer-input" name="timer_hours" min="0"
						max="23" placeholder="HH"> &nbsp;시&nbsp;&nbsp;&nbsp; <input
						type="number" class="timer-input" name="timer_minutes" min="0"
						max="59" placeholder="MM"> &nbsp;분&nbsp;&nbsp;&nbsp; <input
						type="number" class="timer-input" name="timer_seconds" min="0"
						max="59" placeholder="SS"> &nbsp;초&nbsp;&nbsp;&nbsp; <span
						class="error-message" id="timerError"></span>
				</div>

				<div style="text-align: center;">
					<button type="submit" class="yellow-button">의견 받기</button>
				</div>
			</form>
		</div>
	<!-- 오른쪽 sideBar -->
	<%@ include file="../rightSideBar.jsp"%>
	
	</div>
	<script>
		document.getElementById('goStage3Form').addEventListener('submit', function(e) {
			e.preventDefault();
			var timerHours = this.querySelector('input[name="timer_hours"]').value;
			var timerMinutes = this.querySelector('input[name="timer_minutes"]').value;
			var timerSeconds = this.querySelector('input[name="timer_seconds"]').value;

			if (timerHours === "" && timerMinutes === "" && timerSeconds === "") {
				alert('타이머 설정을 위해 최소한 하나의 시간 단위를 입력해주세요.');
				// 입력 필드 강조
				this.querySelectorAll('input[type="number"]').forEach(
					function(input) {\input.style.border = "2px solid red";
				});
				} else {
				// 정상 상태로 복원
					this.querySelectorAll('input[type="number"]').forEach(function(input) {
						input.style.border = "";
					});
				// 모든 조건이 만족되면 폼을 수동으로 제출합니다.
				this.submit();
				}
		});
	</script>

</body>
</html>