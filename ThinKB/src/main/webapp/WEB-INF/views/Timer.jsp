<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.timer-container {
    background-color: white;
    border: 2px solid #e0e0e0;
    border-radius: 25px;
    padding: 20px;
    width: 300px;
    text-align: center;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}
.timer-header {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    margin-bottom: 20px;
}
.timer-icon {
    font-size: 24px;
    margin-right: 10px;
}
.timer-title {
    font-size: 18px;
    font-weight: bold;
}
.timer-countdown {
    font-size: 36px;
    font-weight: bold;
    margin-bottom: 10px;
}
.timer-message {
    font-size: 14px;
}
.timer-message.active {
    color: #007bff;
}
.timer-message.expired {
    color: #dc3545;
}
</style>
<div class="timer-container">
    <div class="timer-header">
        <span class="timer-icon">⏱️</span>
        <span class="timer-title">타이머</span>
    </div>
    <div id="timer" class="timer-countdown">00:00:00</div>
    <div id="timer-message" class="timer-message active">아직 작성할 수 있어요</div>
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
