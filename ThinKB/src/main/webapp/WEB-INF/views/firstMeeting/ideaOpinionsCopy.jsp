<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디어 회의</title>
<style>
body {
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #f0f0f0;
    margin: 0;
    font-family: 'Arial', sans-serif;
}

.container {
    width: 80%;
    background-color: #FFFFFF;
    border: 1px solid #000;
    border-radius: 10px;
    padding: 20px;
    box-sizing: border-box;
    margin-top: 50px;
}

h1 {
    text-align: center;
    margin: 20px 0;
}

.tabs {
    display: flex;
    justify-content: space-around;
    margin-bottom: 20px;
}

.tab {
    padding: 15px 25px;
    cursor: pointer;
    font-weight: bold;
    color: #fff;
    transition: background-color 0.3s ease;
    clip-path: polygon(0 0, 100% 0, 90% 100%, 10% 100%);
    flex: 1;
    text-align: center;
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
    border-top: 1px solid #000;
    padding-top: 10px;
    flex-wrap: nowrap; /* 요소들이 한 줄에 유지되도록 설정 */
}

.opinion-textarea {
    flex: 1;
    width: calc(100% - 120px); /* 너비를 버튼 크기에 맞게 조정 */
    height: 50px; /* 높이를 버튼과 맞춤 */
    margin-right: 10px;
    border: 1px solid #ccc;
    padding: 10px;
    border-radius: 5px;
    box-sizing: border-box; /* 패딩 포함한 크기 조정 */
}

button {
    width: 100px; /* 버튼의 너비 고정 */
    height: 50px; /* 높이를 입력란과 맞춤 */
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

.idea-title-container {
    border: 1px solid #000;
    background-color: #EEEEEE;
    margin-bottom: 20px;
    padding: 20px;
    width: 100%;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
}

.idea-title-inner {
    border: 3px solid #FFCC00;
    background-color: #FFFFFF;
    border-radius: 20px;
    padding: 10px;
    text-align: center;
    font-size: 30px;
    margin: 10px 0;
}

.opinion-section {
    border: 1px solid #000;
    background-color: #EEEEEE;
    padding: 20px;
    width: 100%;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
}

.opinion-entry {
    background-color: #EEEEEE;
    padding: 20px;
    border-radius: 20px;
    margin-bottom: 10px;
    font-size: 22px;
}
</style>
<script>
    window.onload = function() {
    	var urlParams = new URLSearchParams(window.location.search);
        var currentTab = urlParams.get('currentTab');
        var roomId = urlParams.get('roomId');
        var ideaId = urlParams.get('ideaId');
        if (currentTab && roomId && ideaId) {
            showTab(currentTab, getTabColor(currentTab), roomId, ideaId);
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

    function showTab(tabName, color, roomId, ideaId) {
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

        // URL을 업데이트하여 필요한 매개변수 포함
        history.replaceState(null, '', `?roomId=${roomId}&ideaId=${ideaId}&currentTab=${tabName}`);
    }
</script>
</script>
</head>
<body>
    <div class="container">
        <div class="tabs">
            <div class="tab tab-smart" onclick="showTab('tab-smart', '#007bff')">똑똑이</div>
            <div class="tab tab-positive" onclick="showTab('tab-positive', '#ffc107')">긍정이</div>
            <div class="tab tab-worry" onclick="showTab('tab-worry', '#28a745')">걱정이</div>
            <div class="tab tab-strict" onclick="showTab('tab-strict', '#dc3545')">깐깐이</div>
        </div>
        <div class="idea-title-container">
            <div class="idea-title-inner"> ${ideaTitle} </div>
        </div>
        <div class="opinion-section">
            <div id="tab-smart" class="tab-content active">
                <h2>
                    <img src="./resources/message.png" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                    똑똑이 등록된 의견
                </h2>
                <ul class="opinion-list">
                    <c:forEach var="opinion" items="${smartOpinions}">
                        <li class="opinion-entry">${opinion.opinionText}</li>
                    </c:forEach>
                </ul>
                <div class="comment-section">
                    <form:form method="post" action="addOpinion" modelAttribute="opinionForm">
                        <form:hidden path="hatColor" value="Smart" />
                        <form:hidden path="currentTab" value="tab-smart" />
                        <form:textarea path="opinionText" class="opinion-textarea" placeholder="입력해주세요" />
                        <button type="submit">작성</button>
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
                        <li class="opinion-entry">${opinion.opinionText}</li>
                    </c:forEach>
                </ul>
                <div class="comment-section">
                    <form:form method="post" action="addOpinion" modelAttribute="opinionForm">
                        <form:hidden path="hatColor" value="Positive" />
                        <form:hidden path="currentTab" value="tab-positive" />
                        <form:textarea path="opinionText" class="opinion-textarea" placeholder="입력해주세요" />
                        <button type="submit">작성</button>
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
                        <li class="opinion-entry">${opinion.opinionText}</li>
                    </c:forEach>
                </ul>
                <div class="comment-section">
                    <form:form method="post" action="addOpinion" modelAttribute="opinionForm">
                        <form:hidden path="hatColor" value="Worry" />
                        <form:hidden path="currentTab" value="tab-worry" />
                        <form:textarea path="opinionText" class="opinion-textarea" placeholder="입력해주세요" />
                        <button type="submit">작성</button>
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
                        <li class="opinion-entry">${opinion.opinionText}</li>
                    </c:forEach>
                </ul>
                <div class="comment-section">
                    <form:form method="post" action="addOpinion" modelAttribute="opinionForm">
                        <form:hidden path="hatColor" value="Strict" />
                        <form:hidden path="currentTab" value="tab-strict" />
                        <form:textarea path="opinionText" class="opinion-textarea" placeholder="입력해주세요" />
                        <button type="submit">작성</button>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
