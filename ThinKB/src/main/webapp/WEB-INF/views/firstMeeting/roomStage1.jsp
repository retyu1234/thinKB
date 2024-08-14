<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - 아이디어 작성</title>
<style>
body, html {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	overflow-x: hidden;
    width: 100%;
}

.room1-header {
	position: relative;
	z-index: 1;
}

.room1-content {
    padding: 20px;
    margin-left: 20%; /* 또는 더 작은 값 */
    margin-right: 20%;
    z-index: 2;
    /* margin-top: 10px; */
}

.room1-title {
	font-size: 20pt;
	color: black;
	font-weight: bold;
	/* margin-top: 50px; */
	margin-bottom: 20px;
}

/* .room1-title-detail {
	font-size: 13pt;
	position: relative;
    width: 100%;
    overflow: hidden;
}
 */
.room1-title-detail {
    display: flex;
    flex-direction: column;
    margin-bottom: 20px;
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

.stage-info {
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

.submit-info {
    margin-right: 30px;
    font-size: 15pt;
}

.room1-subject {
	font-size: 15pt; /* 제목의 글자 크기 */
	color: black;
	border: 3px solid #FFD700; /* 진한 노란색 테두리 */
	border-radius: 20px; /* 라운드 처리 */
	padding: 20px; /* 내부 여백 */
	background-color: white; /* 배경색 */
}

input.room1-subject {
	font-size: 13pt;
	color: black;
	border: 3px solid lightgrey;
	border-radius: 20px;
	padding: 20px;
	width: 100%;
	box-sizing: border-box;
}

input.room1-subject:focus {
	border-color: #FFD700; /* 포커스 시 테두리 색상 */
	outline: none; /* 기본 포커스 스타일 제거 */
}

.kb-ai-response {
    display: flex;
    font-size: 15pt;
    color: black;
    border: 1px solid #ddd;
    border-radius: 10px;
    background-color: #f0f0f0;
    margin-top: 20px;
    margin-bottom: 50px;
    min-height: 300px;
    max-height: 550px;
    width: 100%;
    overflow: hidden;
}

#ai-response-wrapper {
    flex-grow: 1;
    overflow-y: auto;
    display: flex;
    align-items: center; /* 세로 중앙 정렬 */
    justify-content: center; /* 가로 중앙 정렬 */
}
#ai-response-text {
    white-space: pre-wrap;
    word-wrap: break-word;
    max-height: 100%; /* wrapper의 높이를 넘지 않도록 설정 */
    overflow-y: auto; /* 내용이 넘칠 경우 스크롤 표시 */
}
#other-query {
    display: none;
    width: 100%;
    margin-top: 10px;
    margin-bottom: 10px;
}
#query-input {
    width: 100%;
    padding-right: 40px;
}
.search-container {
    position: relative;
    width: 100%;
}
.search-button {
    position: absolute;
    right: 15px; /* 오른쪽 여백 조정 */
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    cursor: pointer;
    font-size: 20px; /* 이모티콘 크기 조정 */
    padding: 0;
    line-height: 1;
}
.search-button span {
    position: relative;
    top: -2px; /* 미세 조정 */
    font-size:22pt;
}

/* input 필드의 테두리 스타일을 유지하면서 버튼을 안쪽에 배치 */
#query-input:focus {
    outline: none;
}
.ai-image-container {
    width: 150px;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}
.ai-image {
	width: 115px; /* 이미지 크기 조절 */
	height: auto;
	margin-right: 30px; /* 이미지와 텍스트 사이 간격 */
	margin-left: 30px; 
	
}
.ai-content {
    display: flex;
    flex-direction: column;
    flex-grow: 1;
    padding: 20px;
    overflow: hidden;
}

.ai-buttons {
    display: flex;
    justify-content: flex-end;
    gap: 1%;
    margin-bottom: 10px;
}
.stages {
	display: flex;
	justify-content: space-between;
	padding: 30px 0;
	font-size: 13pt;
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

.titleAndDetail {
	display: flex; 
	justify-content: space-between; 
	align-items: center; 
	margin-bottom: 10px;
}
.titleAndDetail-title {
	margin: 0;
	font-size: 18pt;
	color: black;
	font-weight: bold;
}

.ai-opinion-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.title-container {
    display: flex;
    align-items: center;
}

.titleAndDetail-title-link {
    margin-left: 20px;
    font-size: 13pt;
    color: blue;
    cursor: pointer;
}

.titleAndDetail-detail {
	font-size: 13pt;
}

.button-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 100px;
}

