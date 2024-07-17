<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4);
	padding-top: 60px;
}

.modal-content {
	background-color: #fefefe;
	margin: 5% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}
</style>
<script>
    let selectedIdea = null;
    let selectedIdeaId = null;
    let selectedIdeaDescription = null;

    function toggleSelect(element, ideaId, ideaTitle, ideaDescription, isCircle){
        if (selectedIdea) {
            selectedIdea.classList.remove('selected');
        }
        if (selectedIdea !== element) {
            element.classList.add('selected');
            selectedIdea = element;
            selectedIdeaId = ideaId;
            selectedIdeaDescription = ideaDescription;
            if (isCircle) {
                openModal(ideaId, ideaTitle, ideaDescription);
            }
        } else {
            selectedIdea = null;
            selectedIdeaId = null;
            selectedIdeaDescription = null;
            closeModal();
        }
    }

    function openModal(ideaId, ideaTitle, ideaDescription) {
        document.getElementById("myModal").style.display = "block";
        document.getElementById("modal-idea-id").innerText = ideaId;
        document.getElementById("modal-idea-title").innerText = ideaTitle;
        document.getElementById("modal-idea-description").innerText = ideaDescription;

        // AJAX 요청을 통해 댓글 데이터 불러오기
        fetch('${pageContext.request.contextPath}/getIdeaReplies?ideaId=' + ideaId)
            .then(response => response.json())
            .then(data => {
                const repliesContainer = document.getElementById("modal-idea-replies");
                repliesContainer.innerHTML = '';
                data.forEach(reply => {
                    const replyElement = document.createElement('div');
                    replyElement.className = 'idea-box';
                    replyElement.innerText = reply.replyContent;
                    repliesContainer.appendChild(replyElement);
                });
            });
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
						onclick='toggleSelect(this, ${idea.ideaID}, "${idea.title}", "${idea.description.replaceAll('"', '&quot;')}", true)'></div>
					<div class="idea-box ${votedIdeaId == idea.ideaID ? 'voted' : ''}"
						onclick='toggleSelect(this, ${idea.ideaID}, "${idea.title}", "${idea.description.replaceAll('"', '&quot;')}", false)'>${idea.title}</div>
				</div>
			</c:forEach>
		</div>
		<button class="vote-button" onclick="submitVote()">${hasVoted ? '투표 변경하기' : '투표하기'}</button>
	</div>

	<!-- 아이디어 상세정보 모달 -->
	<div id="myModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<p>
				<span><input type="hidden" id="modal-idea-id"></span>
			</p>
			<p>
				<span><input type="hidden" id="modal-idea-title"></span>
			</p>
			<p>
				상세설명 : <span id="modal-idea-description"></span>
			</p>
			<p>질문하기</p>
			<div class="idea-container" id="modal-idea-replies">
				<!-- 댓글 내용이 여기에 동적으로 추가됩니다 -->
			</div>
		</div>
	</div>
</body>
</html>
