<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>thinKB - 의견 확장하기</title>
<style>
.ideaOpinions2-body {
	font-family: KB금융 본문체 Light;
    margin: 0;
    background-color: #FFFFFF;
    width: 60%;
    margin: 0 auto;
    box-sizing: border-box;
    padding: 20px;
    /* 수지 */
   /*  display: flex; */
    /* align-items: center; */
}

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

/* 뒤로가기 버튼 */
.back-btn{
   width: 30px;
   height: 30px;
   margin-top: 40px;
   margin-right: 15px;
   text-decoration: none; /* 링크의 기본 밑줄 제거 */
}
.back-btn:hover {
    opacity: 0.8; /* 이미지가 살짝 투명해지게 설정 */
    transform: scale(1.2); /* 이미지가 살짝 커지도록 설정 */
    transition: all 0.3s ease; /* 부드러운 전환 효과 */
}
a {
    text-decoration: none; /* 링크 전체에 밑줄 제거 */
}

/* 아이디어 제목 */
.ideaOpinionList-title1 {
	font-family: KB금융 제목체 Light;
	font-size: 20pt;
	color: #909090;
	font-weight: bold;
	margin-top: 10px;
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
    margin-top: 10px;
    padding: 10px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 5px;
    overflow-x: auto; /* 가로 스크롤을 추가합니다 */
    max-width: 100%; /* 최대 너비를 부모 요소에 맞춥니다 */
}
#descriptionContent pre {
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

