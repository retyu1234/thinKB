<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의방(1단계)</title>
<style>
body, html {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}

.room1 {
	background: url('<c:url value="/resources/sf_23043.jpg"/>') no-repeat
		center center fixed;
	background-size: cover;
	height: 50vh;
	z-index: -1;
	position: relative;
}

.header {
	position: relative;
	z-index: 1;
}

.room1-content {
	padding: 20px;
	margin-left: 15%;
	margin-right: 15%;
	position: relative;
	z-index: 2;
}

.room1-title {
	font-family: Arial, sans-serif;
	font-size: 20px;
	color: black;
}

.room1-subject {
	font-size: 24px; /* 제목의 글자 크기 */
	color: black;
	border: 3px solid #FFD700; /* 진한 노란색 테두리 */
	border-radius: 20px; /* 라운드 처리 */
	padding: 20px; /* 내부 여백 */
	background-color: white; /* 배경색 */
}

.room1-detail {
	font-size: 18px; /* 제목의 글자 크기 */
	color: black;
	border-radius: 20px; /* 라운드 처리 */
	padding: 20px; /* 내부 여백 */
	background-color: whitesmoke; /* 배경색 */
}

input.room1-subject {
	font-size: 24px;
	color: black;
	border: 3px solid lightgrey;
	border-radius: 20px;
	padding: 20px;
	width: 100%;
	box-sizing: border-box;
}

input.room1-detail {
	font-size: 18px; /* 제목의 글자 크기 */
	color: black;
	width: 100%;
	border: 3px solid whitesmoke;
	box-sizing: border-box;
}

input.room1-subject:focus {
	border-color: #FFD700; /* 포커스 시 테두리 색상 */
	outline: none; /* 기본 포커스 스타일 제거 */
}

input.room1-detail:focus {
	border-color: #FFD700; /* 포커스 시 테두리 색상 */
	outline: none; /* 기본 포커스 스타일 제거 */
}

.kb-ai-button {
	display: block;
	width: 100%;
	margin: 20px 0;
	padding: 15px;
	font-size: 18px;
	color: white;
	background-color: #007BFF; /* 버튼 배경색 */
	border: none;
	border-radius: 10px;
	cursor: pointer;
	text-align: center;
}

.kb-ai-button:hover {
	background-color: #0056b3; /* 버튼 호버 색상 */
}

.kb-ai-response {
	font-size: 16px;
	color: black;
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 20px;
	background-color: #f0f0f0;
	margin-top: 20px;
	margin-bottom: 50px;
	display: none; /* 처음에는 보이지 않도록 설정 */
	display: flex; /* 추가: flex 컨테이너로 설정 */
	align-items: center; /* 추가: 세로 중앙 정렬 */
}

.ai-image {
	width: 50px; /* 이미지 크기 조절 */
	height: auto;
	margin-right: 15px; /* 이미지와 텍스트 사이 간격 */
}

.yellow-button {
	background-color: #e6b800; /* 진한 노란색 배경색 */
	color: black; /* 텍스트 색상 */
	padding: 10px 20px; /* 버튼의 여백 */
	border: none; /* 테두리 없음 */
	border-radius: 20px; /* 라운드 처리 */
	font-size: 20px; /* 텍스트 크기 */
	cursor: pointer; /* 마우스 커서를 포인터로 변경 */
	font-weight: bold;
}

.yellow-button:hover {
	background-color: #696969;
	color: white;
}

