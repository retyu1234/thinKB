<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - 투표하기</title>
<style>
html, body {
    max-width: 100%;
    overflow-x: hidden;
}
.vote-body {
	font-family: KB금융 본문체 Light;
}

.vote-banner {
	margin-top: 45px;
	margin-left: 15%;
	margin-right: 15%;
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
    font-family: KB금융 제목체 Light;
}

.vote-title {
	font-size: 22pt;
	color: black;
	font-weight: bold;
	margin-top: 30px;
	margin-bottom: 20px;
	font-family: KB금융 제목체 Light;
}

.vote-title-detail {
	font-size: 15pt;
}

.line {
	margin-top: 15px;
	margin-bottom: 15px;
	border: 2px solid lightgrey;
}

.vote-options {
    list-style-type: none;
    padding: 10px;
}

.vote-option {
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 20px;
    text-align: center;
}

.vote-radio {
    appearance: none;
    -webkit-appearance: none;
    width: 24px;
    height: 24px;
    border: 2px solid #ccc;
    border-radius: 50%;
    margin-right: 10px;
    cursor: pointer;
    position: relative;
}

.vote-radio:checked {
    background-color: #ffc000;
    border-color: #ffc000;
}

.vote-radio:checked::after {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 12px;
    height: 12px;
    background-color: white;
    border-radius: 50%;
}

.vote-option-text {
    font-size: 18pt;
    font-weight: bold;
    font-family: KB금융 제목체 Light;
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
/* 여기까지  */

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
	cursor: pointer;
}

.option-box.selected {
	align-self: stretch;
	flex: 1;
	position: relative;
	box-shadow: 0 5px 10px rgba(255, 255, 255, 0.25) inset, 0 4px 4px
		rgba(0, 0, 0, 0.25);
	border-radius: var(- -br-31xl);
	background-color: #ffc000;
	max-width: 100%;
}

.option-box.voted {
	align-self: stretch;
	flex: 1;
	position: relative;
	box-shadow: 0 5px 10px rgba(255, 255, 255, 0.25) inset, 0 4px 4px
		rgba(0, 0, 0, 0.25);
	border-radius: var(- -br-31xl);
	background-color: #A9A9A9;
	max-width: 100%;
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
<body class="vote-body">
	<script>
		// 투표 여부 확인 및 리다이렉트
		<c:if test="${not empty votedOptionId and votedOptionId != 0}">
			alert("이미 제출한 투표입니다. 투표 목록 화면으로 이동합니다.");
			window.location.href = "./voteList";
		</c:if>
	</script>

	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>
	
	<!-- 상단 배너영역 -->
	<div class="vote-banner">
		<img src="<c:url value='./resources/voteResultBanner.png'/>" alt="voteResultBanner" 
		style="max-width: 100%; height: auto;">
	</div>
	
	<!-- 콘텐츠 시작 -->	
	<div class="vote-content">
	
	<div class="vote-number">${voteInfo.addVoteId}번 투표</div>
	<div class="vote-title">[${voteInfo.title}] 투표 하기</div>
	<div class="vote-title-detail">투표하고 싶은 항목을 선택하고 투표하기 버튼을 눌러주세요.</div>
	<hr class="line">
	
	<form id="voteForm" action="./submitAddVote" method="post" onsubmit="return validateForm()">
	<input type="hidden" name="userId" value="${userId}">
	<input type="hidden" name="addVoteId" value="${voteInfo.addVoteId}">
		<ul class="vote-options">
			<c:forEach var="vote" items="${optionList}">
				<li class="vote-option">
					<input type="radio" id="option_${vote.addVoteId}" name="optionId" value="${vote.optionId}" class="vote-radio">
					<label for="option_${vote.addVoteId}" class="vote-option-text">${vote.optionText}</label>
				</li>
			</c:forEach>
		</ul>
		<input type="hidden" id="selectedAddVoteId" name="addVoteId" value="">
		<div style="text-align: center; margin-top: 50px;">
			<button type="submit" class="yellow-button">투표하기</button>
		</div>
	</form>
	
	<!-- 페이지 하단 간격조정용 -->
	<div style="margin-bottom: 200px;"></div>
				
</div>

<script>
function validateForm() {
    var options = document.getElementsByName('optionId');
    var selected = false;

    for (var i = 0; i < options.length; i++) {
        if (options[i].checked) {
            selected = true;
            break;
        }
    }

    if (!selected) {
        alert('투표 옵션을 선택해주세요.');
        return false;
    }

    return true;
}   

</script>

</body>
</html>
