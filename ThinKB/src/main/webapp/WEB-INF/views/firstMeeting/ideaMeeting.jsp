<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat"%>
<%
// 사용자 확인
List<Integer> userIdList = (List<Integer>) request.getAttribute("userIdList");
Integer userId = (Integer) session.getAttribute("userId");
boolean isParticipant = false;

if (userIdList != null && userId != null) {
	for (Integer id : userIdList) {
		if (id.equals(userId)) {
	isParticipant = true;
	break;
		}
	}
}

if (!isParticipant) {
%>
<script>
        alert("회의방 참여자가 아닙니다. 회의방 목록 화면으로 이동합니다.");
        window.location.href = "./meetingList";
    </script>
<%
return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - 초안 투표하기</title>
<style>
body, html {
	margin: 0;
	padding: 0;
	font-family: KB금융 본문체 Light;
	overflow-x: hidden;
	width: 100%;
	caret-color: transparent;
}

.site-header {
	position: relative;
	z-index: 1;
}

.ideaMeeting-contents {
	display: flex;
	flex-direction: column;
	margin-left: 20%;
	margin-right: 20%;
	z-index: 2;
	padding: 20px;
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

.topic-title {
	font-size: 20pt;
	color: black;
	font-weight: bold;
	margin-bottom: 20px;
	font-family: KB금융 제목체 Light;
}

.line {
	margin-top: 15px;
	margin-bottom: 15px;
	border: 2px solid lightgrey;
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

.idea-item {
	display: flex;
	align-items: center;
	justify-content: space-between; /* 자식 요소들을 양 끝으로 배치 */
	margin-top: 10px;
	margin-bottom: 1.5%;
	width: auto; /* 전체 너비를 차지하도록 설정 */
	padding: 1%;
}

.idea-item.voted {
	background-color: #FFFBD8 !important;
	border-radius: 20px !important;
	padding: 1% !important;
}

.idea-left {
	display: flex;
	align-items: center;
}

.idea-question, .idea-answer {
	margin-left: auto; /* 오른쪽 정렬 */
	cursor: pointer;
	border-radius: 20px;
	font-weight: bold;
	padding: 10px;
	font-size: 10pt;
	color: #007AFF;
}

.idea-circle {
	width: 45px;
	height: 45px;
	border-radius: 50%;
	background-image: url('./resources/Uncheck.png');
	background-size: 100%;
	background-position: center;
	background-repeat: no-repeat;
	margin-right: 30px;
	cursor: pointer;
	position: relative; /* Added for positioning the background image */
}

.idea-circle.voted, .idea-circle.selected {
	background-image: url('./resources/Check.png');
	background-size: 100%;
	background-position: center;
	background-repeat: no-repeat;
	font-family: KB금융 제목체 Light;
}

.idea-box {
	width: auto;
	height: 70px;
	border-radius: 10px;
	display: flex;
	justify-content: left;
	align-items: center;
	font-size: 20px;
	cursor: pointer;
	position: relative;
}

.idea-box.selected, .idea-box.voted {
	font-weight: bold;
}

.idea-box.selected .idea-circle {
	background-image: url('./resources/Check.png');
	background-size: 100%;
	background-position: center;
	background-repeat: no-repeat;
	font-family: KB금융 제목체 Light;
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

.ideaMeeting-modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow-y: auto;
	overflow-x: hidden;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4);
	padding-top: 60px;
}

.ideaMeeting-modal-content {
	position: relative; /* 추가 */
	background-color: #FFFFFF;
	margin: 5% auto;
	padding: 50px;
	border: 1px solid #888;
	width: 100%; /* 최대 너비를 80%로 설정하여 화면에 맞추기 */
	max-width: 70%; /* 필요에 따라 최대 너비를 픽셀 단위로 설정 */
	border-radius: 15px;
	overflow-y: auto;
	overflow-x: hidden; /* 가로 스크롤바 없애기 */
	box-sizing: border-box;
	min-height: 50%; /* 최소 높이 지정 */
	display: flex;
	flex-direction: column;
}

.closeIdea {
	position: absolute;
	top: 10px;
	right: 20px;
	color: #aaa;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
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

.modal-idea-box {
	width: auto; /* 글자 양에 따라 가로폭 조절 */
	height: 10%;
	background-color: #EEEEEE;
	border-radius: 10px;
	display: flex; /* 글자 양에 따라 가로폭 조절 */
	justify-content: center;
	align-items: center;
	font-size: 15px;
	cursor: pointer;
	position: relative;
	padding: 20px;
	margin-bottom: 1%;
}

.modal-idea-container {
	display: flex;
	flex-direction: column;
	width: 100%;
	margin-bottom: 3%;
}

/* 추가된 CSS 스타일 */
.modal-idea-box.reply {
	background-color: #FFFFFF;
	align-self: flex-start;
}

.modal-idea-box.reply-answer {
	background-color: #FFE297; /* 노란색 */
	align-self: flex-end;
	pointer-events: none; /* 기본적으로 클릭 불가 */
	cursor: default;
}

.modal-idea-box.reply-answer .delete-button, .modal-idea-box.reply .delete-button
	{
	pointer-events: auto; /* 삭제 버튼은 클릭 가능 */
	cursor: pointer;
	color: red;
	background-color: transparent; /* 배경색 투명 */
	border: none; /* 테두리 없애기 */
	padding: 0; /* 기본 패딩 제거 */
	font-size: 12px; /* 필요에 따라 글자 크기 조정 */
	font-weight: bold;
	font-family: KB금융 제목체 Light;
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
	font-family: KB금융 본문체 Light;
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
	margin-top: 20px;
	/* Adjust the margin to provide space below the descriptionContent */
}

.stages {
	display: flex;
	justify-content: space-between;
	padding: 30px 0;
	font-size: 12pt;
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
	font-family: KB금융 제목체 Light;
}

.inactive {
	color: #999;
	pointer-events: none;
}

.ideaMeeitng-modal-inner-container {
	/* 	margin: 5%; */
	background-color: #EBEBEB;
	border-radius: 20px;
	padding: 20px;
}

/* 배너 추가 */
.ideaMeeting-banner {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 30px;
	margin-bottom: -50px;
}

.vote-button-container {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
}

.reply-link {
	color: #007AFF;
	font-weight: bold;
	font-size: 10pt;
	font-family: KB금융 제목체 Light;
	margin-left: 10px;
	cursor: pointer;
	text-align: right;
	display: block;
}

.modal-content-inner {
	margin-top: 40px; /* x 버튼 아래로 내용 이동 */
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

#input-reply-container {
	display: flex;
	width: 100%;
	box-sizing: border-box;
}

#reply-form-container {
	display: flex;
	flex-direction: row; /* 요소들을 가로로 배치 */
	width: 100%;
	box-sizing: border-box;
	align-items: center; /* 수직 가운데 정렬 */
}

#replyContent {
	flex: 1;
	padding: 10px;
	border: none;
	border-bottom: 2pt solid #FFBC00;
	background-color: #FFFFFF;
	font-size: 11pt;
	margin-right: 2.5%;
	color: #353535;
	outline: none; /* 검은색 테두리 제거 */
	font-family: KB금융 본문체 Light;
}

#replyAnswerContent {
	flex: 1;
	padding: 10px;
	border: none;
	border-bottom: 2pt solid #FFBC00;
	background-color: #FFFFFF;
	font-size: 11pt;
	margin-right: 2.5%;
	color: #353535;
	outline: none; /* 검은색 테두리 제거 */
	font-family: KB금융 본문체 Light;
}

