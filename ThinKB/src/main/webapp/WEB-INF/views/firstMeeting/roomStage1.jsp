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
	}

	function submitForm() {
	    var myIdea = document.querySelector('input[name="myIdea"]').value.trim();
	    var ideaDetail = document.querySelector('input[name="ideaDetail"]').value.trim();
	    var hasExistingIdea = ${result == true};
	    var originalIdea = "${submittedIdea.getTitle()}";
	    var originalDetail = "${submittedIdea.getDescription()}";

	    if (hasExistingIdea) {
	        // 기존 아이디어가 있는 경우
	        if (myIdea === "" || ideaDetail === "") {
	            // 필드가 비어있으면 원래 값으로 복원
	            document.querySelector('input[name="myIdea"]').value = originalIdea;
	            document.querySelector('input[name="ideaDetail"]').value = originalDetail;
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
	    document.getElementById('ideaForm').submit();
	}

	function updateForm() {
	    var myIdea = document.querySelector('input[name="myIdea"]').value.trim();
	    var ideaDetail = document.querySelector('input[name="ideaDetail"]').value.trim();
	    var originalIdea = "${submittedIdea.getTitle()}";
	    var originalDetail = "${submittedIdea.getDescription()}";

	    if (myIdea === "" || ideaDetail === "") {
	        // 필드가 비어있으면 원래 값으로 복원
	        document.querySelector('input[name="myIdea"]').value = originalIdea;
	        document.querySelector('input[name="ideaDetail"]').value = originalDetail;
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
	<div>
	<h2 class="room1-title">아이디어 입력 가능 시간</h2>
		<%@ include file="../Timer.jsp"%>
	</div>
	
		<form id="nextStageForm" action="./stage1Clear" method="post">
		    <input type="hidden" name="roomId" value="${info.getRoomId()}">
		    <input type="hidden" name="stage" value="${stage}">
		    <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 20px;">
		        <c:if test="${userId == info.getRoomManagerId()}">
		        <div>
		            <h2 class="room1-title">현재 아이디어 제출인원 : ${submit}명 / ${total}명</h2>
		        </div>
		            <button id="nextStageButton" class="yellow-button" onclick="nextStage()">다음 단계</button>
		        </c:if>
		    </div>
		</form>

		<!-- <div id="timer" class="room1-timer"></div> -->

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

	</div>
</body>
</html>