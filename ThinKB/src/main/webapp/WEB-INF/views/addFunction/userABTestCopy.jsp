<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ABTest 투표</title>
<style>
html, body {
	max-width: 100%;
	overflow-x: hidden;
}

.ab-body {
	font-family: Arial, sans-serif;
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
    margin-bottom: 10px; /* 텍스트와 내용 사이의 간격 */
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
	cursor: pointer;
}

.choice-title {
	font-size: 15pt;
	cursor: pointer;
	font-weight: bold;
	text-align: center;
}

.choice img {
	width: 400px;
	height: auto;
	border: 5px solid transparent;
	transition: border-color 0.3s ease-in-out;
}

.choice.selected img {
	border-color: #ffc107; /* 선택된 항목의 테두리 색상 */
}

.yellow-button {
	background-color: #FFCC00;
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	cursor: pointer;
	font-weight: bold;
}

.yellow-button:hover {
	background-color: #D4AA00;
}

/* 회색버튼 */
.grey-button {
	background-color: #978A8F;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	cursor: pointer;
	font-weight: bold;
}

.grey-button:hover {
	background-color: #60584C;
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
		        <div class="topic-content">A시안과 B시안중에 더 좋은 화면을 골라주세요!</div>
		    </div>
		    <img src="<c:url value='./resources/abTitle.png'/>" alt="abTitleImg" class="topic-image">
		</div>


		<form action="./abTestVote" method="post" id="voteForm">
			<div class="choices">
				<div class="choice" id="choiceA" onclick="selectChoice('A')">
					<div class="choice-title">A 시안</div>
					<img src="./upload/${abtest.variantA}" alt="Image A">
					<input type="radio" name="pick" value="1" style="display: none;">
				</div>
				<div class="choice" id="choiceB" onclick="selectChoice('B')">
					<div class="choice-title">B 시안</div>
					<img src="./upload/${abtest.variantB}" alt="Image B">
					<input type="radio" name="pick" value="0" style="display: none;">
				</div>
			</div>
			<input type="hidden" name="abTestId" value="${abtest.ABTestID}">
			<input type="hidden" name="userId" value="${userId}">
			<div style="text-align: center; margin-top:50px; margin-bottom: 200px;">
				<button type="submit" class="yellow-button">투표 제출</button>
			</div>
		</form>
	</div>

	<script>
        var selectedChoice = null;

        function selectChoice(choice) {
            if (selectedChoice === choice) return; // 이미 선택된 경우 무시
            
            if (selectedChoice) {
                var selectedElement = document.getElementById('choice' + selectedChoice);
                selectedElement.classList.remove('selected');
            }

            selectedChoice = choice;
            var selectedElement = document.getElementById('choice' + selectedChoice);
            selectedElement.classList.add('selected');
            
            // 선택된 값을 숨겨진 라디오 버튼에 설정
            var radio = selectedElement.querySelector('input[type="radio"]');
            radio.checked = true;
        }
    </script>
</body>
</html>
