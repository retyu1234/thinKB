<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThinkKB</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
}

.container {
	width: 80%;
	margin: 0 auto;
	background-color: white;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.header1 {
	text-align: center;
}

.header1 img {
	width: 100%;
	height: auto;
	max-height: 500px;
	/* border-radius: 10px; */
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
	justify-content: flex-start; /* 전체 컨테이너에서 왼쪽 정렬 */
}

.progress label {
	display: flex;
	align-items: center;
	margin-left: 40px; /* 레이블 간의 간격 조정 */
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
/*  */

.ideas {
	margin: 70px 20px;
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
	justify-content: space-between;
	align-items: center;
	font-size: 1.2em; /* 글자 크기를 키움 */
}

.idea h3, .idea p {
	margin: 0;
}

.idea-left {
	text-align: left;
}

.idea-right {
    display: flex;
    justify-content: center; /* 세로로 가운데 정렬 */
    align-items: flex-end;
    flex-direction: column;
}

/* 완료/미완료 버튼 */
.idea-right button {
    font-size: 1em;
    padding: 10px 20px;
    border-radius: 20px;
    border: none;
    cursor: pointer;
    margin-right: 50px;
    width: 200px; /* 버튼 크기를 동일하게 유지 */
    text-align: center;
}

.idea-right button.complete {
	background-color: #d3d3d3; /* 연한 회색 */
	color: black;
}

.idea-right button.incomplete {
	background-color: #ffc107; /* 노란색 */
	color: black;
}

.idea-right button.incomplete:hover {
	background-color: #e0a800;
}

/* 테스트 생성 버튼 */
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

</style>
</head>

<body>
	<%@ include file="../header.jsp"%>
	<div class="header1">
		<img src="./resources/header2.jpg" alt="Header Image">
	</div>
	<div class="progress-header-container">
		<h2 class="progress-header">진행중인 단계</h2>
	</div>
	<div class="progress-container">
		<div class="progress">
			<label><input type="checkbox" data-stage="draft" onchange="filterIdeas()">미완료</label> 
			<label><input type="checkbox" data-stage="first-review" onchange="filterIdeas()">완료</label> 
		</div>
	</div>
	<div class="ideas">
		<div class="idea first-review active">
			<div class="idea-left">
				<h3>A/B테스트 제목 1</h3>
				<br>
				<p>ESG팀</p>
			</div>
			<div class="idea-right">
				<button class="incomplete">미완료</button>
			</div>
		</div>
		<div class="idea draft active">
			<div class="idea-left">
				<h3>A/B테스트 제목 2</h3>
				<br>
				<p>ESG팀</p>
			</div>
			<div class="idea-right">
				<button class="complete">완료</button>
			</div>
		</div>
	</div>
	<div class="vote-button-container">
		<button class="vote-button">테스트 생성</button>
	</div>
</body>

<script>
	function filterIdeas() {
		var checkboxes = document.querySelectorAll('.progress input');
		var ideas = document.querySelectorAll('.idea');
		var anyChecked = false;

		checkboxes.forEach(function(checkbox) {
			if (checkbox.checked) {
				anyChecked = true;
			}
		});

		if (!anyChecked) {
			ideas.forEach(function(idea) {
				idea.style.display = 'flex'; // 모든 아이디어를 기본적으로 보이도록 설정
			});
		} else {
			ideas.forEach(function(idea) {
				idea.style.display = 'none'; // 기본적으로 숨김 처리
			});

			checkboxes.forEach(function(checkbox) {
				if (checkbox.checked) {
					var stage = checkbox.getAttribute('data-stage');
					var matchingIdeas = document.querySelectorAll('.idea.'
							+ stage);
					matchingIdeas.forEach(function(idea) {
						idea.style.display = 'flex'; // 해당하는 아이디어만 보이도록 설정
					});
				}
			});
		}
	}

	document.addEventListener('DOMContentLoaded', function() {
		var checkboxes = document.querySelectorAll('.progress input');
		checkboxes.forEach(function(checkbox) {
			checkbox.addEventListener('change', filterIdeas);
		});
		filterIdeas();
	});
</script>
</html>