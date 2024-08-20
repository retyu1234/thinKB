<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="currentDate" value="${now}" pattern="yyyy-MM-dd" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - 회의방 목록</title>
<style>
body {
	font-family: KB금융 본문체 Light;
}

.content-banner {
	margin-top: 50px;
	margin-left: 15%;
	margin-right: 15%;
	margin-bottom: 15px;
}

.meetingList-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
}

.container {
	width: 80%;
	margin: 0 auto;
	background-color: white;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
/* 상단 회의방 만들기 버튼 */
.button-container {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 10px;
}

.progress-container {
	display: flex;
	justify-content: center;
	align-items: center;
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
	font-size: 11pt;
	font-family: KB금융 본문체 Light;
}

.progress label {
	display: flex;
	align-items: center;
}

.progress input {
	margin-right: 5px;
}

.progress-header-container {
	display: flex;
	justify-content: left;
	width: 80%;
	margin: 0 auto;
	margin-bottom: 20px;
}

.progress-header {
	margin: 0;
	padding: 10px 0;
	font-size: 18pt;
	font-family: KB금융 제목체 Light;
}

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
	background-color: #FFCC00;
	border-color: #FFCC00;
}

.progress input[type="checkbox"]:checked::before {
	content: '\2714';
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	color: white;
	font-size: 14px;
}

.progress label {
	display: flex;
	align-items: center;
	cursor: pointer;
}

/* 아이디어 회의방 목록 */
.ideas {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px 30px;
	padding: 10px;
	margin-top: 40px;
	margin-bottom: 50px;
}

.idea {
	background-color: #F1EFE5;
	border-radius: 20px;
	padding: 20px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
	cursor: pointer;
	transition: box-shadow 0.3s ease;
	height: 240px;
}

