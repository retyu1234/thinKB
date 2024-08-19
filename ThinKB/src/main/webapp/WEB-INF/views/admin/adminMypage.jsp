<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<meta charset="UTF-8">
<title>부서 현황</title>
<style>
.adminMypage-body {
	font-family: KB금융 본문체 Light;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
	display: flex;
	caret-color: transparent;
}

.adminMypageContainer {
	padding-top: 30px;
	width: 100%;
	margin : 0% 10% 6% 20%;
	flex: 1;
}

.userAdmin-title { font-size: 18pt;  font-weight: bold; color: #333; margin-bottom: 20px; display: flex; align-items: center;}
.back2 {width: 30px; height: auto;  margin-right: 20px; margin-top: 10px;}
.userAdmin-line {margin-bottom: 50px; border-bottom: 1px solid #ddd;}

.profile-section {
	text-align: left;
	margin-bottom: 5%;
}

.profile-pic-container {
	position: relative;
	display: inline-block;
}

.profile-pic {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	object-fit: cover;
	border: 5px solid #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	display: block;
}

.profile-span {
	font-size: 18pt;
	font-weight: bold;
	margin-left: 3%;
}

.change-pic-btn {
	border: none;
	text-align: center;
	text-decoration: none;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
	transition: opacity 0.3s;
	position: absolute;
	bottom: 1%;
	right: -3%;
	font-size: 30px;
	background-color: transparent;
	color: #ffffff;
	text-shadow: 0px 0px 3px rgba(0, 0, 0, 0.5);
}

.change-pic-btn:hover {
	opacity: 0.7;
}

.card-container {
	display: flex;
	justify-content: space-between;
	margin-bottom: 3%;
}

.card {
	border: 1px solid #ddd;
	border-radius: 10px;
	width: 30%;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	margin: 1%;
}

.card h3 {
	margin-bottom: 20px;
	font-size: 18pt;
}

.card p {
	font-size: 16pt;
}

.badge-mileage-container {
	display: flex;
	justify-content: space-between;
	margin-bottom: 5%;
}

.badge {
	width: 48%;
	text-align: left;
}

.mileage {
	width: 48%;
	text-align: left;
	border-radius: 10px;
	padding: 20px;
}

.mileage-content {
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 20px 0;
}

.mileage-icon {
	font-size: 48px;
	color: #FFD700;
	margin-right: 20px;
}

.mileage-text {
	font-size: 16px;
	line-height: 1.5;
}

.mileage-points {
	font-size: 24px;
	font-weight: bold;
	color: #60584C;
}

.mileage-history {
	text-align: right;
	margin-top: 10px;
}

.mileage-history a {
	color: #007bff;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
}

.mileage-history a:hover {
	text-decoration: underline;
}

.mileage-history i {
	margin-left: 5px;
}

.mypage-title-p {
	font-family: KB금융 제목체 Light;
	font-size: 15pt;
	font-weight: bold;
}

.mypageUserTable {
	width: 100%;
	border-collapse: collapse;
	caret-color: transparent;
}

.mypageUserTable th, td {
	padding: 12px;
	text-align: left;
}

.mypageUserTable th {
	font-weight: bold;
	width: 30%;
	padding-left: 3%;
	border: none; /* 테두리 없애기 */
	border-radius: 10px;
}

.mypageUserTable tr:nth-child(odd) th, .mypageUserTable tr:nth-child(odd) td
	{
	background-color: #FFFFE4; /* 홀수 줄 배경색 */
}

.mypageUserTable tr:nth-child(even) th, .mypageUserTable tr:nth-child(even) td
	{
	background-color: #ffffff; /* 짝수 줄 배경색 */
}

.mypageUserTable tr {
	border: none; /* 테두리 없애기 */
	border-radius: 10px;
}


#profileUploadModal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
}

.mypageModal-content {
	background-color: #fefefe;
	margin: 5% auto; /* 상단 여백을 줄임 */
	padding: 20px;
	border: 1px solid #888;
	width: 100%;
	max-width: 700px;
	max-height: 80vh; /* 뷰포트 높이의 80%로 제한 */
	border-radius: 8px;
	overflow-y: auto; /* 세로 스크롤 추가 */
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

#mileageTable {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	border-radius: 25px;
}

#mileageTable th {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

#mileageTable td {
	padding: 12px;
	border-bottom: 1px solid #ddd;
}

