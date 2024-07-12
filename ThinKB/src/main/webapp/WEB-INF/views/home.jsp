<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회의방 플랫폼</title>
    <link rel="stylesheet" href="styles.css">
<style type="text/css">
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5;
    color: #333;
}

.main-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 2rem;
    background-color: #fff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.logo {
    font-size: 1.5rem;
    font-weight: bold;
    color: #ffcc00; /* 노란색 */
}

.header-right {
    display: flex;
    align-items: center;
}

.profile {
    margin-right: 1rem;
}

.logout-btn {
    background-color: #ffcc00; /* 노란색 */
    border: none;
    padding: 0.5rem 1rem;
    cursor: pointer;
    border-radius: 4px;
    color: #fff;
    font-weight: bold;
}

.main-container {
    display: flex;
    height: calc(100vh - 80px); /* 헤더 높이만큼 빼줌 */
}

.sidebar {
    width: 250px;
    background-color: #fff;
    padding: 1rem;
    box-shadow: 2px 0 4px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
}

.sidebar h2 {
    font-size: 1.2rem;
    margin-bottom: 1rem;
}

.room-card {
    background-color: #fff;
    padding: 1rem;
    margin-bottom: 1rem;
    border: 1px solid #ccc;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    cursor: pointer;
}

.content {
    flex: 1;
    padding: 2rem;
    overflow-y: auto;
}

.content-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
}

.create-room-btn {
    background-color: #ffcc00; /* 노란색 */
    border: none;
    padding: 0.5rem 1rem;
    cursor: pointer;
    border-radius: 4px;
    color: #fff;
    font-weight: bold;
}

.room-list {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
}

.my-room-card {
    background-color: #fff;
    padding: 1rem;
    width: calc(33.333% - 1rem);
    border: 1px solid #ccc;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    cursor: pointer;
}

@media (max-width: 768px) {
    .sidebar {
        width: 200px;
    }

    .my-room-card {
        width: calc(50% - 1rem);
    }
}

@media (max-width: 480px) {
    .sidebar {
        display: none;
    }

    .my-room-card {
        width: 100%;
    }
}
</style>
</head>
<body>
    <header class="main-header">
        <div class="logo">회의방 로고</div>
        <div class="header-right">
            <div class="profile">프로필</div>
            <button class="logout-btn">로그아웃</button>
        </div>
    </header>
    <div class="main-container">
        <aside class="sidebar">
            <h2>회의방 목록</h2>
            <div class="room-card">회의방 1</div>
            <div class="room-card">회의방 2</div>
            <div class="room-card">회의방 3</div>
            <!-- 추가적인 회의방 카드들 -->
        </aside>
        <main class="content">
            <div class="content-header">
                <h2>나의 회의방</h2>
                <button class="create-room-btn">방 만들기</button>
            </div>
            <div class="room-list">
                <div class="my-room-card">나의 회의방 1</div>
                <div class="my-room-card">나의 회의방 2</div>
                <div class="my-room-card">나의 회의방 3</div>
                <!-- 추가적인 나의 회의방 카드들 -->
            </div>
        </main>
    </div>
</body>
</html>