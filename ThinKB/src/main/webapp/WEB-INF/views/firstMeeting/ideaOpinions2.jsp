<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디어 회의</title>
<style>
    body {
        display: flex;
        flex-direction: column;
        align-items: center;
        background-color: #f0f0f0;
        margin: 0;
        font-family: 'Arial', sans-serif;
    }
    .container {
        width: 80%;
        background-color: #FFFFFF;
        border: 1px solid #000;
        border-radius: 10px;
        padding: 20px;
        box-sizing: border-box;
        margin-top: 50px;
        text-align: center;
    }
    h1 {
        text-align: center;
        margin: 20px 0;
    }
    .tabs {
        display: flex;
        justify-content: space-around;
        margin-bottom: 20px;
    }
    .tab {
        padding: 15px 25px;
        cursor: pointer;
        font-weight: bold;
        color: #fff;
        transition: background-color 0.3s ease;
        clip-path: polygon(0 0, 100% 0, 90% 100%, 10% 100%);
        flex: 1;
        text-align: center;
    }
    .tab-smart { background-color: #007bff; }
    .tab-positive { background-color: #ffc107; color: black; }
    .tab-worry { background-color: #28a745; }
    .tab-strict { background-color: #dc3545; }
    .columns {
        display: flex;
        justify-content: space-between;
    }
    .column {
        width: 45%;
    }
    .preOpinion-list, .currentOpinion-list {
        width: 100%;
        list-style-type: none;
        padding: 0;
    }
    .box {
        background-color: #FFFFFF;
        border: 1px solid #000;
        border-radius: 10px;
        padding: 10px;
        margin-bottom: 20px;
        height: 365px;
        overflow-y: auto;
    }
    .tab-title {
        font-size: 30px;
        margin-bottom: 10px;
        text-align: center;
        color: #fff;
    }
    .no-opinions {
        color: #ccc;
        font-style: italic;
        text-align: center;
        margin-top: 20px;
        font-size: 20px;
    }
    .opinion-entry {
        background-color: #EEEEEE;
        padding: 10px;
        border-radius: 10px;
        margin-bottom: 10px;
        font-size: 20px;
        position: relative;
        text-align: left;
    }
    .opinion-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start; /* 세로 정렬을 위쪽에 맞추기 위해 flex-start 사용 */
    }
    .opinion-header .name-date {
        display: flex;
        align-items: center;
    }
    .name {
        margin-right: 10px;
        font-weight: bold;
    }
    .date {
        font-size: 12px;
        color: #777;
    }
    .opinion-text {
        margin: 10px 0;
    }
    
    /* 좋아요 */
     /* 좋아요 */
    .like-section {
        display: flex;
        flex-direction: column; /* 좋아요 버튼과 좋아요 수를 다른 줄로 배치 */
        align-items: center;
        justify-content: center;
        margin-bottom: 10px;
    }
    .like-button {
        background: none;
        border: none;
        cursor: pointer;
        margin-right: 5px;
    }
    .like-button img {
        width: 20px;
        height: 20px;
    }
    .like-count {
	    margin-top: 5px; /* 좋아요 수를 이미지 아래에 약간의 간격을 둠 */
	    font-size: 16px;
	    font-weight: bold;
	}

    
    .delete-button {
        /* background-color: #dc3545; */
        color: #777 !important;
        text-align: left; /* 좌측 정렬 */
        border: none;
        cursor: pointer; 
        font-weight: bold;
        font-weight: bold;
        
    }
/*     .delete-button:hover {
        background-color: #c82333;
    } */
    
    .comment-section {
        display: flex;
        align-items: center;
        margin-top: 20px;
        border-top: 1px solid #000;
        padding-top: 10px;
        flex-wrap: nowrap;
    }
    .opinion-textarea {
        width: calc(100% - 120px);
        height: 50px;
        margin-right: 10px;
        border: 2px solid #ccc;
        padding: 12px;
        border-radius: 5px;
        box-sizing: border-box;
        font-weight: bold;
        font-size: 16px;
    }
   .write-button {
	    width: 100px;
	    height: 50px;
	    border: none;
	    background-color: #ffc107;
	    color: #000;
	    font-weight: bold;
	    padding: 0 20px;
	    border-radius: 5px;
	    cursor: pointer;
	    transition: background-color 0.3s ease;
	}
	
	.write-button:hover {
	    background-color: #e0a800;
	}
    .idea-title-container {
        border: 1px solid #000;
        background-color: #EEEEEE;
        padding: 20px;
        width: 100%;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
    }
    .idea-title-inner {
        border: 3px solid #FFCC00;
        background-color: #FFFFFF;
        border-radius: 20px;
        padding: 10px;
        text-align: center;
        font-size: 30px;
        margin: 10px 0;
    }
</style>
<script>
window.onload = function() {
    <c:if test="${alreadyWritten}">
        alert('이미 해당 탭에 의견을 작성하셨습니다.');
    </c:if>
};

function validateAndSubmitForm() {
    var opinionText = document.querySelector('.opinion-textarea').value.trim();
    
    if (opinionText === '') {
        alert('의견을 입력해주세요!');
        return false; // 폼 제출 방지
    }

    // 서버 측에서 중복 검사를 수행하기 위해 폼을 제출
    return true;
}

function confirmDelete() {
    return confirm('정말로 이 의견을 삭제하시겠습니까?');
}

/* 타이머 종료시 함수 */
function onTimerEnd() {
    // 방장
	if ("${roomManagerId}" === "${userId}") {
        document.getElementById("nextStepButton").style.display = "block";
	}
    // 일반사용자
 	// 의견 작성 섹션을 숨기고 종료 메시지를 표시
 	console.log("Timer ended");

    document.querySelectorAll(".comment-section").forEach(function(el) {
        el.style.display = "none";
    });
    document.querySelectorAll(".comment-ended").forEach(function(el) {
        el.style.display = "block";
    });
}

	// 방장이 다음 단계로 버튼 클릭 시 확인 창을 띄우고, 확인 시 이동
function confirmNextStep() {
    if (confirm("정말로 다음 페이지로 넘어가시겠습니까?")) {
    	const roomId = "${roomId}";
        const ideaId = "${ideaId}";
        window.location.href = "./ideaOpinionsClear?roomId=" + roomId + "&ideaId=" + ideaId;
    }
}
	
</script>
</head>
<body>
<%@ include file="../header.jsp"%>
    <div class="container">
    	<!-- 타이머 -->
	    <div id="timer-section" style="margin-top:100px;">
	    	<%@ include file="../Timer.jsp"%>
	    </div>
	    <c:if test="${userId == roomManagerId}">
		    <!-- <button id="nextStepButton" style="display:none;">다음 단계로</button> -->
		    <button id="nextStepButton" onclick="confirmNextStep()">다음 단계로</button>
		</c:if>
		
        <h1>${ideaTitle}</h1>
        <div class="tabs">
            <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-smart" class="tab tab-smart ${currentTab == 'tab-smart' ? 'active' : ''}">똑똑이</a>
            <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-positive" class="tab tab-positive ${currentTab == 'tab-positive' ? 'active' : ''}">긍정이</a>
            <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-worry" class="tab tab-worry ${currentTab == 'tab-worry' ? 'active' : ''}">걱정이</a>
            <a href="ideaOpinions2?roomId=${roomId}&ideaId=${ideaId}&currentTab=tab-strict" class="tab tab-strict ${currentTab == 'tab-strict' ? 'active' : ''}">깐깐이</a>
        </div>
        <div class="columns">
            <div class="column">
                <h2>기존 의견들</h2>
		        <ul class="preOpinion-list">
                    <c:choose>
                        <c:when test="${empty previousOpinions}">
                            <li class="no-opinions">
                                <img src="./resources/noContents.png" alt="No opinions" style="width: 180px; height: 200px; vertical-align: middle;">
                                <br>의견이 아직 등록되지 않았어요! <br><br>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${previousOpinions}" varStatus="status">
                                <li class="opinion-entry">
                                    <div class="opinion-header">
                                        <div class="name-date">
                                            <span class="name">${opinion.userName}</span>
                                            <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                        </div>
                                    </div>
                                    <div class="opinion-text">${opinion.opinionText}</div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            
			<div class="column">
		    <h2>현재 의견들</h2>
		    <ul class="currentOpinion-list">
		        <c:choose>
		            <c:when test="${empty currentOpinions}">
		                <li class="no-opinions">
		                    <img src="./resources/noContents.png" alt="No opinions" style="width: 180px; height: 200px; vertical-align: middle;">
		                    <br>의견이 아직 등록되지 않았어요! <br><br>
		                </li>
		            </c:when>
		            <c:otherwise>
		                <c:forEach var="opinion" items="${currentOpinions}" varStatus="status">
		                    <li class="opinion-entry">
		                        <div class="opinion-header">
                                    <div class="name-date">
                                        <span class="name">${opinion.userName}</span>
                                        <div class="date">
                                            <fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" />
                                        </div>
                                    </div>
                                    <div class="like-section">
									    <form action="likeOpinion" method="post" style="display: inline;">
									        <input type="hidden" name="opinionId" value="${opinion.opinionID}" />
									        <input type="hidden" name="userId" value="${userId}" />
									        <input type="hidden" name="like" value="${opinion.likedByCurrentUser ? false : true}" />
									        <input type="hidden" name="roomId" value="${roomId}" />
									        <input type="hidden" name="ideaId" value="${ideaId}" />
									        <input type="hidden" name="currentTab" value="${currentTab}" />
									        <button type="submit" class="like-button">
									            <c:choose>
									                <c:when test="${opinion.likedByCurrentUser}">
									                    <img src="./resources/filled_heart.png" alt="Filled Heart">
									                </c:when>
									                <c:otherwise>
									                    <img src="./resources/empty_heart.png" alt="Empty Heart">
									                </c:otherwise>
									            </c:choose>
									        </button>
									    </form>
									    <div class="like-count">
									        <span>${opinion.likeNum}</span>
									    </div>
									</div>
                                </div>
                                <div class="opinion-text">${opinion.opinionText}</div>
                                <c:if test="${opinion.userID == userId}">
                                    <form action="deleteOpinion2" method="post" onsubmit="return confirmDelete();" style="display: inline;">
                                        <input type="hidden" name="opinionId" value="${opinion.opinionID}" />
                                        <input type="hidden" name="ideaId" value="${ideaId}" />
                                        <input type="hidden" name="roomId" value="${roomId}" />
                                        <input type="hidden" name="currentTab" value="${currentTab}" />
                                        <button type="submit" class="delete-button" >삭제</button>
                                    </form>
                                </c:if>
		                    </li>
		                </c:forEach>
		            </c:otherwise>
		        </c:choose>
		    </ul>
		    <form action="addOpinion2" method="post" class="comment-section" onsubmit="return validateAndSubmitForm();">
		        <input type="hidden" name="ideaId" value="${ideaId}" />
		        <input type="hidden" name="roomId" value="${roomId}" />
		        <input type="hidden" name="currentTab" value="${currentTab}" />
		        <textarea class="opinion-textarea" name="opinionText" placeholder="의견을 입력하세요"></textarea>
		        <button type="submit" class="write-button">작성</button>
                <!-- <button type="button" onclick="validateAndSubmitForm('opinionForm')">작성</button> -->
            </form>
            <div class="comment-ended" style="display: none;">
				    타이머가 종료되었습니다. 더 이상 의견을 작성할 수 없습니다.
			</div>
		    </div>
		</div>
    </div>
</body>
</html>
