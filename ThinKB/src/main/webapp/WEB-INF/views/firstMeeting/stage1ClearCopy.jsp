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
	overflow-x: hidden;
    width: 100%;
}

.stage1clear-header {
	position: relative;
	z-index: 1;
}

.room1-content {
	padding: 20px;
	margin-left: 20%;
	margin-right: 20%;
	z-index: 2;
	/* margin-top: 120px; */
}

.room1-title {
	font-size: 20pt;
	color: black;
	font-weight: bold;
	margin-top: 10px;
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
	font-size: 15pt;
	text-align: left;
}

.idea-title .icon {
	margin-right: 10px;
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
	margin: 0 40px;
	line-height: 1.5;
	display: inline-block;
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
	font-size: 13pt;
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

.reject-modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.4);
    overflow: auto; /* 'hidden'에서 'auto'로 변경 */
}

.reject-modal-content {
    width: 60%;
    max-height: 90vh; /* 최대 높이를 뷰포트 높이의 90%로 제한 */
    margin: 5vh auto; /* 상하 여백을 뷰포트 높이의 5%로 설정 */
    padding: 20px;
    background: white;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    overflow: hidden; /* 내용이 넘칠 경우 숨김 */
}

.reject-modal-footer {
    text-align: center;
    padding: 20px;
}

/* 스크롤바 스타일 */
.scrollable-content {
    flex-grow: 1;
    overflow-y: auto;
    padding-right: 10px;
    max-height: calc(100% - 120px); /* 헤더와 푸터를 고려한 높이 조정 */
}

.scrollable-content::-webkit-scrollbar {
    width: 10px;
}

.scrollable-content::-webkit-scrollbar-track {
    background: #f1f1f1;
}

.scrollable-content::-webkit-scrollbar-thumb {
    background: #888;
    border-radius: 5px;
}

.scrollable-content::-webkit-scrollbar-thumb:hover {
    background: #555;
}

.reject-modal-body {
    flex-grow: 1;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    padding: 0 20px; /* 좌우 패딩 추가 */
}

.reject-modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 20px 20px 20px;
}

.reject-modal-body::-webkit-scrollbar {
	width: 10px;
}

.reject-modal-body::-webkit-scrollbar-track {
	background: #f1f1f1;
}

.reject-modal-body::-webkit-scrollbar-thumb {
	background: #888;
	border-radius: 5px;
}

.reject-modal-body::-webkit-scrollbar-thumb:hover {
	background: #555;
}

body.reject-modal-open {
	overflow: hidden;
}

.reject-close {
	cursor: pointer;
	font-size: 35px;
	margin-right: 20px;
}

.reject-close:hover {
	color: red;
}
.reject-modal-body .idea-box,
.reject-modal-body .titleAndDetail,
.reject-modal-body form {
    width: 100%; /* 부모 요소의 전체 너비 사용 */
    box-sizing: border-box; /* padding과 border를 width에 포함 */
}

.line {
	margin-top: 15px;
	margin-bottom: 15px;
	border: 2px solid lightgrey;
}

