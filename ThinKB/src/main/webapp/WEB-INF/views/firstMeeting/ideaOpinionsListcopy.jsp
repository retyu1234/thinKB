<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디어 의견 목록 세로형</title>
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
    display: flex;
    flex-direction: column;
    align-items: center;
}

h1 {
    text-align: center;
    margin: 20px 0;
}

.opinion-section {
    width: 100%;
    display: flex;
    justify-content: space-around;
}

.tab {
    width: 23%;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 10px;
    box-sizing: border-box;
}

.tab h2 {
    text-align: center;
    margin: 10px 0;
}

.opinion-list {
    list-style-type: none;
    padding: 0;
}

.opinion-entry {
    background-color: #f0f0f0;
    margin-bottom: 10px;
    padding: 10px;
    border-radius: 5px;
    font-size: 14px;
}

.no-opinions {
    color: #aaa;
    font-style: italic;
    text-align: center;
    margin-top: 20px;
    font-size: 16px;
}
</style>
</head>
<body>
    <div class="container">
        <h1>${ideaTitle}</h1>
        <div class="opinion-section">
            <div class="tab">
                <h2>똑똑이</h2>
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty smartOpinions}">
                            <li class="no-opinions">
                                <img src="./resources/noContents.png" alt="No opinions" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                                <br>의견이 아직 등록되지 않았어요!
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${smartOpinions}">
                                <li class="opinion-entry">
                                    <span class="opinion-text">${opinion.userName}: ${opinion.opinionText}</span>
                                    <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div class="tab">
                <h2>긍정이</h2>
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty positiveOpinions}">
                            <li class="no-opinions">
                                <img src="./resources/noContents.png" alt="No opinions" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                                <br>의견이 아직 등록되지 않았어요!
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${positiveOpinions}">
                                <li class="opinion-entry">
                                    <span class="opinion-text">${opinion.userName}: ${opinion.opinionText}</span>
                                    <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div class="tab">
                <h2>걱정이</h2>
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty worryOpinions}">
                            <li class="no-opinions">
                                <img src="./resources/noContents.png" alt="No opinions" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                                <br>의견이 아직 등록되지 않았어요!
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${worryOpinions}">
                                <li class="opinion-entry">
                                    <span class="opinion-text">${opinion.userName}: ${opinion.opinionText}</span>
                                    <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div class="tab">
                <h2>깐깐이</h2>
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty strictOpinions}">
                            <li class="no-opinions">
                                <img src="./resources/noContents.png" alt="No opinions" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                                <br>의견이 아직 등록되지 않았어요!
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${strictOpinions}">
                                <li class="opinion-entry">
                                    <span class="opinion-text">${opinion.userName}: ${opinion.opinionText}</span>
                                    <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