.rightAligned {
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

/* 구분선 */
.line {
	margin-top: 15px;
	margin-bottom: 15px;
	border: 2px solid lightgrey;
}
    
/* 4가지 탭 */
.tabs {
	font-family: KB금융 제목체 Light;
    display: flex;
    /* justify-content: space-around; */
    justify-content: flex-start; /* 탭들을 왼쪽으로 몰리게 함 */
    gap: 10px; /* 탭 간의 간격 조절 */
    margin-top: 15px;
    margin-bottom: 50px;
}
.tab {
    padding: 15px 25px;
	cursor: pointer;
	font-size: 15pt;
	font-weight: bold;
	color: #909090; /* 기본 색상 */
	transition: background-color 0.3s ease, color 0.3s ease;
	clip-path: polygon(0 0, 100% 0, 90% 100%, 10% 100%);
	flex: 1;
	text-align: center;
	text-decoration: none; /* 기본 밑줄 제거 */	
}
/* 선택된 탭 */
.tab.active {
    color: black; /* 선택된 탭의 글자색 */
    border-bottom: 6px solid #FFE297; /* 선택된 탭의 밑줄 색상 */
    width: 80%; /* 선택된 탭의 밑줄 길이 줄이기 */
    margin: 0 auto; /* 가운데 정렬 */
}

/* 작성버튼 */
.write-button {
	font-family: KB금융 제목체 Light;
    width: 100px;
    height: 50px;
    border: none;
    background-color: #FFCC00;
    color: #000;
    font-size: 13pt;
    font-weight: bold;
    padding: 0 20px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin-bottom: 50px;
}
.write-button:hover {
    background-color: #D4AA00;
}

/* 의견을 입력해주세요란 */
.opinion-textarea {
	font-family: KB금융 본문체 Light;
    width: calc(100% - 120px);
    /* min-height: 50px; */
    max-height: 200px;
    overflow-y: auto;
    resize: vertical;
    line-height: 1.5;
    white-space: pre-wrap;
    word-wrap: break-word;
    margin-right: 10px;
    margin-bottom: 50px;
    border: 2px solid #ccc;
    padding: 12px;
    border-radius: 5px;
    box-sizing: border-box;
    font-size: 12pt;
    font-weight: bold;
}
.opinion-textarea:focus {
	outline: none; /* 기본 포커스 스타일 제거 */
	border: 1px solid #ffc107; /* 두꺼운 노란색 테두리 */
	box-shadow: 0 0 5px rgba(255, 193, 7, 0.5); /* 선택적: 약간의 그림자 효과 */
}


    
    
    .columns {
        display: flex;
        justify-content: space-between;
    }
    .column {
        width: 45%;
    }
    .preOpinion-list, .currentOpinion-list {
        width: 100%;
        list-style-type: none;
        padding: 0;
    }
    .box {
        background-color: #FFFFFF;
        border: 1px solid #000;
        border-radius: 10px;
        padding: 10px;
        margin-bottom: 20px;
        height: 365px;
        overflow-y: auto;
    }
    .tab-title {
        font-size: 30px;
        margin-bottom: 10px;
        text-align: center;
        color: #fff;
    }
    .no-opinions {
        color: #909090; /* 기본 색상 */
		font-style: italic; /* 기울임꼴로 표시 */
		text-align: center;
		margin-top: 30px;
		margin-bottom: 30px;
		font-size: 13pt;
	}
    /* 기존 의견들, 현재 의견들 */
    .opinion-title {
    	font-family: KB금융 제목체 Light;
    	font-size: 15pt;
    	font-weight: bold;
    }
    /* 기존 의견들 탭 */
    .opinion-entry1 {
        background-color: #EEEEEE; /* 연한회색 */
        padding: 10px;
        border-radius: 10px;
        margin-bottom: 10px;
        font-size: 20px;
        position: relative;
        text-align: left;
    }
    /* 현재 의견들 탭 */
    .opinion-entry2 {
        background-color: #FFE297; /* 노란색 */
        padding: 10px;
        border-radius: 10px;
        margin-bottom: 10px;
        font-size: 20px;
        position: relative;
        text-align: left;
    }
    
    .opinion-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start; /* 세로 정렬을 위쪽에 맞추기 위해 flex-start 사용 */
    }
    .opinion-header .name-date {
        display: flex;
        align-items: center;
    }
    .name {
        margin-right: 10px;
        font-size: 13pt;
        font-weight: bold;
    }
    .date {
        font-size: 10pt;
        color: #777;
    }
    .opinion-text {
        margin: 10px 0;
        font-size: 10pt;
        white-space: pre-wrap;
    	word-wrap: break-word;
    }
    
    /* 좋아요 */
     /* 좋아요 */
    .like-section {
        display: flex;
        flex-direction: column; /* 좋아요 버튼과 좋아요 수를 다른 줄로 배치 */
        align-items: center;
        justify-content: center;
        margin-bottom: 10px;
    }
    .like-button {
        background: none;
        border: none;
        cursor: pointer;
        margin-right: 5px;
    }
    .like-button img {
        width: 20px;
        height: 20px;
    }
    .like-count {
	    margin-top: 5px; /* 좋아요 수를 이미지 아래에 약간의 간격을 둠 */
	    font-size: 16px;
	    font-weight: bold;
	}

    /* 삭제버튼 */
    .delete-button {
    	font-family: KB금융 제목체 Light;
        background-color: #FFE297;
        color: #777 !important;
        text-align: left; /* 좌측 정렬 */
        border: none;
        cursor: pointer; 
        font-weight: bold;
        font-weight: bold;
        
    }

    
    .comment-section {
        display: flex;
        align-items: center;
        margin-top: 20px;
        border-top: 1px solid #000;
        padding-top: 10px;
        flex-wrap: nowrap;
    }

    .idea-title-container {
        border: 1px solid #000;
        background-color: #EEEEEE;
        padding: 20px;
        width: 100%;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
    }
    .idea-title-inner {
        border: 3px solid #FFCC00;
        background-color: #FFFFFF;
        border-radius: 20px;
        padding: 10px;
        text-align: center;
        font-size: 30px;
        margin: 10px 0;
    }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
