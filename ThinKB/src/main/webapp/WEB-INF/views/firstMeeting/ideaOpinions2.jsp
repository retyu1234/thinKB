<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        text-align: center;
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
    .tab-smart { background-color: #007bff; }
    .tab-positive { background-color: #ffc107; color: black; }
    .tab-worry { background-color: #28a745; }
    .tab-strict { background-color: #dc3545; }
    .columns {
        display: flex;
        justify-content: space-between;
    }
    .column {
        width: 45%;
    }
    .preOpinion-list {
        width: 100%;
        margin-right: 2.5%;
        list-style-type: none;
        padding: 0;
    }
    .currentOpinion-list {
        width: 100%;
        margin-left: 2.5%;
        list-style-type: none;
        padding: 0;
    }
    .box {
        background-color: #FFFFFF;
        border: 1px solid #000;
        border-radius: 10px;
        padding: 10px;
        margin-bottom: 20px;
        height: 365px;
        overflow-y: auto;
    }
    .tab-title {
        font-size: 30px;
        margin-bottom: 10px;
        text-align: center;
        color: #fff;
    }
    .no-opinions {
        color: #ccc;
        font-style: italic;
        text-align: center;
        margin-top: 20px;
        font-size: 20px;
    }
    .opinion-entry {
        background-color: #EEEEEE;
        padding: 10px;
        border-radius: 10px;
        margin-bottom: 10px;
        font-size: 22px;
        position: relative;
        text-align: left;
    }
    .opinion-text {
        display: inline-block;
        margin-right: 10px;
    }
    .date {
        font-size: 12px;
        color: #777;
        margin-top: 5px;
    }
    .delete-button {
        background-color: #dc3545;
        color: #fff;
        border: none;
        padding: 5px 10px;
        border-radius: 5px;
        cursor: pointer;
        position: absolute;
        right: 10px;
        top: 10px;
    }
    .delete-button:hover {
        background-color: #c82333;
    }
    .comment-section {
        display: flex;
        align-items: center;
        margin-top: 20px;
        border-top: 1px solid #000;
        padding-top: 10px;
        flex-wrap: nowrap;
    }
    .opinion-textarea {
        width: calc(100% - 120px);
        height: 50px;
        margin-right: 10px;
        border: 2px solid #ccc;
        padding: 12px;
        border-radius: 5px;
        box-sizing: border-box;
        font-weight: bold;
        font-size: 16px;
    }
    button {
        width: 100px;
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
</style>
<script>
function updateTimer() {
    const endDate = new Date("${timer}").getTime();
    const now = new Date().getTime();
    const distance = endDate - now;

    if (distance < 0) {
        document.getElementById("timer").innerHTML = "시간이 종료되었습니다";
        return;
    }

    const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((distance % (1000 * 60)) / 1000);

    document.getElementById("timer").innerHTML = 
        "남은 시간: " + 
        (hours < 10 ? "0" : "") + hours + ":" +
        (minutes < 10 ? "0" : "") + minutes + ":" +
        (seconds < 10 ? "0" : "") + seconds;
}

document.addEventListener("DOMContentLoaded", function() {
    updateTimer();
    setInterval(updateTimer, 1000);
});
</script>
</head>
<body>
    <div class="container">
        <h1>${ideaTitle}</h1>
        <div class="tabs">
            <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-smart" class="tab tab-smart ${currentTab == 'tab-smart' ? 'active' : ''}">똑똑이</a>
            <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-positive" class="tab tab-positive ${currentTab == 'tab-positive' ? 'active' : ''}">긍정이</a>
            <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-worry" class="tab tab-worry ${currentTab == 'tab-worry' ? 'active' : ''}">걱정이</a>
            <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-strict" class="tab tab-strict ${currentTab == 'tab-strict' ? 'active' : ''}">깐깐이</a>
        </div>
        <div class="columns">
            <div class="column">
                <h2>기존 의견들</h2>
		        <ul class="preOpinion-list">
                    <c:choose>
                        <c:when test="${empty previousOpinions}">
                            <li class="no-opinions">
                                <img src="./resources/noContents.png" alt="No opinions" style="width: 180px; height: 200px; vertical-align: middle;">
                                <br>의견이 아직 등록되지 않았어요! <br><br>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${previousOpinions}" varStatus="status">
                                <li class="opinion-entry">
                                    <span class="opinion-text">${opinion.userName}: ${opinion.opinionText}</span>
                                    <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            
            <div class="column">
		        <h2>현재 의견들</h2>
		        <ul class="currentOpinion-list">
		            <c:choose>
		                <c:when test="${empty currentOpinions}">
		                    <li class="no-opinions">
		                        <img src="./resources/noContents.png" alt="No opinions" style="width: 180px; height: 200px; vertical-align: middle;">
		                        <br>의견이 아직 등록되지 않았어요! <br><br>
		                    </li>
		                </c:when>
		                <c:otherwise>
                            <c:forEach var="opinion" items="${currentOpinions}" varStatus="status">
                                <li class="opinion-entry">
                                    <span class="opinion-text">${opinion.userName}: ${opinion.opinionText}</span>
                                    <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                    <c:if test="${opinion.userID == userId}">
                                        <form action="deleteOpinion2" method="post" style="display: inline;">
                                            <input type="hidden" name="opinionId" value="${opinion.opinionID}" />
                                            <input type="hidden" name="ideaId" value="${ideaId}" />
                                            <input type="hidden" name="roomId" value="${roomId}" />
                                            <input type="hidden" name="currentTab" value="${currentTab}" />
                                            <button type="submit" class="delete-button">삭제</button>
                                        </form>
                                    </c:if>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <form action="addOpinion2" method="post" class="comment-section">
                    <input type="hidden" name="ideaId" value="${ideaId}" />
                    <input type="hidden" name="roomId" value="${roomId}" />
                    <input type="hidden" name="currentTab" value="${currentTab}" />
                    <textarea class="opinion-textarea" name="opinionText" placeholder="의견을 입력하세요"></textarea>
                    <button type="submit">작성</button>
                </form>
		    </div>
		</div>
    </div>
</body>
</html>
