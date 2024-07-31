<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디어 회의 목록</title>
<style>
body {
	display: flex;
/* 	flex-direction: column; */
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

.column {
	width: 45%;
	display: inline-block;
	vertical-align: top;
	margin: 20px;
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
	cursor: pointer;
	text-decoration: none; /* 링크 밑줄 제거 */
}

.tab-smart {
	background-color: #007bff;
}

.tab-positive {
	background-color: #ffc107;
	color: black;
}

.tab-worry {
	background-color: #28a745;
}

.tab-strict {
	background-color: #dc3545;
}

.no-opinions {
	color: #ccc;
	font-style: italic;
	text-align: center;
	margin-top: 20px;
	font-size: 20px;
}

.opinion-list {
	list-style-type: none; /* 기본 마커 제거 */
	padding: 0; /* 기본 패딩 제거 */
}

.opinion-entry {
	background-color: #EEEEEE;
	padding: 10px;
	border-radius: 10px;
	margin-bottom: 10px;
	font-size: 14px;
	position: relative;
	text-align: left; /* 왼쪽 정렬 */
	cursor: pointer; /* 포인터 커서 추가 */
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
<body>
<%@ include file="../header.jsp"%>
<%@ include file="../leftSideBar.jsp"%>
	<div class="container">
		<h1>${ideaTitle}</h1>
		<div class="column">
			<div class="box tab-smart">
				<a href="javascript:navigateToTab('tab-smart');" class="tab-title">똑똑이</a>
				<ul class="opinion-list">
					<c:choose>
						<c:when test="${empty smartOpinions}">
							<li class="no-opinions"><img
								src="./resources/noContents.png" alt="No opinions"
								style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
								<br>의견이 아직 등록되지 않았어요! <br>
							<br></li>
						</c:when>
						<c:otherwise>
							<c:forEach var="opinion" items="${smartOpinions}"
								varStatus="status">
								<c:if test="${status.index < 2}">
									<li class="opinion-entry" onclick="navigateToTab('tab-smart');">
										<span class="opinion-text">${opinion.userName}:
											${opinion.opinionText}</span>
										<div class="date">
											<fmt:formatDate value="${opinion.createdAt}"
												pattern="yyyy-MM-dd HH:mm" />
										</div>
									</li>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			<div class="box tab-positive">
				<a href="javascript:navigateToTab('tab-positive');"
					class="tab-title">긍정이</a>
				<ul class="opinion-list">
					<c:choose>
						<c:when test="${empty positiveOpinions}">
							<li class="no-opinions"><img
								src="./resources/noContents.png" alt="No opinions"
								style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
								<br>의견이 아직 등록되지 않았어요! <br>
							<br></li>
						</c:when>
						<c:otherwise>
							<c:forEach var="opinion" items="${positiveOpinions}"
								varStatus="status">
								<c:if test="${status.index < 2}">
									<li class="opinion-entry"
										onclick="navigateToTab('tab-positive');"><span
										class="opinion-text">${opinion.userName}:
											${opinion.opinionText}</span>
										<div class="date">
											<fmt:formatDate value="${opinion.createdAt}"
												pattern="yyyy-MM-dd HH:mm" />
										</div></li>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
		<div class="column">
			<div class="box tab-worry">
				<a href="javascript:navigateToTab('tab-worry');" class="tab-title">걱정이</a>
				<ul class="opinion-list">
					<c:choose>
						<c:when test="${empty worryOpinions}">
							<li class="no-opinions"><img
								src="./resources/noContents.png" alt="No opinions"
								style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
								<br>의견이 아직 등록되지 않았어요! <br>
							<br></li>
						</c:when>
						<c:otherwise>
							<c:forEach var="opinion" items="${worryOpinions}"
								varStatus="status">
								<c:if test="${status.index < 2}">
									<li class="opinion-entry" onclick="navigateToTab('tab-worry');">
										<span class="opinion-text">${opinion.userName}:
											${opinion.opinionText}</span>
										<div class="date">
											<fmt:formatDate value="${opinion.createdAt}"
												pattern="yyyy-MM-dd HH:mm" />
										</div>
									</li>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			<div class="box tab-strict">
				<a href="javascript:navigateToTab('tab-strict');" class="tab-title">깐깐이</a>
				<ul class="opinion-list">
					<c:choose>
						<c:when test="${empty strictOpinions}">
							<li class="no-opinions"><img
								src="./resources/noContents.png" alt="No opinions"
								style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
								<br>의견이 아직 등록되지 않았어요! <br>
							<br></li>
						</c:when>
						<c:otherwise>
							<c:forEach var="opinion" items="${strictOpinions}"
								varStatus="status">
								<c:if test="${status.index < 2}">
									<li class="opinion-entry"
										onclick="navigateToTab('tab-strict');"><span
										class="opinion-text">${opinion.userName}:
											${opinion.opinionText}</span>
										<div class="date">
											<fmt:formatDate value="${opinion.createdAt}"
												pattern="yyyy-MM-dd HH:mm" />
										</div></li>
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