</style>
</head>
<body style="margin: 0;">
	<!-- 헤더영역 -->
	<header class="stage1clear-header">
		<%@ include file="../header.jsp"%>
	</header>

	<!-- 왼쪽 sideBar -->
	<%@ include file="../leftSideBar.jsp"%>

	<div class="room1-content">

	<!-- 6개 단계 표시 -->
	<%
	    String[] stages =  {"아이디어 초안", "초안 투표하기", "관점별 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
	    request.setAttribute("stages", stages);
	%>

	<div class="stages">
	    <c:forEach var="stage" items="${stages}" varStatus="status">
	        <c:choose>
	            <c:when test="${meetingRoom.getStageId() >= status.index + 1}">
	                <a
	                    href="./roomDetail?roomId=${meetingRoom.getRoomId()}&stage=${status.index + 1}&ideaId=${yesPickList[0].getIdeaID()}"
	                    class="stage ${meetingRoom.getStageId() == status.index + 1 ? 'active' : ''}">
	                    ${status.index + 1}. ${stage}
	                </a>
	            </c:when>
	            <c:otherwise>
	                <div class="stage inactive">${status.index + 1}. ${stage}</div>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	</div>

		<!-- 상단 회의방 이름, 단계 설명 -->
		<div class="room1-title">[${meetingRoom.getRoomTitle()}] 투표 진행여부 결정</div>
		<div class="room1-title-detail">이전 단계에서 수집된 아이디어 목록이에요. 아이디어를 다시
			받으려면 반려사유를 선택해서 "다시 받기" 버튼을 눌러주세요.</div>
		<div class="room1-title-detail">※ 단 '다시 받기'는 전체 아이디어에 같이 적용됩니다.</div>

		<!-- 다시받기버튼 -->
		<div style="text-align: right;">
			<button type="button" class="grey-button" style="margin-top: 10px;">
			아이디어 다시 받기</button>
		</div>
		
		<hr class="line">

		<!-- 모달 -->
<div id="ideaModal" class="reject-modal">
    <div class="reject-modal-content">
        <div class="reject-modal-header">
            <h2>아이디어 다시받기</h2>
            <span class="reject-close">&times;</span>
        </div>
        <div class="reject-modal-body">
            <div class="room1-title" style="font-size: 18pt;">아이디어 목록</div>
            <div class="scrollable-content">
                <form id="ideaForm2" action="./goReset" method="post">
                    <input type="hidden" name="roomId" value="${roomId}">
                    <input type="hidden" name="stage" value="${stage}">
                    <c:forEach var="li" items="${ideaList}" varStatus="status">
                        <div class="idea-box">
                            <div class="idea-title">
                                <span class="icon">💡</span> ${li.getTitle()}
                            </div>
                            <div class="idea-detail">
                                <span style="font-weight: bold; color: #007AFF;">상세설명</span><br>
                                <span>${li.getDescription()}</span>
                            </div>
                            <span style="font-size: 13pt; margin-left:25px;">반려시 사유선택</span>
                            <input type="hidden" name="rejectLog[${status.index}].ideaId" value="${li.getIdeaID()}">
                            <select name="rejectLog[${status.index}].rejectContents">
                                <option value="">아이디어 반려 사유를 선택해주세요.</option>
                                <option value="기시행중인 유사 서비스 존재">기시행중인 유사 서비스 존재</option>
                                <option value="서비스 효용 대비 비용과다">서비스 효용 대비 비용과다</option>
                                <option value="주제 범위에 벗어나거나 상관없는 아이디어">주제 범위에 벗어나거나 상관없는 아이디어</option>
                                <option value="관련 규정으로 실현 불가능한 아이디어">관련 규정으로 실현 불가능한 아이디어</option>
                                <option value="좋은 아이디어로 확장, 구체화해서 재제출 요청">좋은 아이디어로 확장, 구체화해서 재제출 요청</option>
                            </select>
                        </div>
                    </c:forEach>
                    <div class="titleAndDetail" style="margin-top: 50px;">
                        <div class="titleAndDetail-title">아이디어 다시 받는 경우 타이머 설정</div>
                        <div class="titleAndDetail-detail">회의 참여자들이 아이디어를 다시 작성할 수 있는 시간을 정해주세요.</div>
                    </div>
                    <div style="text-align: left; margin: 20px;">
                        <input type="number" class="timer-input" name="timer_hours"
                            min="0" max="23" placeholder="HH">&nbsp;시&nbsp;&nbsp;&nbsp;
                        <input type="number" class="timer-input" name="timer_minutes"
                            min="0" max="59" placeholder="MM">&nbsp;분&nbsp;&nbsp;&nbsp;
                        <input type="number" class="timer-input" name="timer_seconds"
                            min="0" max="59" placeholder="SS">&nbsp;초&nbsp;&nbsp;&nbsp;
                        <span class="error-message" id="timerError"></span>
                    </div>
                </form>
            </div>
        </div>
        <div class="reject-modal-footer">
            <button type="button" id="submitButton" class="yellow-button">다시 받기</button>
        </div>
    </div>
</div>

		<!-- 아이디어 목록 -->
		<div class="room1-title" style="font-size: 18pt; margin-top: 30px;">아이디어 목록</div>
		<div style="text-align: center;">
				<c:forEach var="li" items="${ideaList}" varStatus="status">
					<div class="idea-box">
						<div class="idea-title" >
							<span class="icon">💡</span> ${li.getTitle()}
						</div>
						<div class="idea-detail">
							<span style="font-weight: bold; color: #007AFF;">상세설명</span><br>
							<span>${li.getDescription()}</span>
						</div>
						
					</div>
				</c:forEach>

			<div class="titleAndDetail" style="margin-top: 80px;">
				<div class="titleAndDetail-title">아이디어 투표 진행시 타이머 설정</div>
				<div class="titleAndDetail-detail">상단의 아이디어를 바탕으로 투표를 진행 시 투표 가능 시간을 정해주세요.</div>
			</div>
			<form action="./goStage2" id="goStageForm" method="post">
				<input type="hidden" name="roomId" value="${roomId}">
				<input type="hidden" name="stage" value="${stage}">
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
<div style="margin-top:100px;"></div>
	</div>
	<!-- 오른쪽 sideBar -->
	<%@ include file="../rightSideBar.jsp"%>

	<script>  
	// 모달 관련 JavaScript
	var modal = document.getElementById("ideaModal");
	var openBtn = document.querySelector(".grey-button");
	var closeBtn = document.getElementsByClassName("reject-close")[0];

	openBtn.onclick = function() {
		  modal.style.display = "block";
		  document.body.classList.add('reject-modal-open');
		}

		closeBtn.onclick = function() {
		  modal.style.display = "none";
		  document.body.classList.remove('reject-modal-open');
		}

		window.onclick = function(event) {
		  if (event.target == modal) {
		    modal.style.display = "none";
		    document.body.classList.remove('reject-modal-open');
		  }
		}

	// 모달 내부의 submit 버튼에 대한 이벤트 리스너
	// 모달 내부의 submit 버튼에 대한 이벤트 리스너
document.getElementById('submitButton').addEventListener('click', function(e) {
  e.preventDefault();
  
  var selects = document.querySelectorAll('#ideaModal select[name^="rejectLog"]');
  var anySelected = false;
  
  selects.forEach(function(select) {
    if (select.value !== "") {
      anySelected = true;
      select.style.border = "";
    } else {
      select.style.border = "";
    }
  });
  
  var timerHours = document.querySelector('#ideaModal input[name="timer_hours"]').value;
  var timerMinutes = document.querySelector('#ideaModal input[name="timer_minutes"]').value;
  var timerSeconds = document.querySelector('#ideaModal input[name="timer_seconds"]').value;
  var timerInputted = timerHours !== "" || timerMinutes !== "" || timerSeconds !== "";
  
  if (!timerInputted) {
    document.querySelectorAll('#ideaModal input[type="number"]').forEach(function(input) {
      input.style.border = "2px solid red";
    });
  } else {
    document.querySelectorAll('#ideaModal input[type="number"]').forEach(function(input) {
      input.style.border = "";
    });
  }
  
  if (anySelected && timerInputted) {
    // 선택된 아이디어만 폼에 포함
    var form = document.getElementById('ideaForm2');
    selects.forEach(function(select, index) {
      if (select.value === "") {
        var ideaIdInput = form.querySelector(`input[name="rejectLog[${index}].ideaId"]`);
        if (ideaIdInput) {
          ideaIdInput.remove();
        }
        select.remove();
      }
    });
    form.submit();
  } else {
    if (!anySelected) {
      alert('최소 하나의 아이디어에 대해 반려 사유를 선택해주세요.');
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
</body>
</html>