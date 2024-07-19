<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>4가지 견해 등록 1</title>
<style>
body {
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #f0f0f0;
    margin: 0;
    font-family: 'Arial', sans-serif;
    background: url('./resources/header4.jpg') no-repeat center center fixed;
    background-size: cover;
}

.container {
    width: 80%;
    background-color: rgba(255, 255, 255, 0.9); /* 배경이 살짝 투명한 흰색으로 변경 */
    border: 1px solid #ccc;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    box-sizing: border-box;
    margin-top: 50px;
    backdrop-filter: blur(10px); /* 배경 이미지 블러 효과 */
}

h1 {
    text-align: center;
    margin: 20px 0;
}

.tabs {
    display: flex;
    justify-content: space-around;
    margin: 20px auto;
    border-bottom: 2px solid #ccc;
    position: relative;
}

.tab {
    padding: 15px 25px;
    cursor: pointer;
    font-weight: bold;
    flex: 1;
    text-align: center;
    color: #fff;
    transition: background-color 0.3s ease;
    clip-path: polygon(0 0, 100% 0, 100% 100%, 0 80%);
}

.tab-smart {
    background-color: #007bff; /* 파란색 */
}

.tab-positive {
    background-color: #ffc107; /* 노란색 */
    color: black;
}

.tab-worry {
    background-color: #28a745; /* 초록색 */
}

.tab-strict {
    background-color: #dc3545; /* 빨간색 */
}

.tab-content-container {
    margin-top: 20px;
}

.tab-content {
    display: none;
    border: 2px solid;
    padding: 20px;
    box-sizing: border-box;
    background-color: #fff;
}

.tab-content.active {
    display: block;
}

.opinion-list {
    list-style-type: none;
    padding: 0;
}

.opinion-list li {
    margin-bottom: 10px;
}

.comment-section {
    display: flex;
    align-items: center;
    margin-top: 20px;
}

.opinion-textarea {
    width: calc(100% - 100px);
    height: 50px;
    margin-right: 10px;
    border: 1px solid #ccc;
    padding: 10px;
    border-radius: 5px;
}

button {
    height: 50px;
    border: none;
    background-color: #ffc107;
    color: #000;
    font-weight: bold;
    padding: 0 20px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #e0a800;
}

</style>
<script>
    window.onload = function() {
        var urlParams = new URLSearchParams(window.location.search);
        var currentTab = urlParams.get('currentTab');
        if (currentTab) {
            showTab(currentTab, getTabColor(currentTab));
        }
    };

    function getTabColor(tabName) {
        switch(tabName) {
            case 'tab-smart': return '#007bff';
            case 'tab-positive': return '#ffc107';
            case 'tab-worry': return '#28a745';
            case 'tab-strict': return '#dc3545';
            default: return '#007bff';
        }
    }

    function showTab(tabName, color) {
        var tabs = document.getElementsByClassName('tab-content');
        for (var i = 0; i < tabs.length; i++) {
            tabs[i].classList.remove('active');
        }
        document.getElementById(tabName).classList.add('active');
        document.querySelector('.tab-content.active').style.borderColor = color;

        var allTabs = document.getElementsByClassName('tab');
        for (var j = 0; j < allTabs.length; j++) {
            allTabs[j].style.borderBottom = 'none';
        }
        document.querySelector('.tab.' + tabName).style.borderBottom = '5px solid ' + color;

        // 폼의 currentTab 값을 업데이트
        var currentTabInputs = document.querySelectorAll('input[name="currentTab"]');
        for (var k = 0; k < currentTabInputs.length; k++) {
            currentTabInputs[k].value = tabName;
        }
    }
</script>
</head>
<body>
    <h1>아이디어 회의를 매일 아침 10분씩 진행하기</h1>
    <div class="container">
        <div class="tabs">
            <div class="tab tab-smart tab-smart-content" onclick="showTab('tab-smart', '#007bff')">똑똑이</div>
            <div class="tab tab-positive tab-positive-content" onclick="showTab('tab-positive', '#ffc107')">긍정이</div>
            <div class="tab tab-worry tab-worry-content" onclick="showTab('tab-worry', '#28a745')">걱정이</div>
            <div class="tab tab-strict tab-strict-content" onclick="showTab('tab-strict', '#dc3545')">깐깐이</div>
        </div>
        <div class="tab-content-container">
            <div id="tab-smart" class="tab-content active">
                <h2>
                    <img src="./resources/message.png" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                    똑똑이 등록된 의견
                </h2>
                <ul class="opinion-list">
                    <c:forEach var="opinion" items="${smartOpinions}">
                        <li>${opinion.opinionText}</li>
                    </c:forEach>
                </ul>
                <div class="comment-section">
                    <form:form method="post" action="addOpinion" modelAttribute="opinionForm">
                        <form:hidden path="hatColor" value="Smart" />
                        <form:hidden path="currentTab" value="tab-smart" />
                        <form:textarea path="opinionText" class="opinion-textarea" placeholder="입력해주세요" />
                        <button type="submit">등록</button>
                    </form:form>
                </div>
            </div>

            <div id="tab-positive" class="tab-content">
                <h2>
                    <img src="./resources/message.png" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                    긍정이 등록된 의견
                </h2>
                <ul class="opinion-list">
                    <c:forEach var="opinion" items="${positiveOpinions}">
                        <li>${opinion.opinionText}</li>
                    </c:forEach>
                </ul>
                <div class="comment-section">
                    <form:form method="post" action="addOpinion" modelAttribute="opinionForm">
                        <form:hidden path="hatColor" value="Positive" />
                        <form:hidden path="currentTab" value="tab-positive" />
                        <form:textarea path="opinionText" class="opinion-textarea" placeholder="입력해주세요" />
                        <button type="submit">등록</button>
                    </form:form>
                </div>
            </div>

            <div id="tab-worry" class="tab-content">
                <h2>
                    <img src="./resources/message.png" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                    걱정이 등록된 의견
                </h2>
                <ul class="opinion-list">
                    <c:forEach var="opinion" items="${worryOpinions}">
                        <li>${opinion.opinionText}</li>
                    </c:forEach>
                </ul>
                <div class="comment-section">
                    <form:form method="post" action="addOpinion" modelAttribute="opinionForm">
                        <form:hidden path="hatColor" value="Worry" />
                        <form:hidden path="currentTab" value="tab-worry" />
                        <form:textarea path="opinionText" class="opinion-textarea" placeholder="입력해주세요" />
                        <button type="submit">등록</button>
                    </form:form>
                </div>
            </div>

            <div id="tab-strict" class="tab-content">
                <h2>
                    <img src="./resources/message.png" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                    깐깐이 등록된 의견
                </h2>
                <ul class="opinion-list">
                    <c:forEach var="opinion" items="${strictOpinions}">
                        <li>${opinion.opinionText}</li>
                    </c:forEach>
                </ul>
                <div class="comment-section">
                    <form:form method="post" action="addOpinion" modelAttribute="opinionForm">
                        <form:hidden path="hatColor" value="Strict" />
                        <form:hidden path="currentTab" value="tab-strict" />
                        <form:textarea path="opinionText" class="opinion-textarea" placeholder="입력해주세요" />
                        <button type="submit">등록</button>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
