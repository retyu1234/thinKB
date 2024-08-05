<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디어 투표</title>
<style>
body {
	font-family: 'Inter', sans-serif;
	margin-top: 50px;
	padding: 0;
	margin-bottom: 100px;
}

.ideaMeeting-contents {
	display: flex;
	flex-direction: column;
	margin-left: 20%;
	margin-right: 20%;
	/*  	justify-content: center;  */
	height: 100vh; /* Ensure it takes the full viewport height */
}

.content {
	margin-top: 100px; /* 헤더 높이만큼 여백 추가 */
	display: flex;
	flex-direction: column;
	align-items: center;
}

.idea_header {
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1000;
}

.ideaMeeting-topic-box {
	margin-left: 3%;
	margin-right: 3%;
}

.topic-title {
	font-size: 18pt;
	color: black;
	font-weight: bold;
	margin-top: 50px;
	margin-bottom: 20px;
}

.topic-description {
	font-size: 14pt;
	margin-bottom: 70px;
}

.idea-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 20px;
}

.modal-idea-container {
	width: 100%;
	height: 87px;
	top: 0;
	right: 0;
	left: 0;
	border-radius: var(- -br-11xl);
	background-color: var(- -color-white);
	border: 5px solid var(- -color-gold);
	z-index: 1;
}

.idea-item {
	display: flex;
	align-items: center;
	margin-top: 10px;
	margin-left: 5%;
	margin-right: 5%;
	margin-bottom: 1.5%
	
}

.idea-circle {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	background-image: url('./resources/Uncheck.png');
	background-size: 100%;
	background-position: center;
	background-repeat: no-repeat;
	margin-right: 30px;
	cursor: pointer;
	position: relative; /* Added for positioning the background image */
}

.idea-circle.selected {
	background-image: url('./resources/Check.png');
	background-size: 100%;
	background-position: center;
	background-repeat: no-repeat;
}

.idea-box {
	width: 100%;
	height: 70px;
	background-color: #EEEEEE;
	border-radius: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 20px;
	cursor: pointer;
	position: relative;
	height: 70px; /* Added for positioning the "투표됨" text */
}

.idea-box.selected {
	align-self: stretch;
	flex: 1;
	position: relative;
	border-radius: var(- -br-31xl);
	background-color: #EEEEEE;
	max-width: 100%;
}

.idea-box.voted {
	align-self: stretch;
	flex: 1;
	position: relative;
	border-radius: var(- -br-31xl);
	background-color: #FFE297;
	max-width: 100%;
}

.idea-box.voted::after {
	content: '투표됨';
	position: absolute;
	right: 40px;
	color: #007AFF;
	font-size: 16px;
	font-weight: bold;
}

.vote-button {
	width: 150px;
	height: 40px;
	background-color: #FFCE20;
	border: none;
	border-radius: 10px;
	font-size: 13px;
	cursor: pointer;
	margin-top: 40px;
	font-weight: bold;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow-y: auto;
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
	overflow-y: auto;
}

