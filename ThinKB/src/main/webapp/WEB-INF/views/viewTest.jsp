<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디어 회의방</title>
    <link rel="stylesheet" href="styles.css">
    <style type="text/css">
    * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Arial', sans-serif;
}

header {
    display: flex;
    flex-direction: column;
    background-color: #f8f8f8;
    border-bottom: 1px solid #ddd;
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 20px;
    background-color: #fff;
}

.timer {
    font-size: 1.2em;
    font-weight: bold;
}

.participants ul {
    list-style: none;
    display: flex;
    gap: 10px;
}

.progress-bar {
    display: flex;
    justify-content: space-around;
    padding: 5px 0;
    background-color: #e0e0e0;
}

.stage {
    padding: 5px 10px;
    border-radius: 5px;
    background-color: #c0c0c0;
    font-weight: bold;
}

aside {
    width: 200px;
    background-color: #f0f0f0;
    padding: 20px;
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
}

aside h2 {
    margin-bottom: 15px;
}

aside ul {
    list-style: none;
}

aside ul li {
    margin-bottom: 10px;
    padding: 10px;
    background-color: #ddd;
    border-radius: 5px;
}

main {
    margin-left: 220px;
    padding: 20px;
}

main h1 {
    margin-bottom: 20px;
}

main section {
    margin-bottom: 20px;
}

main section h2 {
    margin-bottom: 10px;
}

main section p {
    background-color: #f9f9f9;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
}
    
    </style>
</head>
<body>
    <header>
        <div class="header-content">
            <div class="timer">00:00</div>
            <div class="participants">
                <ul>
                    <li>참여자 1</li>
                    <li>참여자 2</li>
                    <li>참여자 3</li>
                </ul>
            </div>
        </div>
        <div class="progress-bar">
            <div class="stage">1단계</div>
            <div class="stage">2단계</div>
            <div class="stage">3단계</div>
            <div class="stage">4단계</div>
        </div>
    </header>
    <aside>
        <h2>사이드바</h2>
        <ul>
            <li>메뉴 1</li>
            <li>메뉴 2</li>
            <li>메뉴 3</li>
            <li>메뉴 4</li>
        </ul>
    </aside>
    <main>
        <h1>회의 내용</h1>
        <section>
            <h2>섹션 1</h2>
            <p>여기에 섹션 1의 내용이 들어갑니다. 이 텍스트는 더미 텍스트입니다.</p>
        </section>
        <section>
            <h2>섹션 2</h2>
            <p>여기에 섹션 2의 내용이 들어갑니다. 이 텍스트는 더미 텍스트입니다.</p>
        </section>
        <section>
            <h2>섹션 3</h2>
            <p>여기에 섹션 3의 내용이 들어갑니다. 이 텍스트는 더미 텍스트입니다.</p>
        </section>
    </main>
</body>
</html>
