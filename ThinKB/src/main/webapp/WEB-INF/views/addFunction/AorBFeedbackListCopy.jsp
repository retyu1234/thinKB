<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - A/B테스트 결과 피드백</title>
<style>
html, body {
	max-width: 100%;
	overflow-x: hidden;
}

.ab-feedback-body {
	font-family: KB금융 본문체 Light;
}

.ab-feedback-banner {
	margin-top: 50px;
	margin-left: 15%;
	margin-right: 15%;
	margin-top: 1%;
}

.ab-feedback-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
}

.ab-feedback-button-container {
	display: flex;
	justify-content: end;
	margin-left: 15%;
	margin-right: 15%;
}

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
	font-family: KB금융 본문체 Light;
}

.grey-button:hover {
	background-color: #60584C;
}

.progress-container {
	display: flex;
	justify-content: center;
	margin: 10px 0;
}

.progress {
	background-color: #ffffff;
	padding: 10px 20px;
	border-radius: 25px;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 50px;
	width: 80%;
	border: 1px solid #ccc;
	font-size: 1.1em;
}

.progress label {
	display: flex;
	align-items: center;
	margin: 0 50px;
}

.progress input {
	margin-right: 5px;
}

/* 진행중인 단계 스타일은 그대로 유지 */
.progress-header-container {
	display: flex;
	justify-content: left;
	width: 80%;
	margin: 0 auto;
	margin-top: 10px;
}

.progress-header {
	margin: 0;
	padding: 10px 0;
	font-family: KB금융 제목체 Light;
}

.ab-feedback-tests {
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-start; /* 변경: space-between에서 flex-start로 */
    margin: 30px 30px;
}

.ab-feedback-test {
    width: calc(33.33% - 20px); /* 변경: 30%에서 calc(33.33% - 20px)로 */
    height: 400px;
    margin-bottom: 50px;
    margin-left: 10px;
    margin-right: 15px; /* 추가: 오른쪽 마진 추가 */
    padding: 20px;
    border-radius: 20px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    cursor: pointer;
    transition: all 0.3s ease;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* 추가: 3n번째 요소의 오른쪽 마진 제거 */
.ab-feedback-test:nth-child(3n) {
    margin-right: 0;
}

.ab-feedback-test.hidden {
	display: none; /* 숨김 */
}

.ab-feedback-test:hover {
	transform: translateY(-5px);
	box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
}

.ab-feedback-test-complete {
	background-color: #f0f0f0;
}

.ab-feedback-test-incomplete {
	background-color: #E8F1FF;
}

.ab-feedback-test-status {
	display: block;
	width: fit-content; /* 내용에 맞게 너비 조정 */
	padding: 5px 10px;
	border-radius: 15px;
	font-size: 0.9em;
	margin-bottom: 10px;
}

.status-complete {
	background-color: #4a4a4a;
	color: white;
}

.status-incomplete {
	background-color: #007bff;
	color: white;
}

.ab-feedback-test-images {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 20px;
	margin-bottom: 10px;
	position: relative;
	height: 250px; /* 이미지 컨테이너의 높이 고정 */
}

.ab-feedback-test-images img {
	width: 230px; /* 이미지 너비 고정 */
	height: 230px; /* 이미지 높이 고정 */
	object-fit: cover; /* 이미지 비율 유지 */
}
</style>
</head>

<body class="ab-feedback-body">
	<%@ include file="../header.jsp"%>
	<!-- 상단 배너영역 -->
	<div class="ab-feedback-banner">
		<img src="<c:url value='./resources/abFeedbackBanner.png'/>"
			alt="abFeedbackBanner" style="max-width: 100%; height: 100%;">
	</div>

	<!-- 콘텐츠 시작 -->
	<div class="ab-feedback-content">
		<!-- 상단 단계별 조회 -->
		<div class="progress-header-container">
			<h2 class="progress-header">참여 여부</h2>
		</div>

		<div class="progress-container">
			<div class="progress">
				<label><input type="checkbox" id="selectAll"
					onchange="toggleSelectAll(this)">전체 선택</label> 
				<label><input
					type="checkbox" data-stage="incomplete" onchange="filterTests()">미참여</label>
				<label><input type="checkbox" data-stage="complete"
					onchange="filterTests()">참여 완료</label>
			</div>
		</div>
		<div class="ab-feedback-tests">
			<c:forEach var="test" items="${feedbackTests}">
				<div class="ab-feedback-test ${test.participated ? 'complete' : 'incomplete'}"
					onclick="redirectToFeedback(${test.ABTestID})">
					<div
						class="ab-feedback-test-status ${test.participated ? 'status-complete' : 'status-incomplete'}">
						${test.participated ? '참여 완료' : '미참여'}</div>
					<div class="ab-feedback-test-name" style="font-family: KB금융 제목체 Light;">
						<h3>${test.testName}</h3>
					</div>
					<div class="ab-feedback-test-images">
						<c:choose>
							<c:when test="${test.resultANum > test.resultBNum}">
								<img src="./upload/${test.variantA}" alt="imageA">
							</c:when>
							<c:otherwise>
								<img src="./upload/${test.variantB}" alt="imageB">
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

</body>

<script>
function redirectToFeedback(abTestId) {
    window.location.href = './ABFeedback?abTestId=' + abTestId;
}

function toggleSelectAll(checkbox) {
    var checkboxes = document.querySelectorAll('.progress input[type="checkbox"]');
    checkboxes.forEach(function(cb) {
        if (cb !== checkbox) {
            cb.checked = checkbox.checked;
        }
    });
    filterTests();
}

function filterTests() {
    var incomplete = document.querySelector('.progress input[data-stage="incomplete"]').checked;
    var complete = document.querySelector('.progress input[data-stage="complete"]').checked;
    var tests = document.querySelectorAll('.ab-feedback-test');

    tests.forEach(function(test) {
        test.classList.add('hidden'); // 모두 숨김

        if (incomplete && complete) {
            test.classList.remove('hidden'); // 모두 보임
        } else if (incomplete && test.classList.contains('incomplete')) {
            test.classList.remove('hidden'); // 미참여만 보임
        } else if (complete && test.classList.contains('complete')) {
            test.classList.remove('hidden'); // 참여 완료만 보임
        } else if (!incomplete && !complete) {
            test.classList.remove('hidden'); // 모두 보임
        }
    });
}
</script>
</html>
