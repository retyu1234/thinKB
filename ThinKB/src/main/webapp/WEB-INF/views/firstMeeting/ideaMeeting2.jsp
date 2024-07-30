<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디어 투표</title>
<!-- Alpine.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/alpinejs@2.8.2/dist/alpine.min.js" defer></script>
<style>
body {
	font-family: 'Inter', sans-serif;
	margin-top: 50px;
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
	height: 100%;
	position: absolute;
	margin: 0 !important;
	top: 0;
	bottom: 0;
	left: 0;
	box-shadow: 0 5px 10px rgba(255, 255, 255, 0.25) inset, 0 4px 4px
		rgba(0, 0, 0, 0.25);
	border-radius: var(- -br-31xl) 0 var(- -br-31xl) 0;
	background-color: rgba(255, 255, 255, 0.36);
	border: 1px solid #7f6000;
	box-sizing: border-box;
}

.topic-title {
	width: 50px;
	position: relative;
	font-weight: 600;
	display: inline-block;
	z-index: 1;
}

.topic-description {
	flex: 1;
	position: relative;
	display: inline-block;
	max-width: 100%;
	z-index: 1;
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
	align-self: stretch;
	flex: 1;
	position: relative;
	box-shadow: 0 5px 10px rgba(255, 255, 255, 0.25) inset, 0 4px 4px
		rgba(0, 0, 0, 0.25);
	border-radius: var(- -br-31xl);
	background-color: #ffc000;
	max-width: 100%;
}

.idea-box.voted {
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
	display: block;
}

