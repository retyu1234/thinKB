<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - 투표 목록</title>
<style>
/* 스타일 정의 */
html, body {
    max-width: 100%;
    overflow-x: hidden;
}
.vote-body {
	font-family: Arial, sans-serif;
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

/* 투표만들기 버튼 */
.vote-button-container {
	display: flex;
	justify-content: end;
	margin-left: 15%;
	margin-right: 15%;
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

.user-info p {
	margin: 0;
}

.progress-container {
	display: flex;
	justify-content: center;
	align-items: center;
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
	font-size: 13pt;
}

.progress label {
	display: flex;
	align-items: center;
}

.progress input {
	margin-right: 5px;
}
/* 진행중인 단계 */
.progress-header-container {
	display: flex;
	justify-content: left;
	width: 80%;
	margin: 0 auto;
}

.progress-header {
	margin: 0;
	padding: 10px 0;
	font-size: 18pt;
}

.votes {
    display: flex;
    flex-wrap: wrap;
    margin: 30px 20px;
}

.vote {
    width: calc(33.333% - 20px);
    height: 230px;
    margin: 30px 10px;
    padding: 20px;
    border-radius: 20px;
    display: flex;
    flex-direction: column;
    cursor: pointer;
    transition: box-shadow 0.3s ease;
    box-sizing: border-box;
}

.vote:hover {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.vote-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.vote-tag {
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 13px;
}

.vote-creator {
    font-size: 14px;
}

.vote-title {
    font-size: 16pt;
    font-weight: bold;
    text-align: center;
    margin-bottom: 10px;
    height: 90px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.vote-date {
    font-size: 13pt;
    text-align: right;
}

/* 상태별 스타일 */
.vote-completed {
    background-color: #E4E4E4;
}

.vote-voted {
    background-color: #C4CDB8;
}

.vote-not-voted {
    background-color: #EEFCDB;
}

.tag-completed {
    background-color: #575757;
    color: white;
}

.tag-voted {
    background-color: #719F60;
    color: white;
}

.tag-not-voted {
    background-color: #85D16A;
    color: white;
}

</style>
</head>

<body class="vote-body">
	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>
	
	<!-- 상단 배너영역 -->
	<div class="vote-banner">
		<img src="<c:url value='./resources/addVoteBanner.png'/>" alt="abtestBanner" 
		style="max-width: 100%; height: auto;">
	</div>
	
	<!-- 투표 만들기 버튼 -->
	<div class="vote-button-container">
		<button class="yellow-button" onclick="location.href='./newVote'">+ 투표 만들기</button>
	</div>
	
	<!-- 콘텐츠 시작 -->	
	<div class="vote-content">
	
	<!-- 상단 단계별 조회 -->
	<div class="progress-header-container">
		<h2 class="progress-header">진행중인 단계</h2>
	</div>

		<div class="progress-container">
		    <div class="progress">
		        <label><input type="checkbox" data-status="not-voted" onchange="filterVotes()"> 미참여 </label>
		        <label><input type="checkbox" data-status="voted" onchange="filterVotes()"> 참여 완료 </label>
		        <label><input type="checkbox" data-status="completed" onchange="filterVotes()"> 투표 종료 </label>
		    </div>
		</div>

		<div class="votes">
			<c:choose>
				<c:when test="${empty voteList}">
					<div class="no-room">
						<img src="./resources/noContent.png" alt="no Contents"
							style="width: 100px; height: auto; margin-bottom: 10px;">
						<div class="contents">참여했던 투표가 없어요.</div>
						<div class="contents">투표를 시작해서 의견을 모아보세요!</div>
					</div>
				</c:when>

			<c:otherwise>
                   <c:forEach var="li" items="${voteList}">
                        <div class="vote 
					        ${li.isCompleted ? 'vote-completed' : 
					          (li.votedOptionId != 0 ? 'vote-voted' : 'vote-not-voted')}"
					         onclick="goToVotePage(${li.isCompleted}, ${li.votedOptionId}, ${li.addVoteId})">
                            <div class="vote-header">
                                <span class="vote-tag 
                                    ${li.isCompleted ? 'tag-completed' : 
                                      (li.votedOptionId != 0 ? 'tag-voted' : 'tag-not-voted')}">
                                    ${li.isCompleted ? '투표 종료' : 
                                      (li.votedOptionId != 0 ? '참여 완료' : '미참여')}
                                </span>
								<span class="vote-creator">
                                    <c:forEach var="voteMaker" items="${voteMaker}">
                                        <c:if test="${voteMaker.userId eq li.createUserID}">
                                            ${voteMaker.userName}님의 투표
                                        </c:if>
                                    </c:forEach>
                                </span>                            </div>
                            <div class="vote-title">✅ ${li.title}</div>
                            <div class="vote-date">~ ${li.endDate} 까지</div>
                            <div class="vote-date">${li.voteNum} / ${li.totalNum} 명 참여</div>
                        </div>
                    </c:forEach>
                </c:otherwise>
		</c:choose>
	</div>
		
		
	
	</div>
	<script>
	function goToVotePage(isCompleted, votedOptionId, addVoteId) {
	    var baseUrl = '${pageContext.request.contextPath}';
	    var url = isCompleted || (!isCompleted && votedOptionId != 0) 
	        ? baseUrl + '/addVoteAfter?addVoteId=' + addVoteId
	        : baseUrl + '/addVote?addVoteId=' + addVoteId;
	    window.location.href = url;
	}
	
	function filterVotes() {
	    var checkboxes = document.querySelectorAll('.progress input');
	    var votes = document.querySelectorAll('.vote');
	    var anyChecked = false;

	    checkboxes.forEach(function(checkbox) {
	        if (checkbox.checked) {
	            anyChecked = true;
	        }
	    });

	    if (!anyChecked) {
	        votes.forEach(function(vote) {
	            vote.style.display = 'flex';
	        });
	    } else {
	        votes.forEach(function(vote) {
	            vote.style.display = 'none';
	        });

	        checkboxes.forEach(function(checkbox) {
	            if (checkbox.checked) {
	                var status = checkbox.getAttribute('data-status');
	                votes.forEach(function(vote) {
	                    if (vote.classList.contains('vote-' + status)) {
	                        vote.style.display = 'flex';
	                    }
	                });
	            }
	        });
	    }
	}

	document.addEventListener('DOMContentLoaded', function() {
	    var checkboxes = document.querySelectorAll('.progress input');
	    checkboxes.forEach(function(checkbox) {
	        checkbox.addEventListener('change', filterVotes);
	    });
	    filterVotes();
	});
	</script>
</body>
</html>
