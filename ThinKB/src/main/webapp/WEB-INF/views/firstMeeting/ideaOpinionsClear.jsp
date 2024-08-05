<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2차 의견 타이머 설정</title>
<style>

.content-container {
	padding: 20px;
	margin-left: 15%;
	margin-right: 15%;
	position: relative;
	z-index: 2;
	width: 60%;
}


table {
	width: 70%;
	margin-left: auto;
    margin-right: auto;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
	font-weight: bold;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

tr:hover {
	background-color: #f5f5f5;
}

.rank-1, .rank-2, .rank-3 {
	font-weight: bold;
}

.rank-1 {
	color: gold;
	font-weight: bold;
	font-size: 13pt;
}

.rank-2 {
	color: silver;
	font-weight: bold;
	font-size: 13pt;
}

.timer-container {
	margin-top: 30px;
	display: flex;
	align-items: center;
}

.timer-label {
	margin-right: 10px;
	font-size: 20px;
	font-weight: bold;
}

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
</style>

</head>
<body style=""margin: 0;">
	<%@ include file="../header.jsp"%>
	<%@ include file="../leftSideBar.jsp"%>
	<%@ include file="../rightSideBar.jsp"%>
	

<!-- 	<div class="content-container"> -->
			<form action="./goStage4" id="goStage4" method="post">
				<input type="hidden" name="roomId" value="${roomId}">
				<input type="hidden" name="ideaId" value="${ideaId}"> 
				<input type="hidden" name="stage" value="${stage}"> 
				
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
				
				<div style="text-align: center; margin-top: 50px;">
					<button type="submit" class="button">의견 받기</button>
				</div>
			</form>
		</div>

<script>
document.getElementById('goStage4').addEventListener('submit', function(e) {
    e.preventDefault();

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
        
     	// URL 파라미터 추가
        var roomId = this.querySelector('input[name="roomId"]').value;
        var ideaId = this.querySelector('input[name="ideaId"]').value;
        var currentTab = 'tab-smart'; // 기본 값

     	// 기본 URL 설정 (컨텍스트 경로 포함)
        // var baseUrl = '/star/goStage4'; // 컨텍스트 경로에 맞게 수정하세요
        
        var url = this.action + '?roomId=' + roomId + '&ideaId=' + ideaId + '&currentTab=' + currentTab;
        
     	// 타이머 값이 있으면 URL에 추가
        if (timerHours) url += '&timer_hours=' + timerHours;
        if (timerMinutes) url += '&timer_minutes=' + timerMinutes;
        if (timerSeconds) url += '&timer_seconds=' + timerSeconds;
        
     	// URL로 이동
        window.location.href = url;
        // 모든 조건이 만족되면 폼을 수동으로 제출합니다.
        // this.submit();
    }
});

</script>
	
</body>
</html>