// 페이질 로드시 실행
/* document.addEventListener('DOMContentLoaded', function() {
    console.log('DOMContentLoaded event fired');
    var currentTab = '${currentTab}';
    var currentHatColor = '${currentHatColor}';
    var userCommentedTabs = [<c:forEach items="${userCommentedTabs}" var="tab" varStatus="status">"${tab}"<c:if test="${!status.last}">,</c:if></c:forEach>];
    var alreadyWritten = ${alreadyWritten};
    
    console.log('currentTab:', currentTab);
    console.log('currentHatColor:', currentHatColor);
    console.log('userCommentedTabs:', userCommentedTabs);
    console.log('alreadyWritten:', alreadyWritten);
    
    if (alreadyWritten === true || userCommentedTabs.includes(currentHatColor)) { 
        document.querySelectorAll(".comment-section").forEach(function(el) {
            el.style.display = "none";
        });
        document.querySelectorAll(".comment-full").forEach(function(el) {
            el.style.display = "block";
        });
    }

    // 폼 제출 이벤트 리스너 추가
    var form = document.querySelector('form.comment-section');
    if (form) {
        form.addEventListener('submit', function(event) {
            if (!validateAndSubmitForm(currentTab, userCommentedTabs)) {
                event.preventDefault();
            }
        });
    }
});
 */
 document.addEventListener('DOMContentLoaded', function() {
	 	var currentTab = '${currentTab}' || 'tab-smart';
	    var activeTab = document.querySelector('.tab.' + currentTab);
	    if (activeTab) {
	        activeTab.classList.add('active');
	    }
	    
	    var tabs = document.querySelectorAll('.tab');
	    
	    // 현재 탭 활성화
	    document.querySelector('.tab.' + currentTab).classList.add('active');
	    
	    tabs.forEach(function(tab) {
	        tab.addEventListener('click', function(e) {
	            // 클릭 이벤트의 기본 동작을 막지 않음 (페이지 이동 허용)
	            
	            // 모든 탭에서 active 클래스 제거
	            tabs.forEach(function(t) {
	                t.classList.remove('active');
	            });
	            
	            // 클릭된 탭에 active 클래스 추가
	            this.classList.add('active');
	        });
	    });
	    
	    // 입력창 줄바꿈 반영
	    var textareas = document.querySelectorAll('.opinion-textarea');
	    textareas.forEach(function(textarea) {
	        textarea.addEventListener('input', autoResize, false);
	    });

	    function autoResize() {
	        this.style.height = 'auto';
	        this.style.height = this.scrollHeight + 'px';
	    }
	});

function getHatColorFromTab(tab) {
    switch (tab) {
        case "tab-smart": return "Smart";
        case "tab-positive": return "Positive";
        case "tab-worry": return "Worry";
        case "tab-strict": return "Strict";
        default: return "Smart";
    }
}


function validateAndSubmitForm(tabName, userCommentedTabs) {
    console.log('validateAndSubmitForm called', tabName, userCommentedTabs);
    var opinionText = document.querySelector('.opinion-textarea').value.trim();
    var currentHatColor = getHatColorFromTab(tabName);

    if (opinionText === '') {
        alert('의견을 입력해주세요!');
        return false;
    } /* else if (userCommentedTabs.includes(currentHatColor)) {
        alert('이미 해당 탭에 의견을 작성하셨습니다.\n다른 탭에 의견을 추가 작성해주세요');
        return false;
    } */
    return true;
}


function confirmDelete() {
    return confirm('정말로 이 의견을 삭제하시겠습니까?');
}

