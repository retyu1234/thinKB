<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body, html {
	font-family: KB금융 본문체 Light;
	overflow-x: hidden;
    width: 100%;
}

.end-content {
    padding: 20px;
    margin-left: 15%;
    margin-right: 15%;
    margin-top: 1%;
}

.stages {
	display: flex;
	justify-content: space-between;
	padding: 30px 0;
	font-size: 13pt;
}

.stage {
    flex: 1;
    text-align: center;
    padding: 3px; /* 5px에서 3px로 줄임 */
    margin: 0 2px; /* 좌우 여백 추가 */
    cursor: pointer;
    text-decoration: none;
    color: #000;
    white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 함 */
    overflow: hidden; /* 넘치는 텍스트 숨김 */
    text-overflow: ellipsis; /* 넘치는 텍스트를 ...으로 표시 */
}

.active {
	color: #FFD700;
	font-weight: bold;
}

.inactive {
	color: #999;
	pointer-events: none;
}
/* 아이디어 주제 ${meetingRoom}*/
.meeting-summary {
    text-align: center;
    margin-top: 30px;
    margin-bottom: 80px;
}

.summary-text {
    font-size: 15pt;
    margin-bottom: 10px;
}

.quote-container {
    position: relative;
    display: inline-block;
    margin: 20px 0;
}

.meeting-title {
    font-size: 22pt;
    font-weight: bold;
    margin: 0 20px;
    font-family: KB금융 제목체 Light;
}

.quote-mark {
    font-size: 40pt;
    position: absolute;
    top: -20px;
}

.quote-mark.left {
    left: -20px;
}

.quote-mark.right {
    right: -20px;
}
/* 참여자 목록 ${userList} */
.participants-container {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    margin-top: 30px; /* 상하 여백 증가 */
    gap: 20px; /* 참여자 간 간격 추가 */
}

.participant {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 120px; /* 너비 증가 */
}

.user-profile-img {
    width: 70px; /* 이미지 크기 증가 */
    height: 70px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 10px; /* 이미지와 이름 사이 간격 증가 */
}

.user-name {
    font-size: 13pt;
    text-align: center;
    word-break: break-word;
    max-width: 100%;
    line-height: 1.2; /* 줄 간격 추가 */
}

/* 아이디어 초안 ${totalIdea} */
.initial-ideas {
    text-align: center;
    margin: 80px 0;
}

.idea-intro {
    font-size: 15pt;
    margin-bottom: 20px;
}

