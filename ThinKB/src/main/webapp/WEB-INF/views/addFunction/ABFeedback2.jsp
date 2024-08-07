<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ABTest 투표</title>
<style>
/* 기존 스타일 */
body, html {
	max-width: 100%;
	overflow-x: hidden;
}

.ab-feedback-detail-body {
	font-family: Arial, sans-serif;
	align-items: center;
}

.ab-feedback-container {
	display: flex;
	flex-direction: row;
	width: 100%;
	margin-bottom: 5%;
}

.abfd-box {
	width: auto; /* 너비를 100%로 설정 */
	padding: 10px 0; /* 패딩 추가 */
	margin-top: 50px;
	margin-left: 10%;
	margin-right: 10%;
}

.abfd-title {
	font-size: 24px;
	font- color: #000000;
	text-align: left;
	/* 	margin-left: 15%; */
	font-weight: bold;
	text-align: left;
	margin-bottom: 5%;
}

.abfd-buttons {
	display: flex;
	justify-content: end;
	/* 	margin-left: 15%;
	margin-right: 15%; */
}

.yellow-button {
	background-color: #FFCC00;
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	cursor: pointer;
	font-weight: bold;
}

.yellow-button:hover {
	background-color: #D4AA00;
}

/* 회색버튼 */
.grey-button {
	background-color: #978A8F;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	cursor: pointer;
	font-weight: bold;
}

.grey-button:hover {
	background-color: #60584C;
	s
}

.abtestHeadImg {
	width: auto;
	background-size: cover; /* 이미지가 요소에 완전히 맞도록 비율을 조정 */
	background-position: center; /* 이미지를 가운데 정렬 */
	background-repeat: no-repeat;
}

.ab-feedback-image-detail {
	width: 30%;
	margin-left: 8%;
	margin-right: 2%;
	/* 	background-color: red; */
}

.ab-feedback-detail-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	padding: 20px;
}

.topic {
	font-size: 1.5em;
	font-weight: bold;
	margin-bottom: 20px;
}

.choice img {
	margin-top: 5%;
	width: auto;
	height: auto;
}

.submit-button {
	background-color: #ffc107;
	color: #ffffff;
	font-size: 1.2em;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 20px;
}

.submit-button:hover {
	background-color: #e0a800;
}

.coordinate-button {
    position: absolute;
    background-color: #60584C;
    border: none;
    width: 60px;
    height: 60px;
    cursor: pointer;
    border-radius: 30px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 10; /* 높은 z-index 값을 주어 다른 요소들 위에 표시되도록 함 */
}

.coordinate-button::before {
    content: "";
    position: absolute;
    width: 45px;
    height: 45px;
    border-radius: 50%;
    background-size: cover;
    background-position: center;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-image: var(--profile-img);
    z-index: 11; /* 버튼보다 높은 z-index 값을 주어 이미지가 버튼 위에 표시되도록 함 */
}

.coordinate-button::after {
    content: "";
    position: absolute;
    bottom: -17px;
    left: 50%;
    transform: translateX(-50%);
    width: 0;
    height: 0;
    border: 10px solid transparent;
    border-top-color: #60584C;
    z-index: 9; /* 화살표가 이미지 아래에 위치하도록 함 */
}
.coordinate-form {
    position: absolute;
    background-color: white;
    border: 1px solid #ccc;
    padding: 20px;
    z-index: 1000;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 250px;
}

.coordinate-form textarea {
    width: 100%;
    height: 60px;
    border-radius: 5px;
    border: 1px solid #ccc;
    padding: 10px;
    box-sizing: border-box;
    margin-bottom: 10px;
}

 .coordinate-form button {
    padding: 5px 10px;
    margin-right: 10px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}
 
