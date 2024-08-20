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
<title>thinKB - 의견 확장하기</title>
<style>
/* 5개 단계 표시 */
.stages {
	font-family: KB금융 본문체 Light;
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


.ideaOpinionsList-body {
	font-family: KB금융 본문체 Light;
    margin: 0;
    background-color: #FFFFFF;
    margin: 0 auto;
    box-sizing: border-box;
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

/* 4가지 관점 틀 */
.columns {
    width: 60%;
    margin: 0 auto;
}
/* 가운데 내용 부분 */
.container {
    display: flex;
    flex-wrap: wrap; /* 필요 시 줄바꿈을 허용 */
    justify-content: space-between; /* 박스 사이에 공간을 균등하게 배치 */
}
.column {
   width: 48%; 
    margin-bottom: 20px;
    /* display: flex;
    justify-content: space-between; */
    /* flex-wrap: wrap; */
}

/* 객관적관점, 기대효과, 문제점, 실현가능성 박스 */
.box {
	font-family: KB금융 본문체 Light;
    background-color: #ffffff;
    /* border: 1px solid #FFE297; */
    border-radius: 10px;
    padding: 10px;
    height: 350px;
    overflow-y: auto;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.4); /* 그림자 추가 */
}
.section-header {
	font-family: KB금융 제목체 Light;
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}


/* 탭 제목 */
.tab-title {
	font-family: KB금융 제목체 Light;
    font-size: 15pt;
    font-weight: bold;
    text-align: left;
    padding: 10px;
    cursor: pointer;
    border-radius: 10px 10px 0 0;
    color: #000000;
    /* border-bottom: 6px solid #FFE297; */
}
/* .tab-smart { background-color: #007bff; }
.tab-positive { background-color: #ffc107; color: #000000; }
.tab-worry { background-color: #28a745; }
.tab-strict { background-color: #dc3545; } */

.opinion-list {
    list-style-type: none;
    padding: 0;
}
.opinion-entry {
    background-color: #ffeeee;
    padding: 10px;
    border-radius: 10px;
    margin-bottom: 10px;
    font-size: 15pt;
    position: relative;
    cursor: pointer;
    text-align: left;
}
.opinion-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 5px;
}

