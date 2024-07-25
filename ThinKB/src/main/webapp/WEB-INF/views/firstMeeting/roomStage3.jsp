<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.content-container {
	padding: 20px;
	margin-left: 15%;
	margin-right: 15%;
	position: relative;
	z-index: 2;
}

body {
	padding-top: 100px;
}

.timer-container {
	margin-top: 30px;
	display: flex;
	align-items: center;
}

.timer-label {
	margin-right: 10px;
	font-size: 20px;
	font-weight: bold;
}

.timer-input {
	width: 60px;
	padding: 8px;
	border: 2px solid #666;
	border-radius: 5px;
	font-size: 16px;
	text-align: center;
}

.timer-input:hover {
	border-color: #ffcc00;
}

.button {
	background-color: #4CAF50;
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
}

.ideas {
	margin: 70px 20px;
}

.idea {
	padding: 20px;
	background-color: #ffffff;
	border-radius: 20px;
	margin-top: 30px;
	margin-left: auto;
	margin-right: auto;
	border: 1px solid #ccc;
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	font-size: 1.2em;
	width: 80%;
	cursor: pointer;
	transition: box-shadow 0.3s ease;
}

.idea:hover {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 커서를 대면 그림자 추가 */
}

.idea h2 {
	margin: 0 0 10px 0;
	padding: 0;
	font-size: 1.5em;
	width: 100%;
}

.idea-details {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	text-align: right;
	width: 100%;
}

.idea-details p {
	margin: 0;
}

.idea-left {
	text-align: left;
}

.idea-right {
	text-align: right;
	align-self: flex-end;
	justify-content: flex-end;
	display: flex;
	flex-direction: column;
}
</style>
</head>
<body>
	<%@ include file="../header.jsp"%>

	<div class="content-container">
		<h1>투표 결과 선택된 아이디어</h1>
		<div class="ideas">
			<c:forEach var="li" items="${yesPickList}">
				<div class="idea"
					onclick="window.location.href='./ideaOpinions?roomId=${li.getRoomID()}&ideaId=${li.getIdeaID()}&currentTab='">
					<h2>${li.getTitle()}</h2>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>