.button-container button {
    margin: 0 10px; /* 버튼 사이에 20px 간격을 만듭니다 (좌우 각각 10px) */
}

.line {
	margin-top: 15px;
	margin-bottom: 15px;
	border: 2px solid lightgrey;
}
.aiModal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0,0,0,0.4);
}

.aiModal-content {
    background-color: #fefefe;
    margin: 5% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 800px;
    border-radius: 10px;
}

.aiClose {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.aiClose:hover,
.aiClose:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
/* 채팅 스타일 */
#aiLogChat {
    height: 700px;
    overflow-y: auto;
    padding: 10px;
}

.aiChat-message {
    display: flex;
    margin-bottom: 15px;
}

.aiUser-message {
    justify-content: flex-start;
}

.ai-message {
    justify-content: flex-end;
}

.aiMessage-content {
    max-width: 70%;
    padding: 10px;
    border-radius: 10px;
}

.aiUser-message .aiMessage-content {
    background-color: #f1f0f0;
}

.ai-message .aiMessage-content {
    background-color: #FFD700;
}

.aiProfile-img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 10px;
}

.ai-img {
    width: 40px;
    height: 40px;
    margin-left: 10px;
}
.aiMessage-content, #descriptionContent {
    white-space: pre-wrap;
    word-wrap: break-word;
}

#descriptionContent {
    margin-top: 10px;
    padding: 10px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 5px;
    max-width: 100%;
    box-sizing: border-box;
    overflow-wrap: break-word;
    word-wrap: break-word;
    hyphens: auto;
    
}
#descriptionContent pre {
    white-space: pre-wrap;
    word-wrap: break-word;
    max-width: 100%;
    margin: 0;
}
textarea.room1-subject {
	font-size: 13pt;
	color: black;
	border: 3px solid lightgrey;
	border-radius: 20px;
	padding: 20px;
	width: 100%;
	box-sizing: border-box;
	white-space: pre-wrap;
	font-family: Arial, sans-serif; /* 원하는 폰트로 변경 */
    font-size: 13pt;
}

textarea.room1-subject:focus {
	border-color: #FFD700; /* 포커스 시 테두리 색상 */
	outline: none; /* 기본 포커스 스타일 제거 */
}
.loading-hidden {
  display: none;
}

#loading-screen {
display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(255, 255, 255, 0.8);
  z-index: 1000;
  display: flex;
  justify-content: center;
  align-items: center;
}

.loading-content {
  text-align: center;
}

.thinking-brain {
  font-size: 100px;
  animation: pulse 1.5s infinite;
}

.loading-text {
  font-size: 24px;
  margin-top: 20px;
  font-weight: bold;
}

.loading-dots span {
  font-size: 36px;
  animation: blink 1.4s infinite both;
}

.loading-dots span:nth-child(2) {
  animation-delay: 0.2s;
}

.loading-dots span:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes pulse {
  0% { transform: scale(1); }
  50% { transform: scale(1.1); }
  100% { transform: scale(1); }
}

@keyframes blink {
  0% { opacity: 0.2; }
  20% { opacity: 1; }
  100% { opacity: 0.2; }
}

/* 반려이력보기 모달 */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.4);
    display: flex;
    justify-content: center;
    align-items: center;
}

.modal-content {
    background-color: #fefefe;
    padding: 20px;
    border: 1px solid #888;
    width: 40%;
    height: 50%;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    position: relative;
}

.close {
    position: absolute;
    top: 10px;
    right: 20px;
}

.modal h2 {
    margin-top: 0;
}

#rejectList {
    flex-grow: 1;
    overflow-y: auto;
    margin-bottom: 20px;
}

.reject-item {
    margin-bottom: 10px;
    padding: 10px;
    background-color: #f9f9f9;
    border-radius: 5px;
}

#reapplyButton {
    align-self: center;
    margin-top: auto;
}