.room1-timer {
	font-size: 24px;
	font-weight: bold;
	color: #007BFF;
	text-align: center;
	margin-bottom: 20px;
}
</style>
</head>
<script>
	function showResponse() {
		const responseDiv = document.getElementById("kb-ai-response");
		const responseText = document.getElementById("ai-response-text");
		responseDiv.style.display = "flex"; // "block" 대신 "flex" 사용
		responseText.innerText = "api써서 받아온 응답이 보여집니다.";

		// 밑에부터 fetch를 사용하여 서버에 데이터 전송
		/*   const myIdea = document.querySelector('input[name="myIdea"]').value;

		  fetch('./saveAiLog', {
		      method: 'POST',
		      headers: {
		          'Content-Type': 'application/json',
		      },
		      body: JSON.stringify({
		          myIdea: myIdea
		      }),
		  })
		  .then(response => response.json())
		  .then(data => {
		      console.log("서버 응답:", data);
		      // 여기서 서버 응답에 따른 추가 처리를 할 수 있습니다.
		  })
		  .catch(error => {
		      console.error("요청 중 오류 발생:", error);
		  }); */
	}

	function submitForm() {
		var myIdea = document.querySelector('input[name="myIdea"]').value;
		var ideaDetail = document.querySelector('input[name="ideaDetail"]').value;

		document.getElementById('myIdeaHidden').value = myIdea;
		document.getElementById('ideaDetailHidden').value = ideaDetail;

		document.getElementById('ideaForm').submit();
	}

	function updateForm() {
		var myIdea = document.querySelector('input[name="myIdea"]').value;
		var ideaDetail = document.querySelector('input[name="ideaDetail"]').value;

		document.getElementById('myIdeaHidden2').value = myIdea;
		document.getElementById('ideaDetailHidden2').value = ideaDetail;

		document.getElementById('updateForm').submit();

	}

	function nextStage() {
		document.getElementById('nextStageForm').submit();
	}

	// 여기 아래부터 타이머
	// 타이머 함수
	function updateTimer() {
		const endDate = new Date("${timer}").getTime();
		const now = new Date().getTime();
		const distance = endDate - now;

		if (distance < 0) {
			document.getElementById("timer").innerHTML = "아이디어를 입력할 수 있는 시간이 지났어요.";
			// 입력 필드 비활성화
			document.getElementById("myIdeaInput").disabled = true;
			document.getElementById("ideaDetailInput").disabled = true;
			// 제출 버튼 숨기기
			document.getElementById("submitButton").style.display = "none";
			document.getElementById("updateButton").style.display = "none";
			// 다음 단계 버튼 표시 여부 확인
			showNextStageButton();
			return;
		}

		const hours = Math.floor((distance % (1000 * 60 * 60 * 24))
				/ (1000 * 60 * 60));
		const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
		const seconds = Math.floor((distance % (1000 * 60)) / 1000);


		document.getElementById("timer").innerHTML = "아이디어 입력 가능 시간: "
				+ (hours < 10 ? "0" : "") + hours + ":"
				+ (minutes < 10 ? "0" : "") + minutes + ":"
				+ (seconds < 10 ? "0" : "") + seconds;
	}

	// 페이지 로드 시 타이머 시작
	document
			.addEventListener(
					"DOMContentLoaded",
					function() {
						updateTimer();
						setInterval(updateTimer, 1000);
						showNextStageButton();

						// 페이지 로드 시 이미 타이머가 종료되었는지 확인
						const endDate = new Date("${timer}").getTime();
						const now = new Date().getTime();
						if (now >= endDate) {
							document.getElementById("myIdeaInput").disabled = true;
							document.getElementById("ideaDetailInput").disabled = true;
							document.getElementById("submitButton").style.display = "none";
							document.getElementById("updateButton").style.display = "none";
						}

						// result 값에 따라 버튼 표시 여부 결정
						const result = ${result};
						if (result) {
							document.getElementById("submitButton").style.display = "none";
							document.getElementById("updateButton").style.display = "inline-block";
						} else {
							document.getElementById("submitButton").style.display = "inline-block";
							document.getElementById("updateButton").style.display = "none";
						}
					});

	// 타이머끝

	function showNextStageButton() {
		const endDate = new Date("${timer}").getTime();
		const now = new Date().getTime();
		const isManager = ${userId == info.getRoomManagerId()};
		if (now >= endDate && isManager) {
			document.getElementById("nextStageButton").style.display = "block";
		} else {
			document.getElementById("nextStageButton").style.display = "none";
		}
	}