#mileageTable th {
	background-color: #AB9A80;
	color: white;
}

#mileageTable tr:hover {
	background-color: #f5f5f5;
}

#mileageTable th:first-child, #mileageTable td:first-child {
	width: 70%; /* 회의 제목 열 */
	text-align: left;
}

#mileageTable td:first-child {
	padding-left: 15px;
}

#mileageTable th:last-child {
	width: 30%; /* 마일리지 점수 열 */
	text-align: left;
}

#mileageTable td:last-child {
	width: 30%;
	text-align: left;
	padding-left: 30px;
}

.search-sort-container {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 10px;
	position: relative;
}

#searchInput {
	width: 50%;
	padding: 10px 30px 10px 10px;
	font-size: 11pt;
	border-radius: 20px;
}

.search-icon {
	position: absolute;
	right: 10px;
	top: 50%;
	transform: translateY(-50%);
	color: #888; /* 아이콘 색상 */
	pointer-events: none; /* 아이콘이 클릭되지 않도록 */
}

.sort-buttons {
	display: flex;
}

.sort-button {
	background: none;
	border: none;
	cursor: pointer;
	padding: 0 5px;
	font-size: 12pt;
	color: white;
}

.sort-button:focus {
	outline: none;
}

.mypagePagination {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.mypagePagination button {
	margin: 0 5px;
	padding: 5px 10px;
	cursor: pointer;
	background-color: transparent;
	font-size: 11pt;
	border: none;
}

.mypagePagination button.active {
	background-color: #ffcc00;
	color: white;
	font-weight: bold;
	border: none;
	border-radius: 30px;
}

.file-upload-container {
	text-align: center;
	margin-bottom: 20px;
}

.file-upload-label {
	display: inline-block;
	padding: 10px 20px;
	background-color: #978A8F;
	color: white;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.file-upload-label:hover {
	background-color: #60584C;
}

#profileImgInput {
	display: none;
}

.image-preview {
	width: 200px;
	height: 200px;
	border-radius: 50%;
	margin: 20px auto;
	overflow: hidden;
	display: block;
}

.image-preview img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.button-container {
	display: flex;
	justify-content: center;
	margin-top: 20px;
	gap: 3%;
}

.upload-btn, .reset-btn {
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.upload-btn {
	background-color: #FFCC00;
	color: white;
}

.upload-btn:hover {
	background-color: #D4AA00;
}

.reset-btn {
	background-color: #6c757d;
	color: white;
}

.reset-btn:hover {
	background-color: #5a6268;
}
/* 세번째 줄 */
.best-sections-wrapper {
	display: flex;
	justify-content: space-between;
	margin-top: 40px;
}

.best-section {
	flex: 1;
	background-color: #ffffff;
	border-radius: 30px;
	padding: 20px;
	margin: 0 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.best-content {
	display: flex;
	justify-content: space-around;
	margin-top: 40px;
}

.best-item {
	text-align: center;
	margin: 0 5px;
}

.section-header {
	display: flex;
	justify-content: start;
	align-items: center;
	margin-bottom: 10px;
}

.section-title {
	font-family: KB금융 제목체 Light;
	font-size: 20pt;
	font-weight: bold;
	color: black;
}


.profile-image {
	width: 100%;
	height: 100%;
	border-radius: 50%;
	object-fit: cover;
}

.medal {
	position: absolute;
	bottom: -2px;
	left: -3px;
	width: 20px;
	height: 30px;
}

.best-name {
	font-size: 16px;
	font-weight: bold;
	margin-bottom: 5px;
}

.best-description {
	font-size: 12px;
	color: #666;
}

.adminReport-content {
	max-height: 300px;
	overflow-y: auto;
}

.adminReport-list {
	list-style-type: none;
	padding: 0;
}

.adminReport-list li {
	margin-bottom: 10px;
	padding: 10px;
	background-color: #f8f9fa;
	border-radius: 5px;
}

.adminReport-title {
	font-weight: bold;
}

.adminReport-status, .adminReport-date {
	float: right;
	font-size: 0.9em;
	color: #6c757d;
}

.adminReport-author {
	font-size: 0.9em;
	color: #6c757d;
	margin-left: 10px;
}

.no-reports {
	text-align: center;
	color: #6c757d;
	background-color: #EAEAEA;
	width: 100%;
	height: auto;
	min-height: 100px;
	align-content: center;
	border-radius: 10px;
}

.team-icon {
	font-size: 30px;
}

.profile-container {
	position: relative;
	width: 60px;
	height: 60px;
	margin: 0 auto 10px;
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #f8f9fa;
	border-radius: 50%;
}

.rank-number {
	position: absolute;
	top: -5px;
	left: -5px;
	width: 25px;
	height: 25px;
	background-color: #007bff;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	font-weight: bold;
	font-size: 14px;
	color: #ffffff;
}

.gold {
	color: #FFD700;
}

.silver {
	color: #C0C0C0;
}

.bronze {
	color: #CD7F32;
}
    /* 더보기 버튼 */
    .more-button { 
		border: none;
		background-color: transparent; /* 배경색 제거 */
		align-items: center;
		cursor: pointer;
		font-size: 9pt;
		color: #007AFF;
		margin-top: 10px;
	}
	.more-button:hover {
		color: #0056B3;
	}
</style>
<script>
function openModal(modalId) {
    document.getElementById(modalId).style.display = 'block';
}

function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

// 창 외부 클릭 시 모달 닫기
window.onclick = function(event) {
    if (event.target.className === 'mypageModal') {
        event.target.style.display = "none";
    }
}
</script>
</head>
<body style="margin: 0;">
	<div class="adminMypage-body">
		<%@ include file="../adminSideBar.jsp"%>
		<div class="adminMypageContainer">
			<div class="userAdmin-title">
				<a href="./adminMain"><img src="./resources/back2.png" alt="back2" class="back2"></a>
				<span>thinKB-부서 현황</span>
			</div>
			<hr class="userAdmin-line">
			
			<p class="mypage-title-p">부서 회의방 현황</p>
			<div class="card-container">

				<div class="card">
					<h3>${MeetingRoomStats.ongoingMeetings}개</h3>
					<p>🕜진행중인 회의</p>
				</div>
				<div class="card">
					<h3>${MeetingRoomStats.completedMeetings}개</h3>
					<p>🫛완료된 회의</p>
				</div>
				<div class="card">
					<h3>${MeetingRoomStats.totalMeetings}개</h3>
					<p>🅰️전체 회의</p>
				</div>
			</div>

			<!-- 3번째 줄 -->
			<div class="best-sections-wrapper">
				<div class="best-section">
					<div class="section-header">
						<div class="section-title" style="font-size: 15pt;">🏆 베스트
							직원</div>
						
					</div>
					<div class="best-content">
						<c:forEach var="employee" items="${bestEmployees}"
							varStatus="status">
							<div class="best-item">
								<div class="profile-container">
									<c:url var="profileImgUrl"
										value="/upload/${employee.profileImg}" />
									<img src="${profileImgUrl}" alt="${employee.userName}"
										class="profile-image">

									<c:choose>
										<c:when test="${status.index == 0}">
											<img src="<c:url value='/resources/gold-medal.png' />"
												alt="금메달" class="medal">
										</c:when>
										<c:when test="${status.index == 1}">
											<img src="<c:url value='/resources/silver-medal.png' />"
												alt="은메달" class="medal">
										</c:when>
										<c:otherwise>
											<img src="<c:url value='/resources/bronze-medal.png' />"
												alt="동메달" class="medal">
										</c:otherwise>
									</c:choose>

								</div>
								<p class="best-name">${employee.userName}</p>
								<p class="best-description">기여도:
									${employee.totalContribution}</p>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="best-section">
					<div class="section-header">
						<div class="section-title" style="font-size: 15pt;">📈 베스트
							사용량</div>
					</div>
					<div class="best-content">
						<c:forEach var="usage" items="${bestUsage}" varStatus="status">
							<div class="best-item">
								<div class="profile-container">
									<img
										src="<c:url value='/resources/department${status.index + 1}.png' />"
										alt="${usage.teamName}" class="profile-image">
								</div>
								<p class="best-name">${usage.teamName}</p>
								<p class="best-description">사용 횟수: ${usage.teamCount}</p>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="best-section">
					<div class="section-header">
						<div class="section-title" style="font-size: 15pt;">👥 베스트 팀</div>
					</div>
					<div class="best-content">
						<c:set var="prevRank" value="0" />
						<c:set var="displayRank" value="0" />
						<c:forEach var="team" items="${bestTeams}" varStatus="status">
							<c:choose>
								<c:when test="${team.teamRank > prevRank}">
									<c:set var="displayRank" value="${team.teamRank}" />
								</c:when>
								<c:otherwise>
									<c:set var="displayRank" value="${prevRank}" />
								</c:otherwise>
							</c:choose>
							<div class="best-item">
								<div class="profile-container">
									<span class="rank-number">${displayRank}</span>
									<c:choose>
										<c:when test="${displayRank == 1}">
											<i class="fas fa-trophy team-icon gold"></i>
										</c:when>
										<c:when test="${displayRank == 2}">
											<i class="fas fa-award team-icon silver"></i>
										</c:when>
										<c:otherwise>
											<i class="fas fa-medal team-icon bronze"></i>
										</c:otherwise>
									</c:choose>
								</div>
								<p class="best-name">${team.teamName}</p>
								<p class="best-description">${team.departmentName}</p>
								<p class="best-description">
									채택률:
									<fmt:formatNumber value="${team.teamAdoptionPercentage}"
										pattern="#,##0.0" />
									%
								</p>
							</div>
							<c:set var="prevRank" value="${team.teamRank}" />
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="best-sections-wrapper" style="margin-bottom: 5%;">
				<div class="best-section">
					<div class="section-header">
						<div class="section-title" style="font-size: 15pt;">📊 오늘의
							결재내역</div><button class="more-button" onclick="location.href='./departmentReportList'">+ 더보기</button>
					</div>
					<div class="adminReport-content">
						<c:choose>
							<c:when test="${not empty todayReports}">
								<ul class="adminReport-list">
									<c:forEach var="report" items="${todayReports}">
										<li><span class="adminReport-title">${report.reportTitle}</span>
											<span class="adminReport-status"> <c:choose>
                                <c:when test="${report.isChoice == null}">결재대기</c:when>
                                <c:when test="${report.isChoice == 1}">채택</c:when>
                                <c:when test="${report.isChoice == 0}">미채택</c:when>
                                <c:otherwise>알 수 없음</c:otherwise>
												</c:choose>
										</span></li>
									</c:forEach>
								</ul>
							</c:when>
							<c:otherwise>
								<p class="no-reports">오늘 올라온 보고서가 없습니다.</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="best-section" >
					<div class="section-header">
						<div class="section-title" style="font-size: 15pt;">🏆 연간 채택
							아이디어</div><button class="more-button" onclick="location.href='./departmentReportList'">+ 더보기</button>
					</div>
					<div class="adminReport-content">
						<c:choose>
							<c:when test="${not empty yearlyAdoptedReports}">
								<ul class="adminReport-list">
									<c:forEach var="report" items="${yearlyAdoptedReports}">
										<li><span class="adminReport-title">${report.reportTitle}</span>
											<span class="adminReport-author">${report.authorName}
												(${report.authorId})</span> <span class="adminReport-date">${report.updatedAt}</span>
										</li>
									</c:forEach>
								</ul>
							</c:when>
							<c:otherwise>
								<p class="no-reports">올해 채택된 보고서가 없습니다.</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>

		</div>
	</div>

</body>
</html>