.coordinate-form .submit-button {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: #4CAF50;
    color: white;
    border: none;
    cursor: pointer;
    position: absolute;
    right: -20px;
    top: 50%;
    transform: translateY(-50%);
    display: flex;
    align-items: center;
    justify-content: center;
}
.coordinate-form .close-button {
    background-color: transparent;
    border: none;
    color: #aaa;
    font-size: 20px;
    font-weight: bold;
    cursor: pointer;
    position: absolute;
    right: 10px;
    top: 10px;
}
.coordinate-form .close-button:hover {
    color: #000;
}
.comment {
	background-color: #f5f5f5;
	border: 1px solid #ccc;
	padding: 10px;
	margin-bottom: 10px;
	position: relative;
	border-radius: 5px;
}

.delete-button {
	position: absolute;
	top: 10px;
	right: 10px;
	color: white;
	border: none;
	padding: 5px;
	cursor: pointer;
	border-radius: 5px;
}

.ab-feedback-message-detail {
	width: 50%;
	margin-right: 8%;
	margin-left: 2%;
	border-radius: 20px;
	padding: 20px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.how-to-feedback {
	width: 97%;
	display: flex;
	align-items: center;
	padding: 20px;
	background-color: #8c8c8c;
	border-radius: 50px;
	margin-bottom: 20px;
}

.how-to-profile {
	width: 65px;
	height: 65px;
	border-radius: 50%;
	margin-right: 10px;
	background-image:
		url('${pageContext.request.contextPath}/resources/ccoli.png');
	/* background-size: cover; */
	background-position: center;
	justify-content: center;
	display: flex;
	align-items: center;
}

.how-to-text {
	color: white;
	display: flex;
	flex-direction: column;
	margin-left: 2%;
}

.how-to-title {
	font-size: 13pt;
	font-weight: bold;
	margin-bottom: -4px;
}

.how-to-description {
	font-size: 11pt;
	margin-top: -4px;
}

.comments-container {
	width: 100%;
	background-color: #EBEBEB;
	padding: 10px;
	margin-left: 10px;
	margin-right: 10px;
	border-radius: 20px;
	min-height: 90%;
}

.ab-feedback-title {
	font-size: 18pt;
	font-weight: bold;
	margin-bottom: 10px;
	text-align: center;
	margin-top: 50px;
}

.ab-feedback-date {
	font-size: 10pt;
	color: #666;
	text-align: center;
	margin-bottom: 100px;
}

.abfd-comment {
	display: flex;
	align-items: center;
	padding: 10px 20px;
	background-color: white;
	border-radius: 50px;;
	margin-bottom: 15px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin-left: 40px;
	margin-right: 40px;
}

.abfd-comment-profile img {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	margin-left: -5px;
	margin-right: 20px;
}

.abfd-comment-detail {
	display: flex;
	flex-direction: column;
}

.abfd-comment-userInfo {
	display: flex;
	align-items: center;
	margin-bottom: 5px;
}

.abfd-comment-userName {
	font-size: 12pt;
	font-weight: bold;
	margin-right: 10px;
}

.abfd-comment-date {
	font-size: 9pt;
	color: #666;
}

.abfd-comment-text {
	font-size: 10pt;
}
</style>
<script type="text/javascript">
    window.onload = function() {
        displayExistingComments();
    };

    var currentTempButton = null;
    var existingButtons = [];

    function sendCoordinates(event) {
        var x = event.clientX + window.scrollX;
        var y = event.clientY + window.scrollY;

        createCoordinateButton(x, y);
    }

    function createCoordinateButton(x, y, isExisting = false, profileImg = null) {
        var button = document.createElement("button");
        button.className = "coordinate-button";
        button.style.left = (x - 30) + "px";
        button.style.top = (y - 30) + "px";
        if (profileImg) {
            button.style.setProperty('--profile-img', 'url(' + profileImg + ')');
        }

        button.onclick = function(event) { 
            event.stopPropagation();
            showCommentForm(x, y); 
        };
        document.body.appendChild(button);

        if (isExisting) {
            existingButtons.push(button);
        } else {
            if (currentTempButton) {
                document.body.removeChild(currentTempButton);
            }
            currentTempButton = button;
            showCommentForm(x, y);
        }
    }

    function showCommentForm(x, y) {
        var form = document.createElement("div");
        form.className = "coordinate-form";
        form.style.left = (x + 40) + "px";
        form.style.top = (y - 30) + "px";

        var textarea = document.createElement("textarea");
        form.appendChild(textarea);

        var submitButton = document.createElement("button");
        submitButton.className = "submit-button";
        submitButton.innerHTML = "✔";
        submitButton.onclick = function() { submitComment(x, y, textarea.value); };
        form.appendChild(submitButton);

        var closeButton = document.createElement("button");
        closeButton.className = "close-button";
        closeButton.innerHTML = "×";
        closeButton.onclick = function() { closeCommentForm(form); };
        form.appendChild(closeButton);

        document.body.appendChild(form);
        form.style.display = "block";

        displayCommentsAtPosition(x, y, form);
    }

    function closeCommentForm(form) {
        document.body.removeChild(form);
        if (currentTempButton) {
            document.body.removeChild(currentTempButton);
            currentTempButton = null;
        }
        location.reload();
    }

    function submitComment(x, y, commentText) {
        var abTestId = document.getElementById("abTestId").value;
        var userId = document.getElementById("userId").value;

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "${pageContext.request.contextPath}/addComment", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                console.log("Comment submitted successfully");
                if (currentTempButton) {
                    existingButtons.push(currentTempButton);
                    currentTempButton = null;
                }
                location.reload();
            }
        };
        var data = "x=" + encodeURIComponent(x) + "&y=" + encodeURIComponent(y) + "&abTestId=" + encodeURIComponent(abTestId) + "&userId=" + encodeURIComponent(userId) + "&commentText=" + encodeURIComponent(commentText);
        xhr.send(data);
    }

    function displayExistingComments() {
        var comments = document.getElementById("commentsData").getElementsByTagName("div");

        for (var i = 0; i < comments.length; i++) {
            var comment = comments[i];
            var x = parseFloat(comment.getAttribute("data-x"));
            var y = parseFloat(comment.getAttribute("data-y"));
            var profileImg = comment.getAttribute("data-profile-img");

            console.log(`Displaying button at x: ${x}, y: ${y}`);

            createCoordinateButton(x, y, true, profileImg);
        }
    }

    function displayCommentsAtPosition(x, y, form) {
        var comments = document.getElementById("commentsData").getElementsByTagName("div");
        var currentUserId = document.getElementById("userId").value;

        for (var i = 0; i < comments.length; i++) {
            var comment = comments[i];
            var commentX = parseFloat(comment.getAttribute("data-x"));
            var commentY = parseFloat(comment.getAttribute("data-y"));

            if (commentX === x && commentY === y) {
                var userName = comment.getAttribute("data-username");
                var commentText = comment.getAttribute("data-comment");
                var commentId = comment.getAttribute("data-comment-id");
                var commentUserId = comment.getAttribute("data-user-id");

                var commentDiv = document.createElement("div");
                commentDiv.className = "comment";
                commentDiv.innerHTML = "<strong>" + userName + ":</strong> " + commentText;

                if (currentUserId === commentUserId) {
                    var deleteButton = document.createElement("button");
                    deleteButton.className = "delete-button";
                    deleteButton.innerHTML = "Delete";
                    deleteButton.onclick = function() { deleteComment(commentId, commentDiv); };
                    commentDiv.appendChild(deleteButton);
                }

                form.appendChild(commentDiv);
            }
        }
    }

    function deleteComment(commentId, commentDiv) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "${pageContext.request.contextPath}/deleteComment", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                console.log("Comment deleted successfully");
                commentDiv.parentNode.removeChild(commentDiv);
            }
        };
        var data = "commentId=" + encodeURIComponent(commentId);
        xhr.send(data);
        location.reload();
    }
