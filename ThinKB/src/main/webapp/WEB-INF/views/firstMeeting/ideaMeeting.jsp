<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디어 투표</title>
<style>
body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
}

.idea_header {
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1000;
}

.content {
	margin-top: 60px; /* 헤더 높이만큼 여백 추가 */
	display: flex;
	flex-direction: column;
	align-items: center;
}

.topic-box {
	width: 962px;
	height: 150px;
	background-color: #EEEEEE;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: left;
	margin-top: 90px;
}

.topic-title {
	font-size: 25px;
	text-align: left;
	margin-left: 20px;
}

.topic-description {
	font-size: 20px;
	text-align: left;
	margin-left: 30px;
}

.idea-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 20px;
}

.idea-item {
	display: flex;
	align-items: center;
	margin-top: 10px;
}

.idea-circle {
	width: 96px;
	height: 96px;
	border-radius: 50%;
	background-color: #EEEEEE;
	margin-right: 10px;
	cursor: pointer;
}

.idea-circle.selected {
	background-color: #FFCE20;
}

.idea-box {
	width: 849px;
	height: 96px;
	background-color: #EEEEEE;
	border-radius: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 20px;
}

.idea-box.selected {
	background-color: #FFCE20;
}

.vote-button {
	width: 216px;
	height: 53px;
	background-color: #FFCE20;
	border: none;
	border-radius: 10px;
	font-size: 20px;
	cursor: pointer;
	margin-top: 20px;
}
</style>
<script>
	let selectedIdea = null;

	function toggleSelect(element) {
		if (selectedIdea) {
			selectedIdea.classList.remove('selected');
		}
		if (selectedIdea !== element) {
			element.classList.add('selected');
			selectedIdea = element;
		} else {
			selectedIdea = null;
		}
	}

	function submitVote() {
		if (selectedIdea) {
			const selectedTitle = selectedIdea.innerText;

			// 폼 생성 및 제출
			const form = document.createElement('form');
			form.method = 'POST';
			form.action = '${pageContext.request.contextPath}/submitVote'; // 실제 투표 제출 경로로 변경

			const input = document.createElement('input');
			input.type = 'hidden';
			input.name = 'selectedIdea';
			input.value = selectedTitle;

			const roomIdInput = document.createElement('input');
			roomIdInput.type = 'hidden';
			roomIdInput.name = 'roomId';
			roomIdInput.value = '${meetingRoom.roomId}';

			const roomTitleInput = document.createElement('input');
			roomTitleInput.type = 'hidden';
			roomTitleInput.name = 'roomTitle';
			roomTitleInput.value = '${meetingRoom.roomTitle}';

			const userIdInput = document.createElement('input');
			userIdInput.type = 'hidden';
			userIdInput.name = 'userId';
			userIdInput.value = '${sessionScope.userId}';

			form.appendChild(input);
			form.appendChild(roomIdInput);
			form.appendChild(userIdInput);
			form.appendChild(roomTitleInput);
			document.body.appendChild(form);
			form.submit();

		} else {
			alert('아이디어를 선택하세요.');
		}
	}
	window.onload = function() {
		<%
			String message = (String) session.getAttribute("Message");
			if (message != null) {
				session.removeAttribute("Message");
		%>
			const message = "<%= message %>";
			if (message) {
				alert(message);
			}
		<%
			}
		%>
	};

</script>
</head>
<body>
	<div class="idea_header">
		<jsp:include page="../header.jsp" />
	</div>
	<div class="content">
		<div class="topic-box">
			<div class="topic-title">
				${meetingRoom.roomTitle} <input type="hidden" name="roomId"
					value="${meetingRoom.roomId}" />
			</div>
			<div class="topic-description">${meetingRoom.description}</div>
		</div>
		<div class="idea-container">
			<c:forEach var="idea" items="${ideas}">
				<div class="idea-item">
					<div class="idea-circle"></div>
					<div class="idea-box" onclick="toggleSelect(this)">${idea.title}</div>
				</div>
			</c:forEach>
		</div>
		<button class="vote-button" onclick="submitVote()">투표하기1</button>
	</div>
</body>
</html>