#input-button {
	padding: 10px 20px;
	background-color: #FFBC00;
	border: none;
	border-radius: 10px;
	color: black;
	font-size: 10pt;
	cursor: pointer;
	font-weight: bold;
	font-family: KB금융 본문체 Light;
}

#reply-button {
	padding: 10px 20px;
	background-color: #FFBC00;
	border: none;
	border-radius: 10px;
	color: black;
	font-size: 10pt;
	cursor: pointer;
	font-weight: bold;
	margin-left: 11px; /* 버튼과 입력 필드 사이의 간격 추가 */
	font-family: KB금융 본문체 Light;
}

#input-button:hover {
	background-color: #D4AA00;
}

#reply-button:hover {
	background-color: #D4AA00;
}

#modal-idea-description {
	font-size: 13pt;
}

#modal-idea-title {
	font-size: 16pt;
	font-weight: bold;
	font-family: KB금융 제목체 Light;
}
/* 상세설명 - 토글 */
.title-detail {
	display: flex;
	flex-direction: column;
	margin-bottom: 20px;
}

.toggle-container {
	display: flex;
	align-items: center;
}

.toggle-switch {
	position: relative;
	display: inline-block;
	width: 60px;
	height: 34px;
	margin-right: 10px;
}

.toggle-text {
	font-family: KB금융 본문체 Light;
	margin-left: 10px;
	vertical-align: middle;
}