</script>
</head>

<body class="ab-feedback-detail-body">
	<!-- 상단 헤더 -->
	<div class="abtestHeadImg">
		<%@ include file="../header.jsp"%>
	</div>

	<!-- 페이지 제목, 이동버튼  -->
	<div class="abfd-box">
		<div class="abfd-title">A/B테스트 결과 피드백</div>
		<div class="abfd-buttons">
			<a href="./AorBFeedbackList"><button class="grey-button"
					style="margin-right: 20px;">피드백 목록</button></a> <a
				href="./completedTestDetail?abTestId=${abtest.ABTestID}"><button
					class="yellow-button">A/B테스트 결과 보기</button></a>
		</div>
	</div>

	<!-- 메인내용 -->
	<div class="ab-feedback-container">
		<!-- a/b테스트 선택된 이미지 -->
		<div class="ab-feedback-image-detail" onclick="sendCoordinates(event)">
			<div class="ab-feedback-detail-container">
				<div class="choice">
					<c:choose>
						<c:when test="${aPercentage >= bPercentage}">
							<img
								src="${pageContext.request.contextPath}/upload/${abtest.variantA}"
								alt="Image A">
						</c:when>
						<c:otherwise>
							<img
								src="${pageContext.request.contextPath}/upload/${abtest.variantB}"
								alt="Image B">
						</c:otherwise>
					</c:choose>
				</div>
				<input type="hidden" id="abTestId" name="abTestId"
					value="${abtest.ABTestID}"> <input type="hidden"
					id="userId" name="userId" value="${userId}">
				<div id="commentsData" style="display: none;">
					<c:forEach var="comment" items="${comments}">
						<div data-x="${comment.x}" data-y="${comment.y}"
							data-username="${comment.userName}"
							data-comment="${comment.commentText}"
							data-comment-id="${comment.commentId}"
							data-user-id="${comment.userID}"
							data-profile-img="${pageContext.request.contextPath}/upload/${comment.userProfileImg}"></div>
					</c:forEach>
				</div>
			</div>
		</div>

		<!-- 이미지에 달린 메모 -->
		<div class="ab-feedback-message-detail">
			<div class="how-to-feedback">
				<div class="how-to-profile"></div>
				<div class="how-to-text">
					<a class="how-to-title">핀 메모 사용법</a> <br> <a
						class="how-to-description">피드백이 필요한 부분을 클릭해 메모를 남겨보세요</a>
				</div>
			</div>
			<div class="comments-container">
				<div class="ab-feedback-title">${abtest.testName}</div>
				<div class="ab-feedback-date">${abtest.createdAt}</div>
				<c:choose>
				    <c:when test="${empty comments}">
				        <div class="abfd-comment">
				            <div class="abfd-comment-profile">
				                <img
				                    src="${pageContext.request.contextPath}/resources/ccoli.png"
				                    alt="ThinKB" class="profile-img">
				            </div>
				            <div class="abfd-comment-detail">
				                <div class="abfd-comment-userInfo">
				                    <div class="abfd-comment-userName">ThinKB</div>
				                    <div class="abfd-comment-date">2024-01-01</div>
				                </div>
				                <div class="abfd-comment-text">첫 메모를 등록해보세요!</div>
				            </div>
				        </div>
				    </c:when>
				    <c:otherwise>
				        <c:forEach var="abfd" items="${comments}">
				            <div class="abfd-comment">
				                <div class="abfd-comment-profile">
				                    <img
				                        src="${pageContext.request.contextPath}/upload/${abfd.userProfileImg}"
				                        alt="${abfd.userName}" class="profile-img">
				                </div>
				                <div class="abfd-comment-detail">
				                    <div class="abfd-comment-userInfo">
				                        <div class="abfd-comment-userName">${abfd.userName}</div>
				                        <div class="abfd-comment-date">${abfd.timestamp}</div>
				                    </div>
				                    <div class="abfd-comment-text">${abfd.commentText}</div>
				                </div>
				            </div>
				        </c:forEach>
				    </c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</body>
</html>