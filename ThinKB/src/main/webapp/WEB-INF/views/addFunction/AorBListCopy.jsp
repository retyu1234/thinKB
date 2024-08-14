<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - A/B테스트 목록</title>
<style>
html, body {
    max-width: 100%;
    overflow-x: hidden;
}
.ab-body {
	font-family: KB금융 본문체 Light;
}

.ab-banner {
	margin-top: 50px;
	margin-left: 15%;
	margin-right: 15%;
	margin-top: 1%;
}

.ab-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
}
.ab-button-container {
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

.abtests {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    margin: 30px 30px;
}

.abtest {
 	width: 550px;
    height: 400px;
    margin-bottom: 50px;
    padding: 20px;
    border-radius: 20px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    cursor: pointer;
    transition: all 0.3s ease;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
}

.abtest:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
}

.abtest-complete {
    background-color: #f0f0f0;
}

.abtest-incomplete {
    background-color: #E8F1FF;
}

.abtest-status {
    display: block;
    width: fit-content;
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

.abtest-images {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 20px;
    margin-bottom: 10px;
    position: relative;
    height: 250px;
}

.abtest-images img {
    width: 230px;
    height: 230px;
    object-fit: cover;
}

.abtest-vs {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    font-weight: bold;
    font-size: 20px;
    padding: 5px 15px;
    border-radius: 50%;
    font-family: KB금융 제목체 Light;
}

.abtest-name {
    font-size: 1.2em;
    font-weight: bold;
    margin: 10px 20px;
    font-family: KB금융 제목체 Light;
}
</style>
</head>


<body class="ab-body">
	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>
	
	<!-- 상단 배너영역 -->
	<div class="ab-banner">
		<img src="<c:url value='./resources/abtestBanner.png'/>" alt="abtestBanner" 
		style="max-width: 100%; height: auto;">
	</div>
	
	<!-- 결과피드백, 테스트만들기 버튼 -->
	<div class="ab-button-container">
		<a href="./AorBFeedbackList"><button class="grey-button"
			style="margin-right:20px;">결과 피드백</button></a>
		<a href="./makeAorB"><button class="yellow-button" >+ 새로운 A/B테스트</button></a>
	</div>
	
	<!-- 콘텐츠 시작 -->
	<div class="ab-content">
	
	<!-- 상단 단계별 조회 -->
	<div class="progress-header-container">
		<h2 class="progress-header">진행중인 단계</h2>
	</div>
	
	<div class="progress-container">
		<div class="progress">
			<label><input type="checkbox" id="selectAll"
				onchange="toggleSelectAll(this)">전체 선택</label> <label><input
				type="checkbox" data-stage="incomplete" onchange="filterIdeas()">미완료</label>
			<label><input type="checkbox" data-stage="complete"
				onchange="filterIdeas()">완료</label>
		</div>
	</div>
	
	<!-- 테스트 목록 -->
<div class="abtests">
    <c:forEach var="test" items="${abTests}">
        <div class="abtest ${test.participated ? 'abtest-complete' : 'abtest-incomplete'}"
             onclick="redirectToDetail(${test.ABTestID}, '${test.participated ? 'complete' : 'incomplete'}')">
            <div class="abtest-status ${test.participated ? 'status-complete' : 'status-incomplete'}">
                ${test.participated ? '참여 완료' : '미참여'}
            </div>
            <div class="abtest-images">
                <img src="./upload/${test.variantA}" alt="Image A">
                <span class="abtest-vs">VS</span>
                <img src="./upload/${test.variantB}" alt="Image B">
            </div>
            <div class="abtest-name">${test.testName}</div>
        </div>
    </c:forEach>
</div>
	
	
</div>

</body>

<script>
function redirectToDetail(abTestId, status) {
    // 상태에 따라 다른 URL로 리디렉션
    if (status === 'complete') {
        // 완료된 경우 다른 URL로 이동
        window.location.href = './completedTestDetail?abTestId=' + abTestId;
    } else {
        // 미완료된 경우 기본 URL로 이동
        window.location.href = './adTsetdetail?abTestId=' + abTestId;
    }
}
function toggleSelectAll(checkbox) {
    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i] !== checkbox) {
            checkboxes[i].checked = checkbox.checked;
        }
    }
    filterIdeas();
}

function filterIdeas() {
    var showIncomplete = document.querySelector('input[data-stage="incomplete"]').checked;
    var showComplete = document.querySelector('input[data-stage="complete"]').checked;
    var abtests = document.querySelectorAll('.abtest');

    abtests.forEach(function(abtest) {
        if ((showIncomplete && abtest.classList.contains('abtest-incomplete')) ||
            (showComplete && abtest.classList.contains('abtest-complete'))) {
            abtest.style.display = '';
        } else {
            abtest.style.display = 'none';
        }
    });
}

// 페이지 로드 시 모든 아이디어 표시
window.onload = function() {
    document.getElementById('selectAll').checked = true;
    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    checkboxes.forEach(function(checkbox) {
        checkbox.checked = true;
    });
    filterIdeas();
};
</script>
</html>
