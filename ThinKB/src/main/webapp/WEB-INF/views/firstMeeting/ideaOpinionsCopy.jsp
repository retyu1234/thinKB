<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디어 회의</title>
<style>
.ideaOpinions-body {
    margin: 0;
    font-family: 'Arial', sans-serif;
    background-color: #FFFFFF;
    width: 70%;
    margin: 0 auto;
    box-sizing: border-box;
    padding: 20px;
    /* 수지 */
   /*  display: flex; */
    /* align-items: center; */
    /* display: flex; */
    align-items: center;
}

/* 제목 */
.title {
    font-weight: bold;
    font-size: 26pt;
    /* color: black; */
    text-align: left;
    margin-left: 50px;
    margin-top: 20px; 
    margin-bottom: 20px; 
}
/* 현재 단계 완료 참여자 수 */
.countDone {
	/* float: left;  */
	font-size: 15pt;
	margin-left: 50px;
	margin-bottom: 100px;
}
/* 말풍선*/
.speechBubble {
    background-color: #e0f7fa; /* 말풍선 배경 색상 */
    border-radius: 30px; /* 둥근 네모 모양 */
    padding: 20px;
    display: inline-block;
    position: relative;
    width: 60%;
    height: 150px;
    max-width: 60%;
    margin: 20px 0px 50px 60px; /* 위쪽, 오른쪽, 아래쪽, 왼쪽 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
}
/* 말풍선 - 화살표 */
.speechBubble::after {
    content: '';
    position: absolute;
    bottom: -25px; /* 화살표를 아래에 위치 */
    right: 25px; /* 화살표를 오른쪽 라인에 위치 */
    width: 0;
    height: 0;
    border-left: 50px solid transparent;
    border-right: -10px solid transparent;
    border-top: 25px solid #e0f7fa; /* 말풍선 배경 색상과 일치 */
}
/* 캐릭터 이름 */
.characterName {
    font-size: 22pt;
    margin-bottom: 20px;
    color : blue;
}
/* 캐릭터 설명 */
.characterExplain {
    font-size: 15pt;
}
/* 캐릭터 이미지 */
.character-img-container {
    float: right;
    font-size: 16px;
}
.character-img {
    width: 250px; /* 이미지 크기 조정 */
    height: 250px;
    vertical-align: middle;
	margin-right: 150px;
}

/* 추가 작성 의견수, 작성된 전체 의견 갯수, 최대 작성 가능, 추가 가능 */
.counts {
	font-size: 15pt;
}

h1 {
	text-align: center;
	margin: 20px 0;
}

/* 4가지 탭 */
.tabs {
    display: flex;
    justify-content: flex-start; /* 탭들을 왼쪽으로 몰리게 함 */
    gap: 10px; /* 탭 간의 간격 조절 */
    margin-bottom: 20px;
}

.tab {
    padding: 15px 25px;
    cursor: pointer;
    font-weight: bold;
    color: #909090; /* 기본 색상 */
    transition: background-color 0.3s ease, color 0.3s ease;
    clip-path: polygon(0 0, 100% 0, 90% 100%, 10% 100%);
    text-align: center;
    font-size: 22pt;
    text-decoration: none; /* 기본 밑줄 제거 */
    flex: 1;
}

/* 탭 색상 */
/* .tab-smart {
    background-color: #007bff;
} 
.tab-positive {
    background-color: #ffc107;
    color: black;
}
.tab-worry {
    background-color: #28a745;
}
.tab-strict {
    background-color: #dc3545;
}  */

/* 선택된 탭 */
.tab.active {
    color: black; /* 선택된 탭의 글자색 */
    border-bottom: 6px solid #FFE297; /* 선택된 탭의 밑줄 색상 */
    width: 80%; /* 선택된 탭의 밑줄 길이 줄이기 */
    margin: 0 auto; /* 가운데 정렬 */
}

/* 전체 흰색 네모 */
.tab-content {
	display: none;
	padding: 20px;
	box-sizing: border-box;
	background-color: #fff;
}
.tab-content.active {
	display: block;
}

/* 의견 박스 */
/* .opinion-section {
	border: 1px solid #000;
	background-color: #EEEEEE;
	padding: 20px;
	width: 100%;
	box-sizing: border-box;
	display: flex;
	flex-direction: column;
} */

.opinion-entry {
	/* background-color: #FFE297; */
	background-color: #EEEEEE;
	padding: 20px;
	border-radius: 20px;
	margin-bottom: 10px;
	font-size: 22px;
	position: relative; /* 삭제 버튼 위치를 절대 위치로 설정하기 위해 상대 위치로 설정 */
}







.opinion-list {
	list-style-type: none;
	padding: 0;
}

.opinion-list li {
	margin-bottom: 10px;
}

.comment-section {
	display: flex;
	align-items: center;
	margin-top: 20px;
	border-top: 1px solid #000;
	padding-top: 10px;
	flex-wrap: nowrap; /* 요소들이 한 줄에 유지되도록 설정 */
}

.opinion-textarea {
	width: calc(100% - 120px); /* 너비를 버튼 크기에 맞게 조정 */
	height: 50px; /* 높이를 버튼과 맞춤 */
	margin-right: 10px;
	border: 2px solid #ccc; /* 두께를 두껍게 조정 */
	padding: 12px; /* 패딩을 더 두껍게 조정 */
	border-radius: 5px;
	box-sizing: border-box; /* 패딩 포함한 크기 조정 */
	font-weight: bold; /* 텍스트 두께를 두껍게 조정 */
	font-size: 16px; /* 텍스트 크기를 키움 */
}

button {
	width: 100px; /* 버튼의 너비 고정 */
	height: 50px; /* 높이를 입력란과 맞춤 */
	border: none;
	background-color: #ffc107;
	color: #000;
	font-weight: bold;
	padding: 0 20px;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

button:hover {
	background-color: #e0a800;
}




.opinion-text {
	display: inline-block;
	margin-right: 10px;
}

.delete-button {
	position: absolute;
	right: 10px;
	top: 10px;
}

.date {
	font-size: 12px;
	color: #777;
	margin-top: 5px;
}
/* 등록된 의견이 없을 때 */
.no-opinions {
	color: #ccc; /* 연한 회색 */
	font-style: italic; /* 기울임꼴로 표시 */
	text-align: center;
	margin-top: 20px;
	margin-bottom: 100px;
	font-size: 25px;
}

.no-opinions img {
	margin-bottom: 20px; /* 이미지 아래 여백 */
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        function formatTimestamp(timestamp) {
            const date = new Date(timestamp);
            const year = date.getFullYear();
            const month = date.getMonth() + 1;
            const day = date.getDate();
            const hours = date.getHours();
            const minutes = date.getMinutes();

            const formattedMonth = (month < 10 ? '0' + month : month);
            const formattedDay = (day < 10 ? '0' + day : day);
            const formattedHours = (hours < 10 ? '0' + hours : hours);
            const formattedMinutes = (minutes < 10 ? '0' + minutes : minutes);

            return year + '.' + formattedMonth + '.' + formattedDay + ' ' + formattedHours + ':' + formattedMinutes;
        }

        // 포맷된 날짜를 표시하기 위해 createdAt 값을 변환
        $('.date').each(function() {
            const timestamp = $(this).text().trim();
            const date = new Date(timestamp);
            if (!isNaN(date.getTime())) {
                $(this).text(formatTimestamp(date));
            } else {
                $(this).text(timestamp);
            }
        });
        
        window.onload = function() {
            var urlParams = new URLSearchParams(window.location.search);
            var currentTab = urlParams.get('currentTab');
            var roomId = urlParams.get('roomId');
            var ideaId = urlParams.get('ideaId');
            if (currentTab && roomId && ideaId) {
                showTab(currentTab, getTabColor(currentTab), roomId, ideaId);
            }
         	// 메시지 처리
            <c:if test="${not empty message}">
                alert('${message}');
            </c:if>
        };

        function getTabColor(tabName) {
            switch(tabName) {
                case 'tab-smart': return '#007bff';
                case 'tab-positive': return '#ffc107';
                case 'tab-worry': return '#28a745';
                case 'tab-strict': return '#dc3545';
                default: return '#007bff';
            }
        }

        window.showTab = function(tabName, color, roomId, ideaId) {
            var tabs = document.getElementsByClassName('tab-content');
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove('active');
            }
            document.getElementById(tabName).classList.add('active');
            document.querySelector('.tab-content.active').style.borderColor = color;

            var allTabs = document.getElementsByClassName('tab');
            for (var j = 0; j < allTabs.length; j++) {
                allTabs[j].style.borderBottom = 'none';
            }
            document.querySelector('.tab.' + tabName).style.borderBottom = '5px solid ' + color;

            // 폼의 currentTab 값을 업데이트
            var currentTabInputs = document.querySelectorAll('input[name="currentTab"]');
            for (var k = 0; k < currentTabInputs.length; k++) {
                currentTabInputs[k].value = tabName;
            }

            // URL을 업데이트하여 필요한 매개변수 포함
            history.replaceState(null, '', `?roomId=${roomId}&ideaId=${ideaId}&currentTab=${tabName}`);
        }


    	// 의견을 작성하지 않은 상태로 작성 버튼 클릭시 오류 팝업창 + 작성할 수 있는 의견 수가 0개인 탭에 의견 작성시 오류 팝업창
        window.validateAndSubmitForm = function(tabName, maxComments, currentOpinionCount) {
            var opinionText = document.querySelector('#' + tabName + ' .opinion-textarea').value.trim();
            if (opinionText === '') {
                alert('의견을 입력해주세요!');
            } else if (currentOpinionCount >= maxComments) {
                alert('의견 작성 제한 인원을 초과하였습니다. \n다른 의견 탭에 의견을 작성해주세요');
            } else {
                document.querySelector('#' + tabName + ' form').submit();
            }
        };
/*     	// 의견을 작성하지 않은 상태로 작성 버튼 클릭시 오류 팝업창 + 작성할 수 있는 의견 수가 0개인 탭에 의견 작성시 오류 팝업창 + 2개 이상 작성시 추가 의견 가능
        window.validateAndSubmitForm = function(tabName, maxComments, currentOpinionCount, userOpinionCount) {
		    var opinionText = document.querySelector('#' + tabName + ' .opinion-textarea').value.trim();
		    if (opinionText === '') {
		        alert('의견을 입력해주세요!');
		    } else if (userOpinionCount < 2 && currentOpinionCount >= maxComments) {
		        alert('의견 작성 제한 인원을 초과하였습니다.\n다른 의견 탭에 의견을 작성해주세요');
		    } else {
		        document.querySelector('#' + tabName + ' form').submit();
		    }
		}; */

        window.deleteOpinion = function(opinionId, currentTab) {
            var roomId = '<c:out value="${roomId}" />';
            var ideaId = '<c:out value="${ideaId}" />';
            
            // opinionId와 currentTab이 올바른지 확인
            if (!opinionId || !currentTab) {
                alert('삭제할 의견 정보가 잘못되었습니다.');
                return;
            }
            
            if (confirm('정말로 이 의견을 삭제하시겠습니까?')) {
                var url = 'deleteOpinion?opinionId=' + opinionId + '&currentTab=' + currentTab + '&roomId=' + roomId + '&ideaId=' + ideaId;
                window.location.href = url;
            }
        };

        var urlParams = new URLSearchParams(window.location.search);
        var currentTab = urlParams.get('currentTab');
        var roomId = urlParams.get('roomId');
        var ideaId = urlParams.get('ideaId');
        if (currentTab && roomId && ideaId) {
            showTab(currentTab, getTabColor(currentTab), roomId, ideaId);
        }
    });
    
    /* 타이머 종료시 함수 */
    function onTimerEnd() {
	    // 방장
		if ("${roomManagerId}" === "${userId}") {
	        document.getElementById("nextStepButton").style.display = "block";
		}
	    // 일반사용자
     	// 의견 작성 섹션을 숨기고 종료 메시지를 표시
     	console.log("Timer ended");

        document.querySelectorAll(".comment-section").forEach(function(el) {
            el.style.display = "none";
        });
        document.querySelectorAll(".comment-ended").forEach(function(el) {
            el.style.display = "block";
        });
    }
    
 	// 방장이 다음 단계로 버튼 클릭 시 확인 창을 띄우고, 확인 시 이동
    function confirmNextStep() {
        if (confirm("정말로 다음 페이지로 넘어가시겠습니까?")) {
        	const roomId = "${roomId}";
            const ideaId = "${ideaId}";
            window.location.href = "./ideaOpinionsClear?roomId=" + roomId + "&ideaId=" + ideaId;
        }
    }
    
	
    