.closeIdea {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.closeIdea:hover, .closeIdea:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.wrapper {
	align-self: stretch;
	display: flex;
	align-items: flex-start;
	justify-content: flex-start;
	box-sizing: border-box;
	max-width: 100%;
}

.selected-option {
	flex-direction: column;
	padding: 26px 0 27px 77px;
	position: relative;
	gap: 11px;
}

.modal-idea-container {
	alignt-items: center;
	width: 100%;
	height: 100%;
	overflow-y: auto;
	background-color: var(- -color-white);
	border: 5px solid var(- -color-gold);
	border-radius: var(- -br-11xl);
	box-sizing: border-box;
	padding: 10px; /* Add padding if needed */
}

/* 추가된 CSS 스타일 */
.idea-box.reply {
	background-color: #FFCE20; /* 노란색 */
}

.idea-box.reply-answer {
	background-color: #EEEEEE;
}

.next-step-container {
	margin-right: 30px;
	font-size: 13pt;
}

/* 노란색 버튼 */
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

.vote-info {
	margin-right: 30px;
	font-size: 14pt;
}

/* 5단계 css 추가 */
.stage-info {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	margin-top: -50px;
}

.stages {
	display: flex;
	justify-content: space-between;
	padding: 30px 0;
	font-size: 13pt;
	margin-top: 50px;
}

.stage {
	flex: 1;
	text-align: center;
	padding: 3px; /* 5px에서 3px로 줄임 */
	margin: 0 2px; /* 좌우 여백 추가 */
	cursor: pointer;
	text-decoration: none;
	color: #000;
	white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 함 */
	overflow: hidden; /* 넘치는 텍스트 숨김 */
	text-overflow: ellipsis; /* 넘치는 텍스트를 ...으로 표시 */
}

.active {
	color: #FFD700;
	font-weight: bold;
}

.inactive {
	color: #999;
	pointer-events: none;
}
/* 배너 추가  */
.ideaMeeting-banner {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 30px;
	margin-bottom: -50px;
}

.ideaMeeting-vote-container {
	margin-top: 50px;
	align-items: center;
}

.vote-button-container {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
}
</style>
</head>
<body>
	<input type="hidden" id="session-user-id"
		value="${sessionScope.userId}">
	<input type="hidden" id="session-room-id"
		value="${sessionScope.roomId}">

	<c:if test="${not empty sessionScope.Message}">
		<div class="alert">${sessionScope.Message}</div>
	</c:if>

	<%
	String[] stages = {"아이디어 초안", "초안 투표하기", "관점별 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
	request.setAttribute("stages", stages);
	%>

	<!-- 상단, 좌측, 우측 헤더 -->
	<div class="ideaMeeting-header">
		<header class="site-header">
			<%@ include file="../header.jsp"%>
		</header>
		<div class="left-header">
			<%@ include file="../leftSideBar.jsp"%>
		</div>
		<div class="right-header">
			<%@ include file="../rightSideBar.jsp"%>
		</div>
	</div>

	<!-- 메인 콘텐츠 -->
	<div class="ideaMeeting-contents">

		<!-- 5개 단계 표시 -->
		<div class="stages">
			<c:forEach var="stage" items="${stages}" varStatus="status">
				<c:choose>
					<c:when test="${meetingRoom.getStageId() >= status.index + 1}">
						<a
							href="roomDetail?roomId=${meetingRoom.getRoomId()}&stage=${status.index + 1}"
							class="stage ${meetingRoom.getStageId() == status.index + 1 ? 'active' : ''}">
							${status.index + 1}. ${stage} </a>
					</c:when>
					<c:otherwise>
						<div class="stage inactive">${status.index + 1}.${stage}</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>

		<!-- 배너  -->
		<div class="ideaMeeting-banner">
			<img src="<c:url value='./resources/ideaMeetingBanner.png'/>"
				alt="Example Image" style="min-width: 100%; height: auto;">
		</div>


		<!-- 투표 내용 -->
		<div class="ideaMeeting-vote-container">
			<!-- 회의 방 내용 -->
			<div class="ideaMeeting-topic-box">
				<div class="topic-title">
					[${meetingRoom.roomTitle}] <input type="hidden" name="roomId"
						value="${meetingRoom.roomId}">
				</div>
				<div class="topic-description">${meetingRoom.description}</div>
			</div>

			<!-- 방장만 보이는 다음단계 버튼 -->
			<form id="nextStageForm" action="./stage2Clear" method="post">
				<input type="hidden" name="roomId" value="${meetingRoom.roomId}">
				<input type="hidden" name="stage" value="${meetingRoom.stageId}">
				<div class="stage-info" style="margin-bottom: 50px;">
					<c:if test="${userId == meetingRoom.getRoomManagerId()}">
						<div class="vote-info">현재 투표 참여인원 : ${voteCnt}명 / ${total}명</div>
						<button id="nextStepButton" class="yellow-button"
							onclick="goToNextStep()">다음 단계</button>
					</c:if>
				</div>
			</form>
			<div class="ideaMeeting-idea-container">
				<c:forEach var="idea" items="${ideas}">
					<div class="idea-item">
						<div
							class="idea-circle <%-- ${votedIdeaId == idea.ideaID ? 'selected' : ''} --%>"
							onclick='toggleSelect(this, ${idea.ideaID}, "${idea.title.replaceAll("\"", "&quot;")}", "${idea.description.replaceAll("\"", "&quot;")}", "${idea.userID}", false)'></div>
						<div class="idea-box ${votedIdeaId == idea.ideaID ? 'voted' : ''}"
							onclick='toggleSelect(this, ${idea.ideaID}, "${idea.title.replaceAll("\"", "&quot;")}", "${idea.description.replaceAll("\"", "&quot;")}", "${idea.userID}", true)'>${idea.title}</div>
					</div>
				</c:forEach>
			</div>
			<div class="vote-button-container">
				<button id="voteButton" class="yellow-button"
					style="margin-top: 50px;" onclick="submitVote()">
					${hasVoted ? '투표 변경하기' : '투표하기'}</button>
			</div>

		</div>
	</div>

	<!-- Modal window -->
	<div id="myModal" class="modal">
		<div class="modal-content">

			<span class="closeIdea" onclick="closeModal()">&times;</span>

			<p>
				<span><input type="hidden" id="modal-idea-id"></span>
			</p>
			<p>
				<span><input type="hidden" id="modal-idea-title"></span>
			</p>
			<p>
				<span><input type="hidden" id="modal-idea-userId"></span>
			</p>
			<p>
				상세설명 : <span id="modal-idea-description"></span>
			</p>
			<p>질문하기</p>
			<div class="modal-idea-container" id="modal-idea-replies">
				<!-- 댓글 내용이 여기에 동적으로 추가됩니다 -->
			</div>
			<div id="input-reply-container">
				<input type="text" id="replyContent" placeholder="댓글을 입력하세요" />
				<button onclick="submitReply()" id="input-button">입력</button>
			</div>

			<div id="reply-form-container" style="display: none;">
				<p>
					답변할 질문: <span id="replying-to-question"></span>
				</p>
				<input type="hidden" id="replyToId" /> <input type="text"
					id="replyAnswerContent" placeholder="답변을 입력하세요" />
				<div id="reply-button-container">
					<button onclick="submitReplyAnswer()" id="reply-button">답글달기</button>
				</div>
			</div>
		</div>
	</div>
	<script>
    let selectedIdea = null;
    let selectedIdeaId = null;
    let selectedIdeaDescription = null;
    let selectedIdeaUserId = null;
    let timerEnded = false; // 타이머 종료 여부를 추적하는 변수

    function toggleSelect(element, ideaId, ideaTitle, ideaDescription, ideaUserId, isCircle) {
        if (selectedIdea) {
            selectedIdea.classList.remove('selected');
        }
        if (selectedIdea !== element) {
            element.classList.add('selected');
            selectedIdea = element;
            selectedIdeaId = ideaId;
            selectedIdeaDescription = ideaDescription;
            selectedIdeaUserId = ideaUserId;
            if (isCircle) {
                openModal(ideaId, ideaTitle, ideaDescription, ideaUserId);
            }
        } else {
            selectedIdea = null;
            selectedIdeaId = null;
            selectedIdeaDescription = null;
            selectedIdeaUserId = null;
            closeModal();
        }
    }

    function closeModal() {
        document.getElementById("myModal").style.display = "none";
        console.log('아이디어 닫기 버튼 클릭됨');
        hideReplyForm(); // Hide the reply form container when the modal is closed
    }

    function openModal(ideaId, ideaTitle, ideaDescription, ideaUserId) {
        document.getElementById("myModal").style.display = "block";
        document.getElementById("modal-idea-id").innerText = ideaId;
        document.getElementById("modal-idea-title").innerText = ideaTitle;
        document.getElementById("modal-idea-description").innerText = ideaDescription;
        document.getElementById("modal-idea-userId").innerText = ideaUserId;

        if (timerEnded) {
            document.getElementById("input-reply-container").style.display = "none";
            document.getElementById("reply-form-container").style.display = "none";
        } else {
            const sessionUserId = document.getElementById("session-user-id").value;

            if (Number(sessionUserId) === Number(ideaUserId)) {
                document.getElementById("reply-button").style.display = "block";
                document.getElementById("replyContent").style.display = "none";
                document.getElementById("input-button").style.display = "none";
                document.getElementById("input-button").innerText = "답변전송";
            } else {
                document.getElementById("reply-button").style.display = "none";
                document.getElementById("replyContent").style.display = "block";
                document.getElementById("input-button").style.display = "block";
                document.getElementById("input-button").innerText = "입력";
            }
        }

        // AJAX 요청을 통해 댓글 데이터 불러오기
        fetch('${pageContext.request.contextPath}/getIdeaReplies?ideaId=' + ideaId)
        .then(response => response.json())
        .then(data => {
            const repliesContainer = document.getElementById("modal-idea-replies");
            repliesContainer.innerHTML = '';
            data.forEach(reply => {
                const replyElement = document.createElement('div');
                replyElement.className = 'idea-box';
                if (reply.replyStep === 0) {
                    replyElement.classList.add('reply');
                } else {
                    replyElement.classList.add('reply-answer');
                }
                let replyHtml = reply.replyContent;
                replyElement.innerHTML = replyHtml;
                replyElement.onclick = function() {
                    const sessionUserId = document.getElementById("session-user-id").value;
                    if (!timerEnded && Number(sessionUserId) !== Number(reply.userId) && Number(sessionUserId) === Number(ideaUserId)) {
                        showReplyForm(reply.ideaReply, replyHtml.replace(/"/g, '&quot;').replace(/'/g, '&#39;'));
                    } else {
                        hideReplyForm();
                    }
                };
                repliesContainer.appendChild(replyElement);
            });
        });
    }

    function showReplyForm(replyID, replyContent) {
        document.getElementById("reply-form-container").style.display = "block";
        document.getElementById("replying-to-question").innerText = replyContent;
        document.getElementById("replyToId").value = replyID;
    }

    function hideReplyForm() {
        document.getElementById("reply-form-container").style.display = "none";
    }

    function submitReply() {
        const replyContent = document.getElementById("replyContent").value;
        if (replyContent.trim() === "") {
            alert("질문 내용을 입력하세요.");
            return;
        }

        const sessionUserId = document.getElementById("session-user-id").value;
        const ideaUserId = document.getElementById("modal-idea-userId").innerText;

        const data = new URLSearchParams();
        data.append("replyContent", replyContent);
        data.append("ideaId", selectedIdeaId);
        data.append("roomId", ${meetingRoom.roomId});

        fetch('/star/submitReply', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data.toString()
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.text(); // JSON 대신 텍스트 형식으로 응답 처리
        })
        .then(result => {
            console.log("Submit Reply Result: ", result);
            if (result === 'success') {
                alert("댓글이 성공적으로 등록되었습니다.");
                openModal(selectedIdeaId, document.getElementById("modal-idea-title").innerText, document.getElementById("modal-idea-description").innerText, ideaUserId); // 모달 새로고침
            } else {
                alert("댓글 등록에 실패하였습니다.");
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("댓글 등록 중 오류가 발생하였습니다.");
        });
    }

    function submitReplyAnswer() {
        const replyAnswerContent = document.getElementById("replyAnswerContent").value;
        if (replyAnswerContent.trim() === "") {
            alert("답변 내용을 입력하세요.");
            return;
        }

        const ideaReply = document.getElementById("replyToId").value;

        const data = new URLSearchParams();
        data.append("replyContent", replyAnswerContent);
        data.append("ideaId", selectedIdeaId);
        data.append("roomId", ${meetingRoom.roomId});
        data.append("replyStep", ideaReply);

        console.log("Submitting reply answer with data: ", data.toString());

        fetch('/star/submitReplyAnswer', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data.toString()
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.text(); // JSON 대신 텍스트 형식으로 응답 처리
        })
        .then(result => {
            console.log("Submit Reply Answer Result: ", result);
            if (result === 'success') {
                alert("답글이 성공적으로 등록되었습니다.");
                openModal(selectedIdeaId, document.getElementById("modal-idea-title").innerText, document.getElementById("modal-idea-description").innerText, '${sessionScope.userId}'); // 모달 새로고침
            } else {
                alert("답글 등록에 실패하였습니다.");
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("답글 등록 중 오류가 발생하였습니다.");
        });
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
    
    document.addEventListener("DOMContentLoaded", function() {
        initializeTimer();
    });
    
    //타이머 종료시 함수
    function onTimerEnd() {
	timerEnded = true; // 타이머 종료 표시
	if ("${meetingRoom.getRoomManagerId()}" === "${userId}") {
        document.getElementById("nextStepButton").style.display = "block";
    }
	document.getElementById("voteButton").style.display = "none";
	}

	function goToNextStep() {
	document.getElementById('nextStageForm').submit();
	}


</script>
</body>
</html>
