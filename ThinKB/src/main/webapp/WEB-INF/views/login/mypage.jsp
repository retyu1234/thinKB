<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<style>
.mypage-body {
    font-family: 'Arial', sans-serif;
    background-color: #ffffff;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
}

.container {
    background-color: #ffffff;
    padding: 30px;
    width: 90%;
    margin-top: 0;
    margin-left: 17%;
    margin-right: 17%;
}

h1 {
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
    margin:1%;
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

.badge, .mileage {
    width: 48%;
    text-align: left;
}
.mypage-title-p{
	font-size: 15pt;
	font-weight: bold;
}
table {
    width: 100%;
    border-collapse: collapse;
    caret-color: transparent;
}

th, td {
    padding: 12px;
    text-align: left;
}

th {
    font-weight: bold;
    width: 30%;
    padding-left:3%;
    border: none; /* 테두리 없애기 */
    border-radius: 10px;
}

tr:nth-child(odd) th, tr:nth-child(odd) td {
    background-color: #FFFFE4; /* 홀수 줄 배경색 */
}

tr:nth-child(even) th, tr:nth-child(even) td {
    background-color: #ffffff; /* 짝수 줄 배경색 */
}

tr {
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
    width: 80%;
    max-width: 500px;
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
    margin-top: 20px;
}

#mileageTable th, #mileageTable td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

#mileageTable th {
    background-color: #f2f2f2;
    font-weight: bold;
}

#mileageTable tr:nth-child(even) {
    background-color: #f9f9f9;
}

#mileageTable tr:hover {
    background-color: #f5f5f5;
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
<body style="margin:0;">
<%@ include file="../header.jsp"%>
<div class="mypage-body">
    <div class="container">
        <h1>My ThinKB</h1>
        <hr style="margin-bottom: 4%;">
        <div class="profile-section">
            <div class="profile-pic-container">
                <c:choose>
                    <c:when test="${not empty user.profileImg}">
                        <img src="./upload/${user.profileImg}" alt="Profile Picture" class="profile-pic">
                    </c:when>
                    <c:otherwise>
                        <img src="./resources/profile1.png" alt="Profile Picture" class="profile-pic">
                    </c:otherwise>
                </c:choose>
                <button class="change-pic-btn" onclick="openModal('profileUploadModal')">✏️</button>
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
                <p class="mypage-title-p">배지</p>
                <p style="text-align:center; padding:20px;">Gold Member</p>
            </div>
            <div class="mileage">
                <p class="mypage-title-p">내 마일리지</p>
                <p style="text-align:center; padding:20px;">${user.userName}님 누적 마일리지는 <span style="font-weight:bold;">'${MeetingRoomStats.totalContribution}'</span>점입니다.</p>
                <a href="#" onclick="openModal('mileageModal')"><p style="text-align:right;">마일리지내역 ></p></a>
            </div>
        </div>

        <p class="mypage-title-p">내 정보</p>
        <table>
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
        <table id="mileageTable">
            <thead>
                <tr>
                    <th>회의 제목</th>
                    <th>획득 마일리지</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="contribution" items="${ContributionDetail}">
                    <tr>
                        <td>${contribution.roomTitle}</td>
                        <td>${contribution.contribution}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

    <div id="profileUploadModal">
        <div class="mypageModal-content">
            <span class="close" onclick="closeModal('profileUploadModal')">&times;</span>
            <h2>프로필 사진 업로드</h2>
            <form action="./updateProfileImg" method="post" enctype="multipart/form-data">
                <input type="file" name="profileImg">
                <input type="hidden" name="userId" value="${user.userId}">
                <br><br>
                <button type="submit" class="">업로드</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