.idea-list {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.idea-item {
    margin-bottom: 15px;
    max-width: 80%;
}

.idea-title {
    font-size: 18pt;
    font-weight: bold;
    margin: 0;
    display: inline-block;
    font-family: KB금융 제목체 Light;
}

.idea-text {
    position: relative;
}

.idea-text.my-idea::after {
    content: '';
    position: absolute;
    left: 0;
    bottom: -2px;
    width: 100%;
    height: 6px;
    background-color: rgba(255, 215, 0, 0.5); /* 반투명한 노란색 */
    z-index: -1;
}

.my-idea-mark {
    font-size: 14pt;
    font-weight: normal;
    color: #333;
    margin-left: 10px;
}

/* 선택된 아이디어 ${yesPickList} */
.selected-ideas {
    text-align: center;
    margin: 80px 0;
}

.selected-intro {
    font-size: 15pt;
    margin-bottom: 40px;
}

.selected-idea-list {
    display: flex;
    justify-content: center;
    gap: 40px;
}

.selected-idea-item {
    width: 45%; /* 각 아이디어 영역의 너비를 45%로 설정 */
    max-width: 500px; /* 최대 너비 설정 */
    display: flex;
    flex-direction: column;
    align-items: center;
}

.rank-icon {
    width: 80px;
    height: auto;
    margin-bottom: 20px;
}

.selected-idea-title {
    font-size: 20pt;
    font-weight: bold;
    margin: 10px 0;
    width: 100%; /* 제목 영역을 부모 요소의 전체 너비로 설정 */
    word-wrap: break-word; /* 긴 단어의 경우 줄바꿈 */
    font-family: KB금융 제목체 Light;
}

.idea-author {
    font-size: 15pt;
    color: #555;
    margin-top: 10px;
}

/* 아이디어별 의견 */
.opinions-container {
    margin: 80px 0;
    text-align: center;
}

.opinions-intro {
    font-size: 15pt;
    margin-bottom: 40px;
}

.opinions-grid {
    display: flex;
    justify-content: space-between;
    gap: 40px;
}

.opinion-column {
    width: 45%;
    text-align: center;
}

.idea-title {
    font-size: 18pt;
    font-weight: bold;
    margin-bottom: 20px;
}

.opinion-category {
    font-size: 16pt;
    font-weight: bold;
    margin-top: 30px;
    margin-bottom: 15px;
    font-family: KB금융 제목체 Light;
}

.opinion-list {
    list-style-type: none;
    padding: 0;
}

.opinion-list li {
    font-size: 13pt;
    margin-bottom: 10px;
}

.highlight {
    position: relative;
    display: inline-block;
}

.highlight::after {
    content: '';
    position: absolute;
    left: 0;
    bottom: 0;
    width: 100%;
    height: 8px;
    background-color: rgba(255, 215, 0, 0.5);
    z-index: -1;
}

/* 기여도 */
.contribution-container {
    margin: 80px 0;
    text-align: center;
}

.contribution-intro {
    font-size: 15pt;
    margin-bottom: 40px;
}

.contribution-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
}

.contribution-item {
    display: flex;
    align-items: center;
    width: 22%;
    min-width: 200px;
}

.contribution-profile {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    object-fit: cover;
    margin-right: 10px;
}

.contribution-info {
    text-align: left;
}

.contribution-name {
    font-size: 14pt;
    font-weight: bold;
    margin-bottom: 5px;
}

.contribution-score {
    font-size: 13pt;
    color: #555;
}
/* 마무리 */
.ending-container {
    text-align: center;
    margin-top: 80px;
    margin-bottom: 200px;
}

.gif-container {
    margin-bottom: 20px;
}

.ending-gif {
    width: 400px;
    height: auto;
}

.ending-message {
    font-size: 15pt;
    margin: 10px 0;
    font-family: KB금융 제목체 Light;
}

/*  */
.scrolling-banner-outer {
    width: 100%;
    overflow: hidden;
    position: relative;
}

.scrolling-banner-container {
    width: 60%;
    margin: 0 auto;
    overflow: hidden;
}

.scrolling-banner {
    display: flex;
    width: 200%;
    animation: scrollBanner 10s linear infinite;
}

.scrolling-banner-img {
    width: 50%;
    height: auto;
}

@keyframes scrollBanner {
    0% {
        transform: translateX(0);
    }
    100% {
        transform: translateX(-50%);
    }
}

/* 스크롤 효과 */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translate3d(0, 50px, 0);
    }
    to {
        opacity: 1;
        transform: translate3d(0, 0, 0);
    }
}

.fade-in-section {
    opacity: 0;
    transform: translate3d(0, 50px, 0);
    transition: opacity 0.8s ease-out, transform 0.8s ease-out;
    will-change: opacity, transform;
}

.fade-in-section.is-visible {
    opacity: 1;
    transform: translate3d(0, 0, 0);
}
</style>
</head>
<body>
<!-- 헤더영역 -->
<%@ include file="../header.jsp"%>