.name {
    font-weight: bold;
    font-size: 11pt;
}
.date {
    font-size: 8pt;
    color: #777;
}
.opinion-text {
    margin-top: 5px;
    font-size: 10pt; 
    white-space: pre-wrap;
    word-wrap: break-word;
}
.no-opinions {
	font-family: KB금융 본문체 Light;
    color: #ccc;
    font-style: italic;
    text-align: center;
    margin-top: 20px;
    font-size: 12pt;
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
    function navigateToTab(currentTab) {
        var roomId = '${roomId}';
        var ideaId = '${ideaId}';
        var stage= '${stage}';
        var url = '<c:url value="/ideaOpinions2"/>' + '?roomId=' + roomId
                + '&ideaId=' + ideaId + '&currentTab=' + currentTab+'&stage='+stage;
        window.location.href = url;
    }
    
  	//방장이 다음 단계로 버튼 클릭 시 확인 창을 띄우고, 확인 시 이동
    function confirmNextStep() {
        if (confirm("정말로 다음 페이지로 넘어가시겠습니까? \n아이디어 2개가 모두 제출됩니다.")) {
        	const roomId = "${roomId}";
            const ideaId = "${ideaId}";
            window.location.href = "./ideaOpinionsClear2?roomId=" + roomId + "&ideaId=" + ideaId;
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
    
 	// 타이머 종료시 Time Out 표시
    document.addEventListener("DOMContentLoaded", function() {
        const stageId = ${meetingRoom.getStageId()};
        const timerElement = document.getElementById("timer");
        const timerMessageElement = document.getElementById("timer-message");
        if (stageId >= 5) {
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
            
            if (now > endDate) {
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
	
	<!-- 5개 단계 표시 -->
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
	<div class="ideaOpinionList-title2">
        [${ideaTitle}]
    </div>
    
    <!-- 상세설명 -->
	<!-- <button class="grey-button">설명 보기/숨기기</button> -->
	<div class="title-detail">
	    <div class="toggle-container">
	        <div class="toggle-switch">
	            <input type="checkbox" id="toggleDescription" class="toggle-input">
	            <label for="toggleDescription" class="toggle-label">
	                <span class="toggle-inner"></span>
	                <span class="toggle-switch"></span>
	            </label>
	        </div>
	        <span class="toggle-text">설명 보기</span>
	    </div>
	    <div id="descriptionContent" style="display:none;">
	        <pre>${meetingRoom.getDescription()}</pre>
	    </div>
	</div>
	
	<!-- 방장이면 표시 -->
	<div class="rightAligned">
		<c:if test="${userId == roomManagerId}">
			<!-- 현재 단계 완료 참여자 수 -->
			<span class="countDone"> 현재 단계 완료 참여자 수:
				${doneUserCount}/${userCount}</span>
				<c:if test="${meetingRoom.stageId==4}">
			<!-- 다음 단계로 버튼 -->
			<button id="nextStepButton" class="nextStepButton"
				onclick="confirmNextStep()">다음 단계로</button>
				</c:if>
		</c:if>
	</div>
	
	<hr class="line">
	
	<div class="ideaOpinionList-title-detail">4가지 관점중 1가지 관점을 골라 창의적인 의견을 작성해주세요! <br> 다른 관점에 추가 의견 작성도 가능합니다.</div>

    <div class="container">
    	<!-- 객관적관점 -->
        <div class="column">
            <div class="box">
	            <div class="section-header">
					<div class="tab-title tab-smart" onclick="navigateToTab('tab-smart')">객관적관점</div>
					<img src="./resources/nextIcon.png" onclick="navigateToTab('tab-smart')"
					style="width: 15px; height: 15px; float: right; margin-right: 20px; cursor: pointer;">
				</div>
				
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty smartOpinions}">
                            <li class="no-opinions">
                            <img src="./resources/noIdea.png" alt="No opinions"
                                style="width: 110px; height: 150px; vertical-align: middle; margin-top: 30px; margin-right: 10px;">
                                <br> 의견이 아직 등록되지 않았어요!
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${smartOpinions}" varStatus="status">
                                <c:if test="${status.index < 3}">
                                    <li class="opinion-entry" onclick="navigateToTab('tab-smart')" style="background-color: #E7F3FF;">
                                        <div class="opinion-header">
                                            <span class="name">${opinion.userName}</span>
                                            <span class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
                                        </div>
                                        <div class="opinion-text">${opinion.opinionText}</div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
        
        <!-- 기대효과 -->
        <div class="column">
            <div class="box">
            	<div class="section-header">
					<div class="tab-title tab-positive" onclick="navigateToTab('tab-positive')">기대효과</div>
					<img src="./resources/nextIcon.png" onclick="navigateToTab('tab-positive')"
					style="width: 15px; height: 15px; float: right; margin-right: 20px; cursor: pointer;">
				</div>
				
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty positiveOpinions}">
                            <li class="no-opinions">
                            <img src="./resources/noIdea.png" alt="No opinions"
                                style="width: 110px; height: 150px; vertical-align: middle; margin-top: 30px; margin-right: 10px;">
                                <br> 의견이 아직 등록되지 않았어요!
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${positiveOpinions}" varStatus="status">
                                <c:if test="${status.index < 3}">
                                    <li class="opinion-entry" onclick="navigateToTab('tab-positive')" style="background-color: #FFFFE7;">
                                        <div class="opinion-header">
                                            <span class="name">${opinion.userName}</span>
                                            <span class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
                                        </div>
                                        <div class="opinion-text">${opinion.opinionText}</div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
        
        <!-- 문제점 -->
        <div class="column">
            <div class="box">
            	<div class="section-header">
					<div class="tab-title tab-worry" onclick="navigateToTab('tab-worry')">문제점</div>
					<img src="./resources/nextIcon.png" onclick="navigateToTab('tab-worry')"
					style="width: 15px; height: 15px; float: right; margin-right: 20px; cursor: pointer;">
				</div>
                
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty worryOpinions}">
                            <li class="no-opinions">
                            <img src="./resources/noIdea.png" alt="No opinions"
                                style="width: 110px; height: 150px; vertical-align: middle; margin-top: 30px; margin-right: 10px;">
                                <br> 의견이 아직 등록되지 않았어요!
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${worryOpinions}" varStatus="status">
                                <c:if test="${status.index < 3}">
                                    <li class="opinion-entry" onclick="navigateToTab('tab-worry')">
                                        <div class="opinion-header">
                                            <span class="name">${opinion.userName}</span>
                                            <span class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
                                        </div>
                                        <div class="opinion-text">${opinion.opinionText}</div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
        
        <!-- 실현가능성 -->
        <div class="column">
            <div class="box">
            	<div class="section-header">
					<div class="tab-title tab-strict" onclick="navigateToTab('tab-strict')">실현가능성</div>
					<img src="./resources/nextIcon.png" onclick="navigateToTab('tab-strict')"
					style="width: 15px; height: 15px; float: right; margin-right: 20px; cursor: pointer;">
				</div>
                
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty strictOpinions}">
                            <li class="no-opinions">
                            <img src="./resources/noIdea.png" alt="No opinions"
                                style="width: 110px; height: 150px; vertical-align: middle; margin-top: 30px; margin-right: 10px;">
                                <br> 의견이 아직 등록되지 않았어요!
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${strictOpinions}" varStatus="status">
                                <c:if test="${status.index < 3}">
                                    <li class="opinion-entry" onclick="navigateToTab('tab-strict')" style="background-color: #EDFFE7;">
                                        <div class="opinion-header">
                                            <span class="name">${opinion.userName}</span>
                                            <span class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
                                        </div>
                                        <div class="opinion-text">${opinion.opinionText}</div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>