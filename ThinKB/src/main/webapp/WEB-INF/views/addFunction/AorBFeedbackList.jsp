<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThinkKB</title>
<style>
.ab-body {
 font-family: 'KB금융 본문체 Light';
	background-color: #FFFFf1;
}

.header1 {
	text-align: center;
}

.header1 img {
	width: 100%;
	height: auto;
	max-height: 500px;
}

.button-container {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 10px;
}

.progress-container {
	display: flex;
	justify-content: center;
	margin: 10px 0;
}

.progress {
	background-color: #ffffff;
	padding: 10px;
	border-radius: 25px;
	display: flex;
	justify-content: space-around;
	height: 50px;
	width: 80%;
	border: 1px solid #ccc;
	font-size: 1.3em;
	justify-content: flex-start;
}

.progress label {
	display: flex;
	align-items: center;
	margin-left: 40px;
}

.progress input {
	margin-right: 5px;
}

.progress-header-container {
	display: flex;
	justify-content: left;
	width: 80%;
	margin: 0 auto;
	margin-top: 50px;
}

.progress-header {
	margin: 0;
	padding: 10px 0;
}

.ideas {
	margin: 30px 20px;
}

.idea {
	padding: 20px 20px;
	background-color: #ffffff;
	border-radius: 10px;
	margin-top: 30px;
	margin-left: auto;
	margin-right: auto;
	height: 100px;
	width: 80%;
	border: 1px solid #ccc;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
	font-size: 1.2em;
	cursor: pointer;
}

.idea h3, .idea p {
	margin: 0;
}

.idea-left {
	text-align: left;
}

.idea-right {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	height: 100%;
}

.idea-status {
	padding: 10px 20px;
	border-radius: 10px;
	color: white;
	font-weight: bold;
	 font-family: 'KB금융 제목체 Light';
	text-align: center;
	background-color: #EAEAEA;
}

.vote-button-container {
	display: flex;
	justify-content: center;
	margin-top: 30px;
}

.vote-button {
	background-color: #ffc107;
	font-size: 1.2em;
	border: none;
	width: 300px;
	padding: 15px 30px;
	border-radius: 25px;
	cursor: pointer;
}

.vote-button:hover {
	background-color: #e0a800;
}
</style>
</head>

<body class="ab-body">
	<%@ include file="../header.jsp"%>
	<div class="header1">
		<img src="./resources/header2.jpg" alt="Header Image">
	</div>
	<div class="progress-header-container">
		<h2 class="progress-header">진행중인 피드백 단계</h2>
	</div>
	<div class="ideas">
		<c:forEach var="test" items="${feedbackTests}">
			<div class="idea" onclick="redirectToFeedback(${test.ABTestID})">
				<div class="idea-left">
					<h3>${test.testName}</h3>
				</div>
				<div class="idea-right">
					<div class="idea-status">투표 완료</div>
				</div>
			</div>
		</c:forEach>
	</div>
</body>

<script>
function redirectToFeedback(abTestId) {
    window.location.href = './ABFeedback?abTestId=' + abTestId;
}
</script>
</html>
