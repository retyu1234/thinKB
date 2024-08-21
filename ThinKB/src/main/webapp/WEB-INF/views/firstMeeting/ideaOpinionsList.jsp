<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%
// 사용자 확인
List<Integer> userIdList = (List<Integer>) request.getAttribute("userIdList");
Integer userId = (Integer) session.getAttribute("userId");
boolean isParticipant = false;

if (userIdList != null && userId != null) {
    for (Integer id : userIdList) {
        if (id.equals(userId)) {
            isParticipant = true;
            break;
        }
    }
}

if (!isParticipant) {
	%>
    <script>
        alert("회의방 참여자가 아닙니다. 회의방 목록 화면으로 이동합니다.");
        window.location.href = "./meetingList";
    </script>
    <%
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>thinKB - 의견 모으기</title>
<style>
.ideaOpinionsList-body {
	font-family: KB금융 본문체 Light;
    margin: 0;
    font-family: 'Arial', sans-serif;
    background-color: #FFFFFF;
    margin: 0 auto;
    box-sizing: border-box;
}

/* 5개 단계 표시 */
.stages {
	display: flex;
	justify-content: space-between;
	padding: 30px 0;
	font-size: 13pt;
}
.stage {
	font-family: KB금융 본문체 Light;
    flex: 1;
    text-align: center;
    padding: 3px; /* 5px에서 3px로 줄임 */
    margin: 0 2px; /* 좌우 여백 추가 */
    cursor: pointer;
    text-decoration: none;
    color: #000;
    white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 함 */
    overflow: hidden; /* 넘치는 텍스트 숨김 */
    text-overflow: ellipsis; /* 넘치는 텍스트를 ...으로 표시 */
}
.active {
	color: #FFD700;
	font-weight: bold;
}
.inactive {
	color: #999;
	pointer-events: none;
}

/* 아이디어 제목 */
.ideaOpinionList-title1 {
	font-family: KB금융 제목체 Light;
	font-size: 20pt;
	color: #909090;
	font-weight: bold;
	margin-top: 40px;
	/* font-style: italic; */
}
.ideaOpinionList-title2 {
	font-family: KB금융 제목체 Light;
	font-size: 17pt;
	color: black;
	font-weight: bold;
	margin-bottom: 20px;
}
.ideaOpinionList-title-detail {
	font-family: KB금융 본문체 Light;
	font-size: 13pt;
	position: relative;
    width: 100%;
    overflow: hidden;
    margin-bottom: 20px;
}

/* 다음 단계로 section */
.rightAligned {
	display: flex;
	justify-content: flex-end;
	align-items: center;
}
/* 현재 단계 완료 참여자 수 */
.countDone {
	font-family: KB금융 본문체 Light;
	font-size: 13pt;
	margin-right: 10px;
}
/* 다음단계로 버튼 */
.nextStepButton {
	font-family: KB금융 제목체 Light;
	background-color: #FFCC00;
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	font-weight: bold;
	cursor: pointer;
	margin-right: 10px;
}
.nextStepButton:hover {
	background-color: #D4AA00;
}
/* 구분선 */
.line {
	margin-top: 15px;
	margin-bottom: 15px;
	border: 2px solid lightgrey;
}

/* 가운데 내용 부분 */
.columns {
    width: 60%;
    margin: 0 auto;
}

/* 4가지 관점 */
.column {
    width: 100%;
    margin-bottom: 20px;
}
.box {
    background-color: #ffffff;
    border-radius: 10px;
    padding: 10px;
    height: auto;
}
.tab-title {
	font-family: KB금융 제목체 Light;
    font-size: 15pt;
    font-weight: bold;
    color: #000000;
}
.section-header {
	font-family: KB금융 제목체 Light;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
    padding: 10px;
    border: 3px solid #ddd;
    border-radius: 30px;
    cursor: pointer;
}
.spacer {
    flex: 1 1 auto;  /* 남은 공간을 모두 차지 */
    min-width: 20px;  /* 최소 너비 설정 */
    min-height: 30px;  /* 최소 높이 설정 */
}
.nav-spacer {
    width: 3px; /* 원하는 간격 크기로 조정 가능 */
    min-height: 30px;
}
.next-icon {
    width: 15px;
    height: 15px;
    margin-left: 20px; /* 우측 정렬을 위해 추가 */
    margin-right: 20px;
    cursor: pointer;
}
.navigate-area {
    display: flex;
    align-items: center;
    flex: 0 0 auto;  /* 고정 크기 유지 */
    padding-left: 4%; /* 왼쪽에 약간의 패딩 추가 */
    border-left: 1px solid #ddd; /* 구분선 추가 */
}
.write-opinion {
    margin-right: 10px;
    font-size: 14px;
    color: #2086FF;
    white-space: nowrap;  /* 텍스트가 줄 바꿈되지 않도록 */
}
/* 토글 */
.toggle-icon {
    font-size: 20px;
    transition: transform 0.3s ease;
    margin-right: 10px;
}
.toggle-icon.open {
    transform: rotate(90deg);
}

/* 작성된 의견들 */
.opinion-list {
    list-style-type: none;
    padding: 0;
    display: none;
}
.opinion-entry {
    padding: 10px;
    border-radius: 10px;
    position: relative;
    width: 90%;
    margin: 10px auto;
    background-color: #ffeeee;
}
.opinion-header {
    display: flex;
    /* justify-content: space-between; */
    align-items: center;
    margin-bottom: 5px;
}
.name {
    font-weight: bold;
    font-size: 13pt;
    margin-left: 10px;
}
.date {
    font-size: 10pt;
    color: #777;
    margin-left: 15px;
}
.opinion-text {
    margin-top: 5px;
    margin-left: 13pt;
    font-size: 13pt;
    white-space: pre-wrap;
}
.toggle-area {
    display: flex;
    align-items: center;
    flex: 0 10px auto;
    cursor: pointer;
    margin-left: 2%;
}
/* 관점별 구분선 */
.divider {
    border-top: 1px solid #ccc;
    margin: 10px 0;
}

/* 의견이 아직 등록되지 않았어요! */
.no-opinions {
    color: #ccc;
    font-style: italic;
    text-align: center;
    margin-top: 20px;
    font-size: 20px;
}

/* 상세설명 - 토글 */
.title-detail {
	font-family: KB금융 본문체 Light;
    display: flex;
    flex-direction: column;
    margin-bottom: 20px;
    width: 100%;
    box-sizing: border-box;
}
.toggle-container {
    display: flex;
    align-items: center;
}
.toggle-switch {
    position: relative;
    display: inline-block;
    width: 60px;
    height: 34px;
    margin-right: 10px;
}
.toggle-text {
    margin-left: 10px;
    vertical-align: middle;
}
#descriptionContent {
	font-family: KB금융 본문체 Light;
    margin-top: 10px;
    padding: 10px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 5px;
    overflow-x: auto; /* 가로 스크롤을 추가합니다 */
    max-width: 100%; /* 최대 너비를 부모 요소에 맞춥니다 */
}
#descriptionContent pre {
	font-family: KB금융 본문체 Light;
    white-space: pre-wrap; /* 긴 줄을 wrap합니다 */
    word-wrap: break-word; /* 긴 단어를 강제로 줄바꿈합니다 */
    max-width: 100%; /* 최대 너비를 부모 요소에 맞춥니다 */
}
.toggle-input {
    opacity: 0;
    width: 0;
    height: 0;
}
.toggle-label {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #ccc;
    transition: .4s;
    border-radius: 34px;
}
.toggle-label:before {
    position: absolute;
    content: "";
    height: 26px;
    width: 26px;
    left: 4px;
    bottom: 4px;
    background-color: white;
    transition: .4s;
    border-radius: 50%;
}
.toggle-input:checked + .toggle-label {
    background-color: #FFCC00;
}
.toggle-input:checked + .toggle-label:before {
    transform: translateX(26px);
}
.toggle-text {
    margin-left: 10px;
    vertical-align: middle;
}
/* 비활성화된 요소를 위한 스타일 추가 */
.disabled-element {
    opacity: 0.5;
    pointer-events: none;
}
.meeting-ended-notice {
    color: #cc0000;
    padding: 10px;
    text-align: center;
    font-weight: bold;
    width: 100%;
    box-sizing: border-box;
    position: sticky;
    top: 0;
    z-index: 1000;
}
/* 스테이지 네비게이션 링크 스타일 */
.stages a {
    pointer-events: auto !important;
    opacity: 1 !important;
}
</style>
<script>
/* 회전 토글 */
function toggleSection(sectionId) {
    var content = document.getElementById(sectionId);
    var icon = document.getElementById(sectionId + '-icon');
    if (content.style.display === "none" || content.style.display === "") {
        content.style.display = "block";
        icon.style.transform = "rotate(90deg)";
    } else {
        content.style.display = "none";
        icon.style.transform = "rotate(0deg)";
    }
}
//방장이 다음 단계로 버튼 클릭 시 확인 창을 띄우고, 확인 시 이동
function confirmNextStep() {
    if (confirm("정말로 다음 페이지로 넘어가시겠습니까? \n아이디어 2개가 모두 제출됩니다.")) {
    	const roomId = "${roomId}";
        const ideaId = "${ideaId}";
        window.location.href = "./ideaOpinionsClear?roomId=" + roomId + "&ideaId=" + ideaId;
    }
}

