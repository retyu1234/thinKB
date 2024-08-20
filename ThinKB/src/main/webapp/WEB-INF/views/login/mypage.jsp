<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<meta charset="UTF-8">
<title>My Page</title>
<style>
.mypage-body {
	font-family: KB금융 본문체 Light;
	background-color: #ffffff;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	caret-color: transparent;
}

.mypageContainer {
	background-color: #ffffff;
	padding: 30px;
	width: 90%;
	margin-top: 0;
	margin-left: 17%;
	margin-right: 17%;
}

.myPageh1 {
	color: #333;
	text-align: left;
	margin-bottom: 30px;
}

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
	font-size: 20pt;
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

.mypageModal {
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
    gap:3%;
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
/* 물음표 버튼 스타일 */
        .info-button {
            background: none;
            border: 2px solid black;
            font-size: 16px;
            cursor: pointer;
            vertical-align: middle;
            color: black;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            padding: 0;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            line-height: 1;
            margin-left: 5px;
            transition: all 0.3s ease;
            font-family: KB금융 본문체 light;
            font-weight: bold;
            margin:5%;
        }

        .info-button:hover {
            background-color: #f0f0f0;
        }
        .level-info-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .level-info-modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 90%;
            max-width: 600px;
            height:auto;
            min-height:300px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .level-info-close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .level-info-close:hover,
        .level-info-close:focus {
            color: #000;
            text-decoration: none;
        }

        .level-progression {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 60px;
            position: relative;
            padding: 0 20px;
        }

        .progress-line {
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 4px;
            background-color: #e0e0e0;
            z-index: 1;
        }

        .progress-fill {
            height: 100%;
            background-color: #FFD700;
            transition: width 0.5s ease-in-out;
        }

        .level-icon {
            display: flex;
            flex-direction: column;
            align-items: center;
            z-index: 2;
            background-color: #fff;
            padding: 10px;
            border-radius: 50%;
            transition: all 0.3s ease;
        }

        .level-icon i {
            font-size: 28px;
            margin-bottom: 5px;
        }

        .level-icon.current {
            transform: scale(1.2);
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        .level-name {
            font-size: 14px;
            text-align: center;
            font-weight: bold;
            margin-top: 5px;
        }

        .level-points {
            font-size: 12px;
            color: #666;
            margin-top: 2px;
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
	<%@ include file="../header.jsp"%>
	<div class="mypage-body">
		<div class="mypageContainer">
			<h1 class="myPageh1">My ThinKB</h1>
			<hr style="margin-bottom: 4%;">
			<div class="profile-section">
				<div class="profile-pic-container">
					<c:choose>
						<c:when test="${not empty user.profileImg}">
							<img src="./upload/${user.profileImg}" alt="Profile Picture"
								class="profile-pic">
						</c:when>
						<c:otherwise>
							<img src="./resources/profile1.png" alt="Profile Picture"
								class="profile-pic">
						</c:otherwise>
					</c:choose>
					<button class="change-pic-btn"
						onclick="openModal('profileUploadModal')">✏️</button>
				</div>
				<span class="profile-span">${user.userName}님, 안녕하세요!</span>
			</div>
			<p class="mypage-title-p">나의 회의 현황</p>
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

			<div class="badge-mileage-container">
				<div class="badge">
				<div style="display:flex; justify-content:space-between">
					<p class="mypage-title-p"><i class="fas fa-medal" style="margin-right: 10px;"></i>Think level</p>
					<button class="info-button" onclick="openLevelInfoModal()">?</button></div><div style="text-align: center; padding: 20px;">
						<c:choose>
							<c:when test="${MeetingRoomStats.totalContribution <= 100}">
								<i class="fas fa-award" style="color: #CD7F32; font-size: 40px;"></i>
								<p style="font-weight: bold; margin-top: 10px;">Bronze
									Member</p>
						
								<div class="progress-bar"
									style="width: 100%; background-color: #e0e0e0; height: 10px; border-radius: 5px; margin-top: 10px;">
									<div
										style="width: ${MeetingRoomStats.totalContribution}%; background-color: #CD7F32; height: 100%; border-radius: 5px;"></div>
								</div>
								<p>Silver까지 ${100 - MeetingRoomStats.totalContribution}점 남음</p>
							</c:when>
							<c:when test="${MeetingRoomStats.totalContribution <= 200}">
								<i class="fas fa-award" style="color: #C0C0C0; font-size: 40px;"></i>
								<p style="font-weight: bold; margin-top: 10px;">Silver
									Member</p>
								
								<div class="progress-bar"
									style="width: 100%; background-color: #e0e0e0; height: 10px; border-radius: 5px; margin-top: 10px;">
									<div
										style="width: ${(MeetingRoomStats.totalContribution - 100) / 1}%; background-color: #C0C0C0; height: 100%; border-radius: 5px;"></div>
								</div>
								<p>Gold까지 ${200 - MeetingRoomStats.totalContribution}점 남음</p>
							</c:when>
							<c:when test="${MeetingRoomStats.totalContribution <= 300}">
								<i class="fas fa-award" style="color: #FFD700; font-size: 40px;"></i>
								<p style="font-weight: bold; margin-top: 10px;">Gold Member</p>

								<div class="progress-bar"
									style="width: 100%; background-color: #e0e0e0; height: 10px; border-radius: 5px; margin-top: 10px;">
									<div
										style="width: ${(MeetingRoomStats.totalContribution - 200) / 1}%; background-color: #FFD700; height: 100%; border-radius: 5px;"></div>
								</div>
								<p>Platinum까지 ${300 - MeetingRoomStats.totalContribution}점
									남음</p>
							</c:when>
							<c:otherwise>
								<i class="fas fa-crown" style="color: #B9F2FF; font-size: 40px;"></i>
								<p style="font-weight: bold; margin-top: 10px;">Platinum
									Member</p>
								
								<div class="progress-bar"
									style="width: 100%; background-color: #B9F2FF; height: 10px; border-radius: 5px; margin-top: 10px;">
									<div
										style="width: 100%; background-color: #4CAF50; height: 100%; border-radius: 5px;"></div>
								</div>
								<p style="color: #4CAF50;">
									<i class="fas fa-check-circle"></i> Platinum등급 달성!
								</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

<div class="mileage">
    <p class="mypage-title-p" style="margin-top:0;"><i class="fas fa-coins" style="margin-right: 10px;"></i>내 마일리지</p>
    <div class="mileage-content">
        <div class="mileage-icon">
            <i class="fas fa-trophy"></i>
        </div>
        <div class="mileage-text">
            ${user.userName}님의 누적 마일리지는<br>
            <span class="mileage-points">${MeetingRoomStats.totalContribution}점</span> 입니다.
        </div>
    </div>
    <div class="mileage-history">
        <a href="#" onclick="openModal('mileageModal')">
            마일리지 내역 보기 <i class="fas fa-chevron-right"></i>
        </a>
    </div>
</div>
			</div>

			<p class="mypage-title-p">내 정보</p>
			<table class="mypageUserTable">
				<tr>
					<th>사용자 ID</th>
					<td>${user.userId}</td>
				</tr>
				<tr>
					<th>사용자 이름</th>
					<td>${user.userName}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${user.email}</td>
				</tr>
				<tr>
					<th>생일</th>
					<td>${user.birth}</td>
				</tr>
				<tr>
					<th>부서</th>
					<td>${user.departmentName}</td>
				</tr>
				<tr>
					<th>팀</th>
					<td>${user.teamName}</td>
				</tr>
			</table>
		</div>
		<%--마일리지 모달 --%>
		<div id="mileageModal" class="mypageModal">
			<div class="mypageModal-content">
				<span class="close" onclick="closeModal('mileageModal')">&times;</span>
				<h2>마일리지 내역</h2>
				<div class="search-sort-container">
					<input type="text" id="searchInput" placeholder="회의 제목 검색...">
					<i class="fa fa-search search-icon"></i>
				</div>
				<table id="mileageTable">
					<thead>
						<tr>
							<th>회의 제목
								<button class="sort-button" onclick="sortTable(0)">
									<i class="fas fa-sort"></i>
								</button>
							</th>
							<th>획득 마일리지
								<button class="sort-button" onclick="sortTable(1)">
									<i class="fas fa-sort"></i>
								</button>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="contribution" items="${ContributionDetail}">
							<tr>
								<td>🏠&nbsp;${contribution.roomTitle}</td>
								<td>${contribution.contribution}점</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="mypagePagination" id="mypagePagination"></div>
			</div>
		</div>
					 
    <!-- Think level 설명 모달 (body 끝 부분으로 이동) -->
    <div id="levelInfoModal" class="level-info-modal">
        <div class="level-info-modal-content">
            <span class="level-info-close" onclick="closeLevelInfoModal()">&times;</span>
            <h2>Think Level 안내</h2>
            <p>Think Level은 회원님의 활동량과 기여도에 따라 부여되는 등급입니다.</p>
            <div class="level-progression">
                <div class="progress-line">
                    <div class="progress-fill" id="progressFill"></div>
                </div>
                <div class="level-icon" id="bronzeIcon">
                    <i class="fas fa-award" style="color: #CD7F32;"></i>
                    <span class="level-name">Bronze</span>
                    <span class="level-points">0 - 100</span>
                </div>
                <div class="level-icon" id="silverIcon">
                    <i class="fas fa-award" style="color: #C0C0C0;"></i>
                    <span class="level-name">Silver</span>
                    <span class="level-points">101 - 200</span>
                </div>
                <div class="level-icon" id="goldIcon">
                    <i class="fas fa-award" style="color: #FFD700;"></i>
                    <span class="level-name">Gold</span>
                    <span class="level-points">201 - 300</span>
                </div>
                <div class="level-icon" id="platinumIcon">
                    <i class="fas fa-crown" style="color: #B9F2FF;"></i>
                    <span class="level-name">Platinum</span>
                    <span class="level-points">301+</span>
                </div>
            </div>
        </div>
    </div>
		<!-- 프로필업로드 모달 -->
<div id="profileUploadModal" class="mypageModal">
    <div class="mypageModal-content" style="width:400px;">
        <span class="close" onclick="closeModal('profileUploadModal')">&times;</span>
        <h2 class="modal-title">프로필 사진 업로드</h2>
        <form action="./updateProfileImg" method="post" enctype="multipart/form-data" id="profileUploadForm">
            <div class="file-upload-container">
            <div style="display:flex; justify-content:flex-end;">
                <label for="profileImgInput" class="file-upload-label">
                    <i class="fas fa-cloud-upload-alt"></i> 파일 선택
                </label>
                <input type="file" name="profileImg" id="profileImgInput" accept="image/*">
            </div></div>
            <div class="image-preview" id="imagePreview">
                <img src="./upload/${user.profileImg}" alt="프로필 이미지" id="previewImg">
            </div>
            <input type="hidden" name="userId" value="${user.userId}">
             <input type="hidden" name="profileImgName" id="profileImgName" value="${user.profileImg}">
            <div class="button-container">
                <button type="submit" class="upload-btn">업로드</button>
                <button type="button" class="reset-btn" id="resetBtn">초기화</button>
            </div>
        </form>
    </div>
</div>

	</div>

	<script>
// 전역 변수
let currentPage = 1;
const rowsPerPage = 10;
let sortColumn = -1; // 정렬된 열 인덱스
let sortAscending = true; // 정렬 방향
let originalData = []; // 원본 데이터를 저장할 변수
let filteredAndSortedData = []; // 필터링 및 정렬된 데이터

// 페이지 로드 시 실행
window.onload = function() {
    const table = document.getElementById('mileageTable');
    originalData = Array.from(table.rows).slice(1);
    filteredAndSortedData = [...originalData];
    updateTable();
    
    // 검색 이벤트 리스너
    document.getElementById('searchInput').addEventListener('input', function() {
        currentPage = 1; // 검색 시 첫 페이지로 리셋
        filterAndSortData();
    });
};

// 테이블 정렬
function sortTable(columnIndex) {
    if (sortColumn === columnIndex) {
        // 같은 열을 다시 클릭하면 정렬 방향을 반대로
        sortAscending = !sortAscending;
    } else {
        sortColumn = columnIndex;
        sortAscending = true;
    }
    
    filterAndSortData();
}

// 데이터 필터링 및 정렬
function filterAndSortData() {
    const searchText = document.getElementById('searchInput').value.toLowerCase();
    
    filteredAndSortedData = originalData.filter(row =>
        row.cells[0].textContent.toLowerCase().includes(searchText)
    );
    
    if (sortColumn !== -1) {
        filteredAndSortedData.sort((a, b) => {
            let aValue = a.cells[sortColumn].textContent;
            let bValue = b.cells[sortColumn].textContent;
            
            if (sortColumn === 1) {
                // 마일리지 열은 숫자로 정렬
                aValue = parseInt(aValue);
                bValue = parseInt(bValue);
            }
            
            if (aValue < bValue) return sortAscending ? -1 : 1;
            if (aValue > bValue) return sortAscending ? 1 : -1;
            return 0;
        });
    }
    
    updateTable();
}

// 테이블 업데이트 및 페이지네이션
function updateTable() {
    const table = document.getElementById('mileageTable');
    const tbody = table.querySelector('tbody');
    tbody.innerHTML = '';
    
    const start = (currentPage - 1) * rowsPerPage;
    const paginatedData = filteredAndSortedData.slice(start, start + rowsPerPage);
    
    paginatedData.forEach(row => tbody.appendChild(row.cloneNode(true)));
    
    updatePagination();
    updateSortIndicators();
}

// 페이지네이션 업데이트
function updatePagination() {
    const totalRows = filteredAndSortedData.length;
    const pageCount = Math.ceil(totalRows / rowsPerPage);
    const pagination = document.getElementById('mypagePagination');
    pagination.innerHTML = '';
    
    // 이전 페이지 버튼
    if (currentPage > 1) {
        const prevButton = createPageButton('<', () => {
            currentPage--;
            updateTable();
        });
        pagination.appendChild(prevButton);
    }

    // 페이지 번호 버튼
    for (let i = Math.max(1, currentPage - 2); i <= Math.min(pageCount, currentPage + 2); i++) {
        const pageButton = createPageButton(i, () => {
            currentPage = i;
            updateTable();
        });
        if (i === currentPage) {
            pageButton.classList.add('active');
        }
        pagination.appendChild(pageButton);
    }

    // 다음 페이지 버튼
    if (currentPage < pageCount) {
        const nextButton = createPageButton('>', () => {
            currentPage++;
            updateTable();
        });
        pagination.appendChild(nextButton);
    }
}

// 페이지 버튼 생성 함수
function createPageButton(text, onClick) {
    const button = document.createElement('button');
    button.textContent = text;
    button.addEventListener('click', onClick);
    return button;
}

// 정렬 표시 업데이트
function updateSortIndicators() {
    const headers = document.querySelectorAll('#mileageTable th');
    headers.forEach((header, index) => {
        const sortButton = header.querySelector('.sort-button i');
        if (sortButton) {
            if (index === sortColumn) {
                sortButton.className = sortAscending ? 'fas fa-sort-up' : 'fas fa-sort-down';
            } else {
                sortButton.className = 'fas fa-sort';
            }
        }
    });
}
//프로필 모달
let originalImageSrc = "./upload/${user.profileImg}";
const defaultImageSrc = "./upload/noprofile.png";

function openModal(modalId) {
    document.getElementById(modalId).style.display = 'block';
    document.getElementById('previewImg').src = originalImageSrc;
    document.getElementById('profileImgName').value = "${user.profileImg}";
    resetForm();
}

function resetForm() {
    document.getElementById('profileImgInput').value = '';
}

document.getElementById('profileImgInput').addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('previewImg').src = e.target.result;
        }
        reader.readAsDataURL(file);
        document.getElementById('profileImgName').value = file.name;
    }
});

