<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - A/B테스트 결과 확인</title>
<style>
html, body {
	max-width: 100%;
	overflow-x: hidden;
}

.ab-body {
	font-family: KB금융 본문체 Light;
}

.ab-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
}

.topic {
	background-color: #f0f0f0;
	border-radius: 20px;
	padding: 15px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 50px;
}

.topic-left {
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.topic-text {
	font-size: 18pt;
	font-weight: bold;
	margin-left: 20pt;
	margin-bottom: 10px;
	font-family: KB금융 제목체 Light;
}

.topic-content {
	font-size: 13pt;
	margin-left: 20pt;
}

.topic-image {
	max-height: 100px;
	width: auto;
	margin-left: 20pt;
	margin-right: 20pt;
}
.choices {
	display: flex;
	justify-content: center;
	margin-bottom: 20px;
}
.choice {
	margin: 0 100px;
}

.choice-title {
	font-size: 15pt;
	cursor: pointer;
	font-weight: bold;
	text-align: center;
	font-family: KB금융 제목체 Light;
}

.choice img {
	width: 400px;
	height: auto;
	border: 5px solid transparent;
	transition: border-color 0.3s ease-in-out;
}

.choice.selected img {
	border-color: #ffc107;
}

.submit-button {
	background-color: #ffc107;
	color: #ffffff;
	font-size: 1.2em;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 20px;
}

.submit-button:hover {
	background-color: #e0a800;
}

.vote-results {
    display: flex;
    justify-content: flex-start;
    margin-top: 20px;
    height: 40px;
    width: 80%;
    margin-left: auto;
    margin-right: auto;
    margin-bottom: 200px;
    background-color: #e0e0e0;
    border-radius: 20px;
    overflow: hidden;
    font-family: KB금융 본문체 Light;
}

.vote-bar-a, .vote-bar-b {
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    transition: width 0.5s ease-in-out;
    font-size: 13pt;
    font-weight: bold;
    min-width: 100px;
    font-family: KB금융 제목체 Light;
}
.vote-bar-a {
    background-color: #FFCC00;
}

.vote-bar-b {
    background-color: #ED3F3E;
}

.choice.winning img {
	border-color: #ffd700;
}
</style>
</head>

<body class="ab-body">
	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>
	
	<div class="ab-content">
		<div class="topic">
		    <div class="topic-left">
		        <div class="topic-text">[${abtest.testName}]</div>
		        <div class="topic-content">A/B테스트 결과를 확인해봐요.</div>
		    </div>
		    <img src="<c:url value='./resources/abTitle.png'/>" alt="abTitleImg" class="topic-image">
		</div>
		
            <div class="choices">
                <div class="choice ${aPercentage >= bPercentage ? 'winning' : ''}" id="choiceA">
                    <div class="choice-title">A 시안</div>
                    <img src="./upload/${abtest.variantA}" alt="Image A">
                    <input type="radio" name="pick" value="1" style="display: none;">
                </div>
                <div class="choice ${bPercentage > aPercentage ? 'winning' : ''}" id="choiceB">
                    <div class="choice-title">B 시안</div>
                    <img src="./upload/${abtest.variantB}" alt="Image B">
                    <input type="radio" name="pick" value="0" style="display: none;">
                </div>
            </div>
            <!-- 투표결과 -->
            <div style="text-align: end; font-size:13pt; margin-right: 100px;">총 투표 수 ${totalVotes}건</div>
			<div class="vote-results">
			    <c:if test="${abtest.resultANum > 0}">
			        <div class="vote-bar-a" style="width: ${aPercentage}%;">${String.format("%.1f", aPercentage)}%(${abtest.resultANum}건)</div>
			    </c:if>
			    <c:if test="${abtest.resultBNum > 0}">
			        <div class="vote-bar-b" style="width: ${bPercentage}%;">${String.format("%.1f", bPercentage)}%(${abtest.resultBNum}건)</div>
			    </c:if>
			</div>
            
 
    </div>

<script>
    // 페이지 로드 시 사용자의 선택을 표시
    window.onload = function() {
        var userChoice = "${userChoice}"; // 서버에서 사용자의 선택을 받아옴
        if (userChoice === "A") {
            document.getElementById('choiceA').classList.add('selected');
        } else if (userChoice === "B") {
            document.getElementById('choiceB').classList.add('selected');
        }
    }

    // selectChoice 함수 제거
</script>
</body>
</html>