#descriptionContent {
	font-family: KB금융 본문체 Light;
	margin-top: 10px;
	padding: 10px;
	background-color: #f9f9f9;
	border: 1px solid #ddd;
	border-radius: 5px;
	box-sizing: border-box;
	overflow-wrap: break-word;
	word-wrap: break-word;
}

#descriptionContent pre {
	font-family: KB금융 본문체 Light;
	hyphens: auto;
	white-space: pre-wrap; /* 자동 줄바꿈을 허용 */
	word-wrap: break-word; /* 단어 단위로 줄바꿈 */
}

.toggle-input {
	opacity: 0;
	width: 0;
	height: 0;
	font-family: KB금융 본문체 Light;
}

.toggle-label {
	font-family: KB금융 본문체 Light;
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	transition: .4s;
	border-radius: 34px;
}

.toggle-label:before {
	font-family: KB금융 본문체 Light;
	position: absolute;
	content: "";
	height: 26px;
	width: 26px;
	left: 4px;
	bottom: 4px;
	background-color: white;
	transition: .4s;
	border-radius: 50%;
}

.toggle-input:checked+.toggle-label {
	background-color: #FFCC00;
}

.toggle-input:checked+.toggle-label:before {
	transform: translateX(26px);
}

.toggle-text {
	font-family: KB금융 본문체 Light;
	margin-left: 10px;
	vertical-align: middle;
}
/* 비활성화된 요소를 위한 스타일 추가 */
.disabled-element {
	opacity: 0.5;
	pointer-events: none;
}

