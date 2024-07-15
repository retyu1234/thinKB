<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<style>
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5;
}

.container {
    max-width: 1700px;
    margin: 0 auto;
    padding: 20px;
}

header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #ffffff;
    padding: 10px 20px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    border-radius: 10px;
}

.logo img {
    height: 50px;
}

nav ul {
    display: flex;
    list-style-type: none;
}

nav ul li {
    margin-right: 20px;
}

nav ul li a {
    text-decoration: none;
    color: #333;
    font-weight: bold;
}

.user {
    display: flex;
    align-items: center;
}

.user span {
    margin-right: 10px;
}

.user img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
}

main {
    margin-top: 30px;
}

h2 {
    color: #333;
    border-bottom: 2px solid #3498db;
    padding-bottom: 10px;
}

.room-list {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    margin-bottom: 30px;
}

.room {
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    padding: 20px;
    margin-bottom: 20px;
    width: calc(33.33% - 20px);
    transition: transform 0.3s ease;
}

.room:hover {
    transform: translateY(-5px);
}

.room h3 {
    color: #3498db;
    margin-top: 0;
}

.create-room {
    background-color: #3498db;
    color: #ffffff;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease;
}

.create-room:hover {
    background-color: #2980b9;
}

.notification {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.notification button {
    background-color: #f1f1f1;
    border: none;
    padding: 10px;
    border-radius: 5px;
    text-align: left;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.notification button.blue {
    background-color: #e1f0ff;
    color: #3498db;
}

.notification button:hover {
    background-color: #e0e0e0;
}

.bottom-content {
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
}

.notifications, .my-reports {
    width: 48%;
}

.notifications h2, .my-reports h2 {
    margin-bottom: 15px;
}

.notifications a, .my-reports a {
    color: #3498db;
    text-decoration: none;
    float: right;
}

.notifications a:hover, .my-reports a:hover {
    text-decoration: underline;
}

.report-list {
    background-color: #ffffff;
    border-radius: 8px;
    padding: 15px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.report-list ul {
    list-style-type: none;
    padding: 0;
}

.report-list li {
    padding: 10px 0;
    border-bottom: 1px solid #f1f1f1;
}

.report-list li:last-child {
    border-bottom: none;
}
.room-list {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: 20px;
    margin-bottom: 30px;
}

.room {
    flex-basis: calc(25% - 15px); /* 4개의 카드가 한 줄에 들어가도록 설정 */
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    padding: 20px;
    transition: transform 0.3s ease;
    display: flex;
    flex-direction: column;
    min-height: 200px; /* 최소 높이 설정 */
}

.room:hover {
    transform: translateY(-5px);
}

.room h3 {
    color: #3498db;
    margin-top: 0;
    margin-bottom: 10px;
    font-size: 1.2em;
}

.room p {
    flex-grow: 1;
    margin-bottom: 10px;
    font-size: 1em;
}

.room .date, .notification-card .date {
    font-size: 0.8em;
    color: #888;
    align-self: flex-end;
}

.notification-list {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 15px;
}

.notification-card {
    background-color: #f8f8f8;
    border-radius: 8px;
    padding: 15px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    transition: background-color 0.3s ease;
    display: flex;
    flex-direction: column;
}

.notification-card:hover {
    background-color: #e1f0ff;
}

.notification-card h4 {
    color: #3498db;
    margin-top: 0;
    margin-bottom: 10px;
}

.notification-card p {
    flex-grow: 1;
    margin-bottom: 10px;
}

.bottom-content {
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
    gap: 30px;
}

.notifications, .my-reports {
    flex: 1;
}
@media (max-width: 1200px) {
    .room {
        flex-basis: calc(33.333% - 13.333px); /* 3개의 카드가 한 줄에 들어가도록 설정 */
    }
}

@media (max-width: 900px) {
    .room {
        flex-basis: calc(50% - 10px); /* 2개의 카드가 한 줄에 들어가도록 설정 */
    }
}

@media (max-width: 600px) {
    .room {
        flex-basis: 100%; /* 1개의 카드가 한 줄에 들어가도록 설정 */
    }
}
</style>
<head>
    <meta charset="UTF-8">
    <title>thinKB 홈</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <script src="<c:url value='/js/jquery.min.js'/>"></script>
</head>
<body>
    <div class="container">
        <header>
            <div class="logo">
                <img src="./resources/logo1.png" alt="thinKB Logo">
            </div>
            <nav>
                <ul>
                    <li><a href="#">사용자 가이드</a></li>
                    <li><a href="#">회의방</a></li>
                    <li><a href="#">내 보고서</a></li>
                    <li><a href="#">알림함</a></li>
                    <li><a href="#">마이페이지</a></li>
                </ul>
            </nav>
            <div class="user">
                <span>이지훈 님</span>
                <img src="<c:url value='/images/user_profile.png'/>" alt="">
            </div>
        </header>
<main>
    <h2>진행중인 회의방</h2>
    <div class="room-list">
        <div class="room">
            <h3>신제품 아이디어 회의</h3>
            <p>1차 투표를 진행해주세요!</p>
            <span class="date">2024-07-20</span>
        </div>
        <div class="room">
            <h3>마케팅 전략 회의</h3>
            <p>2차 토론이 진행 중입니다.</p>
            <span class="date">2024-07-18</span>
        </div>
        <div class="room">
            <h3>사용자 경험 개선 회의</h3>
            <p>최종 투표를 진행해주세요!</p>
            <span class="date">2024-07-15</span>
        </div>
        <div class="room">
            <h3>신규 서비스 기획 회의</h3>
            <p>아이디어 제안 단계입니다.</p>
            <span class="date">2024-07-14</span>
        </div>
    </div>
    <button class="create-room">+ 아이디어 회의방 만들기</button>
    
    <div class="bottom-content">
        <div class="notifications">
            <h2>알림함 <a href="#">+ 더보기</a></h2>
            <div class="notification-list">
                <div class="notification-card">
                    <h4>신제품 아이디어 회의</h4>
                    <p>1차 투표가 시작되었습니다. 참여해주세요!</p>
                    <span class="date">2024-07-20 14:30</span>
                </div>
                <div class="notification-card">
                    <h4>마케팅 전략 회의</h4>
                    <p>새로운 의견이 등록되었습니다. 확인해주세요.</p>
                    <span class="date">2024-07-19 11:15</span>
                </div>
                <div class="notification-card">
                    <h4>사용자 경험 개선 회의</h4>
                    <p>최종 투표가 24시간 후 마감됩니다.</p>
                    <span class="date">2024-07-18 09:00</span>
                </div>
            </div>
        </div>
        <div class="my-reports">
            <h2>나의 보고서 <a href="#">+ 더보기</a></h2>
            <div class="report-list">
                <ul>
                    <li>2024년 2분기 마케팅 성과 보고서</li>
                    <li>신제품 출시 전략 보고서</li>
                    <li>사용자 만족도 조사 결과 보고서</li>
                </ul>
            </div>
        </div>
    </div>
</main>
    </div>
</body>
</html>