/* 타이머 종료시 함수 */
function onTimerEnd() {
    // 방장
	if ("${roomManagerId}" === "${userId}") {
        document.getElementById("nextStepButton").style.display = "block";
	}
    // 모든 사용자
 	console.log("Timer ended");

 	// 모든 comment-section, comment-full 요소를 숨깁니다
    document.querySelectorAll(".comment-section, .comment-full").forEach(function(el) {
        el.style.display = "none";
    });
 	
    // 타이머 종료 메시지만 표시
    document.querySelectorAll(".comment-ended").forEach(function(el) {
        el.style.display = "block";
        el.textContent = "타이머가 종료되었습니다. 더 이상 의견을 작성할 수 없습니다.";
    });
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
</head>
<body style="margin: 0;">
<%@ include file="../header.jsp"%>
<%@ include file="../leftSideBar.jsp"%>
<div class="ideaOpinions2-body">
<%@ include file="../rightSideBar.jsp"%>

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
				<!-- 뒤로가기버튼(ideaOpinionsList2로 이동) -->
				<a href="./ideaOpinionsList2?roomId=${roomId}&ideaId=${ideaId}">
		       		<img src="./resources/back2.png" alt="뒤로가기" class="back-btn">
		       	</a>
	           	아이디어 A
	       	</c:when>
			<c:otherwise>
				<!-- 뒤로가기버튼(ideaOpinionsList2로 이동) -->
				<a href="./ideaOpinionsList2?roomId=${roomId}&ideaId=${ideaId}">
		       		<img src="./resources/back2.png" alt="뒤로가기" class="back-btn">
		       	</a>
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
	
	<hr class="line">
        
        <!-- 4가지 탭 -->
<%--         <div class="tabs">
            <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-smart" 
            class="tab tab-smart ${currentTab == 'tab-smart' ? 'active' : ''}">객관적관점</a>
            <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-positive" 
            class="tab tab-positive ${currentTab == 'tab-positive' ? 'active' : ''}">기대효과</a>
            <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-worry" 
            class="tab tab-worry ${currentTab == 'tab-worry' ? 'active' : ''}">문제점</a>
            <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-strict" 
            class="tab tab-strict ${currentTab == 'tab-strict' ? 'active' : ''}">실현가능성</a>
        </div> --%>
        <div class="tabs">
		    <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-smart" 
		       class="tab tab-smart ${currentTab == 'tab-smart' || empty currentTab ? 'active' : ''}">객관적관점</a>
		    <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-positive" 
		       class="tab tab-positive ${currentTab == 'tab-positive' ? 'active' : ''}">기대효과</a>
		    <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-worry" 
		       class="tab tab-worry ${currentTab == 'tab-worry' ? 'active' : ''}">문제점</a>
		    <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-strict" 
		       class="tab tab-strict ${currentTab == 'tab-strict' ? 'active' : ''}">실현가능성</a>
		</div>
        
        
        <div class="columns">
            <div class="column">
                <div class="opinion-title">기존 의견들</div>
                <div class="countDone">(3단계) 관점별 의견 모으기 단계에서 작성된 의견들입니다.</div>
		        <ul class="preOpinion-list">
                    <c:choose>
                        <c:when test="${empty previousOpinions}">
                            <li class="no-opinions">
                                <img src="./resources/noContents.png" alt="No opinions" style="width: 180px; height: 200px; vertical-align: middle;">
                                <br>의견이 아직 등록되지 않았어요! <br><br>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${previousOpinions}" varStatus="status">
                                <li class="opinion-entry1">
                                    <div class="opinion-header">
                                        <div class="name-date">
                                            <div class="name">${opinion.userName}</div>
                                            <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                        </div>
                                    </div>
                                    <%-- <div class="opinion-text">${opinion.opinionText}</div> --%>
                                    <div class="opinion-text"><c:out value="${fn:replace(opinion.opinionText, newLineChar, '<br>')}" escapeXml="false"/></div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            
			<div class="column">
		    <div class="opinion-title">현재 의견들</div>
		    <div class="countDone">내가 작성한 의견 수: ${userOpinionCount}/4(탭당 1개)</div>
		    <ul class="currentOpinion-list">
		        <c:choose>
		            <c:when test="${empty currentOpinions}">
		                <li class="no-opinions">
		                    <img src="./resources/noContents.png" alt="No opinions" style="width: 180px; height: 200px; vertical-align: middle;">
		                    <br>의견이 아직 등록되지 않았어요! <br><br>
		                </li>
		            </c:when>
		            <c:otherwise>
		                <c:forEach var="opinion" items="${currentOpinions}" varStatus="status">
		                    <li class="opinion-entry2">
		                        <div class="opinion-header">
                                    <div class="name-date">
                                        <span class="name">${opinion.userName}</span>
                                        <div class="date">
                                            <fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" />
                                        </div>
                                    </div>
                                    <div class="like-section">
									    <form action="likeOpinion" method="post" style="display: inline;">
									        <input type="hidden" name="opinionId" value="${opinion.opinionID}" />
									        <input type="hidden" name="userId" value="${userId}" />
									        <input type="hidden" name="like" value="${opinion.likedByCurrentUser ? false : true}" /> 
									        <input type="hidden" name="roomId" value="${roomId}" />
									        <input type="hidden" name="ideaId" value="${ideaId}" />
									        <input type="hidden" name="currentTab" value="${currentTab}" />
									        <button type="submit" class="like-button">
									            <c:choose>
									                <c:when test="${opinion.likedByCurrentUser}">
									                    <img src="./resources/filled_heart.png" alt="Filled Heart">
									                </c:when>
									                <c:otherwise>
									                    <img src="./resources/empty_heart.png" alt="Empty Heart">
									                </c:otherwise>
									            </c:choose>
									        </button>
									    </form>
									    <div class="like-count">
									        <span>${opinion.likeNum}</span>
									    </div>
									</div>
                                </div>
                                <%-- <div class="opinion-text">${opinion.opinionText}</div> --%>
                                <div class="opinion-text"><c:out value="${fn:replace(opinion.opinionText, newLineChar, '<br>')}" escapeXml="false"/></div>
                                <c:if test="${opinion.userID == userId}">
                                    <form action="deleteOpinion2" method="post" onsubmit="return confirmDelete();" style="display: inline;">
                                        <input type="hidden" name="opinionId" value="${opinion.opinionID}" />
                                        <input type="hidden" name="ideaId" value="${ideaId}" />
                                        <input type="hidden" name="roomId" value="${roomId}" />
                                        <input type="hidden" name="currentTab" value="${currentTab}" />
                                        <button type="submit" class="delete-button" >삭제</button>
                                    </form>
                                </c:if>
		                    </li>
		                </c:forEach>
		            </c:otherwise>
		        </c:choose>
		    </ul>
	       <c:if test="${4 - userOpinionCount > 0}">
			    <c:choose>
			        <c:when test="${!userCommentedTabs.contains(currentHatColor)}">
			            <form action="addOpinion2" method="post" class="comment-section" onsubmit="return validateAndSubmitForm()"> 
			                <input type="hidden" name="ideaId" value="${ideaId}" />
			                <input type="hidden" name="roomId" value="${roomId}" />
			                <input type="hidden" name="currentTab" value="${currentTab}" />
			                <textarea class="opinion-textarea" name="opinionText" placeholder="의견을 입력해주세요"></textarea>
			                <button type="submit" class="write-button">작성</button>
			            </form>
			        </c:when>
			        <c:otherwise>
			            <div class="comment-ended">이미 해당 탭에 의견을 작성하셨습니다.<br> 다른 탭에 의견을 추가 작성해주세요</div>
			        </c:otherwise>
			    </c:choose>
			</c:if>
			<c:if test="${4 - userOpinionCount <= 0}">
			    <div class="comment-full">최대 작성 가능 의견 4개 작성을 완료하셨습니다. <br> 더 이상 의견을 작성할 수 없습니다.</div>
			</c:if>
            <div class="comment-ended" style="display: none;">
				타이머가 종료되었습니다. 더 이상 의견을 작성할 수 없습니다.
			</div>
		    </div>
		</div>
</div>
</body>
</html>
