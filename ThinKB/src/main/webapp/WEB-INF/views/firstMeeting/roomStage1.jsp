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
}

.room1-header {
	position: relative;
	z-index: 1;
}

.room1-content {
    padding: 20px;
    margin-left: 17%; /* 또는 더 작은 값 */
    margin-right: 17%;
    z-index: 2;
    margin-top: 80px;
}

.room1-title {
	font-size: 22pt;
	color: black;
	font-weight: bold;
	margin-top: 50px;
	margin-bottom: 20px;
}

.room1-title-detail {
	font-size: 18pt;
}

/* 노란색 버튼 */
.yellow-button {
	background-color: #FFCC00;
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 15pt;
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
	font-size: 15pt;
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
	font-size: 15pt;
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
	font-size: 15pt;
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
	height: 150px;
}

.ai-image {
	width: 115px; /* 이미지 크기 조절 */
	height: auto;
	margin-right: 30px; /* 이미지와 텍스트 사이 간격 */
	margin-left: 30px; 
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
	font-size: 22pt;
	color: black;
	font-weight: bold;
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

</style>
</head>
<script>
	function showResponse() {
		const responseDiv = document.getElementById("kb-ai-response");
		const responseText = document.getElementById("ai-response-text");
		responseDiv.style.display = "flex"; // "block" 대신 "flex" 사용
		responseText.innerText = "api써서 받아온 응답이 보여집니다.";
	}

	function submitIdeaForm() {
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
	
	<%
	    String[] stages = {"아이디어 초안 제출하기", "좋은 초안에 투표하기", "다양한 관점 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
	    request.setAttribute("stages", stages);
	%>

</script>
<body>
<!-- 헤더영역 -->
	<header class="room1-header">
		<%@ include file="../header.jsp"%>
	</header>
 	<%-- <%@ include file="../leftSideBar.jsp"%> --%>
<!-- 컨텐츠 영역 시작 -->	
	<div class="room1-content">
	
	<!-- 사이드바 import -->

	<%@ include file="../rightSideBar.jsp"%>
	
	<!-- 5개 단계 표시 -->
	<div class="stages">
        <c:forEach var="stage" items="${stages}" varStatus="status">
            <c:choose>
                <c:when test="${meetingRoom.getStageId() >= status.index + 1}">
                    <a href="roomDetail?roomId=${meetingRoom.getRoomId()}&stage=${status.index + 1}" class="stage ${meetingRoom.getStageId() == status.index + 1 ? 'active' : ''}">
                        ${status.index + 1}. ${stage}
                    </a>
                </c:when>
                <c:otherwise>
                    <div class="stage inactive">
                        ${status.index + 1}. ${stage}
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
    
    <!-- 제목, 상세설명 -->
    <div class="room1-title">[${info.getRoomTitle()}]</div>
    <div class="room1-title-detail">${info.getDescription()}</div>
	
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
		            <button id="nextStageButton" class="yellow-button" onclick="nextStage()">다음 단계</button>
		        </c:if>
		    </div>
		</form>
	
	<!-- 아이디어 입력창 -->
		<div class="titleAndDetail">
			<div class="titleAndDetail-title">나의 아이디어</div>
			<div class="titleAndDetail-detail">회의 주제에 대한 나의 아이디어를 작성해주세요.</div>
		</div>
		<div style="margin-bottom: 50px;">
			<input type="text" id="myIdeaInput" class="room1-subject"
				name="myIdea" placeholder="여기에 작성해주세요"
				value="${result == true ? submittedIdea.getTitle() : ''}">
		</div>
		
	<!-- 아이디어 상세설명 입력창 -->
		<div class="titleAndDetail">
			<div class="titleAndDetail-title">아이디어에 대한 상세 설명</div>
			<div class="titleAndDetail-detail">내가 작성한 아이디어에 대해 자세히 설명해주세요.</div>
		</div>
		<div style="margin-bottom: 50px;">
			<input type="text" id="ideaDetailInput" class="room1-subject" style="height: 150px;"
				name="ideaDetail" placeholder="여기에 작성해주세요" 
				value="${result == true ? submittedIdea.getDescription() : ''}">
		</div>
		
	<!-- ai영역 -->
	<div class="titleAndDetail">
			<div class="titleAndDetail-title">나의 아이디어에 대한 KB AI 의견</div>
			<div class="titleAndDetail-detail">아래 AI에게 물어보기 버튼을 눌러 의견을 확인할 수 있어요.</div>
		</div>
		<div id="kb-ai-response" class="kb-ai-response">
			<img src="<c:url value='/resources/aiImg.png'/>" alt="AI Robot"
				class="ai-image"> <span id="ai-response-text">KB ai의 응답
				내용이 여기에 표시됩니다.</span>
		</div>

	<!-- 맨 하단 버튼영역 -->
	<div class="button-container">
		<button class="grey-button" onclick="showResponse()">KB ai에게
			물어보기</button>


		<form id="ideaForm" action="./submitIdea" method="post">
			<input type="hidden" name="roomId" value="${info.getRoomId()}">
			<input type="hidden" name="stage" value="${stage}">
			<input type="hidden" id="myIdeaHidden" name="myIdea">
			<input type="hidden" id="ideaDetailHidden" name="ideaDetail">

			<button type="button" id="submitButton" class="yellow-button"
					onclick="submitIdeaForm()">아이디어 제출하기</button>

		</form>

		<form id="updateForm" action="./updateIdea" method="post">
			<input type="hidden" name="roomId" value="${info.getRoomId()}">
			<input type="hidden" name="stage" value="${stage}"> <input
				type="hidden" id="myIdeaHidden2" name="myIdea"> <input
				type="hidden" id="ideaDetailHidden2" name="ideaDetail">

				<button type="button" id="updateButton" class="yellow-button"
					 onclick="updateForm()">아이디어
					수정하기</button>

		</form>
</div>
	</div>
	</div>
</body>
</html>