//반려아이디어 있는경우 알럿
function checkRejectedIdea() {
    const isRejected = ${submittedIdea.isReject() ? 'true' : 'false'};
    const rejectedIdeaTitle = "${submittedIdea.getTitle()}";
    const rejectContents = "${rejectContents}";
    if (isRejected) {
        alert("기존에 제출한 아이디어가 반려되었습니다.\n제출 아이디어: " + rejectedIdeaTitle + "\n반려 사유: " + rejectContents);
    }
}

</script>
<body>

	<header class="header">
		<%@ include file="../header.jsp"%>
	</header>
	<!-- 방장 sideBar -->
	<c:if test="${userId == meetingRoom.getRoomManagerId() }">
		<%@ include file="../sideBar.jsp"%>
	</c:if>
	<div class="room1"></div>
	<!-- 배경 이미지를 위한 영역 -->
	<div class="room1-content">
	<%-- <%@ include file="../Timer.jsp" %> --%>
		<div id="timer" class="room1-timer"></div>

		<!-- 방장만 보이는 버튼?? -->
		<div style="text-align: right;">
			<c:if test="${userId == info.getRoomManagerId() }">
				<button type="button" class="yellow-button"
					onclick="window.location.href='./managerMenu'">회의방 관리</button>
			</c:if>
		</div>

		<h2 class="room1-title">아이디어 회의 주제</h2>
		<div class="room1-subject">${info.getRoomTitle()}</div>

		<h2 class="room1-title" style="padding-top: 30px;">상세 설명</h2>
		<div class="room1-detail">${info.getDescription()}</div>


		<h2 class="room1-title" style="padding-top: 30px;">나의 아이디어</h2>
		<input type="text" id="myIdeaInput" class="room1-subject"
			name="myIdea" placeholder="여기에 작성해주세요"
			value="${result == true ? submittedIdea.getTitle() : ''}">

		<button class="kb-ai-button" onclick="showResponse()">KB ai에게
			물어보기</button>
		<div id="kb-ai-response" class="kb-ai-response">
			<img src="<c:url value='/resources/aiImg.png'/>" alt="AI Robot"
				class="ai-image"> <span id="ai-response-text">KB ai의 응답
				내용이 여기에 표시됩니다.</span>
		</div>

		<h2 class="room1-title" style="padding-top: 30px;">아이디어에 대한 상세 설명</h2>
		<input type="text" id="ideaDetailInput" class="room1-detail"
			name="ideaDetail" placeholder="여기에 작성해주세요"
			style="margin-bottom: 100px;"
			value="${result == true ? submittedIdea.getDescription() : ''}">


		<form id="ideaForm" action="./submitIdea" method="post">
			<input type="hidden" name="roomId" value="${info.getRoomId()}">
			<input type="hidden" name="stage" value="${stage}"> <input
				type="hidden" id="myIdeaHidden" name="myIdea"> <input
				type="hidden" id="ideaDetailHidden" name="ideaDetail">
			<div style="text-align: center;">
				<button type="button" id="submitButton" class="yellow-button"
					style="margin-bottom: 100px; display: inline-block;"
					onclick="submitForm()">아이디어 제출하기</button>
			</div>
		</form>

		<form id="updateForm" action="./updateIdea" method="post">
			<input type="hidden" name="roomId" value="${info.getRoomId()}">
			<input type="hidden" name="stage" value="${stage}"> <input
				type="hidden" id="myIdeaHidden2" name="myIdea"> <input
				type="hidden" id="ideaDetailHidden2" name="ideaDetail">
			<div style="text-align: center;">
				<button type="button" id="updateButton" class="yellow-button"
					style="margin-bottom: 100px; display: none;" onclick="updateForm()">아이디어
					수정하기</button>
			</div>
		</form>

		<form id="nextStageForm" action="./stage1Clear" method="post">
			<input type="hidden" name="roomId" value="${info.getRoomId()}">
			<input type="hidden" name="stage" value="${stage}">
			<div style="text-align: right; margin-top: 20px;">
				<button id="nextStageButton" class="yellow-button"
					style="display: none;" onclick="nextStage()">다음 단계</button>
			</div>
		</form>
		
	</div>

</body>
</html>