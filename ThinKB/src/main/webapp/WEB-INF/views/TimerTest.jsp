<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이머 테스트</title>
</head>
<body>
<div><%@ include file="./Timer.jsp"%></div>

<div id="nextStepButton" style="display: none;">
    <button onclick="goToNextStep()">다음 단계</button>
</div>

<script>
// 타이머 종료시 동작될 것들 onTimerEnd안에 기재하면 됨
function onTimerEnd() {
	if ("${roomInfo.getRoomManagerId()}" === "${userId}") {
        document.getElementById("nextStepButton").style.display = "block";
    }
}

function goToNextStep() {
    // 다음 화면으로 이동하는 로직 구현
    // 예: window.location.href = "다음_페이지_URL";
}
</script>
</body>
</html>