<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>2차 의견</title>
<style>
.ideaOpinions2-body {
    margin: 0;
    font-family: 'Arial', sans-serif;
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
.stageActive {
	color: #FFD700;
	font-weight: bold;
}
.stageInactive {
	color: #999;
	pointer-events: none;
}

/* 제목 */
.title {
    font-weight: bold;
    font-size: 22pt;
    /* color: black; */
    text-align: left;
    margin-top: 20px; 
    margin-bottom: 20px; 
}

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
    
/* 4가지 탭 */
.tabs {
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
}
.write-button:hover {
    background-color: #D4AA00;
}

/* 의견을 입력해주세요란 */
.opinion-textarea {
    width: calc(100% - 120px);
    height: 50px;
    margin-right: 10px;
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
	margin-top: 20px;
	margin-bottom: 100px;
	font-size: 13pt;
    }
    /* 기존 의견들, 현재 의견들 */
    .opinion-title {
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

    
    .delete-button {
        background-color: #FFE297;
        color: #777 !important;
        text-align: left; /* 좌측 정렬 */
        border: none;
        cursor: pointer; 
        font-weight: bold;
        font-weight: bold;
        
    }
/*     .delete-button:hover {
        background-color: #c82333;
    } */
    
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

// 방장이 다음 단계로 버튼 클릭 시 확인 창을 띄우고, 확인 시 이동
function confirmNextStep() {
    if (confirm("정말로 다음 페이지로 넘어가시겠습니까?")) {
    	const roomId = "${roomId}";
        const ideaId = "${ideaId}";
        window.location.href = "./ideaOpinionsClear2?roomId=" + roomId +"&ideaId=" + ideaId;
        /* window.location.href = "./goStage5?roomId=" + roomId +"&ideaId=" + ideaId; */
    }
}

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
	                    <a href="roomDetail?roomId=${meetingRoom.getRoomId()}&stage=${status.index + 1}&ideaId=${ideaId}" 
	                    class="stage ${meetingRoom.getStageId() == status.index + 1 ? 'stageActive' : ''}">
	                        ${status.index + 1}. ${stage}
	                    </a>
	                </c:when>
	                <c:otherwise>
	                    <div class="stage stageInactive">
	                        ${status.index + 1}. ${stage}
	                    </div>
	                </c:otherwise>
	            </c:choose>
	        </c:forEach>
	    </div>
	    
		<!-- 제목 -->
        <div class="title"> [${ideaTitle}] </div>
        
         <!-- 방장이면 표시 -->
        <div class="rightAligned">
	    <c:if test="${userId == roomManagerId}">
	    	<!-- 현재 단계 완료 참여자 수 -->
        	<span class="countDone"> 현재 단계 완료 참여자 수: ${doneUserCount}/${userCount}</span>
        	<!-- 다음 단계로 버튼 -->
		    <button id="nextStepButton" class="nextStepButton" onclick="confirmNextStep()">다음 단계로</button>
		</c:if>
		</div>
		<hr>
        
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
                                    <div class="opinion-text">${opinion.opinionText}</div>
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
                                <div class="opinion-text">${opinion.opinionText}</div>
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
