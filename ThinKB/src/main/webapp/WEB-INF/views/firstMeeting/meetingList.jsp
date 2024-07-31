<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - 회의방 목록</title>
<style>
body {
	font-family: Arial, sans-serif;
}

.content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 150px;
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
	font-size: 22pt;
}

/* <style> 태그 안에 다음 CSS를 추가하세요 */
.progress input[type="checkbox"] {
	appearance: none;
	-webkit-appearance: none;
	width: 20px;
	height: 20px;
	border: 2px solid #ccc;
	border-radius: 4px;
	outline: none;
	transition: all 0.3s;
	cursor: pointer;
	position: relative;
	margin-right: 10px;
}

.progress input[type="checkbox"]:checked {
	background-color: #FFCC00; /* 체크된 상태의 배경색 */
	border-color: #FFCC00; /* 체크된 상태의 테두리 색 */
}

.progress input[type="checkbox"]:checked::before {
	content: '\2714'; /* 체크 표시 */
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	color: white; /* 체크 표시 색상 */
	font-size: 14px;
}

.progress label {
	display: flex;
	align-items: center;
	cursor: pointer;
}

.ideas {
	margin: 70px 20px;
}

.idea {
	padding: 20px;
	border-radius: 20px;
	margin-top: 30px;
	margin-left: auto;
	margin-right: auto;
	/* border: 1px solid #ccc; */
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	font-size: 1.2em;
	width: 80%;
	cursor: pointer;
	transition: box-shadow 0.3s ease, background-color 0.3s ease;
}

.idea-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 100%;
}

.idea-icon {
	margin-right: 10px;
	margin-left: 30px;
	font-size: 24pt;
	flex-shrink: 0;
}

h2 {
	display: flex;
	align-items: center;
	margin: 0;
	padding: 0;
	font-size: 1.5em;
	width: calc(100% - 30px); /* next-icon의 너비와 여백을 고려 */
	overflow: hidden;
}

.next-icon {
	width: 15px;
	height: auto;
	margin-left: 15px;
	margin-right: 30px;
	flex-shrink: 0;
}

.room-title {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	flex-grow: 1;
}

.idea:hover {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 커서를 대면 그림자 추가 */
}

.idea[data-stage="6"] {
	background-color: #f0f0f0;
}

