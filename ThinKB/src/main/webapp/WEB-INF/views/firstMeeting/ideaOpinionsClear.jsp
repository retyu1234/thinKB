<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - 의견 확장하기 설정</title>
<style>
html, body {
	max-width: 100%;
	overflow-x: hidden;
}

.opinion-body {
	font-family: KB금융 본문체 Light;
}

/* .content-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    position: relative;
    z-index: 2;
    width: 70%;
    padding: 20px;
    margin: 0 auto;
} */

/* 가운데 내용 부분 */
.columns {
    width: 60%;
    margin: 0 auto;
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

/* 아이디어 제목 */
.ideaOpinionList-title2 {
	font-family: KB금융 제목체 Light;
	font-size: 18pt;
	color: black;
	font-weight: bold;
	margin-top: 50px;
	margin-bottom: 20px;
}
.ideaOpinionClear-title-detail {
	font-family: KB금융 본문체 Light;
	font-size: 13pt;
	position: relative;
    width: 100%;
    overflow: hidden;
    margin-bottom: 20px;
}
/* 구분선 */
.line {
	margin-top: 15px;
	margin-bottom: 15px;
	border: 2px solid lightgrey;
}


/* 타이머 */
.timer-input {
    width: 60px;
    padding: 8px;
    border: 2px solid #666;
    border-radius: 5px;
    font-size: 16px;
    text-align: center;
}
.timer-input:hover {
    border-color: #ffcc00;
}

/* 완료버튼 */
.btn-done {
	font-family: KB금융 제목체 Light;
    width: 120px;
    height: 50px;
    border: none;
    background-color: #FFCC00;
    color: #000;
    font-weight: bold;
    font-size: 13pt;
    padding: 0 20px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    display: block;
    margin: 50px auto 0;
}
.btn-done:hover {
    background-color: #D4AA00;
}

/* 아이디어 목록 */
table {
	font-family: KB금융 본문체 Light;
    width: 100%;
    border-collapse: collapse;
}
th, td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: center;
}
th {
    background-color: #f2f2f2;
    font-weight: bold;
}
/* 아이디어 목록(완료여부) + 2차 의견 타이머 설정*/
.ideaList {
	font-family: KB금융 제목체 Light;
    text-align: left;
    margin-top: 50px;
    margin-bottom: 20px;
    font-weight: bold;
    font-size: 18pt;
}
</style>
</head>
<body class="opinion-body">
	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>
	
    <%@ include file="../leftSideBar.jsp"%>
    <%@ include file="../rightSideBar.jsp"%>
    
    <div class="columns">
    
    <!-- 5개 단계 표시 -->
    <%
	String[] stages = {"아이디어 초안", "초안 투표하기", "관점별 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
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
	
	<!-- 제목 & 상세설명 -->
	<div class="ideaOpinionList-title2">[clear page] 2차 의견단계 타이머 설정</div>
	<div class="ideaOpinionClear-title-detail">이전 단계에서 수집된 아이디어 목록&완료 여부 확인 후 타이머를 설정해주세요!</div>
	<hr class="line">
    
        <form action="./goStage4" id="goStage4" method="post">
            <input type="hidden" name="roomId" value="${roomId}">
            <input type="hidden" name="ideaId" value="${ideaId}"> 
            <input type="hidden" name="stage" value="${stage}"> 
            
            <%-- JSP 부분 --%>
			<c:set var="allCompleted" value="true" />
			<c:forEach items="${ideasInfo}" var="idea">
			    <c:if test="${idea.stageID == 3}">
			        <c:set var="allCompleted" value="false" />
			    </c:if>
			</c:forEach>

            <div class="ideaList">아이디어 목록(완료여부)</div>
            <table>
                <tr>
                    <th>아이디어 제목</th> 
                    <th>1차의견 완료 여부</th>
                </tr>
                <c:forEach items="${ideasInfo}" var="idea">
                    <tr>
                        <td>${idea.title}</td>
                        <td>
                            <c:choose>
                                <c:when test="${idea.stageID == 4}">
                                    <span style="color: blue;">완료</span>
                                </c:when>
                                <c:when test="${idea.stageID == 3}">
                                    <span style="color: red;">진행중</span>
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            
            <div class="ideaList">2차 의견 타이머 설정</div>
            
            <div>
                <input type="number" class="timer-input" name="timer_hours" min="0" max="23" placeholder="HH">
                    &nbsp;시&nbsp;&nbsp;&nbsp;
                <input type="number" class="timer-input" name="timer_minutes" min="0" max="59" placeholder="MM">
                    &nbsp;분&nbsp;&nbsp;&nbsp;
                <input type="number" class="timer-input" name="timer_seconds" min="0" max="59" placeholder="SS">
                    &nbsp;초&nbsp;&nbsp;&nbsp;
                <span class="error-message" id="timerError"></span>
            </div>
            
            
            <div>
                <button type="submit" class="btn-done">의견 받기</button>
            </div>
        </form>
    </div>
<script>
document.getElementById('goStage4').addEventListener('submit', function(e) {
    e.preventDefault();
    
	var allCompleted = ${allCompleted}; // JSP 변수를 JavaScript로 전달
    
    if (!allCompleted) {
        alert("아직 진행이 완료되지 않은 아이디어가 있습니다.");
        return;
    }
    
    var timerHours = this.querySelector('input[name="timer_hours"]').value;
    var timerMinutes = this.querySelector('input[name="timer_minutes"]').value;
    var timerSeconds = this.querySelector('input[name="timer_seconds"]').value;
    
    if (timerHours === "" && timerMinutes === "" && timerSeconds === "") {
        alert('타이머 설정을 위해 최소한 하나의 시간 단위를 입력해주세요.');
        
        this.querySelectorAll('input[type="number"]').forEach(function(input) {
            input.style.border = "2px solid red";
        });
    } else {
        this.querySelectorAll('input[type="number"]').forEach(function(input) {
            input.style.border = "";
        });
        
        // 모든 아이디어의 진행 상태 확인
        /* var allCompleted = true;
        var ideaStatuses = document.querySelectorAll('table tr td:nth-child(2)');
        
        ideaStatuses.forEach(function(status) {
            if (status.textContent.trim() === '진행중') {
                allCompleted = false;
            }
        }); */

        /* if (allCompleted) {
            var roomId = this.querySelector('input[name="roomId"]').value;
            var ideaId = this.querySelector('input[name="ideaId"]').value;
            var currentTab = 'tab-smart';
            
            var url = this.action + '?roomId=' + roomId + '&ideaId=' + ideaId + '&currentTab=' + currentTab;
            
            if (timerHours) url += '&timer_hours=' + timerHours;
            if (timerMinutes) url += '&timer_minutes=' + timerMinutes;
            if (timerSeconds) url += '&timer_seconds=' + timerSeconds;
            
            window.location.href = url;
        } else {
            alert("아직 진행이 완료되지 않은 아이디어가 있습니다.");
        } */
        
        var roomId = this.querySelector('input[name="roomId"]').value;
        var ideaId = this.querySelector('input[name="ideaId"]').value;
        var currentTab = 'tab-smart';
        
        var url = this.action + '?roomId=' + roomId + '&ideaId=' + ideaId + '&currentTab=' + currentTab;
        
        if (timerHours) url += '&timer_hours=' + timerHours;
        if (timerMinutes) url += '&timer_minutes=' + timerMinutes;
        if (timerSeconds) url += '&timer_seconds=' + timerSeconds;
        
        window.location.href = url;
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
</script>
    
</body>
</html>