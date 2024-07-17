<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디어 투표</title>
<style>
body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
}

.idea_header {
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1000;
}

.content {
	margin-top: 60px; /* 헤더 높이만큼 여백 추가 */
	display: flex;
	flex-direction: column;
	align-items: center;
}

.topic-box {
	width: 962px;
	height: 150px;
	background-color: #EEEEEE;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: left;
	margin-top: 90px;
}

.topic-title {
	font-size: 25px;
	text-align: left;
	margin-left: 20px;
}

.topic-description {
	font-size: 20px;
	text-align: left;
	margin-left: 30px;
}

.idea-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 20px;
}

.idea-item {
	display: flex;
	align-items: center;
	margin-top: 10px;
}

.idea-circle {
	width: 96px;
	height: 96px;
	border-radius: 50%;
	background-color: #EEEEEE;
	margin-right: 10px;
	cursor: pointer;
}

.idea-circle.selected {
	background-color: #FFCE20;
}

.idea-box {
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

.idea-box.selected {
	background-color: #FFCE20;
}

.idea-box.voted {
	background-color: #A9A9A9;
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

.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
	display: flex;
	justify-content: center;
	align-items: center;
}

.modal-content {
	background-color: #D9D9D9;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 920px;
	max-width: 920px;
	min-height: 489px;
	display: flex;
	flex-direction: column;
	align-items: center;
	border-radius: 10px; /* 모서리 둥글게 */
	box-sizing: border-box; /* 패딩과 테두리를 포함한 크기 계산 */
}

.close {
	color: #aaa;
	align-self: flex-end;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
}

.modal-content h2 {
	font-weight: bold;
	font-size: 23pt;
	color: #494949;
	margin: 20px 0 10px 0; /* 상하 여백 동일하게, 좌우 여백 0 */
	align-self: flex-start; /* 왼쪽 정렬 */
}

.description-box, .question-box {
	width: 836px;
	/*     height: 87px; */
	border: 5px solid #FFC000;
	background-color: #FFFFFF;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-top: 20px;
	font-weight: 500;
	font-size: 20px;
	color: #212121;
	border-radius: 10px; /* 모서리 둥글게 */
}

.question-input {
	width: 100%;
	height: 100%;
	border: none;
	border-bottom: 5px solid #6F614E;
	background-color: transparent;
	padding: 10px;
	font-weight: 500;
	font-size: 20px;
	color: #212121;
	box-sizing: border-box;
	/*     border-radius: 0 0 10px 10px; /* 모서리 둥글게, 아래쪽만 */
	*/
}
</style>
<script>
let selectedIdea = null;
let selectedIdeaId = null;

function toggleSelectCircle(element, ideaId, ideaTitle, ideaDescription) {
    if (selectedIdea) {
        selectedIdea.classList.remove('selected');
    }
    if (selectedIdea !== element) {
        element.classList.add('selected');
        selectedIdea = element;
        selectedIdeaId = ideaId;
        openModal(ideaId, ideaTitle, ideaDescription);
    } else {
        selectedIdea = null;
        selectedIdeaId = null;
        closeModal();
    }
}

function toggleSelectBox(element, ideaId) {
    if (selectedIdea) {
        selectedIdea.classList.remove('selected');
    }
    if (selectedIdea !== element) {
        element.classList.add('selected');
        selectedIdea = element;
        selectedIdeaId = ideaId;
    } else {
        selectedIdea = null;
        selectedIdeaId = null;
    }
}

function openModal(ideaId, ideaTitle, ideaDescription) {
    console.log("Opening modal with description: ", ideaDescription); // 디버깅용 로그
    document.getElementById("myModal").style.display = "flex";
    document.getElementById("modal-idea-id").innerText = ideaId;
    document.getElementById("modal-idea-title").innerText = ideaTitle;
    document.getElementById("modal-idea-description").innerText = ideaDescription;
}


function closeModal() {
    document.getElementById("myModal").style.display = "none";
}

function submitVote() {
    if (selectedIdea) {
        const selectedTitle = selectedIdea.innerText;

        // 폼 생성 및 제출
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/submitVote'; // 실제 투표 제출 경로로 변경

        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'selectedIdea';
        input.value = selectedTitle;

        const roomIdInput = document.createElement('input');
        roomIdInput.type = 'hidden';
        roomIdInput.name = 'roomId';
        roomIdInput.value = '${meetingRoom.roomId}';

        const roomTitleInput = document.createElement('input');
        roomTitleInput.type = 'hidden';
        roomTitleInput.name = 'roomTitle';
        roomTitleInput.value = '${meetingRoom.roomTitle}';

        const userIdInput = document.createElement('input');
        userIdInput.type = 'hidden';
        userIdInput.name = 'userId';
        userIdInput.value = '${sessionScope.userId}';

        const ideaIdInput = document.createElement('input');
        ideaIdInput.type = 'hidden';
        ideaIdInput.name = 'ideaId';
        ideaIdInput.value = selectedIdeaId;

        form.appendChild(input);
        form.appendChild(roomIdInput);
        form.appendChild(userIdInput);
        form.appendChild(roomTitleInput);
        form.appendChild(ideaIdInput);
        document.body.appendChild(form);
        form.submit();
    } else {
        alert('아이디어를 선택하세요.');
    }
}

window.onload = function() {
    const Message = '${errorMessage}';
    if (Message) {
        alert(Message);
    }
}

</script>
</head>
<body>
	<div class="idea_header">
		<jsp:include page="../header.jsp" />
	</div>
	<div class="content">
		<div class="topic-box">
			<div class="topic-title">
				${meetingRoom.roomTitle} <input type="hidden" name="roomId"
					value="${meetingRoom.roomId}" />
			</div>
			<div class="topic-description">${meetingRoom.description}</div>
		</div>
		<div class="idea-container">
			<c:forEach var="idea" items="${ideas}">
				<div class="idea-item">
					<div class="idea-circle"
						onclick="toggleSelectCircle(this, ${idea.ideaID}, '${idea.title}', '${idea.description}')"></div>
					<div class="idea-box ${votedIdeaId == idea.ideaID ? 'voted' : ''}"
						onclick="toggleSelectBox(this, ${idea.ideaID})">${idea.title}</div>
				</div>
			</c:forEach>


		</div>
		<button class="vote-button" onclick="submitVote()">${hasVoted ? '투표 변경하기' : '투표하기'}</button>
	</div>

	<!-- 아이디어 상세정보 모달 -->
	<div id="myModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<h2>상세설명</h2>
			<div class="description-box">
				<p id="modal-idea-description">${idea.description}</p>
			</div>
			<h2>질문하기</h2>
			<div class="description-box">
				<div class="question-box">
					<input type="text" class="question-input"
						placeholder="여기에 질문을 입력하세요.">
				</div>
			</div>
		</div>
	</div>
</body>
</html>