.idea:not([data-stage="6"]) {
	background-color: #FFE297;
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
	margin: 0 50px 0 0;
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

.pagination {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.pagination a {
	color: black;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	transition: background-color .3s;
	border: 1px solid #ddd;
	margin: 0 4px;
}

.pagination a.active {
	background-color: #ffc107;
	color: white;
	border: 1px solid #ffc107;
}

.pagination a:hover:not(.active) {
	background-color: #ddd;
}
</style>
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>

	<div class="content">
		<!-- 회의방 만들기 버튼 영역 -->
		<div class="button-container">
			<button class="grey-button" onclick="location.href='./newIdeaRoom'">+
				아이디어 회의방 만들기</button>
		</div>

		<!-- 회의방 조회 탭 -->
		<div class="progress-header-container">
			<h2 class="progress-header">회의방 단계별 조회</h2>
		</div>
		<div class="progress-container">
			<div class="progress">
				<label><input type="checkbox" data-stage="1"
					onchange="filterIdeas()"> 아이디어 초안</label> <label><input
					type="checkbox" data-stage="2" onchange="filterIdeas()"> 투표
					진행</label> <label><input type="checkbox" data-stage="3"
					onchange="filterIdeas()"> 1차 의견</label> <label><input
					type="checkbox" data-stage="4" onchange="filterIdeas()">
					2차의견</label> <label><input type="checkbox" data-stage="5"
					onchange="filterIdeas()"> 보고서작성</label> <label><input
					type="checkbox" data-stage="6" onchange="filterIdeas()"> 완료</label>
			</div>
		</div>

		<!-- 회의방 목록 -->
		<div class="ideas">
			<%-- <<<<<<< HEAD

=======
			<c:choose>
				<c:when test="${empty roomList}">
					<div class="no-room">
						<img src="./resources/noContents.png" alt="no Contents"
							style="width: 100px; height: auto; margin-bottom: 10px;">
						<div class="contents">참여했던 회의방이 없어요.</div>
						<div class="contents">아이디어 회의방 만들기를 통해 아이디어를 쉽게 도출해보세요!</div>
					</div>
				</c:when>
>>>>>>> refs/heads/main

<<<<<<< HEAD --%>
			<c:forEach var="li" items="${roomList}">
				<div class="idea" data-stage="${li.getStageId()}"
					<c:if test="${li.getStageId() >= 3}">
                <c:set var="ideasList" value="${roomIdeasMap[li.roomId]}" />
                <c:forEach var="idea" items="${ideasList}">
                    onclick="window.location.href='./roomDetail?roomId=${li.getRoomId()}&stage=${li.getStageId()}&ideaId=${idea.getIdeaID()}'"
                </c:forEach>
            </c:if>
					<c:if test="${li.getStageId() < 3}">
                onclick="window.location.href='./roomDetail?roomId=${li.getRoomId()}&stage=${li.getStageId()}'"
            </c:if>>
					<div class="idea-header">
						<h2>
							<span class="idea-icon">📝</span> <span class="room-title">${li.getRoomTitle()}</span>
						</h2>
						<img src="./resources/nextIcon.png" alt="더 보기" class="next-icon">
					</div>
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
								<c:when test="${li.getStageId() == 4}">2차 의견 작성중</c:when>
								<c:when test="${li.getStageId() == 5}">최종보고서 작성중</c:when>
								<c:when test="${li.getStageId() == 6}">아이디어 회의 완료</c:when>
							</c:choose>
						</p>
						<c:if test="${li.getStageId() >= 3}">
							<c:set var="ideasList" value="${roomIdeasMap[li.roomId]}" />
							<c:forEach var="idea" items="${ideasList}">
								<input type="hidden" name="ideaId" value="${idea.getIdeaID()}" />
							</c:forEach>
						</c:if>
					</div>
					</div>
			</c:forEach>

			<div class="no-room" style="display: none;">
				<img src="./resources/noContent.png" alt="no Contents"
					style="width: 100px; height: auto; margin-bottom: 10px;">
				<div class="contents">선택한 단계의 회의방이 없어요.</div>
				<div class="contents">다른 단계를 선택하거나 새로운 회의방을 만들어보세요!</div>
			</div>

			<%-- =======
				<c:otherwise>
					<c:forEach var="li" items="${roomList}">
						<div class="idea" data-stage="${li.getStageId()}"
							<c:if test="${li.getStageId() >= 3}">
                <c:set var="ideasList" value="${roomIdeasMap[li.roomId]}" />
                <c:forEach var="idea" items="${ideasList}">
                    onclick="window.location.href='./roomDetail?roomId=${li.getRoomId()}&stage=${li.getStageId()}&ideaId=${idea.getIdeaID()}'"
                </c:forEach>
            </c:if>
							<c:if test="${li.getStageId() < 3}">
                onclick="window.location.href='./roomDetail?roomId=${li.getRoomId()}&stage=${li.getStageId()}'"
            </c:if>>
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
										<c:when test="${li.getStageId() == 4}">2차 의견 작성중</c:when>
										<c:when test="${li.getStageId() == 5}">최종보고서 작성중</c:when>
										<c:when test="${li.getStageId() == 6}">아이디어 회의 완료</c:when>
									</c:choose>
								</p>
								<c:if test="${li.getStageId() >= 3}">
									<c:set var="ideasList" value="${roomIdeasMap[li.roomId]}" />
									<c:forEach var="idea" items="${ideasList}">
										<input type="hidden" name="ideaId" value="${idea.getIdeaID()}" />
									</c:forEach>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>

			</c:choose>
>>>>>>> refs/heads/main --%>


		</div>

		<!-- 페이지네이션 추가 -->
		<div class="pagination">
			<c:if test="${currentPage > 1}">
				<a href="?page=${currentPage - 1}">&laquo; 이전</a>
			</c:if>

			<c:forEach begin="1" end="${totalPages}" var="i">
				<c:choose>
					<c:when test="${currentPage eq i}">
						<a class="active" href="#">${i}</a>
					</c:when>
					<c:otherwise>
						<a href="?page=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:if test="${currentPage < totalPages}">
				<a href="?page=${currentPage + 1}">다음 &raquo;</a>
			</c:if>

		</div>
</body>

<script>
function filterIdeas() {
    var checkboxes = document.querySelectorAll('.progress input:checked');
    var ideas = document.querySelectorAll('.idea');
    var anyVisible = false;

    if (checkboxes.length === 0) {
        // 체크된 박스가 없으면 모든 아이디어를 표시
        ideas.forEach(function(idea) {
            idea.style.display = 'flex';
        });
        anyVisible = true;
    } else {
        ideas.forEach(function(idea) {
            var ideaStage = idea.getAttribute('data-stage');
            var shouldShow = Array.from(checkboxes).some(function(checkbox) {
                return checkbox.getAttribute('data-stage') === ideaStage;
            });
            idea.style.display = shouldShow ? 'flex' : 'none';
            if (shouldShow) anyVisible = true;
        });
    }

    // 표시할 아이디어가 없는 경우 메시지 표시
    var noRoomMessage = document.querySelector('.no-room');
    if (noRoomMessage) {
        noRoomMessage.style.display = anyVisible ? 'none' : 'flex';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    var checkboxes = document.querySelectorAll('.progress input[type="checkbox"]');
    checkboxes.forEach(function(checkbox) {
        checkbox.addEventListener('change', filterIdeas);
    });
    // 페이지 로드 시 초기 필터링 적용
    filterIdeas();
});
</script>
</html>