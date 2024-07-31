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

.header {
	position: relative;
	z-index: 1;
}

.room1-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	position: relative;
	z-index: 2;
	margin-top: 80px;
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
    cursor: pointer;
    width: 100%;
    margin-left: auto;
    margin-right: auto;
}
.idea-box:hover {
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}
.idea-title {
    font-weight: bold;
    margin-top: 15px;
    margin-bottom: 10px;
    font-size: 24px;
}
select {
    width: 80%;
    padding: 5px;
    font-size: 18px;
    margin-left: 20px;
    margin-right: 20px;
    margin-bottom: 15px;
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
    background-color: rgba(0,0,0,0.4);
}
.modal-content {
    background-color: #fefefe;
    border-radius: 20px;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 70%;
    max-width: 700px; /* 최대 너비 설정 (선택사항) */
    box-sizing: border-box; /* padding이 width에 포함되도록 설정 */
}
.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}
.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
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
	font-size: 13pt;
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
	<header class="header">
		<%@ include file="../header.jsp"%>
	</header>
	
<!-- 방장 sideBar -->
	<c:if test="${userId == meetingRoom.getRoomManagerId() }">
		<%@ include file="../sideBar.jsp"%>
	</c:if>
	
	<div class="room1-content">
	
	<!-- 사이드바 import -->
	<%@ include file="../rightSideBar.jsp"%>
	
	<!-- 5개 단계 표시 -->
	
	<%
	    String[] stages = {"아이디어 초안 제출하기", "좋은 초안에 투표하기", "다양한 관점 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
	    request.setAttribute("stages", stages);
	%>
	<div class="stages">
        <c:forEach var="stage" items="${stages}" varStatus="status">
            <c:choose>
                <c:when test="${meetingRoom.getStageId() >= status.index + 1}">
                    <a href="roomDetail?roomId=${meetingRoom.getRoomId()}&stage=${status.index + 1}" class="stage ${meetingRoom.getStageId() == status.index + 1 ? 'active' : ''}">
                        ${status.index + 1}. ${stage}
                    </a>
                </c:when>
                <c:otherwise>
                    <div class="stage inactive">
                        ${status.index + 1}. ${stage}
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
    
    <!-- 상단 회의방 이름, 단계 설명 -->
    <div class="room1-title">[${meetingRoom.getRoomTitle()}] 투표 진행여부 결정</div>
    <div class="room1-title-detail">이전 단계에서 수집된 아이디어 목록이에요. 아이디어를 다시 받으려면 반려사유를 선택해서 "다시 받기" 버튼을 눌러주세요.</div>
	<div class="room1-title-detail">※ 단 ‘다시 받기’는 전체 아이디어에 같이 적용됩니다.</div>
	
	<!-- 아이디어 목록 -->
	<div class="room1-title">아이디어 목록</div>
	<div style="text-align: center;">
		<form id="ideaForm" action="./goReset" method="post">
    <input type="hidden" name="roomId" value="${roomId}">
    <input type="hidden" name="stage" value="${stage}">
    
    <c:forEach var="li" items="${ideaList}" varStatus="status">
        <div class="idea-box" onclick="openModal(${status.index})">
            <div class="idea-title" onclick="openModal(${status.index})">${li.getTitle()}</div>
            <input type="hidden" name="rejectLog[${status.index}].ideaId" value="${li.getIdeaID()}">
            <select name="rejectLog[${status.index}].rejectContents" onclick="event.stopPropagation()">
                <option value="">아이디어 반려 사유를 선택해주세요.</option>
                <option value="기시행중인 유사 서비스 존재">기시행중인 유사 서비스 존재</option>
                <option value="서비스 효용 대비 비용과다">서비스 효용 대비 비용과다</option>
                <option value="주제 범위에 벗어나거나 상관없는 아이디어">주제 범위에 벗어나거나 상관없는 아이디어</option>
                <option value="관련 규정으로 실현 불가능한 아이디어">관련 규정으로 실현 불가능한 아이디어</option>
                <option value="좋은 아이디어로 확장, 구체화해서 재제출 요청">좋은 아이디어로 확장, 구체화해서 재제출 요청</option>
            </select>
        </div>
        <div id="modal${status.index}" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal(${status.index})">&times;</span>
                <h2>아이디어 상세설명</h2>
                <p>${li.getDescription()}</p>
            </div>
        </div>
    </c:forEach>

	<div class="titleAndDetail" style="margin-top: 50px;">
		<div class="titleAndDetail-title">아이디어 다시 받는 경우 타이머 설정</div>
		<div class="titleAndDetail-detail">아이디어 초안을 다시 받는 경우, 재작성할 수 있는 시간을 정해주세요.</div>
	</div>
    <div style="text-align:left; margin:20px;">
        <input type="number" class="timer-input" name="timer_hours" min="0" max="23" placeholder="HH">&nbsp;시&nbsp;&nbsp;&nbsp;
        <input type="number" class="timer-input" name="timer_minutes" min="0" max="59" placeholder="MM">&nbsp;분&nbsp;&nbsp;&nbsp;
        <input type="number" class="timer-input" name="timer_seconds" min="0" max="59" placeholder="SS">&nbsp;초&nbsp;&nbsp;&nbsp;
        <span class="error-message" id="timerError"></span>
    </div>
    <button type="button" id="submitButton" class="grey-button" style="margin-top: 10px;">다시 받기</button>
</form>

	<div class="titleAndDetail" style="margin-top: 80px;">
		<div class="titleAndDetail-title">아이디어 투표 진행시 타이머 설정</div>
		<div class="titleAndDetail-detail">현재까지 제출된 아이디어를 바탕으로 투표를 진행하는 경우, 투표를 할 수 있는 시간을 정해주세요.</div>
	</div>
			<form action="./goStage2" id="goStageForm" method="post">
				<input type="hidden" name="roomId" value="${roomId}">
				<input type="hidden" name="stage" value="${stage}">
				<div style="text-align:left; margin:20px;">
					<input type="number" class="timer-input" name="timer_hours" min="0"
						max="23" placeholder="HH">&nbsp;시&nbsp;&nbsp;&nbsp; <input
						type="number" class="timer-input" name="timer_minutes" min="0"
						max="59" placeholder="MM">&nbsp;분&nbsp;&nbsp;&nbsp; <input
						type="number" class="timer-input" name="timer_seconds" min="0"
						max="59" placeholder="SS">&nbsp;초&nbsp;&nbsp;&nbsp; <span
						class="error-message" id="timerError"></span>
				</div>
				
				<button type="submit" class="yellow-button" style="margin-top: 10px;">투표 진행하기</button>
			</form>



		</div>
		 <script>
    function openModal(index) {
        document.getElementById('modal' + index).style.display = "block";
    }

    function closeModal(index) {
        document.getElementById('modal' + index).style.display = "none";
    }
    
 	// 드롭박스 클릭 시 이벤트 전파 중지
    document.querySelectorAll('select').forEach(function(select) {
        select.addEventListener('click', function(event) {
            event.stopPropagation();
        });
    });

    window.onclick = function(event) {
        if (event.target.className === 'modal') {
            event.target.style.display = "none";
        }
    }
    
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
    
	
    </script>


	</div>
	
</body>
</html>