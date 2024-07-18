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

.container {
    margin-top: 50px;
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
</style>
</head>

<body class="ab-body">
    <div class="container">
        <div class="topic">${abtest.testName}</div>
        
    <form action="./abTestVote" method="post" id="voteForm">
        <div class="choices">
            <div class="choice" id="choiceA" onclick="selectChoice('A')">
                <img src="./upload/${abtest.variantA}" alt="Image A">
                <div>A 선택</div>
                <input type="radio" name="pick" value="1" style="display: none;">
            </div>
            <div class="choice" id="choiceB" onclick="selectChoice('B')">
                <img src="./upload/${abtest.variantB}" alt="Image B">
                <div>B 선택</div>
                <input type="radio" name="pick" value="0" style="display: none;">
            </div>
        </div>
        <input type="hidden" name="abTestId" value="${abtest.ABTestID}">
        <input type="hidden" name="userId" value="${userId}">
        <button type="submit" class="submit-button">투표 제출</button>
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
