<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThinkKB</title>
<style>
.ab-body {
	font-family: Arial, sans-serif;
	background-color: #FFFFf1;
}

.header1 {
	text-align: center;
}

.header1 img {
	width: 100%;
	height: auto;
	max-height: 500px;
}

.user-info p {
	margin: 0;
}

.button-container {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 10px;
}

.progress-container {
	display: flex;
	justify-content: center;
	margin: 10px 0;
}

.progress {
	background-color: #ffffff;
	padding: 10px;
	border-radius: 25px;
	display: flex;
	justify-content: space-around;
	height: 50px;
	width: 80%;
	border: 1px solid #ccc;
	font-size: 1.3em;
	justify-content: flex-start;
}

.progress label {
	display: flex;
	align-items: center;
	margin-left: 40px;
}

.progress input {
	margin-right: 5px;
}

/* 진행중인 단계 */
.progress-header-container {
	display: flex;
	justify-content: left;
	width: 80%;
	margin: 0 auto;
	margin-top: 50px;
}

.progress-header {
	margin: 0;
	padding: 10px 0;
}

.ideas {
	margin: 30px 20px;
}

.idea {
	padding: 20px 20px;
	background-color: #ffffff;
	border-radius: 10px;
	margin-top: 30px;
	margin-left: auto;
	margin-right: auto;
	height: 100px;
	width: 80%;
	border: 1px solid #ccc;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
	font-size: 1.2em;
	cursor: pointer;
}

.idea h3, .idea p {
	margin: 0;
}

.idea-left {
	text-align: left;
}

.idea-right {
	display: flex;
	justify-content: center;
	align-items: center; /* 세로 가운데 정렬 */
	flex-direction: column;
	height: 100%;
}

.idea-status {
	padding: 10px 20px;
	border-radius: 10px;
	color: white;
	font-weight: bold;
	text-align: center;
}

.idea-complete {
	background-color: #CEFBC9; /* 완료 상태 배경색 */
}
.idea-complete:hover {
	background-color: #CEFBA9; /* 완료 상태 호버 배경색 */
}

.idea-incomplete {
	background-color: #EAEAEA; /* 미완료 상태 배경색 */
}

.idea-incomplete:hover {
	background-color: #D3D3D3; /* 미완료 상태 호버 배경색 */
}

.vote-button-container {
	display: flex;
	justify-content: center;
	margin-top: 30px;
}

.vote-button {
	background-color: #ffc107;
	font-size: 1.2em;
	border: none;
	width: 300px;
	padding: 15px 30px;
	border-radius: 25px;
	cursor: pointer;
}

.vote-button:hover {
	background-color: #e0a800;
}
.abtestMake{
	display: flex;
	justify-content:end;
	margin-right:10%;
}
.abtestMake button {
    padding: 15px 30px;  /* 패딩을 더 크게 설정 */
    background-color: #ffcc00;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 20px;  /* 폰트 크기를 더 크게 설정 */
    font-weight: bold;
    margin-bottom: 5px;
    transition: background-color 0.3s;

}
</style>
</head>

<body class="ab-body">
	<%@ include file="../header.jsp"%></div>
	<div class="header1">
		<img src="./resources/header2.jpg" alt="Header Image">
	</div>
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
	<div class="ideas">
		<div class="abtestMake">
			<button>abtest만들기</button>
		</div>
		<c:forEach var="test" items="${abTests}">
			<div
				class="idea ${test.participated ? 'idea-complete' : 'idea-incomplete'} active"
				onclick="redirectToDetail(${test.ABTestID}, '${test.participated ? 'complete' : 'incomplete'}')"
				data-status="${test.participated ? 'complete' : 'incomplete'}">
				<div class="idea-left">
					<h3>${test.testName}</h3>
					<br>
				</div>
				<div class="idea-right">
					<div class="idea-status">${test.participated ? '완료' : '미완료'}
					</div>
				</div>
			</div>
		</c:forEach>
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
    var ideas = document.querySelectorAll('.idea');

    ideas.forEach(function(idea) {
        if ((showIncomplete && idea.classList.contains('idea-incomplete')) ||
            (showComplete && idea.classList.contains('idea-complete'))) {
            idea.style.display = '';
        } else {
            idea.style.display = 'none';
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
