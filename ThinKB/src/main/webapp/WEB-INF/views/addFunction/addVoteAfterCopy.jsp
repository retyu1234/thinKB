<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - 투표결과보기 </title>
<style>
html, body {
    max-width: 100%;
    overflow-x: hidden;
}
.vote-body {
	font-family: Arial, sans-serif;
}

.vote-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
}
.vote-number {
    display: inline-block;
    font-size: 14pt;
    color: white;
    background-color: #4a4a4a;
    padding: 5px 15px;
    border-radius: 15px;
    margin-bottom: 15px;
    font-weight: bold;
}

.vote-title {
	font-size: 22pt;
	color: black;
	font-weight: bold;
	margin-top: 30px;
	margin-bottom: 20px;
}

.vote-title-detail {
	font-size: 15pt;
}

.line {
	margin-top: 15px;
	margin-bottom: 15px;
	border: 2px solid lightgrey;
}

.vote-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}
.vote-table th {
    font-size: 13pt;
    padding: 10px;
    text-align: center;
}
.vote-table td {
    font-size: 15pt;
    font-weight: bold;
    padding: 10px;
    text-align: center;
}
.highlighted {
    position: relative;
    display: inline-block;
}
.highlighted::after {
    content: '';
    position: absolute;
    left: 0;
    bottom: -2px;
    width: 100%;
    height: 5px;
    background-color: #FFD700;
    z-index: -1;
}
.my-vote {
    font-size: 9pt;
    color: blue;
    margin-left: 5px;
}

.vote-banner {
	margin-top: 100px;
}
</style>
</head>
<body>
<body class="vote-body">
	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>
	
	<!-- 콘텐츠 시작 -->	
	<div class="vote-content">
	
	<div class="vote-number">${voteInfo.addVoteId}번 투표</div>
	<div class="vote-title">[${voteInfo.title}]</div>
	<div class="vote-title-detail">투표 결과를 확인해보세요!</div>
	<hr class="line">
	
	
	<!-- 투표항목 리스트 -->
	<table class="vote-table">
	    <tr>
	        <th>순번</th>
	        <th>항목명</th>
	        <th>득표수(비율)</th>
	    </tr>
	    <c:set var="totalVotes" value="0" />
	    <c:set var="maxVotes" value="0" />
	    <c:forEach var="option" items="${optionList}">
	        <c:set var="totalVotes" value="${totalVotes + option.voteCount}" />
	        <c:if test="${option.voteCount > maxVotes}">
	            <c:set var="maxVotes" value="${option.voteCount}" />
	        </c:if>
	    </c:forEach>
	    <c:forEach var="option" items="${optionList}" varStatus="status">
	        <tr>
	            <td>${status.count}</td>
	            <td>
	                <c:choose>
	                    <c:when test="${option.voteCount eq maxVotes}">
	                        <span class="highlighted">
	                            ${option.optionText}
	                        </span>
	                    </c:when>
	                    <c:otherwise>
	                        ${option.optionText}
	                    </c:otherwise>
	                </c:choose>
	                <c:if test="${option.optionId eq myVote.optionId}">
	                    <span class="my-vote">(내가 투표한 항목)</span>
	                </c:if>
	            </td>
	            <td>
	                ${option.voteCount}표
	                <c:choose>
	                    <c:when test="${totalVotes eq 0}">
	                        (0%)
	                    </c:when>
	                    <c:otherwise>
	                        (<fmt:formatNumber value="${option.voteCount / totalVotes * 100}" maxFractionDigits="1" />%)
	                    </c:otherwise>
	                </c:choose>
	            </td>
	        </tr>
	    </c:forEach>
	</table>
	
	<!-- 하단 배너영역 -->
	<div class="vote-banner">
		<img src="<c:url value='./resources/voteResultBanner.png'/>" alt="voteResultBanner" 
		style="max-width: 100%; height: auto;">
	</div>
	
	</div>
</body>
</html>
