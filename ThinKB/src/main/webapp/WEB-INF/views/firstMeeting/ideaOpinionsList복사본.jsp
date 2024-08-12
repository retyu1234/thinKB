<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디어 의견 요약</title>
<style>
.ideaOpinionsList-body {
    margin: 0;
    font-family: 'Arial', sans-serif;
    background-color: #FFFFFF;
    margin: 0 auto;
    box-sizing: border-box;
}

/* 아이디어 제목 */
.title {
    font-weight: bold;
    font-size: 22pt;
    text-align: center;
    margin-top: 40px; 
    margin-bottom: 40px; 
}

.columns {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    width: 60%;
    margin: 0 auto;
}
.column {
    width: 48%;
    margin-bottom: 20px;
}

/* 객관적관점, 기대효과, 문제점, 실현가능성 박스 */
.box {
    background-color: #ffffff;
    /* border: 1px solid #FFE297; */
    border-radius: 10px;
    padding: 10px;
    height: 350px;
    overflow-y: auto;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.4); /* 그림자 추가 */
}
.section-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}


/* 탭 제목 */
.tab-title {
    font-size: 15pt;
    font-weight: bold;
    text-align: left;
    padding: 10px;
    cursor: pointer;
    border-radius: 10px 10px 0 0;
    color: #000000;
    /* border-bottom: 6px solid #FFE297; */
}
/* .tab-smart { background-color: #007bff; }
.tab-positive { background-color: #ffc107; color: #000000; }
.tab-worry { background-color: #28a745; }
.tab-strict { background-color: #dc3545; } */

.opinion-list {
    list-style-type: none;
    padding: 0;
}
.opinion-entry {
    background-color: #ffeeee;
    padding: 10px;
    border-radius: 10px;
    margin-bottom: 10px;
    font-size: 15pt;
    position: relative;
    cursor: pointer;
    text-align: left;
}
.opinion-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 5px;
}

.name {
    font-weight: bold;
    font-size: 11pt;
}
.date {
    font-size: 8pt;
    color: #777;
}
.opinion-text {
    margin-top: 5px;
    font-size: 10pt;
}
.no-opinions {
    color: #ccc;
    font-style: italic;
    text-align: center;
    margin-top: 20px;
    font-size: 20px;
}
</style>
<script>
    function navigateToTab(currentTab) {
        var roomId = '${roomId}';
        var ideaId = '${ideaId}';
        var url = '<c:url value="/ideaOpinions"/>' + '?roomId=' + roomId
                + '&ideaId=' + ideaId + '&currentTab=' + currentTab;
        window.location.href = url;
    }
</script>
</head>
<body class="ideaOpinionsList-body">
<%@ include file="../header.jsp"%>
<%@ include file="../leftSideBar.jsp"%>
<%@ include file="../rightSideBar.jsp"%>

    <!-- 제목 -->
	<div class="title">[${ideaTitle}]</div>

    <div class="columns">
    
    	<!-- 객관적관점 -->
        <div class="column">
            <div class="box">
	            <div class="section-header">
					<div class="tab-title tab-smart" onclick="navigateToTab('tab-smart')">객관적관점</div>
					<img src="./resources/nextIcon.png" onclick="navigateToTab('tab-smart')"
					style="width: 15px; height: 15px; float: right; margin-right: 20px; cursor: pointer;">
				</div>
				
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty smartOpinions}">
                            <li class="no-opinions">
                            <img src="./resources/noContents.png" alt="No opinions"
                                style="width: 150px; height: 170px; vertical-align: middle; margin-right: 10px;">
                                <br><br> 의견이 아직 등록되지 않았어요!
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${smartOpinions}" varStatus="status">
                                <c:if test="${status.index < 3}">
                                    <li class="opinion-entry" onclick="navigateToTab('tab-smart')" style="background-color: #E7F3FF;">
                                        <div class="opinion-header">
                                            <span class="name">${opinion.userName}</span>
                                            <span class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
                                        </div>
                                        <div class="opinion-text">${opinion.opinionText}</div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
        
        <!-- 기대효과 -->
        <div class="column">
            <div class="box">
            	<div class="section-header">
					<div class="tab-title tab-positive" onclick="navigateToTab('tab-positive')">기대효과</div>
					<img src="./resources/nextIcon.png" onclick="navigateToTab('tab-positive')"
					style="width: 15px; height: 15px; float: right; margin-right: 20px; cursor: pointer;">
				</div>
				
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty positiveOpinions}">
                            <li class="no-opinions">
                            <img src="./resources/noContents.png" alt="No opinions"
                                style="width: 150px; height: 170px; vertical-align: middle; margin-right: 10px;">
                                <br><br> 의견이 아직 등록되지 않았어요!
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${positiveOpinions}" varStatus="status">
                                <c:if test="${status.index < 3}">
                                    <li class="opinion-entry" onclick="navigateToTab('tab-positive')" style="background-color: #FFFFE7;">
                                        <div class="opinion-header">
                                            <span class="name">${opinion.userName}</span>
                                            <span class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
                                        </div>
                                        <div class="opinion-text">${opinion.opinionText}</div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
        
        <!-- 문제점 -->
        <div class="column">
            <div class="box">
            	<div class="section-header">
					<div class="tab-title tab-worry" onclick="navigateToTab('tab-worry')">문제점</div>
					<img src="./resources/nextIcon.png" onclick="navigateToTab('tab-worry')"
					style="width: 15px; height: 15px; float: right; margin-right: 20px; cursor: pointer;">
				</div>
                
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty worryOpinions}">
                            <li class="no-opinions">
                            <img src="./resources/noContents.png" alt="No opinions"
                                style="width: 150px; height: 170px; vertical-align: middle; margin-right: 10px;">
                                <br><br> 의견이 아직 등록되지 않았어요!
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${worryOpinions}" varStatus="status">
                                <c:if test="${status.index < 3}">
                                    <li class="opinion-entry" onclick="navigateToTab('tab-worry')">
                                        <div class="opinion-header">
                                            <span class="name">${opinion.userName}</span>
                                            <span class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
                                        </div>
                                        <div class="opinion-text">${opinion.opinionText}</div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
        
        <!-- 실현가능성 -->
        <div class="column">
            <div class="box">
            	<div class="section-header">
					<div class="tab-title tab-strict" onclick="navigateToTab('tab-strict')">실현가능성</div>
					<img src="./resources/nextIcon.png" onclick="navigateToTab('tab-strict')"
					style="width: 15px; height: 15px; float: right; margin-right: 20px; cursor: pointer;">
				</div>
                
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty strictOpinions}">
                            <li class="no-opinions">
                            <img src="./resources/noContents.png" alt="No opinions"
                                style="width: 150px; height: 170px; vertical-align: middle; margin-right: 10px;">
                                <br><br> 의견이 아직 등록되지 않았어요!
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${strictOpinions}" varStatus="status">
                                <c:if test="${status.index < 3}">
                                    <li class="opinion-entry" onclick="navigateToTab('tab-strict')" style="background-color: #EDFFE7;">
                                        <div class="opinion-header">
                                            <span class="name">${opinion.userName}</span>
                                            <span class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></span>
                                        </div>
                                        <div class="opinion-text">${opinion.opinionText}</div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>