.meeting-ended-notice {
	color: #cc0000;
	padding: 10px;
	text-align: center;
	font-weight: bold;
	width: 100%;
	box-sizing: border-box;
	position: sticky;
	top: 0;
	z-index: 1000;
}
/* 스테이지 네비게이션 링크 스타일 */
.stages a {
	pointer-events: auto !important;
	opacity: 1 !important;
}
</style>
</head>
<script>
	// 선택된 아이디어 및 관련 정보 저장을 위한 변수들
	let selectedIdea = null; // 선택된 아이디어 요소
	let selectedIdeaId = null; // 선택된 아이디어의 ID
	let selectedIdeaDescription = null; // 선택된 아이디어의 설명
	let selectedIdeaUserId = null; // 선택된 아이디어 작성자의 ID

	// 아이디어 선택을 처리하는 함수 (이벤트 버블링 방지)
	function toggleSelect(element, ideaId, ideaTitle, ideaDescription, ideaUserId, isCircle) {
	    if (selectedIdea) {
	        selectedIdea.classList.remove('selected'); // 이전에 선택된 아이디어의 선택 상태 해제
	    }
	    if (selectedIdea !== element) { 
	        element.classList.add('selected'); // 현재 선택된 아이디어에 선택 상태 추가
	        selectedIdea = element;
	        selectedIdeaId = ideaId;
	        selectedIdeaDescription = ideaDescription;
	        selectedIdeaUserId = ideaUserId;
	        if (isCircle) { // 원형 요소의 경우 모달 창 열기
	            openModal(ideaId, ideaTitle, ideaDescription, ideaUserId);
	        }
	    } else { // 이미 선택된 아이디어를 다시 클릭한 경우 선택 취소
	        selectedIdea = null;
	        selectedIdeaId = null;
	        selectedIdeaDescription = null;
	        selectedIdeaUserId = null;
	        closeIdeaMeetingModal(); // 모달 창 닫기
	    }
	}

	// 모달 창을 닫는 함수
	function closeIdeaMeetingModal() {
	    document.getElementById("ideaMeetingModal").style.display = "none"; // 모달 창 숨기기
	    hideReplyForm(); // 답변 입력 폼 숨기기
	    location.reload(); // 페이지 새로고침
	}

	// 모달 창을 여는 함수
	function openModal(ideaId, ideaTitle, ideaDescription, ideaUserId) {
	    document.getElementById("ideaMeetingModal").style.display = "block"; // 모달 창 보이기
	    document.getElementById("modal-idea-id").innerText = ideaId;
	    document.getElementById("modal-idea-title").innerText = ideaTitle;
	    document.getElementById("modal-idea-description").innerText = ideaDescription;
	    document.getElementById("modal-idea-userId").innerText = ideaUserId;

	    const sessionUserId = document.getElementById("session-user-id").value;
	    const stageId = ${meetingRoom.getStageId()}; // stageId를 서버에서 받아오는 부분

	    if (stageId >= 3) {
	        // stageId가 3 이상일 때 질문 폼과 답변 폼 숨기기
	        document.getElementById("input-reply-container").style.display = "none";
	        document.getElementById("reply-form-container").style.display = "none";

	    } else {
	        // stageId가 3 미만일 때는 기본 동작 유지
	        if (Number(sessionUserId) === Number(ideaUserId)) {
	            document.getElementById("input-reply-container").style.display = "none";
	            document.getElementById("reply-form-container").style.display = "flex";
	            document.getElementById("replyAnswerContent").placeholder = "답변할 질문을 클릭해주세요";
	        } else {
	            document.getElementById("input-reply-container").style.display = "flex";
	            document.getElementById("reply-form-container").style.display = "none";
	        }
	    }

	    

	    // AJAX 요청을 통해 댓글 데이터를 불러오기
	    fetch('${pageContext.request.contextPath}/getIdeaReplies?ideaId=' + ideaId)
	    .then(response => response.json())
	    .then(data => {
	        const repliesContainer = document.getElementById("modal-idea-replies");
	        const stageId = ${meetingRoom.getStageId()}; // stageId를 서버에서 받아오는 부분
	        repliesContainer.innerHTML = ''; // 기존 댓글 초기화
	        data.forEach(reply => {
	            const replyElement = document.createElement('div');
	            replyElement.className = 'modal-idea-box';
	            if (reply.replyStep === 0) {
	                replyElement.classList.add('reply'); // 질문일 경우
	                // 질문에 클릭 이벤트 리스너 추가 (답변 폼 표시)
	                replyElement.addEventListener('click', function() {
	                    if (Number(sessionUserId) === Number(ideaUserId)) {
	                        showReplyForm(reply.ideaReply, reply.replyContent);
	                    }
	                });
	            } else {
	                replyElement.classList.add('reply-answer'); // 답변일 경우
	            }
	            let replyHtml = reply.replyContent;
	            replyElement.innerHTML = replyHtml;

	            // 댓글 작성자와 로그인한 사용자가 동일한 경우 삭제 버튼 추가
	            if (Number(sessionUserId) === Number(reply.userId) && stageId == 2) {
	            	
	                const deleteButton = document.createElement('button');
	                deleteButton.classList.add('delete-button');
	                deleteButton.innerText = '삭제';
	                deleteButton.style.marginLeft = '10px';
	                deleteButton.onclick = function(event) {
	                    event.stopPropagation(); // 클릭 이벤트가 부모로 전파되지 않도록 함
	                    deleteReply(reply.ideaReply);
	                };
	                replyElement.appendChild(deleteButton);
	            	
	            }


	            repliesContainer.appendChild(replyElement);
	        });
	    });
	}

	// 답변 폼을 표시하는 함수
	function showReplyForm(replyID, replyContent) {

	    const sessionUserId = document.getElementById("session-user-id").value;
	    const ideaUserId = document.getElementById("modal-idea-userId").innerText;
	    const stageId = ${meetingRoom.getStageId()}; // stageId를 서버에서 받아오는 부분

	    
	    if (stageId >= 3) {
	        // stageId가 3 이상일 때 질문 폼과 답변 폼 숨기기
	     	document.getElementById("reply-form-container").style.display = "none";

	    } else if (Number(sessionUserId) === Number(ideaUserId)) {
	    	 
	        document.getElementById("replyAnswerContent").placeholder = "@" + replyContent + "에 대한 답변을 입력해주세요";
	        document.getElementById("replyToId").value = replyID;
	        document.getElementById("reply-form-container").style.display = "flex";
	    }

	}

	// 답변 폼을 숨기는 함수
	function hideReplyForm() {
	    document.getElementById("reply-form-container").style.display = "none";
	}

	// 댓글 제출 함수
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
	        return response.text(); 
	    })
	    .then(result => {
	        console.log("Submit Reply Result: ", result);
	        if (result === 'success') {
	            alert("댓글이 성공적으로 등록되었습니다.");
	            document.getElementById("replyContent").value = ""; 
	            openModal(selectedIdeaId, document.getElementById("modal-idea-title").innerText, document.getElementById("modal-idea-description").innerText, ideaUserId); 
	        } else {
	            alert("댓글 등록에 실패하였습니다.");
	        }
	    })
	    .catch(error => {
	        console.error("Error:", error);
	        alert("댓글 등록 중 오류가 발생하였습니다.");
	    });
	}

	// 답글 제출 함수
	function submitReplyAnswer() {
	    const replyAnswerContent = document.getElementById("replyAnswerContent").value;
	    if (replyAnswerContent.trim() === "") {
	        alert("답변 내용을 입력하세요.");
	        return;
	    }

	    const ideaReply = document.getElementById("replyToId").value;
	    
	    if (!ideaReply) {
	        alert("답변할 질문을 선택하세요.");
	        return;
	    }

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
	        return response.text(); 
	    })
	    .then(result => {
	        console.log("Submit Reply Answer Result: ", result);
	        if (result === 'success') {
	            alert("답글이 성공적으로 등록되었습니다.");
	            document.getElementById("replyAnswerContent").value = ""; 
	            openModal(selectedIdeaId, document.getElementById("modal-idea-title").innerText, document.getElementById("modal-idea-description").innerText, '${sessionScope.userId}'); 
	        } else {
	            alert("답글 등록에 실패하였습니다.");
	        }
	    })
	    .catch(error => {
	        console.error("Error:", error);
	        alert("답글 등록 중 오류가 발생하였습니다.");
	    });
	}

	// 댓글 삭제 함수
	function deleteReply(ideaReplyId) {
	    if (!confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
	        return;
	    }

	    const data = new URLSearchParams();
	    data.append("ideaReplyId", ideaReplyId);

	    fetch('/star/deleteReply', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/x-www-form-urlencoded'
	        },
	        body: data.toString()
	    })
	    .then(response => {
	        if (!response.ok) {
	            throw new Error('Network response was not ok');
	        }
	        return response.text();
	    })
	    .then(result => {
	        console.log("Delete Reply Result: ", result);
	        if (result === 'success') {
	            alert("댓글이 성공적으로 삭제되었습니다.");
	            openModal(selectedIdeaId, document.getElementById("modal-idea-title").innerText, document.getElementById("modal-idea-description").innerText, selectedIdeaUserId);
	        } else {
	            alert("댓글 삭제에 실패하였습니다.");
	        }
	    })
	    .catch(error => {
	        console.error("Error:", error);
	        alert("댓글 삭제 중 오류가 발생하였습니다.");
	    });
	}

	// 투표 제출 함수
	function submitVote() {
	    if (selectedIdea) {
	        const selectedTitle = selectedIdea.innerText;

	        const form = document.createElement('form');
	        form.method = 'POST';
	        form.action = '${pageContext.request.contextPath}/submitVote'; 

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
	
	


	// 다음 단계로 이동하는 함수
	function goToNextStep() {
	    document.getElementById('nextStageForm').submit();
	}

	// 설명 토글 기능
	document.addEventListener('DOMContentLoaded', function() {
	    const toggleSwitch = document.getElementById('toggleDescription');
	    const toggleText = document.querySelector('.toggle-text');
	    const descriptionContent = document.getElementById('descriptionContent');

	    if (toggleSwitch) {  
	        toggleSwitch.addEventListener('change', function() {
	            if (this.checked) {
	                descriptionContent.style.display = 'block';
	                toggleText.textContent = '설명 숨기기';
	            } else {
	                descriptionContent.style.display = 'none';
	                toggleText.textContent = '설명 보기';
	            }
	        });
	    }
	});

	// 아이디어 박스와 질문/답변 클릭 이벤트 초기화
	document.addEventListener("DOMContentLoaded", function() {
	    document.querySelectorAll('.idea-box').forEach(function(box) {
	        box.addEventListener('click', function(event) {
	            event.stopPropagation();
	            const ideaId = box.dataset.ideaid;
	            const ideaTitle = box.dataset.ideatitle;
	            const ideaDescription = box.dataset.ideadescription;
	            const ideaUserId = box.dataset.ideauserid;
	            toggleSelect(box, ideaId, ideaTitle, ideaDescription, ideaUserId, false);
	        });
	    });

	    document.querySelectorAll('.idea-question, .idea-answer').forEach(function(item) {
	        item.addEventListener('click', function(event) {
	            event.stopPropagation();
	            const ideaId = item.dataset.ideaid;
	            const ideaTitle = item.dataset.ideatitle;
	            const ideaDescription = item.dataset.ideadescription;
	            const ideaUserId = item.dataset.ideauserid;
	            toggleSelect(item, ideaId, ideaTitle, ideaDescription, ideaUserId, true);
	        });
	    });
	});
	
	
	document.addEventListener("DOMContentLoaded", function() {
	    const stageId = ${meetingRoom.getStageId()};
	    const timerElement = document.getElementById("timer");
	    console.log(timerElement);
	    const timerMessageElement = document.getElementById("timer-message");

	    console.log("stageId", stageId);
	    if (stageId >= 3) {
	    	document.getElementById("voteButton").style.display = "none"; // 투표 버튼 숨기기
		    
	        if (timerElement) {
	            timerElement.innerHTML = "Time Out";
	        }
	        if (timerMessageElement) {
	            timerMessageElement.innerHTML = "지금은 작성할 수 없어요";
	            timerMessageElement.classList.remove("active");
	            timerMessageElement.classList.add("expired");
	        }
	        // stageId가 2 이상일 때 updateTimer 함수 오버라이드
	        window.updateTimer = function() {
	            // 아무 동작도 하지 않음
	        };

	    }
	    // stageId가 3 미만일 때는 아무 처리도 하지 않음 (기존 updateTimer 함수가 동작)
	});
	
	// 타이머 종료 시 실행되는 함수
	function onTimerEnd() {
	    // 투표 버튼 숨기기
	    document.getElementById("voteButton").style.display = "none"; 
	    document.getElementById("reply-button").style.display = "none"; 
	    document.getElementById("input-button").style.display = "none"; 
	    
	    // 댓글과 답변 입력 폼 비활성화
	    document.getElementById("replyContent").style.display = "none";
	    document.getElementById("replyAnswerContent").style.display = "none";
	    
	    
	    // 모든 deleteButton 요소를 선택하여 숨기기
	    const deleteButtons = document.querySelectorAll('.delete-button');
	    deleteButtons.forEach(function(button) {
	        button.style.display = "none";
	    });
	
	    // 방장이면 다음 단계 버튼 보이기
	    if ("${meetingRoom.getRoomManagerId()}" === "${userId}") {
	        document.getElementById("nextStepButton").style.display = "block"; 
	    }
	}

	
	  // 특정 요소 비활성화 함수
    function disableInteraction() {
        const elementsToDisable = document.querySelectorAll('input, textarea, button, select');
        elementsToDisable.forEach(element => {
            if (!element.closest('.stages')) {  // stages 클래스 내부의 요소는 제외
                element.disabled = true;
                element.classList.add('disabled-element');
            }
        });

        // 폼 제출 방지
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
            form.onsubmit = function(e) {
                e.preventDefault();
                return false;
            };
        });

        // 회의 종료 안내 메시지 추가
        const notice = document.createElement('div');
        notice.className = 'meeting-ended-notice';
        notice.innerHTML = '회의 기간이 종료되어 더 이상 수정이 불가능합니다. 단, 스테이지 간 이동은 가능합니다.';
        
        // 헤더 다음에 알림 삽입
        const header = document.querySelector('header');
        if (header && header.nextSibling) {
            header.parentNode.insertBefore(notice, header.nextSibling);
        } else {
            document.body.insertBefore(notice, document.body.firstChild);
        }

        // stages 클래스 내부의 요소들은 비활성화에서 제외
        const stageLinks = document.querySelectorAll('.stages a');
        stageLinks.forEach(link => {
            link.classList.remove('disabled-element');
        });
    }

    // 페이지 로드 시 실행
    window.onload = function() {
    	const Message = '${errorMessage}';
    	if (Message) {
    		alert(Message);
    	}    
    	// 회의 기간 종료 확인
        const endDateStr = '${meetingRoom.getEndDate()}';
        if (endDateStr) {
            const endDate = new Date(endDateStr);
            const now = new Date();
            
            // 종료일의 다음날 자정을 계산
            const dayAfterEnd = new Date(endDate);
            dayAfterEnd.setDate(dayAfterEnd.getDate() + 1);
            dayAfterEnd.setHours(0, 0, 0, 0);
            
            if (now >= dayAfterEnd) {
                disableInteraction();
            }
        }
    };
    
 // 이미 투표된 아이디어에 대한 처리
    document.querySelectorAll('.idea-box.voted').forEach(function(box) {
        box.closest('.idea-item').classList.add('voted-item');
    });
	</script>