/* 토글 */
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
	font-family: Arial, sans-serif;
    margin-left: 10px;
    vertical-align: middle;
}

#descriptionContent {
	font-family: Arial, sans-serif;
    margin-top: 10px;
    padding: 10px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 5px;
}

#descriptionContent pre {
    font-family: Arial, sans-serif;
    }

.toggle-input {
    opacity: 0;
    width: 0;
    height: 0;
    font-family: Arial, sans-serif;
}

.toggle-label {
	font-family: Arial, sans-serif;
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
	font-family: Arial, sans-serif;
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

.toggle-input:checked + .toggle-label {
    background-color: #FFCC00;
}

.toggle-input:checked + .toggle-label:before {
    transform: translateX(26px);
}

.toggle-text {
	font-family: Arial, sans-serif;
    margin-left: 10px;
    vertical-align: middle;
}


</style>
</head>
<script>

	function showResponse() {
		const responseDiv = document.getElementById("kb-ai-response");
		const responseText = document.getElementById("ai-response-text");
		responseDiv.style.display = "flex"; // "block" 대신 "flex" 사용
		responseText.innerText = "api써서 받아온 응답이 보여집니다.";
	}

	function submitIdeaForm1() {
	    var myIdea = document.querySelector('input[name="myIdea"]').value.trim();
	    var ideaDetail = document.querySelector('textarea[name="ideaDetail"]').value.trim();
	    var hasExistingIdea = ${result == true};
	    var originalIdea = "${submittedIdea.getTitle()}";
	    var originalDetail = "${submittedIdea.getDescription()}";

	    if (hasExistingIdea) {
	        // 기존 아이디어가 있는 경우
	        if (myIdea === "" || ideaDetail === "") {
	            // 필드가 비어있으면 원래 값으로 복원
	            document.querySelector('input[name="myIdea"]').value = originalIdea;
	            document.querySelector('textarea[name="ideaDetail"]').value = originalDetail;
	            alert("아이디어와 상세 설명을 비워둘 수 없습니다. 원래 값으로 복원됩니다.");
	            return;
	        } else if (myIdea === originalIdea && ideaDetail === originalDetail) {
	            alert("변경된 내용이 없습니다.");
	            return;
	        }
	    } else {
	        // 새 아이디어 제출의 경우
	        if (myIdea === "" || ideaDetail === "") {
	            alert("아이디어와 상세 설명을 모두 입력해주세요.");
	            return;
	        }
	    }

	    // 폼 제출
	    document.getElementById('myIdeaHidden').value = myIdea;
	    document.getElementById('ideaDetailHidden').value = ideaDetail;
	    document.getElementById('ideaForm1').submit();
	}

	function updateForm() {
	    var myIdea = document.querySelector('input[name="myIdea"]').value.trim();
	    var ideaDetail = document.querySelector('textarea[name="ideaDetail"]').value.trim();
	    var originalIdea = "${submittedIdea.getTitle()}";
	    var originalDetail = "${submittedIdea.getDescription()}";

	    if (myIdea === "" || ideaDetail === "") {
	        // 필드가 비어있으면 원래 값으로 복원
	        document.querySelector('input[name="myIdea"]').value = originalIdea;
	        document.querySelector('textarea[name="ideaDetail"]').value = originalDetail;
	        alert("아이디어와 상세 설명을 비워둘 수 없습니다. 이전에 작성했던 내용이 복원됩니다.");
	        return;
	    } else if (myIdea === originalIdea && ideaDetail === originalDetail) {
	        alert("변경된 내용이 없습니다.");
	        return;
	    }

	    document.getElementById('myIdeaHidden2').value = myIdea;
	    document.getElementById('ideaDetailHidden2').value = ideaDetail;
	    document.getElementById('updateForm').submit();
	}

	function nextStage() {
		document.getElementById('nextStageForm').submit();
	}
	
	// 타이머 종료 시 호출될 함수
    function onTimerEnd() {
        console.log("Timer ended");
        document.getElementById("myIdeaInput").disabled = true;
        document.getElementById("ideaDetailInput").disabled = true;
        document.getElementById("submitButton").style.display = "none";
        document.getElementById("updateButton").style.display = "none";
        showNextStageButton();
    }

	function showNextStageButton() {
		console.log("showNextStageButton 함수 실행");
		const nextStageButton = document.getElementById("nextStageButton");
		if (nextStageButton) {
			const isManager = ${userId == info.getRoomManagerId()};
			nextStageButton.style.display = isManager ? "block" : "none";
		} else {
			console.log("nextStageButton 요소를 찾을 수 없습니다.");
		}
	}

	//반려아이디어 있는경우 알럿
	function checkRejectedIdea() {
	    console.log("checkRejectedIdea 함수 실행");
	    const rejectContents = ${rejectResult ? 'true' : 'false'};
	    const newAlredyIdea = ${result ? 'true' : 'false'};
	    
	    console.log("rejectContents:", rejectContents);
	    console.log("newAlredyIdea:", newAlredyIdea);
	    
	    if(rejectContents) {
	        console.log("반려된 아이디어가 있습니다.");
	        if(!newAlredyIdea) {
	            console.log("새 아이디어가 제출되지 않았습니다.");
	            const rejectedIdeaTitle = "${rejectIdeaTitle}";
	            const rejectReason = "${rejectContents.getRejectContents()}";
	            
	            console.log("rejectedIdeaTitle:", rejectedIdeaTitle);
	            console.log("rejectReason:", rejectReason);
	            
	            console.log("alert 표시 직전");
	            alert("기존에 제출한 아이디어가 반려되었습니다.\n제출 아이디어: " + rejectedIdeaTitle + "\n반려 사유: " + rejectReason);
	            console.log("alert 표시 후");
	        } else {
	            console.log("새 아이디어가 이미 제출되었습니다.");
	        }
	    } else {
	        console.log("반려된 아이디어가 없습니다.");
	    }
	}

	document.addEventListener("DOMContentLoaded", function() {
	    console.log("DOMContentLoaded 이벤트 발생");
	    
	    var hasExistingIdea = ${result == true}; // 기존 아이디어 존재 여부
	    var originalIdea = "${submittedIdea.getTitle()}"; // 원래 아이디어 제목
	    var originalDetail = "${submittedIdea.getDescription()}"; // 원래 아이디어 설명

	    try {
	        showNextStageButton();
	    } catch (error) {
	        console.error("showNextStageButton 함수 실행 중 오류 발생:", error);
	    }
	    
	    try {
	        checkRejectedIdea();
	    } catch (error) {
	        console.error("checkRejectedIdea 함수 실행 중 오류 발생:", error);
	    }

	    try {
	        if (${result}) {
	            const submitButton = document.getElementById("submitButton");
	            const updateButton = document.getElementById("updateButton");
	            if (submitButton) submitButton.style.display = "none";
	            if (updateButton) updateButton.style.display = "inline-block";
	        } else {
	            const submitButton = document.getElementById("submitButton");
	            const updateButton = document.getElementById("updateButton");
	            if (submitButton) submitButton.style.display = "inline-block";
	            if (updateButton) updateButton.style.display = "none";
	        }
	    } catch (error) {
	        console.error("버튼 표시 설정 중 오류 발생:", error);
	    }
	});
	
	<%
	    String[] stages = {"아이디어 초안", "초안 투표하기", "관점별 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
	    request.setAttribute("stages", stages);
	%>

</script>
<script>
document.addEventListener("DOMContentLoaded", function() {
// 모달 관련 스크립트
    var aiModal = document.getElementById("aiLogModal");
    var aiBtn = document.querySelector("button[onclick='openAiLogModal()']");
    var aiSpan = document.querySelector(".aiClose");

    function openAiLogModal() {
        aiModal.style.display = "block";
        loadAiLog();
    }

    if (aiSpan) {
        aiSpan.onclick = function() {
            aiModal.style.display = "none";
        }
    }

    window.onclick = function(event) {
        if (event.target == aiModal) {
            aiModal.style.display = "none";
        }
    }

    // openAiLogModal 함수를 전역 스코프에 노출
    window.openAiLogModal = openAiLogModal;

    function loadAiLog() {
        var userId = ${userId};
        var roomId = ${info.getRoomId()};
        fetch(`./getUserAiLog?userId=${userId}&roomId=${roomId}`)
            .then(response => response.json())
            .then(data => {
                var chatHtml = '';
                data.forEach(function(log) {
                    var profileImg = log.profileImg;
                    var aiQuestion = log.aiQuestion.replace(/\n/g, '<br>');
                    var aiContent = log.aiContent.replace(/\n/g, '<br>');
                    var aiImgSrc = "<c:url value='/resources/aiImg.png'/>";

                    chatHtml += '<div class="aiChat-message aiUser-message">' +
                                '<img src="./upload/' + profileImg + '" alt="User" class="aiProfile-img">' +
                                '<div class="aiMessage-content">' + aiQuestion + '</div>' +
                                '</div>' +
                                '<div class="aiChat-message ai-message">' +
                                '<div class="aiMessage-content">' + aiContent + '</div>' +
                                '<img src="' + aiImgSrc + '" alt="AI" class="ai-img">' +
                                '</div>';
                });
                document.getElementById('aiLogChat').innerHTML = chatHtml;
            })
            .catch(error => console.error('Error:', error));
    }
});
</script>
<script type="text/javascript">
function showLoadingScreen() {
	  document.getElementById('loading-screen').style.display = 'flex';
	  document.getElementById('kb-ai-response').style.display = 'none';
	}

function hideLoadingScreen() {
	  document.getElementById('loading-screen').style.display = 'none';
	  document.getElementById('kb-ai-response').style.display = 'flex';
	}
function adjustResponseHeight() {
    const container = document.getElementById('kb-ai-response');
    const wrapper = document.getElementById('ai-response-wrapper');
    const text = document.getElementById('ai-response-text');
    const otherQuery = document.getElementById('other-query');
    const buttons = document.querySelector('.ai-buttons');
    
    if (!container || !wrapper || !text || !buttons) {
        console.error('One or more required elements not found');
        return;
    }
    
    // Reset heights
    container.style.height = '';
    wrapper.style.height = '';
    
    // Calculate available height
    const containerHeight = container.offsetHeight;
    const otherQueryHeight = otherQuery.offsetHeight;
    const buttonsHeight = buttons.offsetHeight;
    const availableHeight = containerHeight - otherQueryHeight - buttonsHeight - 40; // 40px for padding
    
    // Set wrapper height
    wrapper.style.height = `${availableHeight}px`;
    
    // Adjust container height if needed
    const contentHeight = text.offsetHeight + otherQueryHeight + buttonsHeight + 40;
    if (contentHeight > containerHeight) {
        container.style.height = `${Math.min(contentHeight, 550)}px`; // 최대 높이를 550px로 제한
    }
    
    // 텍스트 내용이 적을 경우 중앙 정렬 유지
    if (text.offsetHeight < wrapper.offsetHeight) {
        wrapper.style.alignItems = 'center';
        wrapper.style.justifyContent = 'center';
    } else {
        wrapper.style.alignItems = 'flex-start';
        wrapper.style.justifyContent = 'flex-start';
    }
}

function showFeedback() {
    const roomTitle = document.querySelector('.room1-title').textContent.trim().replace(/^\[|\]$/g, '');
    const ideaTitle = document.getElementById('myIdeaInput').value.trim();
    const ideaContent = document.getElementById('ideaDetailInput').value.trim();
    const roomId = ${info.getRoomId()}; // JSP 표현식을 사용하여 roomId를 가져옵니다.
    if (!ideaTitle || !ideaContent) {
        alert('아이디어 제목과 내용을 모두 입력해주세요.');
        return;
    }
    
    var query = '"' + roomTitle + '"에 대해 [제목: "' + ideaTitle + '" 내용: "' + ideaContent + '"] 아이디어를 만들었는데\n' +
    '시장 조사:\n' +
    '- 이 아이디어와 유사한 제품이나 서비스는 시장에 어떤 형태로 존재하고 있나요?\n' +
    '- 이 아이디어가 목표 시장에서 어떻게 차별화될 수 있을까요?\n\n' +
    '피드백:\n' +
    '- 이 아이디어에 대한 피드백을 한글로 제공해 줄 수 있나요? 개선할 점이나 보완할 점이 있다면 무엇인가요?';

    sendAiRequest(query, roomId);
}
let isOtherQueryVisible = false;

function showOtherQuery() {
    const otherQuery = document.getElementById('other-query');
    if (isOtherQueryVisible) {
        otherQuery.style.display = 'none';
        isOtherQueryVisible = false;
    } else {
        otherQuery.style.display = 'block';
        isOtherQueryVisible = true;
    }
}

function sendQuery() {
    const query = document.getElementById('query-input').value;
    const roomId = ${info.getRoomId()};

    sendAiRequest(query, roomId);
}

function sendAiRequest(query, roomId) {
    showLoadingScreen();
    
    console.log("Original query:", query);  // 원본 쿼리 출력
    
    // UTF-8로 인코딩 후 Base64 인코딩
    const encodedQuery = btoa(unescape(encodeURIComponent(query)));
    console.log("Encoded query:", encodedQuery);  // 인코딩된 쿼리 출력
    
    fetch('./getAiResponse1', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ userInput: encodedQuery, roomId: Number(roomId)})
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.text();
    })
