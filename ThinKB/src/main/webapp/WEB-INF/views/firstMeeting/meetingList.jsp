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

.content {
	padding: 20px;
	margin-left: 15%;
	margin-right: 15%;
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
</style>
</head>

<body>
	<%@ include file="../header.jsp"%>
	<div class="header1">
		<img src="./resources/header2.jpg" alt="Header Image">
	</div>
	<div class="content">
		<div class="button-container">
			<button class="yellow-button" onclick="location.href='./newIdeaRoom'">+
				아이디어 회의방 만들기</button>
		</div>
		<div class="progress-header-container">
			<h2 class="progress-header">진행중인 단계</h2>
		</div>
		<div class="progress-container">
			<div class="progress">
				<!-- data-stage 수정 필요 이 부분 수정이 필요해. 체크박스를 눌렀을 때 해당 단계인 아이디어만 보여지게 하는건 맞지만, 이후 데이터베이스에서 반복문을 통해 데이터를 가져올거기 때문에 지금 코드처럼  data-stage="draft" 이렇게 작성하면 안돼. 재사용 가능하도록 수정하고싶어-->
				<label><input type="checkbox" data-stage="1,2"
					onchange="filterIdeas()"> 아이디어 초안</label> <label><input
					type="checkbox" data-stage="3,4" onchange="filterIdeas()">
					1차 의견</label> <label><input type="checkbox" data-stage="5,6"
					onchange="filterIdeas()"> 2차 의견</label> <label><input
					type="checkbox" data-stage="7" onchange="filterIdeas()">
					보고서 작성</label> <label><input type="checkbox" data-stage="8"
					onchange="filterIdeas()"> 완료</label>
			</div>
		</div>

		<div class="ideas">

			<c:choose>
				<c:when test="${empty roomList}">
					<div class="no-room">
						<img src="./resources/noContents.png" alt="no Contents"
							style="width: 100px; height: auto; margin-bottom: 10px;">
						<div class="contents">참여했던 회의방이 없어요.</div>
						<div class="contents">아이디어 회의방 만들기를 통해 아이디어를 쉽게 도출해보세요!</div>
					</div>
				</c:when>

				<c:otherwise>
					<c:forEach var="li" items="${roomList}">
						<div class="idea" data-stage="${li.getStageId()}"
							onclick="window.location.href='./roomDetail?roomId=${li.getRoomId()}&stage=${li.getStageId()}'">
							<h2>${li.getRoomTitle()}</h2>
							<div class="idea-details">
								<p>종료일: ${li.getEndDate()}</p>
								<p>
									주최 팀명:
									<c:forEach var="team" items="${teamInfo}">
										<c:if test="${team.getTeamId() == li.getTeamId()}">
                                ${team.getTeamName()}
                            </c:if>
									</c:forEach>
								</p>
								<p>
									단계:
									<c:choose>
										<c:when test="${li.getStageId() == 1}">아이디어 초안 작성중</c:when>
										<c:when test="${li.getStageId() == 2}">아이디어 투표 진행중</c:when>
										<c:when test="${li.getStageId() == 3}">1차 의견 작성중</c:when>
										<c:when test="${li.getStageId() == 4}">1차 의견 투표중</c:when>
										<c:when test="${li.getStageId() == 5}">2차 의견 작성중</c:when>
										<c:when test="${li.getStageId() == 6}">2차 의견 투표중</c:when>
										<c:when test="${li.getStageId() == 7}">최종보고서 작성중</c:when>
										<c:when test="${li.getStageId() == 8}">아이디어 회의 완료</c:when>
									</c:choose>
								</p>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>


		</div>
		<!-- <div class="ideas">
		<div class="idea first-review active">
			<div class="idea-left">
				<h3>회의방 제목 1</h3>
				<br>
				<p>ESG팀</p>
			</div>
			<div class="idea-right">
				<p>1차의견</p>
				<p>2024.01.01 까지</p>
			</div>
		</div>
		<div class="idea draft active">
			<div class="idea-left">
				<h3>회의방 제목 2</h3>
				<br>
				<p>ESG팀</p>
			</div>
			<div class="idea-right">
				<p>초안작성</p>
				<p>2024.01.01 까지</p>
			</div>
		</div>
		</div> -->
		<!-- 더 많은 아이디어를 여기에 추가할 수 있습니다 -->
	</div>
	<script>
		function createMeetingRoom() {
			// 회의방 만들기 기능 구현
			alert("회의방 만들기 기능은 구현되지 않았습니다.");
		}
	</script>
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
				idea.style.display = 'flex';
			});
		} else {
			ideas.forEach(function(idea) {
				idea.style.display = 'none';
			});

			checkboxes
					.forEach(function(checkbox) {
						if (checkbox.checked) {
							var stages = checkbox.getAttribute('data-stage')
									.split(',');
							ideas
									.forEach(function(idea) {
										var ideaStage = idea
												.getAttribute('data-stage');
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
</html>