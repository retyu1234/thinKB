<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #fff;
    padding: 10px 20px;
    border-bottom: 1px solid #ddd;
}

.logo img {
    height: 50px;
}

nav ul {
    list-style: none;
    padding: 0;
    margin: 0;
    display: flex;
}

nav ul li {
    margin: 0 15px;
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

.user img {
    height: 40px;
    border-radius: 50%;
    margin-left: 10px;
}

main {
    padding: 20px;
}

.meeting-rooms {
    margin-bottom: 40px;
}

.meeting-rooms h2 {
    font-size: 24px;
    margin-bottom: 20px;
}

.room-list {
    display: flex;
    justify-content: space-between;
}

.room {
    background-color: #f9f9f9;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
    width: 30%;
    text-align: center;
}

.room h3 {
    margin-top: 0;
}

.create-room {
    background-color: #ff0;
    border: none;
    padding: 10px 20px;
    margin-top: 20px;
    font-size: 16px;
    cursor: pointer;
}

.notifications {
    margin-bottom: 40px;
}

.notifications h2 {
    font-size: 24px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.notifications .notification {
    display: flex;
    flex-direction: column;
}

.notifications button {
    background-color: #ddd;
    border: none;
    padding: 10px;
    margin-bottom: 10px;
    cursor: pointer;
    text-align: left;
}

.notifications button.blue {
    background-color: #007bff;
    color: white;
}

</style>
<head>
    <meta charset="UTF-8">
    <title>thinKB 홈</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <script src="<c:url value='/js/jquery.min.js'/>"></script>
</head>
<body>
    <header>
        <div class="logo">
            <img src="<c:url value='/images/thinKB_logo.png'/>" alt="thinKB Logo">
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
            <span>${username} 님</span>
            <img src="<c:url value='/images/user_profile.png'/>" alt="User Profile">
        </div>
    </header>
    <main>
        <section class="meeting-rooms">
            <h2>진행중인 회의방</h2>
            <div class="room-list">
                <div class="room">
                    <h3>진행중인 아이디어 회의방 제목</h3>
                    <p>1차 투표를 진행해주세요!</p>
                </div>
                <div class="room">
                    <h3>진행중인 아이디어 회의방 제목</h3>
                    <p>1차 투표를 진행해주세요!</p>
                </div>
                <div class="room">
                    <h3>진행중인 아이디어 회의방 제목</h3>
                    <p>1차 투표를 진행해주세요!</p>
                </div>
            </div>
            <button class="create-room">+ 아이디어 회의방 만들기</button>
        </section>
        <section class="notifications">
            <h2>알림함 <a href="#">+ 더보기</a></h2>
            <div class="notification">
                <button class="blue">아직 투표 전이에요! 투표를 진행해주세요</button>
                <button>아직 투표 전이에요! 투표를 진행해주세요</button>
                <button>아직 투표 전이에요! 투표를 진행해주세요</button>
            </div>
        </section>
    </main>
</body>
</html>
