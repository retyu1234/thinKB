<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ABTest 투표</title>
<style>
.ab-body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    text-align: center;
}
.abtestHeadImg {
	margin: 0;
	padding: 0;
	background-image:
		url('${pageContext.request.contextPath}/resources/header2.jpg');
	background-size: cover; /* 이미지가 요소에 완전히 맞도록 비율을 조정 */
	background-position: center; /* 이미지를 가운데 정렬 */
	background-repeat: no-repeat;
	height: 400px; /* 요소의 높이를 400px로 고정 */
}


.container {
    margin-top: 50px;
    margin-bottom: 150px;
}

.topic {
    font-size: 1.5em;
    font-weight: bold;
    margin-bottom: 20px;
}

.choices {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}

.choice {
    margin: 0 30px;
    cursor: pointer;
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
            justify-content: center;
            margin-top: 20px;
            height: 30px;
            width: 80%;
            margin-left: auto;
            margin-right: auto;
            background-color: #e0e0e0;
            border-radius: 15px;
            overflow: hidden;
        }
        .vote-bar-a {
            background-color: #4CAF50;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            transition: width 0.5s ease-in-out;
        }
        .vote-bar-b {
            background-color: #2196F3;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            transition: width 0.5s ease-in-out;
        }
        .choice.winning img {
            border-color: #ffd700; /* 골드 색상으로 변경 */
        }
</style>
</head>

<body class="ab-body">
<div class="abtestHeadImg">
<%@ include file="../header.jsp"%></div>
    <div class="container">
        <div class="topic">${abtest.testName}</div>
            <div class="choices">
                <div class="choice ${aPercentage >= bPercentage ? 'winning' : ''}" id="choiceA" onclick="selectChoice('A')">
                    <img src="./upload/${abtest.variantA}" alt="Image A">
                    <div>A 선택</div>
                    <input type="radio" name="pick" value="1" style="display: none;">
                </div>
                <div class="choice ${bPercentage > aPercentage ? 'winning' : ''}" id="choiceB" onclick="selectChoice('B')">
                    <img src="./upload/${abtest.variantB}" alt="Image B">
                    <div>B 선택</div>
                    <input type="radio" name="pick" value="0" style="display: none;">
                </div>
            </div>
            <div class="vote-results">
                <div class="vote-bar-a" style="width: ${aPercentage}%;">${String.format("%.1f", aPercentage)}%(${abtest.resultANum})</div>
                <div class="vote-bar-b" style="width: ${bPercentage}%;">${String.format("%.1f", bPercentage)}%(${abtest.resultBNum})</div>
            </div>
            <div>총 투표 수: ${totalVotes}</div>
            <input type="hidden" name="abTestId" value="${abtest.ABTestID}">
            <input type="hidden" name="userId" value="${userId}">
 
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
