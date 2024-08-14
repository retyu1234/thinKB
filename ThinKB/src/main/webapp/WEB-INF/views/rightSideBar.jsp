<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.right-sidebar {
	font-family: KB금융 본문체 Light;
    position: fixed;
    top: 170px;
    right: 0;
    width: 15%;
    height: 100%;
    padding: 20px;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
}
.sidebar-header {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    margin-bottom: 15px;
    margin-top: 30px;
}
.sidebar-icon {
    font-size: 24px;
    margin-right: 10px;
}
.sidebar-title {
    font-size: 15pt;
    font-weight: bold;
    font-family: KB금융 제목체 Light;
}
.timer-countdown-container {
    background-color: #978A8F;
    border: none;
    border-radius: 22px;
    text-align: center;
    width: 180px;
    height: 55px;
    font-size: 30px;
    font-weight: bold;
    margin-bottom: 10px;
    margin-left: 30px;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: KB금융 제목체 Light;
}
.timer-message {
    font-size: 12pt;
    margin-left: 40px;
    font-weight: normal;
}
.timer-message.active {
    color: #007bff;
}
.timer-message.expired {
    color: #dc3545;
}

.user-item {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}
.user-profile-img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 10px;
}
.user-name {
    font-size: 13pt;
}
#userList {
    max-height: 250px;
    overflow-y: auto;
    margin-left: 30px;
}
/* 스크롤바 스타일링 (선택사항) */
#userList::-webkit-scrollbar {
    width: 5px;
}

#userList::-webkit-scrollbar-track {
    background: #f1f1f1;
}

#userList::-webkit-scrollbar-thumb {
    background: #888;
    border-radius: 5px;
}

#userList::-webkit-scrollbar-thumb:hover {
    background: #555;
}

.contribution-score {
	font-size: 13pt; 
	margin-left: 35px; 
	margin-top: 10px;
}
</style>
<div class="right-sidebar">
	<!-- 타이머 영역 -->
    <div id="timer-section" class="sidebar-header">
        <span class="sidebar-icon">⏱️</span>
        <span class="sidebar-title">타이머</span>
    </div>
    <div id="timer" class="timer-countdown-container"> 
    	00:00:00
    </div>
    <div id="timer-message" class="timer-message active">아직 작성할 수 있어요!</div>

    <!-- 참여자 목록 영역 -->
    <div class="sidebar-header">
        <span class="sidebar-icon">👥</span>
        <span class="sidebar-title">참여자 목록</span>
    </div>
    <div id="userList">
    <c:forEach items="${userList}" var="user">
        <div class="user-item">
            <img src="<c:url value='./upload/${user.profileImg}'/>" alt="Profile Image" class="user-profile-img">
            <span class="user-name">
                <c:if test="${user.userId eq meetingRoom.roomManagerId}">[방장] </c:if>
                ${user.userName}
                <c:if test="${user.userId eq userId}">(나)</c:if>
            </span>
        </div>
    </c:forEach>
    </div>
    
    <!-- 기여도 영역 -->
    <div class="sidebar-header">
        <span class="sidebar-icon">🎖️</span>
        <span class="sidebar-title">내 기여도</span>
    </div>
    
    <div class="contribution-score" >
	    총 ${myContributionNum} 점
	    <c:if test="${totalContributionNum != 0}">
	        <span>(
	            <fmt:formatNumber value="${(myContributionNum / totalContributionNum) * 100}" 
	                              maxFractionDigits="1" 
	                              minFractionDigits="1"/>%
	        )</span>
	    </c:if>
	</div>

</div>
<script>
function updateTimer() {
    const endDate = new Date("${timer}").getTime();
    const now = new Date().getTime();
    const distance = endDate - now;

    if (distance < 0) {
        document.getElementById("timer").innerHTML = "00:00:00";
        document.getElementById("timer-message").innerHTML = "시간이 종료되었어요";
        document.getElementById("timer-message").classList.remove("active");
        document.getElementById("timer-message").classList.add("expired");
        
     	// 타이머 종료 시 onTimerEnd 함수 호출
        if (typeof onTimerEnd === 'function') {
            onTimerEnd();
        }
        return;
    }

    const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((distance % (1000 * 60)) / 1000);

    document.getElementById("timer").innerHTML = 
        (hours < 10 ? "0" : "") + hours + ":" +
        (minutes < 10 ? "0" : "") + minutes + ":" +
        (seconds < 10 ? "0" : "") + seconds;
    document.getElementById("timer-message").innerHTML = "아직 작성할 수 있어요";
    document.getElementById("timer-message").classList.add("active");
    document.getElementById("timer-message").classList.remove("expired");
}

document.addEventListener("DOMContentLoaded", function() {
    updateTimer();
    setInterval(updateTimer, 1000);
});
</script>