.then(data => {
    console.log("Received data:", data);  // 받은 데이터 출력
    let jsonData;
    try {
        jsonData = JSON.parse(data);
        console.log("Parsed JSON data:", jsonData);  // 파싱된 JSON 데이터 출력
    } catch (e) {
        console.error("JSON parsing error:", e);
        throw new Error('Invalid JSON response from server');
    }
    const responseText = document.getElementById('ai-response-text');
    const responseContainer = document.getElementById('kb-ai-response');
    const responseWrapper = document.getElementById('ai-response-wrapper');
    
    if (responseText && responseContainer && responseWrapper) {
        if (jsonData.error) {
            console.error("Server error:", jsonData.error);
            responseText.innerHTML = `오류가 발생했습니다: ${jsonData.error}`;
        } else if (jsonData.aiResponse) {
            // Base64 디코딩 과정 제거
            console.log("AI response:", jsonData.aiResponse);  // AI 응답 출력
            responseText.innerHTML = jsonData.aiResponse.replace(/\n/g, '<br>');
        } else {
            console.error("Unexpected response format:", jsonData);
            responseText.innerHTML = '예상치 못한 응답 형식입니다.';
        }
        
        responseContainer.style.display = 'flex';
        responseWrapper.style.alignItems = 'flex-start';
        responseWrapper.style.justifyContent = 'flex-start';
        hideLoadingScreen();
        adjustResponseHeight();
    } else {
        console.error('Response elements not found');
    }
})
    .catch(error => {
        console.error('Error:', error);
        
        const responseText = document.getElementById('ai-response-text');
        if (responseText) {
            responseText.innerHTML = `AI 응답을 가져오는 데 실패했습니다. 에러: ${error.message}`;
        }
        hideLoadingScreen();
        adjustResponseHeight();
    });
}
//상세내역 토글
document.addEventListener('DOMContentLoaded', function() {
	const toggleSwitch = document.getElementById('toggleDescription');
    const toggleText = document.querySelector('.toggle-text');
    const descriptionContent = document.getElementById('descriptionContent');

    if (toggleSwitch) {  // 요소가 존재하는지 확인
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

//반려이력 모달
document.addEventListener("DOMContentLoaded", function() {
    var modal = document.getElementById("rejectHistoryModal");
    var btn = document.querySelector(".titleAndDetail-title-link");
    var span = document.querySelector("#rejectHistoryModal .close");
    var reapplyButton = document.getElementById("reapplyButton");
    
    // 스테이지 ID 확인 및 버튼 숨김 처리
    var stageId = ${meetingRoom.getStageId()};
    var submitButton = document.getElementById("submitButton");
    var updateButton = document.getElementById("updateButton");

    if (stageId >= 2) {
        if (submitButton) submitButton.style.display = "none";
        if (updateButton) updateButton.style.display = "none";
    }

    btn.onclick = function() {
        modal.style.display = "block";
    }

    span.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    reapplyButton.onclick = function() {
        var selectedRadio = document.querySelector('input[name="rejectSelect"]:checked');
        if (selectedRadio) {
            var index = selectedRadio.value;
            var title = document.getElementById("againTitle" + index).textContent;
            var content = document.getElementById("againContent" + index).textContent;
            
            document.getElementById("myIdeaInput").value = title;
            document.getElementById("ideaDetailInput").value = content;
            
            modal.style.display = "none";
        } else {
            alert("다시 입력할 아이디어를 선택해주세요.");
        }
    }
});
</script>
<body style="margin: 0;">
<!-- 헤더영역 -->
	<header class="room1-header">
		<%@ include file="../header.jsp"%>
	</header>	
 	<%@ include file="../leftSideBar.jsp"%>
 	
	<!-- 컨텐츠 영역 시작 -->	
	<div class="room1-content">
	
	<!-- 사이드바 import -->
	<%@ include file="../rightSideBar.jsp"%>
	
<!-- 6개 단계 표시 -->
	<div class="stages">
	    <c:forEach var="stage" items="${stages}" varStatus="status">
	        <c:choose>
	            <c:when test="${meetingRoom.getStageId() >= status.index + 1}">
	                <a
	                    href="./roomDetail?roomId=${meetingRoom.getRoomId()}&stage=${status.index + 1}&ideaId=${yesPickList[0].getIdeaID()}"
	                    class="stage ${meetingRoom.getStageId() == status.index + 1 ? 'active' : ''}">
	                    ${status.index + 1}. ${stage}
	                </a>
	            </c:when>
	            <c:otherwise>
	                <div class="stage inactive">${status.index + 1}. ${stage}</div>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	</div>
    
    <!-- 제목, 상세설명 -->
    <div class="room1-title">[${info.getRoomTitle()}]</div>
    
	<div class="room1-title-detail">
	    <div class="toggle-container">
	        <div class="toggle-switch">
	            <input type="checkbox" id="toggleDescription" class="toggle-input">
	            <label for="toggleDescription" class="toggle-label">
	                <span class="toggle-inner"></span>
	                <span class="toggle-switch"></span>
	            </label>
	        </div>
	        <span class="toggle-text">설명 보기</span>
	    </div>
	    <div id="descriptionContent" style="display:none;">
	        <pre>${info.getDescription()}</pre>
	    </div>
	</div>
  
    <hr class="line">
	
	<div>
	<!-- 방장만 보이는 다음단계 버튼 -->
	<form id="nextStageForm" action="./stage1Clear" method="post">
	    <input type="hidden" name="roomId" value="${info.getRoomId()}">
	    <input type="hidden" name="stage" value="${stage}">
	    <div class="stage-info" style="margin-bottom: 50px;">
	        <c:if test="${userId == info.getRoomManagerId()}">
	        <div class="submit-info">
	            현재 아이디어 제출인원 : ${submit}명 / ${total}명
	        </div>
	        <c:if test="${meetingRoom.stageId==1}">
	            <button id="nextStageButton" class="yellow-button" onclick="nextStage()">다음 단계</button></c:if>
	        </c:if>
	    </div>
	</form>
	
	<!-- 아이디어 입력창 -->
	<div class="titleAndDetail">
	    <div class="title-container">
	        <div class="titleAndDetail-title">나의 아이디어</div>
	        <div class="titleAndDetail-title-link">반려 이력보기 ></div>
	    </div>
	    <div class="titleAndDetail-detail">회의 주제에 대한 나의 아이디어를 작성해주세요.</div>
	</div>
		
	<div style="margin-bottom: 50px;">
		<input type="text" id="myIdeaInput" class="room1-subject" name="myIdea" 
			placeholder="여기에 작성해주세요" value="${result == true ? submittedIdea.getTitle() : ''}">
	</div>
		
	<!-- 아이디어 상세설명 입력창 -->
	<div class="titleAndDetail">
		<div class="titleAndDetail-title">아이디어에 대한 상세 설명</div>
		<div class="titleAndDetail-detail">내가 작성한 아이디어에 대해 자세히 설명해주세요.</div>
	</div>
		
	<div style="margin-bottom: 50px;">
		<textarea id="ideaDetailInput" class="room1-subject" style="height: 150px;"
   			name="ideaDetail" placeholder="여기에 작성해주세요">${result == true ? submittedIdea.getDescription() : ''}</textarea>
	</div>
		
	<!-- ai영역 -->
	<div class="titleAndDetail ai-opinion-section">
	    <div class="title-container">
	        <div class="titleAndDetail-title">나의 아이디어에 대한 KB AI 의견</div>
	        <div class="titleAndDetail-title-link" onclick="openAiLogModal()">나의 AI 이력 ></div>	
	    </div>
	    <button class="yellow-button" onclick="showFeedback()">AI에게 피드백받기</button>
	</div>
	
	<div id="loading-screen" style="display: none;">
 		<div class="loading-content">
   			<div class="thinking-brain">🤔</div>
    		<div class="loading-text">AI가 열심히 생각 중입니다...</div>
    		<div class="loading-dots">
      			<span>.</span><span>.</span><span>.</span>
    		</div>
 		 </div>
	</div>
	
	<div id="kb-ai-response" class="kb-ai-response">
	    <div class="ai-image-container">
	        <img src="<c:url value='/resources/aiImg.png'/>" alt="AI Robot" class="ai-image">
	    </div>
	    <div class="ai-content">
	        <div class="ai-buttons">
	            <!-- <button class="grey-button" onclick="showFeedback()">피드백</button> -->
	            <button class="grey-button" onclick="showOtherQuery()">다른 질문하기</button>
	        </div>
	        <div id="other-query">
	            <div class="search-container">
	                <input type="text" id="query-input" class="room1-subject" placeholder="질문을 입력하세요">
	                <button onclick="sendQuery()" class="search-button" aria-label="검색">
	                    <span>🔎</span>
	                </button>
	            </div>
	        </div>
	        <div id="ai-response-wrapper">
	            <span id="ai-response-text">KB ai의 응답 내용이 여기에 표시됩니다.</span>
	        </div>
	    </div>
	</div>

	<!-- 맨 하단 버튼영역 -->
	<div class="button-container">

		<form id="ideaForm1" action="./submitIdea" method="post">
			<input type="hidden" name="roomId" value="${info.getRoomId()}">
			<input type="hidden" name="stage" value="${stage}">
			<input type="hidden" id="myIdeaHidden" name="myIdea">
			<input type="hidden" id="ideaDetailHidden" name="ideaDetail">

			<button type="button" id="submitButton" class="yellow-button"
					onclick="submitIdeaForm1()">아이디어 제출하기</button>

		</form>

		<form id="updateForm" action="./updateIdea" method="post">
			<input type="hidden" name="roomId" value="${info.getRoomId()}">
			<input type="hidden" name="stage" value="${stage}">
			<input type="hidden" id="myIdeaHidden2" name="myIdea">
			<input type="hidden" id="ideaDetailHidden2" name="ideaDetail">

				<button type="button" id="updateButton" class="yellow-button"
					 onclick="updateForm()">아이디어 수정하기</button>

		</form>
	</div>

	</div>

	</div>
	
	<!-- AI 로그 모달 -->
	<div id="aiLogModal" class="aiModal">
	    <div class="aiModal-content">
	        <span class="aiClose">&times;</span>
	        <h2>나의 AI 이력</h2>
	        <div id="aiLogChat"></div>
	    </div>
	</div>
	
	<!-- 반려 이력 모달 -->
	<div id="rejectHistoryModal" class="modal">
	    <div class="modal-content">
	        <span class="close">&times;</span>
	        <h2>반려 이력보기</h2>
	        <p>이전에 이 회의방에 제출했지만 반려된 아이디어 목록이에요.<br>선택해서 다시 입력하기 버튼을 누르면 자동으로 세팅됩니다.</p>
	        <div id="rejectList">
	            <c:forEach var="reject" items="${rejectList}" varStatus="status">
	                <div class="reject-item">
	                    <input type="radio" name="rejectSelect" id="reject${status.index}" value="${status.index}">
	                    <label for="reject${status.index}">
	                        <div><span style="font-weight: bold;">아이디어</span>: <span id="againTitle${status.index}">${reject.getRejectIdeaTitle()}</span></div>
	                        <div><span style="font-weight: bold;">상세설명</span>: <span id="againContent${status.index}">${reject.getDescription()}</span></div>
	                        <div><span style="font-weight: bold;">반려사유</span>: <span>${reject.getRejectContents()}</span></div>
	                    </label>
	                </div>
	            </c:forEach>
	        </div>
	        <button id="reapplyButton" class="yellow-button">다시 입력하기</button>
	    </div>
	</div>
	
</body>
</html>