//상세내역 토글
document.addEventListener('DOMContentLoaded', function() {
	const toggleSwitch = document.getElementById('toggleDescription');
    const toggleText = document.querySelector('.toggle-text');
    const descriptionContent = document.getElementById('descriptionContent');

    if (toggleSwitch) {  // 요소가 존재하는지 확인
        toggleSwitch.addEventListener('change', function() {
            if (this.checked) {
                descriptionContent.style.display = 'block';
                toggleText.textContent = '설명 숨기기';
            } else {
                descriptionContent.style.display = 'none';
                toggleText.textContent = '설명 보기';
            }
        });
    }
});

//타이머 종료시 Time Out 표시
document.addEventListener("DOMContentLoaded", function() {
    const stageId = ${meetingRoom.getStageId()};
    const timerElement = document.getElementById("timer");
    const timerMessageElement = document.getElementById("timer-message");
    if (stageId >= 4) {
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

<%
String[] stages = {"아이디어 초안", "초안 투표하기", "관점별 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
request.setAttribute("stages", stages);
%>

</script>
<script>
function navigateToTab(currentTab) {
    var container = document.getElementById('dataContainer');
    var roomId = container.dataset.roomId;
    var ideaId = container.dataset.ideaId;
    var stage= container.dataset.stageId;
    var url = './ideaOpinions?roomId=' + roomId + '&ideaId=' + ideaId + '&currentTab=' + currentTab+'&stage='+stage;
    window.location.href = url;
}
</script>
<script>
    // 특정 요소 비활성화 함수
    function disableInteraction() {
        const elementsToDisable = document.querySelectorAll('input, textarea, button, select');
        elementsToDisable.forEach(element => {
            if (!element.closest('.stages')) {  // stages 클래스 내부의 요소는 제외
                element.disabled = true;
                element.classList.add('disabled-element');
            }
        });

        // 폼 제출 방지
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
            form.onsubmit = function(e) {
                e.preventDefault();
                return false;
            };
        });

        // 회의 종료 안내 메시지 추가
        const notice = document.createElement('div');
        notice.className = 'meeting-ended-notice';
        notice.innerHTML = '회의 기간이 종료되어 더 이상 수정이 불가능합니다. 단, 스테이지 간 이동은 가능합니다.';
        
        // 헤더 다음에 알림 삽입
        const header = document.querySelector('header');
        if (header && header.nextSibling) {
            header.parentNode.insertBefore(notice, header.nextSibling);
        } else {
            document.body.insertBefore(notice, document.body.firstChild);
        }

        // stages 클래스 내부의 요소들은 비활성화에서 제외
        const stageLinks = document.querySelectorAll('.stages a');
        stageLinks.forEach(link => {
            link.classList.remove('disabled-element');
        });
    }

 // 페이지 로드 시 실행
    window.onload = function() {
        // 기존 onload 함수 내용 유지
        
        // 회의 기간 종료 확인
        const endDateStr = '${meetingRoom.getEndDate()}';
        if (endDateStr) {
            const endDate = new Date(endDateStr);
            const now = new Date();
            
            // 종료일의 다음날 자정을 계산
            const dayAfterEnd = new Date(endDate);
            dayAfterEnd.setDate(dayAfterEnd.getDate() + 1);
            dayAfterEnd.setHours(0, 0, 0, 0);
            
            if (now >= dayAfterEnd) {
                disableInteraction();
            }
        }
    };
</script>
</head>
<body class="ideaOpinionsList-body">
	<%@ include file="../header.jsp"%>
	<%@ include file="../leftSideBar.jsp"%>
	<%@ include file="../rightSideBar.jsp"%>

	<div class="columns">

		<%-- 	<div class="stages">
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
	</div> --%>
		<!-- 5개 단계 표시 -->
		<div class="stages">
			<c:forEach var="stage" items="${stages}" varStatus="status">
				<c:choose>
					<c:when test="${meetingRoom.getStageId() >= status.index + 1}">
						<a
							href="./roomDetail?roomId=${meetingRoom.getRoomId()}&stage=${status.index + 1}&ideaId=${yesPickList[0].getIdeaID()}"
							class="stage ${meetingRoom.getStageId() == status.index + 1 ? 'active' : ''}">
							${status.index + 1}. ${stage} </a>
					</c:when>
					<c:otherwise>
						<div class="stage inactive">${status.index + 1}.${stage}</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div id="dataContainer" data-room-id="${roomId}"
			data-idea-id="${ideaId}" data-stage-id="${stage}"></div>
		<!-- 제목 -->
		<div class="ideaOpinionList-title1">
			<c:choose>
				<c:when test="${ideaId == yesPickList[0].ideaID}">
	           아이디어 A
	       	</c:when>
				<c:otherwise>
	           아이디어 B
       		</c:otherwise>
			</c:choose>
		</div>
		<div class="ideaOpinionList-title2">[${ideaTitle}]</div>
		<input type="hidden" id="hiddenIdeaId" value="${ideaId}">

		<!-- 상세설명 -->
		<!-- <button class="grey-button">설명 보기/숨기기</button> -->
		<div class="title-detail">
			<div class="toggle-container">
				<div class="toggle-switch">
					<input type="checkbox" id="toggleDescription" class="toggle-input">
					<label for="toggleDescription" class="toggle-label"> <span
						class="toggle-inner"></span> <span class="toggle-switch"></span>
					</label>
				</div>
				<span class="toggle-text">설명 보기</span>
			</div>
			<div id="descriptionContent" style="display: none;">
				<pre>${meetingRoom.getDescription()}</pre>
			</div>
		</div>

		<!-- 방장이면 표시 -->
		<div class="rightAligned">
			<c:if test="${userId == roomManagerId}">
				<!-- 현재 단계 완료 참여자 수 -->
				<span class="countDone"> 현재 단계 완료 참여자 수:
					${doneUserCount}/${userCount}</span>
					<c:if test="${meetingRoom.stageId==3}">
				<!-- 다음 단계로 버튼 -->
				<button id="nextStepButton" class="nextStepButton"
					onclick="confirmNextStep()">다음 단계로 </button>
					</c:if>
			</c:if>
		</div>

		<hr class="line">

		<div class="ideaOpinionList-title-detail">4가지 관점 중 2가지 관점을 골라
			창의적인 의견을 작성해주세요!</div>

		<!-- 객관적관점 -->
		<div class="column">
			<div class="box">
				<div class="section-header">
					<div class="toggle-area" onclick="toggleSection('smart-opinions')">
						<span id="smart-opinions-icon" class="toggle-icon">▶</span>
						<div class="tab-title tab-smart">객관적관점</div>
					</div>
					<div class="spacer" onclick="toggleSection('smart-opinions')"></div>
					<div class="nav-spacer" onclick="navigateToTab('tab-smart')"></div>
					<div class="navigate-area" onclick="navigateToTab('tab-smart')">
						<span class="write-opinion">의견 작성하러가기</span> 
							<img src="./resources/nextIcon.png" class="next-icon">
					</div>
				</div>
				<ul id="smart-opinions" class="opinion-list">
					<c:choose>
						<c:when test="${empty smartOpinions}">
							<li class="no-opinions"><img src="./resources/noIdea.png"
								alt="No opinions"
								style="width: 60px; height: 80px; vertical-align: middle; margin-right: 10px;">
								<br> 의견이 아직 등록되지 않았어요!</li>
						</c:when>
						<c:otherwise>
							<c:forEach var="opinion" items="${smartOpinions}">
								<li class="opinion-entry" style="background-color: #E7F3FF;">
									<div class="opinion-header">
										<span class="name">${opinion.userName}</span> <span
											class="date"><fmt:formatDate
												value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
									</div>
									<div class="opinion-text">${opinion.opinionText}</div>
								</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			<div class="divider"></div>
		</div>

		<!-- 기대효과 의견 목록 -->
		<div class="column">
			<div class="box">
				<div class="section-header">
					<div class="toggle-area"
						onclick="toggleSection('positive-opinions')">
						<span id="smart-opinions-icon" class="toggle-icon">▶</span>
						<div class="tab-title tab-positive">기대효과</div>
					</div>
					<div class="spacer" onclick="toggleSection('positive-opinions')"></div>
					<div class="nav-spacer" onclick="navigateToTab('tab-positive')"></div>
					<div class="navigate-area" onclick="navigateToTab('tab-positive')">
						<span class="write-opinion">의견 작성하러가기</span> <img
							src="./resources/nextIcon.png" class="next-icon">
					</div>
				</div>
				<ul id="positive-opinions" class="opinion-list">
					<c:choose>
						<c:when test="${empty positiveOpinions}">
							<li class="no-opinions"><img src="./resources/noIdea.png"
								alt="No opinions"
								style="width: 60px; height: 80px; vertical-align: middle; margin-right: 10px;">
								<br> 의견이 아직 등록되지 않았어요!</li>
						</c:when>
						<c:otherwise>
							<c:forEach var="opinion" items="${positiveOpinions}">
								<li class="opinion-entry" style="background-color: #FFFFE7;">
									<div class="opinion-header">
										<span class="name">${opinion.userName}</span> <span
											class="date"><fmt:formatDate
												value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
									</div>
									<div class="opinion-text">${opinion.opinionText}</div>
								</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			<div class="divider"></div>
		</div>

		<!-- 문제점 의견 목록 -->
		<div class="column">
			<div class="box">
				<div class="section-header">
					<div class="toggle-area" onclick="toggleSection('worry-opinions')">
						<span id="smart-opinions-icon" class="toggle-icon">▶</span>
						<div class="tab-title tab-smart">문제점</div>
					</div>
					<div class="spacer" onclick="toggleSection('worry-opinions')"></div>
					<div class="nav-spacer" onclick="navigateToTab('tab-worry')"></div>
					<div class="navigate-area" onclick="navigateToTab('tab-worry')">
						<span class="write-opinion">의견 작성하러가기</span> <img
							src="./resources/nextIcon.png" class="next-icon">
					</div>
				</div>
				<ul id="worry-opinions" class="opinion-list">
					<c:choose>
						<c:when test="${empty worryOpinions}">
							<li class="no-opinions"><img src="./resources/noIdea.png"
								alt="No opinions"
								style="width: 60px; height: 80px; vertical-align: middle; margin-right: 10px;">
								<br> 의견이 아직 등록되지 않았어요!</li>
						</c:when>
						<c:otherwise>
							<c:forEach var="opinion" items="${worryOpinions}">
								<li class="opinion-entry">
									<div class="opinion-header">
										<span class="name">${opinion.userName}</span> <span
											class="date"><fmt:formatDate
												value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
									</div>
									<div class="opinion-text">${opinion.opinionText}</div>
								</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			<div class="divider"></div>
		</div>
		<!-- 실현가능성 의견 목록 -->
		<div class="column">
			<div class="box" style="margin-bottom: 100px;">
				<div class="section-header">
					<div class="toggle-area" onclick="toggleSection('strict-opinions')">
						<span id="smart-opinions-icon" class="toggle-icon">▶</span>
						<div class="tab-title tab-smart">실현가능성</div>
					</div>
					<div class="spacer" onclick="toggleSection('strict-opinions')"></div>
					<div class="nav-spacer" onclick="navigateToTab('tab-strict')"></div>
					<div class="navigate-area" onclick="navigateToTab('tab-strict')">
						<span class="write-opinion">의견 작성하러가기</span> <img
							src="./resources/nextIcon.png" class="next-icon">
					</div>
				</div>
				<ul id="strict-opinions" class="opinion-list">
					<c:choose>
						<c:when test="${empty strictOpinions}">
							<li class="no-opinions"><img src="./resources/noIdea.png"
								alt="No opinions"
								style="width: 60px; height: 80px; vertical-align: middle; margin-right: 10px;">
								<br> 의견이 아직 등록되지 않았어요!</li>
						</c:when>
						<c:otherwise>
							<c:forEach var="opinion" items="${strictOpinions}">
								<li class="opinion-entry" style="background-color: #EDFFE7;">
									<div class="opinion-header">
										<span class="name">${opinion.userName}</span> <span
											class="date"><fmt:formatDate
												value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
									</div>
									<div class="opinion-text">${opinion.opinionText}</div>
								</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>