<body>
	<c:if test="${not empty sessionScope.Message}">
		<div class="alert">${sessionScope.Message}</div>
	</c:if>
	<input type="hidden" id="session-user-id"
		value="${sessionScope.userId}">
	<input type="hidden" id="session-room-id"
		value="${sessionScope.roomId}">

	<%
	String[] stages = { "아이디어 초안", "초안 투표하기", "관점별 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료" };
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
							href="./roomDetail?roomId=${meetingRoom.getRoomId()}&stage=${status.index + 1}&ideaId=${yesPickList[0].getIdeaID()}"
							class="stage ${meetingRoom.getStageId() == status.index + 1 ? 'active' : ''}">
							${status.index + 1}. ${stage} </a>
					</c:when>
					<c:otherwise>
						<div class="stage inactive">${status.index + 1}.${stage}</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>

		<!-- 회의 방 내용 -->
		<div class="ideaMeeting-topic-box">
			<div class="topic-title">
				[${meetingRoom.roomTitle}] <input type="hidden" name="roomId"
					value="${meetingRoom.roomId}">
			</div>
			<div class="title-detail">
				<div class="toggle-container">
					<div class="toggle-switch">
						<input type="checkbox" id="toggleDescription" class="toggle-input">
						<label for="toggleDescription" class="toggle-label"> <span
							class="toggle-inner"></span> <span class="toggle-switch"></span>
						</label>
					</div>
					<span class="toggle-text">설명 보기</span>
				</div>
				<div id="descriptionContent" style="display: none;">
					<pre>${meetingRoom.getDescription()}</pre>
				</div>
			</div>

			<hr class="line">
			<div class="ideaMeeting-description">
				다음 중 가장 좋은 아이디어에 투표해주세요. <br> 궁금한 점이 있다면 '질문하기'를 눌러서 작성자에게 질문할
				수 있어요.
			</div>
			<!-- 방장만 보이는 다음단계 버튼 -->
			<form id="nextStageForm" action="./stage2Clear" method="post">
				<input type="hidden" name="roomId" value="${meetingRoom.roomId}">
				<input type="hidden" name="stage" value="${meetingRoom.stageId}">
				<div class="stage-info">
					<c:if test="${userId == meetingRoom.getRoomManagerId()}">
						<div class="vote-info">현재 투표 참여인원 : ${voteCnt}명 / ${total}명</div>
						<c:if test="${meetingRoom.stageId==2}">
							<button id="nextStepButton" class="yellow-button"
								onclick="goToNextStep()">다음 단계</button>
						</c:if>
					</c:if>
				</div>
			</form>
		</div>
		<!-- Idea Voting Section -->
		<div>
			<div class="ideaMeeting-idea-container">
				<c:forEach var="idea" items="${ideas}">
					<div class="idea-item ${votedIdeaId == idea.ideaID ? 'voted' : ''}">
						<div class="idea-left">
							<div
								class="idea-box ${votedIdeaId == idea.ideaID ? 'voted' : ''}"
								data-ideaid="${idea.ideaID}"
								data-ideatitle="${idea.title.replaceAll("
								\"", "&quot;")}"
								data-ideadescription="${idea.description.replaceAll("
								\"", "&quot;")}"
								data-ideauserid="${idea.userID}">
								<div
									class="idea-circle ${votedIdeaId == idea.ideaID ? 'voted' : ''}"></div>
								${idea.title}
							</div>
						</div>
						<c:choose>
							<c:when test="${sessionScope.userId != idea.userID}">
								<div class="idea-question" data-ideaid="${idea.ideaID}"
									data-ideatitle="${idea.title.replaceAll("
									\"", "&quot;")}"
									data-ideadescription="${idea.description.replaceAll("
									\"", "&quot;")}"
									data-ideauserid="${idea.userID}">
									질문하기 (${ideaReplyCountMap[idea.ideaID]}건)</div>
							</c:when>
							<c:otherwise>
								<div class="idea-answer" data-ideaid="${idea.ideaID}"
									data-ideatitle="${idea.title.replaceAll("
									\"", "&quot;")}"
									data-ideadescription="${idea.description.replaceAll("
									\"", "&quot;")}"
									data-ideauserid="${idea.userID}">
									답변하기 (${ideaReplyCountMap[idea.ideaID]}건)</div>
							</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>
			</div>
			<div class="vote-button-container">
				<button id="voteButton" class="yellow-button"
					style="margin-top: 50px;" onclick="submitVote()">${hasVoted ? '투표 변경하기' : '투표하기'}</button>
			</div>
		</div>
	</div>

	<!-- 질문 모달 창 -->
	<div id="ideaMeetingModal" class="ideaMeeting-modal">
		<div class="ideaMeeting-modal-content">
			<span class="closeIdea" onclick="closeIdeaMeetingModal()">&times;</span>
			<span><input type="hidden" id="modal-idea-id"></span> <span><input
				type="hidden" id="modal-idea-userId"></span>
			<p style="margin-bottom: 3%;">
				<span id="modal-idea-title"></span><br> <span
					id="modal-idea-description"></span>
			</p>
			<div class="ideaMeeitng-modal-inner-container">
				<div class="modal-idea-container" id="modal-idea-replies">댓글
					내용이 여기에 동적으로 추가됩니다</div>
				<div id="input-reply-container">
					<input type="text" id="replyContent" placeholder="질문을 입력하세요" />
					<button onclick="submitReply()" id="input-button">질문하기</button>
				</div>
				<div id="reply-form-container">
					<input type="hidden" id="replyToId" /> <input type="text"
						id="replyAnswerContent" />
					<button onclick="submitReplyAnswer()" id="reply-button">답변하기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>