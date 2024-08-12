<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThinkKB</title>
<style>
/* 스타일 정의 */
html, body {
    max-width: 100%;
    overflow-x: hidden;
}
.vote-body {
	font-family: Arial, sans-serif;
}

.vote-banner {
	margin-top: 45px;
	margin-left: 15%;
	margin-right: 15%;
}

.vote-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
}

/* 투표만들기 버튼 */
.vote-button-container {
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
}

.yellow-button:hover {
	background-color: #D4AA00;
}

.user-info p {
	margin: 0;
}

.progress-container {
	display: flex;
	justify-content: center;
	align-items: center;
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
}

.progress label {
	display: flex;
	align-items: center;
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
}

.progress-header {
	margin: 0;
	padding: 10px 0;
}

.ideas {
	margin: 70px 20px;
}

.idea {
	padding: 20px;
	background-color: #ffffff;
	border-radius: 20px;
	margin-top: 30px;
	margin-left: auto;
	margin-right: auto;
	border: 1px solid #ccc;
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	font-size: 1.2em;
	width: 80%;
	cursor: pointer;
	transition: box-shadow 0.3s ease;
}

.idea:hover {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 커서를 대면 그림자 추가 */
}

.idea h2 {
	margin: 0 0 10px 0;
	padding: 0;
	font-size: 1.5em;
	width: 100%;
}

.idea-details {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	text-align: right;
	width: 100%;
}

.idea-details p {
	margin: 0;
}

.idea-left {
	text-align: left;
}

.idea-right {
	text-align: right;
	align-self: flex-end;
	justify-content: flex-end;
	display: flex;
	flex-direction: column;
}

.no-room {
	display: flex;
	flex-direction: column;
	justify-content: center;
	background-color: white;
	border-radius: 20px;
	font-weight: bold;
	align-items: center;
	height: 300px;
	margin-bottom: 50px;
}

.no-room .contents {
	color: grey;
	font-size: 20px;
	text-align: center;
	margin-bottom: 10px;
}

.no-rooms .img {
	width: 100px; /* 이미지 너비 조정 */
	height: auto; /* 높이 자동 조정 */
	margin-bottom: 10px; /* 이미지와 텍스트 사이 여백 */
}

.add-option-btn {
	display: block;
	padding: 5px 10px;
	margin-top: 10px;
	background-color: #ffc107;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	float: right;
}

.add-option-btn:hover {
	background-color: #e0a800;
}
</style>
</head>

<body class="vote-body">
	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>
	
	<!-- 상단 배너영역 -->
	<div class="vote-banner">
		<img src="<c:url value='./resources/addVoteBanner.png'/>" alt="abtestBanner" 
		style="max-width: 100%; height: auto;">
	</div>
	
	<!-- 투표 만들기 버튼 -->
	<div class="vote-button-container">
		<button class="yellow-button" onclick="location.href='./newVote'">+ 투표 만들기</button>
	</div>
	
	<!-- 콘텐츠 시작 -->	
	<div class="vote-content">
	
	<!-- 상단 단계별 조회 -->
	<div class="progress-header-container">
		<h2 class="progress-header">진행중인 단계</h2>
	</div>

		<div class="progress-container">
			<div class="progress">
				<label><input type="checkbox" data-stage="false"
					onchange="filterIdeas()"> 투표 진행 중 </label> <label><input
					type="checkbox" data-stage="true" onchange="filterIdeas()">
					투표 종료 </label>
			</div>
		</div>

		<div class="ideas">
			<c:choose>
				<c:when test="${empty voteList}">
					<div class="no-room">
						<img src="./resources/noContents.png" alt="no Contents"
							style="width: 100px; height: auto; margin-bottom: 10px;">
						<div class="contents">참여했던 투표가 없어요.</div>
						<div class="contents">투표를 시작해서 의견을 모아보세요!</div>
					</div>
				</c:when>

			<c:otherwise>
				<c:forEach var="li" items="${voteList}">
					<div class="idea" data-stage="${li.isCompleted}"
						onclick="window.location.href='./addVote?addVoteId=${li.addVoteId}'">
						<h2>${li.title}</h2>
						<div class="idea-details">
							<p>종료일: ${li.endDate}</p>
							<p>투표 생성자: ${li.createUserID}</p>
							<p>
								단계:
								<c:choose>
									<c:when test="${li.isCompleted == false}">투표 진행 중 </c:when>
									<c:when test="${li.isCompleted == true}">투표 종료 </c:when>
								</c:choose>
							</p>
							<p>
								<c:choose>
									<c:when test="${li.votedOptionId != 0}">
										<span style="color: green;">투표 완료</span>
									</c:when>
									<c:otherwise>
										<span style="color: red;">미투표</span>
									</c:otherwise>
								</c:choose>
							</p>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
		
		
	
	</div>
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
					idea.style.display = 'flex';
				});
			} else {
				ideas.forEach(function(idea) {
					idea.style.display = 'none';
				});

				checkboxes.forEach(function(checkbox) {
					if (checkbox.checked) {
						var stages = checkbox.getAttribute('data-stage').split(
								',');
						ideas.forEach(function(idea) {
							var ideaStage = idea.getAttribute('data-stage');
							if (stages.includes(ideaStage)) {
								idea.style.display = 'flex';
							}
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
</body>
</html>
