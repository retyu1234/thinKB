<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디어 의견 요약</title>
<style>
.ideaOpinionsList-body {
    margin: 0;
    font-family: 'Arial', sans-serif;
    background-color: #FFFFFF;
    margin: 0 auto;
    box-sizing: border-box;
}

/* 5단계 표시 */
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
    white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 함 */
    overflow: hidden; /* 넘치는 텍스트 숨김 */
    text-overflow: ellipsis; /* 넘치는 텍스트를 ...으로 표시 */
}

/* 아이디어 제목 & 설명 */
.ideaOpinionList-title1 {
	font-size: 20pt;
	color: #909090;
	font-weight: bold;
	margin-top: 40px;
	/* font-style: italic; */
}
.ideaOpinionList-title2 {
	font-size: 17pt;
	color: black;
	font-weight: bold;
	margin-bottom: 20px;
}
.ideaOpinionList-title-detail {
	font-size: 13pt;
	position: relative;
    width: 100%;
    overflow: hidden;
    margin-bottom: 20px;
}
/* 아이디어 설명보기 숨기기버튼 */
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
/* 다음 단계로 section */
.rightAligned {
	display: flex;
	justify-content: flex-end;
	align-items: center;
}
/* 현재 단계 완료 참여자 수 */
.countDone {
	font-size: 13pt;
	margin-right: 10px;
}
/* 다음단계로 버튼 */
.nextStepButton {
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
    font-size: 15pt;
    font-weight: bold;
    color: #000000;
}
.section-header {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    cursor: pointer;
    padding: 10px;
    border: 3px solid #ddd;
    border-radius: 30px;
}
.next-icon {
    width: 15px;
    height: 15px;
    margin-left: auto; /* 우측 정렬을 위해 추가 */
    margin-right: 20px;
    cursor: pointer;
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
    margin-bottom: 20px;
    position: relative;
    width: 90%;
    margin: 0 auto;
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
</style>
<script>
/* 회전 토글 */
function toggleSection(sectionId) {
    var content = document.getElementById(sectionId);
    var icon = document.getElementById(sectionId + '-icon');
    if (content.style.display === "none" || content.style.display === "") {
        content.style.display = "block";
        icon.classList.add('open');
    } else {
        content.style.display = "none";
        icon.classList.remove('open');
    }
}

/* 탭 이름 클릭시 이동 */
function navigateToTab(currentTab) {
    var roomId = '${roomId}';
    var ideaId = '${ideaId}';
    var url = '<c:url value="/ideaOpinions"/>' + '?roomId=' + roomId
            + '&ideaId=' + ideaId + '&currentTab=' + currentTab;
    window.location.href = url;
}

<%
String[] stages = {"아이디어 초안", "초안 투표하기", "관점별 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
request.setAttribute("stages", stages);
%>
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

	<!-- 제목 상세설명 -->
<!-- 	<div class="ideaOpinionList-title1">
	  {yesPickList[0] ? "아이디어 A" : "아이디어 B"}
	</div> -->
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
	<button class="grey-button">설명 보기/숨기기</button>
	
	<!-- 방장이면 표시 -->
	<div class="rightAligned">
		<c:if test="${userId == roomManagerId}">
			<!-- 현재 단계 완료 참여자 수 -->
			<span class="countDone"> 현재 단계 완료 참여자 수:
				${doneUserCount}/${userCount}</span>
			<!-- 다음 단계로 버튼 -->
			<button id="nextStepButton" class="nextStepButton"
				onclick="confirmNextStep()">다음 단계로</button>
		</c:if>
	</div>
	
	<hr class="line">
	
	<div class="ideaOpinionList-title-detail">4가지 관점 중 2가지 관점을 골라 창의적인 의견을 작성해주세요!</div>
	
	<!-- 객관적관점 -->
    <div class="column">
        <div class="box">
            <div class="section-header" onclick="toggleSection('smart-opinions')">
			    <span id="smart-opinions-icon" class="toggle-icon">▶</span>
			    <div class="tab-title tab-smart" onclick="navigateToTab('tab-smart')">객관적관점</div>
			    <img src="./resources/nextIcon.png" onclick="navigateToTab('tab-smart')" class="next-icon">
			</div>
			
            <ul id="smart-opinions" class="opinion-list">
                <c:choose>
                    <c:when test="${empty smartOpinions}">
                        <li class="no-opinions">
						<img src="./resources/noIdea.png" alt="No opinions"
                                style="width: 60px; height: 80px; vertical-align: middle; margin-right: 10px;">
                                <br> 의견이 아직 등록되지 않았어요!
                        </li>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="opinion" items="${smartOpinions}">
                            <li class="opinion-entry" style="background-color: #E7F3FF;">
                                <div class="opinion-header">
                                    <span class="name">${opinion.userName}</span>
                                    <span class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
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
            <div class="section-header" onclick="toggleSection('positive-opinions')">
            	<span id="smart-opinions-icon" class="toggle-icon">▶</span>
			    <div class="tab-title tab-positive" onclick="navigateToTab('tab-positive')">기대효과</div>
			    <img src="./resources/nextIcon.png" onclick="navigateToTab('tab-positive')" class="next-icon">
            </div>
            <ul id="positive-opinions" class="opinion-list">
                <c:choose>
                    <c:when test="${empty positiveOpinions}">
                        <li class="no-opinions">
						<img src="./resources/noIdea.png" alt="No opinions"
                                style="width: 60px; height: 80px; vertical-align: middle; margin-right: 10px;">
                                <br> 의견이 아직 등록되지 않았어요!
                        </li>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="opinion" items="${positiveOpinions}">
                            <li class="opinion-entry" style="background-color: #fffde7;">
                                <div class="opinion-header">
                                    <span class="name">${opinion.userName}</span>
                                    <span class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
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
            <div class="section-header" onclick="toggleSection('worry-opinions')">
                <span id="worry-opinions-icon" class="toggle-icon">▶</span>
                <div class="tab-title tab-worry" onclick="navigateToTab('tab-worry')">문제점</div>
			    <img src="./resources/nextIcon.png" onclick="navigateToTab('tab-worry')" class="next-icon">
            </div>
            <ul id="worry-opinions" class="opinion-list">
                <c:choose>
                    <c:when test="${empty worryOpinions}">
                        <li class="no-opinions">
						<img src="./resources/noIdea.png" alt="No opinions"
                                style="width: 60px; height: 80px; vertical-align: middle; margin-right: 10px;">
                                <br> 의견이 아직 등록되지 않았어요!
                        </li>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="opinion" items="${worryOpinions}">
                            <li class="opinion-entry" style="background-color: #fffde7;">
                                <div class="opinion-header">
                                    <span class="name">${opinion.userName}</span>
                                    <span class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
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
        <div class="box">
            <div class="section-header" onclick="toggleSection('strict-opinions')">
                <span id="strict-opinions-icon" class="toggle-icon">▶</span>
                <div class="tab-title tab-strict" onclick="navigateToTab('tab-strict')">실현가능성</div>
			    <img src="./resources/nextIcon.png" onclick="navigateToTab('tab-strict')" class="next-icon">
            </div>
            <ul id="strict-opinions" class="opinion-list">
                <c:choose>
                    <c:when test="${empty strictOpinions}">
                        <li class="no-opinions">
						<img src="./resources/noIdea.png" alt="No opinions"
                                style="width: 60px; height: 80px; vertical-align: middle; margin-right: 10px;">
                                <br> 의견이 아직 등록되지 않았어요!
                        </li>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="opinion" items="${strictOpinions}">
                            <li class="opinion-entry" style="background-color: #fffde7;">
                                <div class="opinion-header">
                                    <span class="name">${opinion.userName}</span>
                                    <span class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
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