<div class="end-content">
<!-- 5단계 -->
	<%
	    String[] stages = {"아이디어 초안", "초안 투표하기", "관점별 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
	    request.setAttribute("stages", stages);
	%>
	<div class="stages">
	    <c:forEach var="stage" items="${stages}" varStatus="status">
	        <c:choose>
	            <c:when test="${meetingRoom.getStageId() >= status.index + 1}">
	                <a
	                    href="./roomDetail?roomId=${meetingRoom.getRoomId()}&stage=${status.index + 1}&ideaId=${yesPickList[0].getIdeaID()}"
	                    class="stage ${meetingRoom.getStageId() == status.index + 1 ? 'active' : ''}">
	                    ${status.index + 1}. ${stage}
	                </a>
	            </c:when>
	            <c:otherwise>
	                <div class="stage inactive">${status.index + 1}. ${stage}</div>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	</div>
    
<!-- 아이디어 주제 ${meetingRoom} -->
	<div class="meeting-summary fade-in-section">
	    <p class="summary-text">회의가 완료되었어요. 함께 만든 아이디어 회의방의 여정을 살펴봐요!</p>
	    <div class="quote-container fade-in-section">
	        <span class="quote-mark left">&ldquo;</span>
	        <h2 class="meeting-title">${meetingRoom.getRoomTitle()}</h2>
	        <span class="quote-mark right">&rdquo;</span>
	    </div>
	    <p class="summary-text">라는 주제로 아이디어 회의를 진행했어요.</p>
	</div>

<!-- 참여자 목록 ${userList} -->
	<div class="participants-container fade-in-section">
	    <c:forEach var="user" items="${userList}" varStatus="status">
	        <div class="participant">
	            <img src="<c:url value='./upload/${user.profileImg}'/>" alt="Profile Image" class="user-profile-img">
	            <span class="user-name">
	                <c:if test="${user.userId eq meetingRoom.roomManagerId}">[방장] </c:if>
	                ${user.userName}
	                <c:if test="${user.userId eq userId}">(나)</c:if>
	            </span>
	        </div>
	        <c:if test="${status.count % 8 == 0 && !status.last}">
	            </div><div class="participants-container">
	        </c:if>
	    </c:forEach>
	</div>
	
<!-- 이미지 -->
	<div class="fade-in-section" style="text-align: center;">
		<img src="<c:url value='./resources/ideas.png'/>" alt="ideas Image"
				style="margin: 0; width: 400px; height: auto;">
	</div>
<!-- 아이디어 초안 ${totalIdea} -->
	<div class="initial-ideas fade-in-section">
	    <p class="idea-intro">처음에는 이런 아이디어들이 모였었어요.</p>
	    <div class="idea-list">
	        <c:forEach var="idea" items="${totalIdea}">
	            <div class="idea-item fade-in-section">
	                <h3 class="idea-title">
	                    ' <span class="idea-text ${idea.getUserID() eq userId ? 'my-idea' : ''}">${idea.getTitle()}</span> '
	                    <c:if test="${idea.getUserID() eq userId}">
	                        <span class="my-idea-mark">(내가 낸 아이디어예요!)</span>
	                    </c:if>
	                </h3>
	            </div>
	        </c:forEach>
	    </div>
	</div>


<!-- 선택된 아이디어 ${yesPickList} -->
	<div class="selected-ideas fade-in-section">
	    <p class="selected-intro">이 아이디어 중에 투표를 통해 두 가지를 선정했어요.</p>
	    <div class="selected-idea-list fade-in-section">
	        <div class="selected-idea-item fade-in-section">
	            <img src="<c:url value='./resources/first.png'/>" alt="first" class="rank-icon">
	            <h3 class="selected-idea-title">"${yesPickList[0].getTitle()}"</h3>
	            <c:forEach var="user" items="${userList}">
	                <c:if test="${user.getUserId() eq yesPickList[0].getUserID()}">
	                    <p class="idea-author">${user.getUserName()} 님이 낸 아이디어에요!</p>
	                </c:if>
	            </c:forEach>
	        </div>
	        <div class="selected-idea-item">
	            <img src="<c:url value='./resources/second.png'/>" alt="second" class="rank-icon">
	            <h3 class="selected-idea-title">"${yesPickList[1].getTitle()}"</h3>
	            <c:forEach var="user" items="${userList}">
	                <c:if test="${user.getUserId() eq yesPickList[1].getUserID()}">
	                    <p class="idea-author">${user.getUserName()} 님이 낸 아이디어에요!</p>
	                </c:if>
	            </c:forEach>
	        </div>
	    </div>
	</div>

<!-- 이미지 -->
	<div class="fade-in-section" style="text-align: center;">
		<img src="<c:url value='./resources/idea1.png'/>" alt="ideas Image"
				style="margin: 0; width: 500px; height: auto;">
	</div>

<!-- 아이디어별 의견 ${firstOpinion} ${secondOpinion} -->
	<div class="opinions-container fade-in-section">
	    <p class="opinions-intro">모두 의견을 모아서 이 두 가지 아이디어를 확장 시켰어요.</p>
	    <div class="opinions-grid fade-in-section">
	        <div class="opinion-column fade-in-section">
	            <h2 class="idea-title">"${yesPickList[0].getTitle()}" 에 대해서는...</h2>
	            
	            <h3 class="opinion-category fade-in-section">👍 이런 <span class="highlight">긍정적인 효과</span>가 있을 것 같아요.</h3>
	            <ul class="opinion-list">
	                <c:forEach var="opinion" items="${firstOpinion}">
	                    <c:if test="${opinion.getHatColor() eq 'Positive'}">
	                        <li>${opinion.getOpinionText()}</li>
	                    </c:if>
	                </c:forEach>
	            </ul>
	            
	            <h3 class="opinion-category fade-in-section">📊 관련된 <span class="highlight">현황</span>이나 <span class="highlight">데이터</span>는 이래요.</h3>
	            <ul class="opinion-list">
	                <c:forEach var="opinion" items="${firstOpinion}">
	                    <c:if test="${opinion.getHatColor() eq 'Smart'}">
	                        <li>${opinion.getOpinionText()}</li>
	                    </c:if>
	                </c:forEach>
	            </ul>
	            
	            <h3 class="opinion-category fade-in-section">🔍 이런 부분은 <span class="highlight">보완</span>이 필요해요.</h3>
	            <ul class="opinion-list">
	                <c:forEach var="opinion" items="${firstOpinion}">
	                    <c:if test="${opinion.getHatColor() eq 'Worry'}">
	                        <li>${opinion.getOpinionText()}</li>
	                    </c:if>
	                </c:forEach>
	            </ul>
	            
	            <h3 class="opinion-category fade-in-section">🚀 <span class="highlight">실현 가능성</span>에 대한 부분은 이래요.</h3>
	            <ul class="opinion-list">
	                <c:forEach var="opinion" items="${firstOpinion}">
	                    <c:if test="${opinion.getHatColor() eq 'Strict'}">
	                        <li>${opinion.getOpinionText()}</li>
	                    </c:if>
	                </c:forEach>
	            </ul>
	        </div>
	        
	        <div class="opinion-column">
	            <h2 class="idea-title">"${yesPickList[1].getTitle()}" 에 대해서는...</h2>
	            
	            <h3 class="opinion-category fade-in-section">👍 이런 <span class="highlight">긍정적인 효과</span>가 있을 것 같아요.</h3>
	            <ul class="opinion-list">
	                <c:forEach var="opinion" items="${secondOpinion}">
	                    <c:if test="${opinion.getHatColor() eq 'Positive'}">
	                        <li>${opinion.getOpinionText()}</li>
	                    </c:if>
	                </c:forEach>
	            </ul>
	            
	            <h3 class="opinion-category fade-in-section">📊 관련된 <span class="highlight">현황</span>이나 <span class="highlight">데이터</span>는 이래요.</h3>
	            <ul class="opinion-list">
	                <c:forEach var="opinion" items="${secondOpinion}">
	                    <c:if test="${opinion.getHatColor() eq 'Smart'}">
	                        <li>${opinion.getOpinionText()}</li>
	                    </c:if>
	                </c:forEach>
	            </ul>
	            
	            <h3 class="opinion-category fade-in-section">🔍 이런 부분은 <span class="highlight">보완</span>이 필요해요.</h3>
	            <ul class="opinion-list">
	                <c:forEach var="opinion" items="${secondOpinion}">
	                    <c:if test="${opinion.getHatColor() eq 'Worry'}">
	                        <li>${opinion.getOpinionText()}</li>
	                    </c:if>
	                </c:forEach>
	            </ul>
	            
	            <h3 class="opinion-category fade-in-section">🚀 <span class="highlight">실현 가능성</span>에 대한 부분은 이래요.</h3>
	            <ul class="opinion-list">
	                <c:forEach var="opinion" items="${secondOpinion}">
	                    <c:if test="${opinion.getHatColor() eq 'Strict'}">
	                        <li>${opinion.getOpinionText()}</li>
	                    </c:if>
	                </c:forEach>
	            </ul>
	        </div>
	    </div>
	</div>

<!-- 참여자 기여도 ${member} -->
	<div class="contribution-container fade-in-section">
	    <p class="contribution-intro">이번 아이디어 회의 참여자들의 기여도예요</p>
	    <div class="contribution-grid">
	        <c:set var="totalContribution" value="0" />
	        <c:forEach var="m" items="${member}">
	            <c:set var="totalContribution" value="${totalContribution + m.getContributionCnt()}" />
	        </c:forEach>
	        
	        <c:forEach var="user" items="${userList}" varStatus="status">
	            <c:forEach var="m" items="${member}">
	                <c:if test="${user.getUserId() eq m.getUserId()}">
	                    <div class="contribution-item">
	                        <img src="<c:url value='./upload/${user.profileImg}'/>" alt="Profile Image" class="contribution-profile">
	                        <div class="contribution-info">
	                            <div class="contribution-name">${user.userName}</div>
	                            <div class="contribution-score">
	                                기여도 ${m.getContributionCnt()} 점
	                                (<span class="contribution-percentage" data-contribution="${m.getContributionCnt()}" data-total="${totalContribution}"></span>%)
	                            </div>
	                        </div>
	                    </div>
	                </c:if>
	            </c:forEach>
	        </c:forEach>
	    </div>
	</div>

<!-- 마무리 -->
	<div class="scrolling-banner-outer fade-in-section">
	    <div class="scrolling-banner-container">
	        <div class="scrolling-banner">
		        <img src="<c:url value='./resources/imgtest.png'/>" alt="Fighting Banner" class="scrolling-banner-img">
		        <img src="<c:url value='./resources/imgtest.png'/>" alt="Fighting Banner" class="scrolling-banner-img">
	    	</div>
	    </div>
	</div>

	<div class="ending-container fade-in-section">
	    <h2 class="ending-message">모두의 참여로 좋은 아이디어를 만들어 갈 수 있었어요!</h2>
	</div>
	
</div>


<script>
document.addEventListener('DOMContentLoaded', function() {
    var percentageElements = document.querySelectorAll('.contribution-percentage');
    percentageElements.forEach(function(element) {
        var contribution = parseFloat(element.getAttribute('data-contribution'));
        var total = parseFloat(element.getAttribute('data-total'));
        var percentage = (contribution / total) * 100;
        element.textContent = percentage.toFixed(1);
    });
    // 여기까지
    const faders = document.querySelectorAll('.fade-in-section');
    const appearOptions = {
        threshold: 0.15,
        rootMargin: "0px 0px -100px 0px"
    };

    const appearOnScroll = new IntersectionObserver(function(entries, appearOnScroll) {
        entries.forEach(entry => {
            if (!entry.isIntersecting) {
                return;
            } else {
                entry.target.classList.add('is-visible');
                appearOnScroll.unobserve(entry.target);
            }
        });
    }, appearOptions);

    faders.forEach(fader => {
        appearOnScroll.observe(fader);
    });
});
</script>
</body>
</html>