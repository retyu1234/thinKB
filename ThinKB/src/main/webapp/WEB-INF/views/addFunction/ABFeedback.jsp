<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    overflow: hidden;
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
    width: 360px;
    height: 800px;
    object-fit: cover; /* 비율을 유지하면서 가로 세로를 꽉 채우도록 설정 */
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
}
</style>
<script type="text/javascript">
    window.onload = function() {
        displayExistingComments();
    };

    function sendCoordinates(event) {
        var x = event.clientX;
        var y = event.clientY;
        var abTestId = document.getElementById("abTestId").value;
        var userId = document.getElementById("userId").value;

        // 좌표가 범위 내에 있는지 확인
        if (x >= 887 && x <= 1246 && y >= 151 && y <= 947) {
            createCoordinateButton(x, y);
        } else {
            console.log("Click is outside the allowed range.");
        }
    }

    function createCoordinateButton(x, y) {
        var button = document.createElement("button");
        button.className = "coordinate-button";
        button.style.left = x + "px";
        button.style.top = y + "px";
        button.innerHTML = "◆";
        button.onclick = function() { showCommentForm(x, y); };
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
        submitButton.onclick = function() { submitComment(x, y, textarea.value); };
        form.appendChild(submitButton);

        var closeButton = document.createElement("button");
        closeButton.innerHTML = "Close";
        closeButton.onclick = function() { closeCommentForm(form); };
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
        var abTestId = document.getElementById("abTestId").value;
        var userId = document.getElementById("userId").value;

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "${pageContext.request.contextPath}/addComment", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                console.log("Comment submitted successfully");
                // 페이지 새로고침
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

                var commentDiv = document.createElement("div");
                commentDiv.className = "comment";
                commentDiv.innerHTML = "<strong>" + userName + ":</strong> " + commentText;
                form.appendChild(commentDiv);
            }
        }
    }
</script>
</head>

<body class="ab-body" onclick="sendCoordinates(event)">
    <div class="abtestHeadImg">
        <%@ include file="../header.jsp" %>
    </div>
    <div class="container">
        <div class="topic">${abtest.testName}</div>
        <div class="choice">
            <c:choose>
                <c:when test="${aPercentage >= bPercentage}">
                    <img src="${pageContext.request.contextPath}/upload/${abtest.variantA}" alt="Image A">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/upload/${abtest.variantB}" alt="Image B">
                </c:otherwise>
            </c:choose>
        </div>
        <input type="hidden" id="abTestId" name="abTestId" value="${abtest.ABTestID}">
        <input type="hidden" id="userId" name="userId" value="${userId}">
        <div id="commentsData" style="display:none;">
            <c:forEach var="comment" items="${comments}">
                <div data-x="${comment.x}" data-y="${comment.y}" data-username="${comment.userName}" data-comment="${comment.commentText}"></div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
