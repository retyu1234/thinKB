<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - 투표 진행여부 결정</title>
<style>
body, html {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}

.stage1clear-header {
	position: relative;
	z-index: 1;
}

.room1-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	z-index: 2;
	margin-top: 120px;
}

.room1-title {
	font-size: 22pt;
	color: black;
	font-weight: bold;
	margin-top: 50px;
	margin-bottom: 20px;
}

.room1-title-detail {
	font-size: 15pt;
}

.idea-box {
	background-color: #f0f0f0;
	border-radius: 20px;
	padding: 15px;
	margin-bottom: 15px;
	transition: box-shadow 0.3s ease;
	width: 100%;
	margin-left: auto;
	margin-right: auto;
}

.idea-box:hover {
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.idea-title {
	font-weight: bold;
	margin: 5px 20px 5px 20px;
	font-size: 18pt;
	text-align: left;
}

.idea-title .icon {
	margin-right: 10px;
	/* margin-left: 10px; */
	font-size: 24pt;
	flex-shrink: 0;
}

.idea-detail {
	margin: 20px;
	font-size: 13pt;
	background-color: white;
	border-radius: 10px;
	text-align: left;
}

.idea-detail span {
	margin: 0 40px;  /* 좌우 여백만 유지 */
    line-height: 1.5;  /* 줄 간격 조정 */
    display: inline-block;  /* 위아래 여백을 적용하기 위해 필요 */
    padding-top: 5px;
    padding-bottom: 5px;
}

select {
	width: 75%;
	padding: 10px;
	font-size: 18px;
	margin-left: 20px;
	margin-right: 20px;
	margin-bottom: 15px;
	cursor: pointer;
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

.stages {
	display: flex;
	justify-content: space-between;
	padding: 30px 0;
	font-size: 12pt;
}

.stage {
	flex: 1;
	text-align: center;
	padding: 3px; /* 5px에서 3px로 줄임 */
	margin: 0 2px; /* 좌우 여백 추가 */
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

.titleAndDetail {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.titleAndDetail-title {
	margin: 0;
	font-size: 22pt;
	color: black;
	font-weight: bold;
}

.titleAndDetail-detail {
	font-size: 13pt;
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
/* 노란색 버튼 */
.yellow-button {
	background-color: #FFCC00;
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 15pt;
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
	font-size: 15pt;
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
	<header class="stage1clear-header">
		<%@ include file="../header.jsp"%>
	</header>

	<!-- 왼쪽 sideBar -->
	<%-- <%@ include file="../leftSideBar.jsp"%> --%>

	<div class="room1-content">

		<!-- 5개 단계 표시 -->
		<%
		    String[] stages = {"아이디어 초안 제출하기", "좋은 초안에 투표하기", "다양한 관점 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
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
		<div class="room1-title">[${meetingRoom.getRoomTitle()}] 투표 진행여부
			결정</div>
		<div class="room1-title-detail">이전 단계에서 수집된 아이디어 목록이에요. 아이디어를 다시
			받으려면 반려사유를 선택해서 "다시 받기" 버튼을 눌러주세요.</div>
		<div class="room1-title-detail">※ 단 ‘다시 받기’는 전체 아이디어에 같이 적용됩니다.</div>

		<!-- 아이디어 목록 -->
		<div class="room1-title">아이디어 목록</div>
		<div style="text-align: center;">
			<form id="ideaForm" action="./goReset" method="post">
				<input type="hidden" name="roomId" value="${roomId}"> <input
					type="hidden" name="stage" value="${stage}">

				<c:forEach var="li" items="${ideaList}" varStatus="status">
					<div class="idea-box" onclick="openModal(${status.index})">
						<div class="idea-title" onclick="openModal(${status.index})"> <span class="icon">💡</span> ${li.getTitle()}</div>
						<div class="idea-detail">
							<span style="font-weight: bold; color: #007AFF;">상세설명</span><br>
							<span>${li.getDescription()}</span>
						</div>
						<span style="font-size:13pt;">반려시 사유선택</span>
						<input type="hidden" name="rejectLog[${status.index}].ideaId"
							value="${li.getIdeaID()}"> <select
							name="rejectLog[${status.index}].rejectContents"
							onclick="event.stopPropagation()">
							<option value="">아이디어 반려 사유를 선택해주세요.</option>
							<option value="기시행중인 유사 서비스 존재">기시행중인 유사 서비스 존재</option>
							<option value="서비스 효용 대비 비용과다">서비스 효용 대비 비용과다</option>
							<option value="주제 범위에 벗어나거나 상관없는 아이디어">주제 범위에 벗어나거나 상관없는
								아이디어</option>
							<option value="관련 규정으로 실현 불가능한 아이디어">관련 규정으로 실현 불가능한
								아이디어</option>
							<option value="좋은 아이디어로 확장, 구체화해서 재제출 요청">좋은 아이디어로 확장,
								구체화해서 재제출 요청</option>
						</select>
					</div>
				</c:forEach>

				<div class="titleAndDetail" style="margin-top: 50px;">
					<div class="titleAndDetail-title">아이디어 다시 받는 경우 타이머 설정</div>
					<div class="titleAndDetail-detail">아이디어 초안을 다시 받는 경우, 재작성할 수
						있는 시간을 정해주세요.</div>
				</div>
				<div style="text-align: left; margin: 20px;">
					<input type="number" class="timer-input" name="timer_hours" min="0"
						max="23" placeholder="HH">&nbsp;시&nbsp;&nbsp;&nbsp; <input
						type="number" class="timer-input" name="timer_minutes" min="0"
						max="59" placeholder="MM">&nbsp;분&nbsp;&nbsp;&nbsp; <input
						type="number" class="timer-input" name="timer_seconds" min="0"
						max="59" placeholder="SS">&nbsp;초&nbsp;&nbsp;&nbsp; <span
						class="error-message" id="timerError"></span>
				</div>
				<button type="button" id="submitButton" class="grey-button"
					style="margin-top: 10px;">다시 받기</button>
			</form>

			<div class="titleAndDetail" style="margin-top: 80px;">
				<div class="titleAndDetail-title">아이디어 투표 진행시 타이머 설정</div>
				<div class="titleAndDetail-detail">현재까지 제출된 아이디어를 바탕으로 투표를
					진행하는 경우, 투표를 할 수 있는 시간을 정해주세요.</div>
			</div>
			<form action="./goStage2" id="goStageForm" method="post">
				<input type="hidden" name="roomId" value="${roomId}"> <input
					type="hidden" name="stage" value="${stage}">
				<div style="text-align: left; margin: 20px;">
					<input type="number" class="timer-input" name="timer_hours" min="0"
						max="23" placeholder="HH">&nbsp;시&nbsp;&nbsp;&nbsp; <input
						type="number" class="timer-input" name="timer_minutes" min="0"
						max="59" placeholder="MM">&nbsp;분&nbsp;&nbsp;&nbsp; <input
						type="number" class="timer-input" name="timer_seconds" min="0"
						max="59" placeholder="SS">&nbsp;초&nbsp;&nbsp;&nbsp; <span
						class="error-message" id="timerError"></span>
				</div>

				<button type="submit" class="yellow-button"
					style="margin-top: 10px;">투표 진행하기</button>
			</form>

		</div>

	</div>
	<!-- 오른쪽 sideBar -->
	<%@ include file="../rightSideBar.jsp"%>

	<script>  
    //반려사유 선택
    document.getElementById('submitButton').addEventListener('click', function(e) {
        e.preventDefault(); // 기본 제출 동작 방지
        
        var selects = document.querySelectorAll('select[name^="rejectLog"]');
        var allSelected = true;
        
        selects.forEach(function(select) {
            if (select.value === "") {
                allSelected = false;
                select.style.border = "2px solid red"; // 선택되지 않은 항목 강조
            } else {
                select.style.border = ""; // 정상 상태로 복원
            }
        });
        
        // 타이머 입력 확인
        var timerHours = document.querySelector('input[name="timer_hours"]').value;
        var timerMinutes = document.querySelector('input[name="timer_minutes"]').value;
        var timerSeconds = document.querySelector('input[name="timer_seconds"]').value;
        var timerInputted = timerHours !== "" || timerMinutes !== "" || timerSeconds !== "";
        
        if (!timerInputted) {
            document.querySelectorAll('#ideaForm input[type="number"]').forEach(function(input) {
                input.style.border = "2px solid red";
            });
        } else {
            document.querySelectorAll('#ideaForm input[type="number"]').forEach(function(input) {
                input.style.border = "";
            });
        }
        
        if (allSelected && timerInputted) {
            document.getElementById('ideaForm').submit(); // 모든 조건이 만족되면 폼 제출
        } else {
            if (!allSelected) {
                alert('모든 아이디어에 대해 반려 사유를 선택해주세요.');
            }
            if (!timerInputted) {
                alert('타이머 설정을 위해 최소한 하나의 시간 단위를 입력해주세요.');
            }
        }
    });
    
    document.getElementById('goStageForm').addEventListener('submit', function(e) {
        e.preventDefault(); // 항상 기본 제출을 막습니다.

        var timerHours = this.querySelector('input[name="timer_hours"]').value;
        var timerMinutes = this.querySelector('input[name="timer_minutes"]').value;
        var timerSeconds = this.querySelector('input[name="timer_seconds"]').value;
        
        if (timerHours === "" && timerMinutes === "" && timerSeconds === "") {
            alert('타이머 설정을 위해 최소한 하나의 시간 단위를 입력해주세요.');
            
            // 입력 필드 강조
            this.querySelectorAll('input[type="number"]').forEach(function(input) {
                input.style.border = "2px solid red";
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
    
    document.addEventListener("DOMContentLoaded", function() {
        const stageId = ${meetingRoom.getStageId()};
        const timerElement = document.getElementById("timer");
        const timerMessageElement = document.getElementById("timer-message");

        if (stageId >= 2) {
            if (timerElement) {
                timerElement.innerHTML = "Time Out";
            }
            if (timerMessageElement) {
                timerMessageElement.innerHTML = "지금은 작성할 수 없어요";
                timerMessageElement.classList.remove("active");
                timerMessageElement.classList.add("expired");
            }
            window.updateTimer = function() {
                
            };
        }
    });

    </script>
</body>
</html>