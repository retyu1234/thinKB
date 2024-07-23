<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표하기</title>
<style>
body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
}

.option_header {
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1000;
}

.content {
	margin-top: 120px; /* 헤더 높이만큼 여백 추가 */
	display: flex;
	flex-direction: column;
	align-items: center;
}

.topic-box {
	width: 100%;
	max-width: 850px;
	padding: 20px;
	margin-bottom: 20px;
	background-color: rgba(255, 255, 255, 0.8);
	border: 1px solid #7f6000;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	box-sizing: border-box;
	text-align: center;
	position: relative;
}

.topic-title {
	width: auto;
	position: relative;
	font-weight: 600;
	display: inline-block;
	z-index: 1;
}

.er {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 20px;
}

.option-item {
	display: flex;
	align-items: center;
	margin-top: 10px;
}

.option-box {
	width: 849px;
	height: 96px;
	background-color: #EEEEEE;
	border-radius: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 20px;
	cursor: pointer;
}

.option-box.selected {
	align-self: stretch;
	flex: 1;
	position: relative;
	box-shadow: 0 5px 10px rgba(255, 255, 255, 0.25) inset, 0 4px 4px
		rgba(0, 0, 0, 0.25);
	border-radius: var(- -br-31xl);
	background-color: #ffc000;
	max-width: 100%;
}

.option-box.voted {
	align-self: stretch;
	flex: 1;
	position: relative;
	box-shadow: 0 5px 10px rgba(255, 255, 255, 0.25) inset, 0 4px 4px
		rgba(0, 0, 0, 0.25);
	border-radius: var(- -br-31xl);
	background-color: #A9A9A9;
	max-width: 100%;
}

.vote-button {
	width: 216px;
	height: 53px;
	background-color: #FFCE20;
	border: none;
	border-radius: 10px;
	font-size: 20px;
	cursor: pointer;
	margin-top: 20px;
}
</style>
</head>
<body>
	<input type="hidden" id="session-user-id"
		value="${sessionScope.userId}">

	<div class="option_header">
		<jsp:include page="../header.jsp" />
	</div>
	<div class="content">
		<div class="div">
			<div class="selected-option">
				<div class="topic-box">
					<div class="topic-title">${voteInfo.title}</div>

				</div>
			</div>
			<div class="topic-container">
				<c:forEach var="option" items="${optionList}">
					<div class="option-item">
						<div class="option-box"
							onclick="toggleSelect(this, ${option.optionId}, '${option.optionText.replaceAll('\'', '\\\'')}', false)">${option.optionText}</div>
					</div>
				</c:forEach>
			</div>
		</div>

		<button class="vote-button" onclick="submitVote()">투표하기</button>
	</div>

	<script>
    let selectedOption = null;
    let selectedOptionId = null;

    function toggleSelect(element, optionId, optionText, isCircle) {
        if (selectedOption) {
            selectedOption.classList.remove('selected');
        }
        if (selectedOption !== element) {
            element.classList.add('selected');
            selectedOption = element;
            selectedOptionId = optionId;
        } else {
            selectedOption = null;
            selectedOptionId = null;
        }
    }

    function submitVote() {
        if (selectedOption) {
            // 폼 생성 및 제출
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/submitAddVote';

            const optionIdInput = document.createElement('input');
            optionIdInput.type = 'hidden';
            optionIdInput.name = 'optionId';
            optionIdInput.value = selectedOptionId;

            const addVoteIdInput = document.createElement('input');
            addVoteIdInput.type = 'hidden';
            addVoteIdInput.name = 'addVoteId';
            addVoteIdInput.value = '${voteInfo.addVoteId}';

            const userIdInput = document.createElement('input');
            userIdInput.type = 'hidden';
            userIdInput.name = 'userId';
            userIdInput.value = '${sessionScope.userId}';

            form.appendChild(optionIdInput);
            form.appendChild(addVoteIdInput);
            form.appendChild(userIdInput);
            document.body.appendChild(form);
            form.submit();
        } else {
            alert('투표할 항목을 선택하세요.');
        }
    }

    window.onload = function() {
        const isCompleted = '${voteInfo.isCompleted}';
        if (isCompleted == 'true' ) {
            alert('이미 종료된 투표입니다.');
            window.location.href = '${pageContext.request.contextPath}/addVoteAfter?addVoteId=${voteInfo.addVoteId}';
        }
        
        const isVoted = '${votedOptionId}';
        if (isVoted != 0){
        	window.location.href = '${pageContext.request.contextPath}/addVoteAfter?addVoteId=${voteInfo.addVoteId}';
        }

        const message = '${errorMessage}';
        if (message) {
            alert(message);
        }
    }
</script>

</body>
</html>
