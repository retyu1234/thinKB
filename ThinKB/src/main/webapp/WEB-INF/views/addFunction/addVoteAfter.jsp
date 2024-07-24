<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 결과</title>
<style>
body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
}

.option_header {
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1000;
}

.content {
	margin-top: 120px; /* 헤더 높이만큼 여백 추가 */
	display: flex;
	flex-direction: column;
	align-items: center;
}

.topic-box {
	width: 100%;
	max-width: 850px;
	padding: 20px;
	margin-bottom: 20px;
	background-color: rgba(255, 255, 255, 0.8);
	border: 1px solid #7f6000;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	box-sizing: border-box;
	text-align: center;
	position: relative;
}

.topic-title {
	width: auto;
	position: relative;
	font-weight: 600;
	display: inline-block;
	z-index: 1;
}

.er {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 20px;
}

.option-item {
	display: flex;
	align-items: center;
	margin-top: 10px;
}

.option-box {
	width: 849px;
	height: 96px;
	background-color: #EEEEEE;
	border-radius: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 20px;
	position: relative;
	cursor: pointer;
}

.option-box.voted {
	background-color: #A9A9A9;
	cursor: default;
	pointer-events: none;
}

.option-box .vote-count {
	position: absolute;
	bottom: 10px;
	right: 10px;
	font-size: 16px;
	color: #000;
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
</head>
<body>
	<input type="hidden" id="session-user-id" value="${sessionScope.userId}">

	<div class="option_header">
		<jsp:include page="../header.jsp" />
	</div>
	<div class="content">
		<div class="div">
			<div class="selected-option">
				<div class="topic-box">
					<div class="topic-title">${voteInfo.title}</div>
				</div>
			</div>
			<div class="topic-container">
				<c:forEach var="option" items="${optionList}">
					<div class="option-item">
						<div class="option-box ${votedOptionId != null && votedOptionId == option.optionId ? 'voted' : ''}">
							${option.optionText}
							<div class="vote-count">${option.voteCount}표</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<script>
		let selectedOption = null;
		let selectedOptionId = null;

		function toggleSelect(element, optionId, optionText, isCircle) {
			if (selectedOption) {
				selectedOption.classList.remove('selected');
			}
			if (selectedOption !== element) {
				element.classList.add('selected');
				selectedOption = element;
				selectedOptionId = optionId;
			} else {
				selectedOption = null;
				selectedOptionId = null;
			}
		}

		window.onload = function() {
			const message = '${errorMessage}';
			if (message) {
				alert(message);
			}
		}
	</script>
</body>
</html>