.vote-button.hidden {
	display: none;
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
	align-items: center;
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
</style>
</head>
<body>
	<div id="timer-section" style="margin-top: 100px;">
        <%@ include file="../Timer.jsp"%>
    </div>
	<input type="hidden" id="session-user-id" value="${sessionScope.userId}">
	<input type="hidden" id="session-room-id" value="${sessionScope.roomId}">

	<div class="idea_header">
		<jsp:include page="../header.jsp" />
	</div>
	<!-- 방장 sideBar -->
	<c:if test="${userId == meetingRoom.getRoomManagerId() }">
		<%@ include file="../sideBar.jsp"%>
	</c:if>
	<div class="content" x-data="voteApp()">
		<c:if test="${not empty sessionScope.Message}">
			<div class="alert">${sessionScope.Message}</div>
		</c:if>
		<div class="div">
			<div class="selected-option">
				<div class="topic-box"></div>
				<div class="topic-title">
					${meetingRoom.roomTitle} <input type="hidden" name="roomId" value="${meetingRoom.roomId}">
				</div>
				<div class="wrapper">
					<div class="topic-description">${meetingRoom.description}</div>
				</div>
			</div>
			<div class="idea-container">
				<c:forEach var="idea" items="${ideas}">
					<div class="idea-item">
						<div class="idea-circle" :class="{'selected': selectedIdeaId === ${idea.ideaID}}" @click="toggleSelect(${idea.ideaID}, '${idea.title}', '${idea.description}', '${idea.userID}', true)"></div>
						<div class="idea-box" :class="{'voted': votedIdeaId === ${idea.ideaID}}" @click="toggleSelect(${idea.ideaID}, '${idea.title}', '${idea.description}', '${idea.userID}', false)">${idea.title}</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<button id="voteButton" class="vote-button" @click="submitVote()">${hasVoted ? '투표 변경하기' : '투표하기'}</button>

		<!-- 타이머 끝났을때 방장만 보이는 다음단계 버튼 -->
		<form id="nextStageForm" action="./stage2Clear" method="post">
			<input type="hidden" name="roomId" value="${meetingRoom.roomId}">
			<input type="hidden" name="stage" value="${meetingRoom.stageId}">
			<div style="text-align: right; margin-top: 20px;">
				<button id="nextStepButton" class="vote-button hidden" x-show="isRoomManager" @click="goToNextStep()">다음 단계</button>
			</div>
		</form>
	</div>

	<!-- Modal window -->
	<div id="myModal" class="modal" x-show="showModal" @click.self="closeModal()">
		<div class="modal-content">
			 <span class="close" @click="closeModal()">&times;</span>
			 <p>
				<span><input type="hidden" id="modal-idea-id" x-text="modalIdeaId"></span>
			 </p>
			 <p>
				<span><input type="hidden" id="modal-idea-title" x-text="modalIdeaTitle"></span>
			 </p>
			 <p>
				<span><input type="hidden" id="modal-idea-userId" x-text="modalIdeaUserId"></span>
			 </p>
			 <p>
				상세설명 : <span id="modal-idea-description" x-text="modalIdeaDescription"></span>
			 </p>
			 <p>질문하기</p>
			 <div class="modal-idea-container" id="modal-idea-replies">
				<!-- 댓글 내용이 여기에 동적으로 추가됩니다 -->
			 </div>
			 <div id="input-reply-container">
				<input type="text" id="replyContent" placeholder="댓글을 입력하세요" x-model="replyContent" />
				<button @click="submitReply()">입력</button>
			 </div>

			 <div id="reply-form-container" x-show="replyingToId !== null">
				<p>
					답변할 질문: <span x-text="replyingToQuestion"></span>
				</p>
				<input type="hidden" id="replyToId" x-model="replyingToId" /> 
				<input type="text" id="replyAnswerContent" placeholder="답변을 입력하세요" x-model="replyAnswerContent" />
				<div id="reply-button-container">
					<button @click="submitReplyAnswer()">답글달기</button>
				</div>
			 </div>
		</div>
	</div>

	<script>
    function voteApp() {
        return {
            selectedIdeaId: null,
            votedIdeaId: ${votedIdeaId},
            showModal: false,
            modalIdeaId: '',
            modalIdeaTitle: '',
            modalIdeaDescription: '',
            modalIdeaUserId: '',
            replyContent: '',
            replyingToId: null,
            replyingToQuestion: '',
            replyAnswerContent: '',
            isRoomManager: "${userId}" === "${meetingRoom.getRoomManagerId()}",

            toggleSelect(ideaId, ideaTitle, ideaDescription, ideaUserId, isCircle) {
                if (this.selectedIdeaId === ideaId) {
                    this.selectedIdeaId = null;
                    this.showModal = false;
                } else {
                    this.selectedIdeaId = ideaId;
                    if (isCircle) {
                        this.openModal(ideaId, ideaTitle, ideaDescription, ideaUserId);
                    }
                }
            },
            openModal(ideaId, ideaTitle, ideaDescription, ideaUserId) {
                this.showModal = true;
                this.modalIdeaId = ideaId;
                this.modalIdeaTitle = ideaTitle;
                this.modalIdeaDescription = ideaDescription;
                this.modalIdeaUserId = ideaUserId;
                this.loadReplies(ideaId, ideaUserId);
            },
            closeModal() {
                this.showModal = false;
                this.replyingToId = null;
            },
            loadReplies(ideaId, ideaUserId) {
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
                            replyElement.onclick = () => {
                                const sessionUserId = document.getElementById("session-user-id").value;
                                if (Number(sessionUserId) !== Number(reply.userId) && Number(sessionUserId) === Number(ideaUserId)) {
                                    this.showReplyForm(reply.ideaReply, replyHtml.replace(/"/g, '&quot;').replace(/'/g, '&#39;'));
                                } else {
                                    this.hideReplyForm();
                                }
                            };
                            repliesContainer.appendChild(replyElement);
                        });
                    });
            },
            showReplyForm(replyID, replyContent) {
                this.replyingToId = replyID;
                this.replyingToQuestion = replyContent;
            },
            hideReplyForm() {
                this.replyingToId = null;
            },
            submitReply() {
                if (this.replyContent.trim() === "") {
                    alert("질문 내용을 입력하세요.");
                    return;
                }

                const data = new URLSearchParams();
                data.append("replyContent", this.replyContent);
                data.append("ideaId", this.selectedIdeaId);
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
                    return response.text();
                })
                .then(result => {
                    if (result === 'success') {
                        alert("댓글이 성공적으로 등록되었습니다.");
                        this.openModal(this.selectedIdeaId, this.modalIdeaTitle, this.modalIdeaDescription, this.modalIdeaUserId);
                    } else {
                        alert("댓글 등록에 실패하였습니다.");
                    }
                })
                .catch(error => {
                    console.error("Error:", error);
                    alert("댓글 등록 중 오류가 발생하였습니다.");
                });
            },
            submitReplyAnswer() {
                if (this.replyAnswerContent.trim() === "") {
                    alert("답변 내용을 입력하세요.");
                    return;
                }

                const data = new URLSearchParams();
                data.append("replyContent", this.replyAnswerContent);
                data.append("ideaId", this.selectedIdeaId);
                data.append("roomId", ${meetingRoom.roomId});
                data.append("replyStep", this.replyingToId);

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
                    return response.text();
                })
                .then(result => {
                    if (result === 'success') {
                        alert("답글이 성공적으로 등록되었습니다.");
                        this.openModal(this.selectedIdeaId, this.modalIdeaTitle, this.modalIdeaDescription, this.modalIdeaUserId);
                    } else {
                        alert("답글 등록에 실패하였습니다.");
                    }
                })
                .catch(error => {
                    console.error("Error:", error);
                    alert("답글 등록 중 오류가 발생하였습니다.");
                });
            },
            submitVote() {
                if (this.selectedIdeaId) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/submitVote';

                    const ideaInput = document.createElement('input');
                    ideaInput.type = 'hidden';
                    ideaInput.name = 'selectedIdea';
                    ideaInput.value = this.selectedIdeaId;

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

                    form.appendChild(ideaInput);
                    form.appendChild(roomIdInput);
                    form.appendChild(roomTitleInput);
                    form.appendChild(userIdInput);
                    document.body.appendChild(form);
                    form.submit();
                } else {
                    alert('아이디어를 선택하세요.');
                }
            }
        }
    }
    
    document.addEventListener("DOMContentLoaded", function() {
        initializeTimer();
    });
    
    // 타이머 종료시 함수
    function onTimerEnd() {
        if ("${meetingRoom.getRoomManagerId()}" === "${userId}") {
            document.getElementById("nextStepButton").style.display = "block";
        }
        document.getElementById("voteButton").classList.add("hidden");

        // Hide the reply form and input fields
        document.getElementById("input-reply-container").style.display = "none";
        document.getElementById("reply-form-container").style.display = "none";
    }
    </script>
</body>
</html>