document.getElementById('resetBtn').addEventListener('click', function() {
    document.getElementById('previewImg').src = defaultImageSrc;
    document.getElementById('profileImgInput').value = '';
    document.getElementById('profileImgName').value = 'noprofile.png';
});

document.getElementById('profileUploadForm').addEventListener('submit', function(event) {
    const fileInput = document.getElementById('profileImgInput');
    const profileImgName = document.getElementById('profileImgName').value;
    
    if (fileInput.files.length === 0 && profileImgName === "${user.profileImg}" && profileImgName !== 'noprofile.png') {
        event.preventDefault();
        alert('변경사항이 없습니다.');
    } else {
        // 파일이 선택되지 않았지만 profileImgName이 'noprofile.png'인 경우
        // 또는 파일이 선택된 경우 폼 제출을 허용
        console.log('Submitting form with profileImgName:', profileImgName);
    }
});
</script>
<script>
function openLevelInfoModal() {
    document.getElementById('levelInfoModal').style.display = 'block';
    updateLevelProgression();
}

function closeLevelInfoModal() {
    document.getElementById('levelInfoModal').style.display = 'none';
}

function updateLevelProgression() {
    const totalContribution = ${MeetingRoomStats.totalContribution};
    let currentLevel, progressPercentage;

    if (totalContribution <= 100) {
        currentLevel = 'bronzeIcon';
        progressPercentage = (totalContribution / 100) * 100;
    } else if (totalContribution <= 200) {
        currentLevel = 'silverIcon';
        progressPercentage = ((totalContribution - 100) / 100) * 100 + 33.33;
    } else if (totalContribution <= 300) {
        currentLevel = 'goldIcon';
        progressPercentage = ((totalContribution - 200) / 100) * 100 + 66.66;
    } else {
        currentLevel = 'platinumIcon';
        progressPercentage = 100;
    }

    document.querySelectorAll('.level-icon').forEach(icon => {
        icon.classList.remove('current');
    });

    const currentIcon = document.getElementById(currentLevel);
    currentIcon.classList.add('current');

    document.getElementById('progressFill').style.width = progressPercentage + '%';
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
    if (event.target == document.getElementById('levelInfoModal')) {
        closeLevelInfoModal();
    }
}
    </script>
</body>
</html>