</script>
</head>
<body class="ideaOpinions-body">
<%@ include file="../header.jsp"%>
<%-- <%@ include file="../leftSideBar.jsp"%> --%>

    <div class="container">
	    <!-- 타이머 -->
	    <div id="timer-section" style="margin-top:100px;">
	    	<%@ include file="../Timer.jsp"%>
	    </div>
	    
	    <!-- 방장이면 표시 -->
	    <c:if test="${userId == roomManagerId}">
		    <button id="nextStepButton" onclick="confirmNextStep()">다음 단계로</button>
		</c:if>
		
		<!-- 현재 단계 완료 참여자 수 -->
        <div class="title"> [${ideaTitle}] </div>
<%--         <div class="idea-title-container">
            <div class="idea-title-inner">${ideaTitle}</div>
        </div> --%>
        <span class="countDone"> 현재 단계 완료 참여자 수: ${doneUserCount}/${userCount}</span>
       
        <!-- 4가지 탭 -->
        <div class="tabs">
            <div class="tab tab-smart" onclick="showTab('tab-smart', '#007bff', '${roomId}', '${ideaId}')">똑똑이</div>
            <div class="tab tab-positive" onclick="showTab('tab-positive', '#ffc107', '${roomId}', '${ideaId}')">긍정이</div>
            <div class="tab tab-worry" onclick="showTab('tab-worry', '#28a745', '${roomId}', '${ideaId}')">걱정이</div>
            <div class="tab tab-strict" onclick="showTab('tab-strict', '#dc3545', '${roomId}', '${ideaId}')">깐깐이</div>
        </div>

        <div class="opinion-section">
			<div id="tab-smart" class="tab-content active">
				<h2>
					<div class="speechBubble">
						<div class="characterName">
						나는 똑똑이 !
						</div>
						<div class="characterExplain">
						나는 정말 똑똑한 똑똑이야 ~
						똑똑한 사람만 댓글 달아 ~
						</div>
					</div>
					<span class="character-img-container">
						<img src="./resources/smart.png" class="character-img">
					</span>
					 
					<div class="counts"> 
						내가 추가로 달 수 있는 의견 수: ${2-userOpinionCount}/2 <br> 
						현재 탭의 의견 갯수: ${positiveOpinionCount} / 최대 작성 가능: ${maxComments} / 추가 가능: ${maxComments - smartOpinionCount}
					</div>
					<%-- <span style="float: middle; font-size: 16px;"> 
						내가 추가로 달 수 있는 의견 수: ${2-userOpinionCount}/2 <br> 
						현재 탭에 전체 의견 갯수: ${positiveOpinionCount} / 최대 작성 가능: ${maxComments} / 추가 가능: ${maxComments - smartOpinionCount}
					</span> --%>
					
				</h2>
				<ul class="opinion-list">
					<c:choose>
						<c:when test="${empty smartOpinions}">
							<li class="no-opinions"><img
								src="./resources/noContents.png" alt="No opinions"
								style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
								<br>의견이 아직 등록되지 않았어요! <br>
							<br></li>
						</c:when>
						<c:otherwise>
							<c:forEach var="opinion" items="${smartOpinions}">
								<li class="opinion-entry"><span class="opinion-text">${opinion.userName}:
										${opinion.opinionText}</span> <c:if
										test="${opinion.userID == userId}">
										<button class="delete-button"
											onclick="deleteOpinion(${opinion.opinionID}, 'tab-smart')">삭제</button>
									</c:if>
									<div class="date">
										<fmt:formatDate value="${opinion.createdAt}"
											pattern="yyyy-MM-dd HH:mm" />
									</div></li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
				<div class="comment-section">
					<c:if test="${not empty error}">
						<div class="error-message">${error}</div>
					</c:if>

					<!-- <div id="tab-smart" class="tab-content active"> -->
					<c:if test="${2 - userOpinionCount > 0}">
						<form:form method="post" action="./addOpinion"
							modelAttribute="opinionForm"
							onsubmit="return validateAndSubmitForm('tab-smart', ${maxComments}, ${smartOpinionCount}, ${userOpinionCount})"
							style="display: flex; align-items: center; width: 100%;">
							<form:hidden path="hatColor" value="Smart" />
							<form:hidden path="currentTab" value="tab-smart" />
							<form:hidden path="roomId" value="${roomId}" />
							<form:hidden path="ideaId" value="${ideaId}" />
							<form:textarea path="opinionText" class="opinion-textarea"
								placeholder="의견을 입력해주세요" />
							<button type="button"
								onclick="validateAndSubmitForm('tab-smart', ${maxComments}, ${smartOpinionCount}, ${userOpinionCount})">작성</button>
						</form:form>

					</c:if>
					<!-- </div> -->
					<c:if test="${2 - userOpinionCount == 0}">
						<div>필수 의견 2개 작성을 완료하셨습니다. 더 이상 의견을 작성할 수 없습니다.</div>
					</c:if>
				</div>
				<div class="comment-ended" style="display: none;">타이머가
					종료되었습니다. 더 이상 의견을 작성할 수 없습니다.</div>
			</div>

			<div id="tab-positive" class="tab-content">
				<h2>
					<img src="./resources/message.png"
						style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
					긍정이 등록된 의견 <span style="float: right; font-size: 16px;"> 내가
						추가로 달 수 있는 의견 수: ${2-userOpinionCount}/2 <br> 현재 탭에 전체 의견 갯수:
						${positiveOpinionCount} / 최대 작성 가능: ${maxComments} / 추가 가능:
						${maxComments - positiveOpinionCount}
					</span>
				</h2>
				<ul class="opinion-list">
					<c:choose>
						<c:when test="${empty positiveOpinions}">
							<li class="no-opinions"><img
								src="./resources/noContents.png" alt="No opinions"
								style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
								<br>의견이 아직 등록되지 않았어요! <br>
							<br></li>
						</c:when>
						<c:otherwise>
							<c:forEach var="opinion" items="${positiveOpinions}">
								<li class="opinion-entry"><span class="opinion-text">${opinion.userName}:
										${opinion.opinionText}</span> <c:if
										test="${opinion.userID == userId}">
										<button class="delete-button"
											onclick="deleteOpinion(${opinion.opinionID}, 'tab-positive')">삭제</button>
									</c:if>
									<div class="date">
										<fmt:formatDate value="${opinion.createdAt}"
											pattern="yyyy-MM-dd HH:mm" />
									</div></li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
				<div class="comment-section">
					<c:if test="${not empty error}">
						<div class="error-message">${error}</div>
					</c:if>
					<c:if test="${2 - userOpinionCount > 0}">
						<form:form method="post" action="./addOpinion"
							modelAttribute="opinionForm"
							onsubmit="return validateAndSubmitForm('tab-positive', ${maxComments}, ${smartOpinionCount}, ${userOpinionCount})"
							style="display: flex; align-items: center; width: 100%;">
							<form:hidden path="hatColor" value="Positive" />
							<form:hidden path="currentTab" value="tab-positive" />
							<form:hidden path="roomId" value="${roomId}" />
							<form:hidden path="ideaId" value="${ideaId}" />
							<form:textarea path="opinionText" class="opinion-textarea"
								placeholder="의견을 입력해주세요" />
							<button type="button"
								onclick="validateAndSubmitForm('tab-positive', ${maxComments}, ${positiveOpinionCount}, ${userOpinionCount})">작성</button>
						</form:form>
					</c:if>
					<c:if test="${2 - userOpinionCount == 0}">
						<div>필수 의견 2개 작성을 완료하셨습니다. 더 이상 의견을 작성할 수 없습니다.</div>
					</c:if>
				</div>
				<div class="comment-ended" style="display: none;">타이머가
					종료되었습니다. 더 이상 의견을 작성할 수 없습니다.</div>
			</div>


			<div id="tab-worry" class="tab-content">
				<h2>
					<img src="./resources/message.png"
						style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
					걱정이 등록된 의견 <span style="float: right; font-size: 16px;"> 내가
						추가로 달 수 있는 의견 수: ${2-userOpinionCount}/2 <br> 현재 탭에 전체 의견 갯수:
						${positiveOpinionCount} / 최대 작성 가능: ${maxComments} / 추가 가능:
						${maxComments - worryOpinionCount}
					</span>
				</h2>
				<ul class="opinion-list">
					<c:choose>
						<c:when test="${empty worryOpinions}">
							<li class="no-opinions"><img
								src="./resources/noContents.png" alt="No opinions"
								style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
								<br>의견이 아직 등록되지 않았어요! <br>
							<br></li>
						</c:when>
						<c:otherwise>
							<c:forEach var="opinion" items="${worryOpinions}">
								<li class="opinion-entry"><span class="opinion-text">${opinion.userName}:
										${opinion.opinionText}</span> <c:if
										test="${opinion.userID == userId}">
										<button class="delete-button"
											onclick="deleteOpinion(${opinion.opinionID}, 'tab-worry')">삭제</button>
									</c:if>
									<div class="date">
										<fmt:formatDate value="${opinion.createdAt}"
											pattern="yyyy-MM-dd HH:mm" />
									</div></li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
				<div class="comment-section">
					<c:if test="${not empty error}">
						<div class="error-message">${error}</div>
					</c:if>
					<c:if test="${2 - userOpinionCount > 0}">
						<form:form method="post" action="./addOpinion"
							modelAttribute="opinionForm"
							onsubmit="return validateAndSubmitForm('tab-worry', ${maxComments}, ${smartOpinionCount}, ${userOpinionCount})"
							style="display: flex; align-items: center; width: 100%;">
							<form:hidden path="hatColor" value="Worry" />
							<form:hidden path="currentTab" value="tab-worry" />
							<form:hidden path="roomId" value="${roomId}" />
							<form:hidden path="ideaId" value="${ideaId}" />
							<form:textarea path="opinionText" class="opinion-textarea"
								placeholder="의견을 입력해주세요" />
							<button type="button"
								onclick="validateAndSubmitForm('tab-worry', ${maxComments}, ${worryOpinionCount}, ${userOpinionCount})">작성</button>
						</form:form>
					</c:if>
					<c:if test="${2 - userOpinionCount == 0}">
						<div>필수 의견 2개 작성을 완료하셨습니다. 더 이상 의견을 작성할 수 없습니다.</div>
					</c:if>
				</div>
				<div class="comment-ended" style="display: none;">타이머가
					종료되었습니다. 더 이상 의견을 작성할 수 없습니다.</div>
			</div>


			<div id="tab-strict" class="tab-content">
				<h2>
					<img src="./resources/message.png"
						style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
					깐깐이 등록된 의견 <span style="float: right; font-size: 16px;"> 내가
						추가로 달 수 있는 의견 수: ${2-userOpinionCount}/2 <br> 현재 탭에 전체 의견 갯수:
						${positiveOpinionCount} / 최대 작성 가능: ${maxComments} / 추가 가능:
						${maxComments - strictOpinionCount}
					</span>
				</h2>
				<ul class="opinion-list">
					<c:choose>
						<c:when test="${empty strictOpinions}">
							<li class="no-opinions"><img
								src="./resources/noContents.png" alt="No opinions"
								style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
								<br>의견이 아직 등록되지 않았어요! <br>
							<br></li>
						</c:when>
						<c:otherwise>
							<c:forEach var="opinion" items="${strictOpinions}">
								<li class="opinion-entry"><span class="opinion-text">${opinion.userName}:
										${opinion.opinionText}</span> <c:if
										test="${opinion.userID == userId}">
										<button class="delete-button"
											onclick="deleteOpinion(${opinion.opinionID}, 'tab-strict')">삭제</button>
									</c:if>
									<div class="date">
										<fmt:formatDate value="${opinion.createdAt}"
											pattern="yyyy-MM-dd HH:mm" />
									</div></li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
				<div class="comment-section">
					<c:if test="${not empty error}">
						<div class="error-message">${error}</div>
					</c:if>
					<c:if test="${2 - userOpinionCount > 0}">
						<form:form method="post" action="./addOpinion"
							modelAttribute="opinionForm"
							onsubmit="return validateAndSubmitForm('tab-strict', ${maxComments}, ${smartOpinionCount}, ${userOpinionCount})"
							style="display: flex; align-items: center; width: 100%;">
							<form:hidden path="hatColor" value="Strict" />
							<form:hidden path="currentTab" value="tab-strict" />
							<form:hidden path="roomId" value="${roomId}" />
							<form:hidden path="ideaId" value="${ideaId}" />
							<form:textarea path="opinionText" class="opinion-textarea"
								placeholder="의견을 입력해주세요" />
							<button type="button"
								onclick="validateAndSubmitForm('tab-strict', ${maxComments}, ${strictOpinionCount}, ${userOpinionCount})">작성</button>
						</form:form>
					</c:if>
					<c:if test="${2 - userOpinionCount == 0}">
						<div>필수 의견 2개 작성을 완료하셨습니다. 더 이상 의견을 작성할 수 없습니다.</div>
					</c:if>
				</div>
				<div class="comment-ended" style="display: none;">타이머가
					종료되었습니다. 더 이상 의견을 작성할 수 없습니다.</div>
			</div>
		</div>
	</div>
</body>
</html>

