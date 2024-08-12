<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2차 의견 타이머 설정</title>
<style>
html, body {
	max-width: 100%;
	overflow-x: hidden;
}

.opinion-body {
	font-family: Arial, sans-serif;
}

.opinion-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
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
    width: 100%;
    margin-top: 30px;
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
.ideaList {
    text-align: left;
    margin-top: 50px;
    width: 100%;
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
    
    <div class="opinion-content">
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
            
            <h2 style="text-align: left; margin-top: 50px;">2차 의견 타이머 설정</h2>
            
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
</script>
    
</body>
</html>