<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - A/B테스트 투표하기</title>
<style>
html, body {
	max-width: 100%;
	overflow-x: hidden;
}

.ab-body {
	font-family: KB금융 본문체 Light;
}

.ab-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
}

.topic {
    background-color: #f0f0f0;
    border-radius: 20px;
    padding: 15px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 50px;
}
.topic-left {
    display: flex;
    flex-direction: column;
    justify-content: center;
}
.topic-text {
    font-size: 18pt;
    font-weight: bold;
    margin-left: 20pt;
    margin-bottom: 10px;
    font-family: KB금융 제목체 Light;
}
.topic-content {
    font-size: 13pt;
    margin-left: 20pt;
}
.topic-image {
    max-height: 100px;
    width: auto;
    margin-left: 20pt;
    margin-right: 20pt;
}

.choices {
	display: flex;
	justify-content: center;
	margin-bottom: 20px;
}

.choice {
	margin: 0 100px;
	cursor: pointer;
}

.choice-title {
	font-size: 15pt;
	font-weight: bold;
	text-align: center;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 10px;
	font-family: KB금융 제목체 Light;
}

.choice-title input[type="checkbox"] {
	margin-right: 10px;
}

.choice img {
	width: 400px;
	height: auto;
	cursor: pointer;
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
	font-family: KB금융 본문체 Light;
}

.yellow-button:hover {
	background-color: #D4AA00;
}

.grey-button {
	background-color: #978A8F;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	cursor: pointer;
	font-weight: bold;
	font-family: KB금융 본문체 Light;
}

.grey-button:hover {
	background-color: #60584C;
}

.ab-modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0,0,0,0.4);
	font-family: KB금융 제목체 Light;
}

.ab-modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
	max-width: 800px;
}

.ab-close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.ab-close:hover,
.ab-close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.ab-modal-image {
	width: 100%;
	height: auto;
}
</style>
</head>

<body class="ab-body">
	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>
	
	<div class="ab-content">
		<div class="topic">
		    <div class="topic-left">
		        <div class="topic-text">[${abtest.testName}]</div>
		        <div class="topic-content">A시안과 B시안중에 더 좋은 화면을 골라주세요!</div>
		    </div>
		    <img src="<c:url value='./resources/abTitle.png'/>" alt="abTitleImg" class="topic-image">
		</div>

		<form action="./abTestVote" method="post" id="voteForm">
			<div class="choices">
				<div class="choice" id="choiceA">
					<div class="choice-title">
						<input type="checkbox" name="pick" value="1">
						A 시안
					</div>
					<img src="./upload/${abtest.variantA}" alt="Image A" onclick="showModal(this.src, 'A 시안')">
				</div>
				<div class="choice" id="choiceB">
					<div class="choice-title">
						<input type="checkbox" name="pick" value="0">
						B 시안
					</div>
					<img src="./upload/${abtest.variantB}" alt="Image B" onclick="showModal(this.src, 'B 시안')">
				</div>
			</div>
			<input type="hidden" name="abTestId" value="${abtest.ABTestID}">
			<input type="hidden" name="userId" value="${userId}">
			<div style="text-align: center; margin-top:50px; margin-bottom: 200px;">
				<button type="submit" class="yellow-button">투표 제출</button>
			</div>
		</form>
	</div>

	<div id="abTestModal" class="ab-modal">
	    <div class="ab-modal-content">
	        <span class="ab-close">&times;</span>
	        <h2 id="modalTitle">이미지 상세보기</h2>
	        <img id="modalImage" class="ab-modal-image" src="" alt="확대된 이미지">
	    </div>
	</div>

	<script>
    function showModal(imgSrc, title) {
        var modal = document.getElementById("abTestModal");
        var modalImg = document.getElementById("modalImage");
        var modalTitle = document.getElementById("modalTitle");
        
        modal.style.display = "block";
        modalImg.src = imgSrc;
        modalTitle.innerHTML = "이미지 상세보기 - " + title;
    }

    var span = document.getElementsByClassName("ab-close")[0];
    span.onclick = function() {
        var modal = document.getElementById("abTestModal");
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        var modal = document.getElementById("abTestModal");
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    checkboxes.forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
            checkboxes.forEach(function(cb) {
                if (cb !== checkbox) cb.checked = false;
            });
        });
    });
</script>
</body>
</html>