<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ABTest 투표</title>
<style>
body, html {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
}

.ab-body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 100%;
}

.abtestHeadImg {
	width: 100%;
	background-size: cover; /* 이미지가 요소에 완전히 맞도록 비율을 조정 */
	background-position: center; /* 이미지를 가운데 정렬 */
	background-repeat: no-repeat;
}

.container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

.topic {
	font-size: 1.5em;
	font-weight: bold;
	margin-bottom: 20px;
}

.choice img {
	width: 100%;
	height: 100%;
}

.submit-button, .stop-button {
	background-color: #ffc107;
	color: #ffffff;
	font-size: 1.2em;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 20px;
}

.submit-button:hover, .stop-button:hover {
	background-color: #e0a800;
}

.coordinate-button {
	position: absolute;
	background-color: #4CAF50;
	color: white;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
}

.coordinate-form {
	display: none;
	position: absolute;
	background-color: white;
	border: 1px solid #ccc;
	padding: 20px;
	z-index: 1000;
}

.coordinate-form textarea {
	width: 100%;
	height: 100px;
}

.comment {
	background-color: #f5f5f5;
	border: 1px solid #ccc;
	padding: 10px;
	margin-bottom: 10px;
	position: relative;
}

.delete-button {
	position: absolute;
	top: 10px;
	right: 10px;
	background-color: red;
	color: white;
	border: none;
	padding: 5px;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	window.onload = function() {
		displayExistingComments();
	};

	function sendCoordinates(event) {
		var x = event.clientX;
		var y = event.clientY;
		var pinTestId = document.getElementById("pinTestId").value;
		var userId = document.getElementById("userId").value;

		createCoordinateButton(x, y);

	}

	function createCoordinateButton(x, y) {
		var button = document.createElement("button");
		button.className = "coordinate-button";
		button.style.left = x + "px";
		button.style.top = y + "px";
		button.innerHTML = "◆";
		button.onclick = function() {
			showCommentForm(x, y);
		};
		document.body.appendChild(button);
	}

	function showCommentForm(x, y) {
		var form = document.createElement("div");
		form.className = "coordinate-form";
		form.style.left = x + "px";
		form.style.top = y + "px";

		var textarea = document.createElement("textarea");
		form.appendChild(textarea);

		var submitButton = document.createElement("button");
		submitButton.innerHTML = "Submit";
		submitButton.onclick = function() {
			submitComment(x, y, textarea.value);
		};
		form.appendChild(submitButton);

		var closeButton = document.createElement("button");
		closeButton.innerHTML = "Close";
		closeButton.onclick = function() {
			closeCommentForm(form);
		};
		form.appendChild(closeButton);

		document.body.appendChild(form);
		form.style.display = "block";

		// 기존 댓글 표시
		displayCommentsAtPosition(x, y, form);
	}

	function closeCommentForm(form) {
		document.body.removeChild(form);
		// 페이지 새로고침
		location.reload();
	}

	function submitComment(x, y, commentText) {
		var pinTestId = document.getElementById("pinTestId").value;
		var userId = document.getElementById("userId").value;

		var xhr = new XMLHttpRequest();
		xhr.open("POST", "${pageContext.request.contextPath}/addComment", true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				console.log("Comment submitted successfully");
				// 페이지 새로고침
				location.reload();
			}
		};
		var data = "x=" + encodeURIComponent(x) + "&y=" + encodeURIComponent(y) + "&pinTestId=" + encodeURIComponent(pinTestId) + "&userId=" + encodeURIComponent(userId) + "&commentText=" + encodeURIComponent(commentText);
		xhr.send(data);
	}

	function displayExistingComments() {
		var comments = document.getElementById("commentsData").getElementsByTagName("div");

		for (var i = 0; i < comments.length; i++) {
			var comment = comments[i];
			var x = comment.getAttribute("data-x");
			var y = comment.getAttribute("data-y");

			createCoordinateButton(x, y);
		}
	}

	function displayCommentsAtPosition(x, y, form) {
		var comments = document.getElementById("commentsData").getElementsByTagName("div");

		for (var i = 0; i < comments.length; i++) {
			var comment = comments[i];
			if (comment.getAttribute("data-x") == x && comment.getAttribute("data-y") == y) {
				var userName = comment.getAttribute("data-username");
				var commentText = comment.getAttribute("data-comment");
				var commentId = comment.getAttribute("data-comment-id");

				var commentDiv = document.createElement("div");
				commentDiv.className = "comment";
				commentDiv.innerHTML = "<strong>" + userName + ":</strong> " + commentText;

				// Create delete button
				var deleteButton = document.createElement("button");
				deleteButton.className = "delete-button";
				deleteButton.innerHTML = "Delete";
				deleteButton.onclick = function() {
					deleteComment(commentId, commentDiv);
				};
				commentDiv.appendChild(deleteButton);

				form.appendChild(commentDiv);
			}
		}
	}

	function deleteComment(commentId, commentDiv) {
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "${pageContext.request.contextPath}/deleteComment", true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				console.log("Comment deleted successfully");
				// 페이지 새로고침
				location.reload();
			}
		};
		var data = "commentId=" + encodeURIComponent(commentId);
		xhr.send(data);
	}

	function stopTest() {
		var pinTestId = document.getElementById("pinTestId").value;
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "${pageContext.request.contextPath}/stopTest", true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				console.log("Test stopped successfully");
				// 페이지 새로고침 대신 페이지 이동
				window.location.href = "${pageContext.request.contextPath}/pinList";
			}
		};
		var data = "pinTestId=" + encodeURIComponent(pinTestId);
		xhr.send(data);
	}
</script>
</head>


<body class="ab-body" onclick="sendCoordinates(event)">
	<div class="abtestHeadImg">
		<%@ include file="../header.jsp"%>
	</div>
	<div class="container">
		<div class="topic">${pinTest.testName}</div>
		<div class="choice">
			<c:choose>
				<c:when test="${not empty pinTest.fileName}">
					<img src="${pageContext.request.contextPath}/upload/${pinTest.fileName}" alt="Image">
				</c:when>
				<c:otherwise>
					<p>No image available</p>
				</c:otherwise>
			</c:choose>
		</div>
		<input type="hidden" id="pinTestId" name="pinTestId" value="${pinTest.pinTestId}">
		<input type="hidden" id="userId" name="userId" value="${userId}">
		<c:if test="${pinTest.userId == userId}">
			<button class="stop-button" onclick="stopTest()">테스트 중단하기</button>
		</c:if>
		<div id="commentsData" style="display: none;">
			<c:forEach var="comment" items="${comments}">
				<div data-x="${comment.x}" data-y="${comment.y}" data-username="${comment.userName}"
					data-comment="${comment.commentText}" data-comment-id="${comment.commentId}"></div>
			</c:forEach>
		</div>
	</div>
</body>
</html>