.idea:hover {
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.team-tag {
	align-self: flex-start;
	background-color: #FFD700;
	color: black;
	padding: 5px 10px;
	border-radius: 15px;
	font-size: 0.8em;
	margin-bottom: 10px;
	transition: all 0.3s ease;
}

.team-tag-active {
	background-color: #FFD700;
}

.team-tag-completed, .team-tag-overdue {
	background-color: #808080;
	color: #ffffff;
}
.idea[data-stage="6"] {
	background-color: #f0f0f0;
}

.idea[data-stage="6"] .team-tag {
	background-color: #808080;
	color: #ffffff;
}

.idea[data-stage="6"] .room-title, .idea[data-stage="6"] .stage, .idea[data-stage="6"] .end-date
	{
	color: #808080;
}

.room-title {
	text-align: center;
	font-weight: bold;
	margin: 5px 0;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
	font-size: 15pt;
	height: 3.6em;
	line-height: 1.8em;
	font-family: KB금융 제목체 Light;
}

.stage, .end-date {
	text-align: right;
	font-size: 13pt;
	margin-top: 10px;
	margin-right: 10px;
}

.stage {
	margin-top: auto;
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

.no-room {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	background-color: white;
	border-radius: 20px;
	font-weight: bold;
	height: 300px;
	width: 100%;
	margin: 0 auto;
	margin-bottom: 50px;
	text-align: center;
}

.no-room-contents {
	color: grey;
	font-size: 20px;
	text-align: center;
	margin-bottom: 10px;
	width: 100%;
}

.no-room-img {
	width: 150px;
	height: auto;
	margin-bottom: 10px;
	display: block;
	margin-left: auto;
	margin-right: auto;
}
/* 페이지네이션 */
.pagination {
	display: flex;
	justify-content: center;
	margin-top: 20px;
	margin-bottom: 120px;
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

.line-container {
	width: 100%;
	padding: 0 15px;
	box-sizing: border-box;
}

.line {
	border: none;
	border-top: 2px solid #ffc107;
	width: 100%;
	margin: 10px 0;
	transition: border-color 0.3s ease;
}

.idea[data-stage="6"] .line {
	border-top: 2px solid #808080;
}

/* 보고서 결재 상태 태그 */
.status-tag {
    align-self: flex-start;
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 0.8em;
    margin-bottom: 10px;
    margin-left: 10px;
    transition: all 0.3s ease;
}

.status-pending {
    background-color: #FFA500;
    color: white;
}

.status-rejected {
    background-color: #f0f0f0;
    color: white;
}

.status-accepted {
    background-color: #32CD32;
    color: white;
}

.tag-container {
    display: flex;
    justify-content: flex-start;
    align-items: center;
}
</style>
</head>

<body>
	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>

	<!-- 상단 배너영역 -->
	<div class="content-banner">
		<img src="<c:url value='./resources/roomListBanner.png'/>"
			alt="roomListBanner" style="max-width: 100%; height: auto;">
	</div>

	<div class="meetingList-content">
		<!-- 회의방 만들기 버튼 영역 -->
		<div class="button-container">
			<button class="yellow-button" onclick="location.href='./newIdeaRoom'">+
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
					<div class="tag-container">
					<div class="team-tag 
						<c:choose>
							<c:when test="${li.getStageId() == 6 || li.getEndDate() < currentDate}">
								team-tag-completed
							</c:when>
							<c:otherwise>
								team-tag-active
							</c:otherwise>
						</c:choose>
					">
						<c:choose>
							<c:when test="${li.getStageId() == 6}">
								완료
							</c:when>
							<c:when test="${li.getEndDate() < currentDate}">
								기한초과
							</c:when>
							<c:otherwise>
								진행중
							</c:otherwise>
						</c:choose>
					</div>
                    <c:forEach var="report" items="${reportsResult}">
                        <c:if test="${report.getRoomId() == li.getRoomId()}">
                            <div class="status-tag 
                                <c:choose>
                                    <c:when test="${report.getIsChoice() == -1}">status-pending</c:when>
	                                <c:when test="${report.getIsChoice() == 0}">status-rejected</c:when>
	                                <c:when test="${report.getIsChoice() == 1}">status-accepted</c:when>
	                                <c:otherwise>status-pending</c:otherwise>
                                </c:choose>">
                                <c:choose>
                                    <c:when test="${report.getIsChoice() == -1}">결재대기</c:when>
	                                <c:when test="${report.getIsChoice() == 0}">미채택</c:when>
	                                <c:when test="${report.getIsChoice() == 1}">채택</c:when>
	                                <c:otherwise>결재대기</c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
					<div class="room-title">${li.getRoomTitle()}</div>
					<div class="line-container">
						<hr class="line">
					</div>
					<div class="stage">
						<c:choose>
							<c:when test="${li.getStageId() == 1}">아이디어 초안 작성중</c:when>
							<c:when test="${li.getStageId() == 2}">아이디어 투표 진행중</c:when>
							<c:when test="${li.getStageId() == 3}">1차 의견 작성중</c:when>
							<c:when test="${li.getStageId() == 4}">2차 의견 작성중</c:when>
							<c:when test="${li.getStageId() == 5}">최종보고서 작성중</c:when>
							<c:when test="${li.getStageId() == 6}">아이디어 회의 완료</c:when>
						</c:choose>
					</div>
					<div class="end-date">
						<c:forEach var="team" items="${teamInfo}">
							<c:if test="${team.getTeamId() == li.getTeamId()}">
		                        ${team.getTeamName()} 주최
		                    </c:if>
						</c:forEach>
					</div>
					<div class="end-date">~ ${li.getEndDate()}</div>
					<c:if test="${li.getStageId() >= 3}">
						<c:set var="ideasList" value="${roomIdeasMap[li.roomId]}" />
						<c:forEach var="idea" items="${ideasList}">
							<input type="hidden" name="ideaId" value="${idea.getIdeaID()}" />
							<input type="hidden" name="stageId" value="${idea.getStageID()}" />
						</c:forEach>
					</c:if>
				</div>
			</c:forEach>
		</div>

		<!-- 회의방 없는경우 div따로 뺌 -->
		<div class="no-room" style="display: none;">
			<img class="no-room-img" src="./resources/noContent.png"
				alt="no Contents">
			<div class="no-room-contents">선택한 단계의 회의방이 없어요.</div>
			<div class="no-room-contents">다른 단계를 선택하거나 새로운 회의방을 만들어보세요!</div>
		</div>


		<!-- 페이지네이션 추가 -->
		<div class="pagination">
			<c:if test="${currentPage > 1}">
				<a href="?page=${currentPage - 1}">이전</a>
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
				<a href="?page=${currentPage + 1}">다음</a>
			</c:if>

		</div>
	</div>


<script>
function filterIdeas() {
	var checkboxes = document
			.querySelectorAll('.progress input:checked');
	var ideas = document.querySelectorAll('.idea');
	var anyVisible = false;

	if (checkboxes.length === 0) {
		// 체크된 박스가 없으면 전체 표시
		ideas.forEach(function(idea) {
			idea.style.display = 'flex';
		});
		anyVisible = true;
	} else {
		ideas
				.forEach(function(idea) {
					var ideaStage = idea.getAttribute('data-stage');
					var shouldShow = Array
							.from(checkboxes)
							.some(
									function(checkbox) {
										return checkbox
												.getAttribute('data-stage') === ideaStage;
									});
					idea.style.display = shouldShow ? 'flex' : 'none';
					if (shouldShow)
						anyVisible = true;
				});
	}

	// 표시할 아이디어가 없는 경우 메시지 표시
	var noRoomMessage = document.querySelector('.no-room');
	if (noRoomMessage) {
		noRoomMessage.style.display = anyVisible ? 'none' : 'flex';
	}
}

document.addEventListener('DOMContentLoaded', function() {
	var checkboxes = document
			.querySelectorAll('.progress input[type="checkbox"]');
	checkboxes.forEach(function(checkbox) {
		checkbox.addEventListener('change', filterIdeas);
	});
	// 페이지 로드 시 초기(아무것도 안선택된, 전체 나오는) 필터링 적용
	filterIdeas();
});
</script>

</body>
</html>