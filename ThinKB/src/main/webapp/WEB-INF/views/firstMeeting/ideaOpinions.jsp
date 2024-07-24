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
    width: 60%;
    background-color: #FFFFFF;
    border: 1px solid #000;
    border-radius: 10px;
    padding: 20px;
    box-sizing: border-box;
    margin-top: 50px;
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

.tab-smart {
    background-color: #007bff; /* 파란색 */
}

.tab-positive {
    background-color: #ffc107; /* 노란색 */
    color: black;
}

.tab-worry {
    background-color: #28a745; /* 초록색 */
}

.tab-strict {
    background-color: #dc3545; /* 빨간색 */
}

.tab-content-container {
    margin-top: 20px;
}

.tab-content {
    display: none;
    padding: 20px;
    box-sizing: border-box;
    background-color: #fff;
}

.tab-content.active {
    display: block;
}

.opinion-list {
    list-style-type: none;
    padding: 0;
}

.opinion-list li {
    margin-bottom: 10px;
}

.comment-section {
    display: flex;
    align-items: center;
    margin-top: 20px;
    border-top: 1px solid #000;
    padding-top: 10px;
    flex-wrap: nowrap; /* 요소들이 한 줄에 유지되도록 설정 */
}

.opinion-textarea {
    width: calc(100% - 120px); /* 너비를 버튼 크기에 맞게 조정 */
    height: 50px; /* 높이를 버튼과 맞춤 */
    margin-right: 10px;
    border: 2px solid #ccc; /* 두께를 두껍게 조정 */
    padding: 12px; /* 패딩을 더 두껍게 조정 */
    border-radius: 5px;
    box-sizing: border-box; /* 패딩 포함한 크기 조정 */
    font-weight: bold; /* 텍스트 두께를 두껍게 조정 */
    font-size: 16px; /* 텍스트 크기를 키움 */
}

button {
    width: 100px; /* 버튼의 너비 고정 */
    height: 50px; /* 높이를 입력란과 맞춤 */
    border: none;
    background-color: #ffc107;
    color: #000;
    font-weight: bold;
    padding: 0 20px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #e0a800;
}

.idea-title-container {
    border: 1px solid #000;
    background-color: #EEEEEE;
    margin-bottom: 20px;
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

.opinion-section {
    border: 1px solid #000;
    background-color: #EEEEEE;
    padding: 20px;
    width: 100%;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
}

.opinion-entry {
    background-color: #EEEEEE;
    padding: 20px;
    border-radius: 20px;
    margin-bottom: 10px;
    font-size: 22px;
    position: relative; /* 삭제 버튼 위치를 절대 위치로 설정하기 위해 상대 위치로 설정 */
}

.opinion-text {
    display: inline-block;
    margin-right: 10px;
}

.delete-button {
    position: absolute;
    right: 10px;
    top: 10px;
}

.date {
    font-size: 12px;
    color: #777;
    margin-top: 5px;
}
/* 등록된 의견이 없을 때 */
.no-opinions {
    color: #ccc; /* 연한 회색 */
    font-style: italic; /* 기울임꼴로 표시 */
    text-align: center; 
    margin-top: 20px;
    margin-bottom: 100px;
    font-size: 25px; 
}
.no-opinions img {
    margin-bottom: 20px; /* 이미지 아래 여백 */
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        function formatTimestamp(timestamp) {
            const date = new Date(timestamp);
            const year = date.getFullYear();
            const month = date.getMonth() + 1;
            const day = date.getDate();
            const hours = date.getHours();
            const minutes = date.getMinutes();

            const formattedMonth = (month < 10 ? '0' + month : month);
            const formattedDay = (day < 10 ? '0' + day : day);
            const formattedHours = (hours < 10 ? '0' + hours : hours);
            const formattedMinutes = (minutes < 10 ? '0' + minutes : minutes);

            return year + '.' + formattedMonth + '.' + formattedDay + ' ' + formattedHours + ':' + formattedMinutes;
        }

        // 포맷된 날짜를 표시하기 위해 createdAt 값을 변환
        $('.date').each(function() {
            const timestamp = $(this).text().trim();
            const date = new Date(timestamp);
            if (!isNaN(date.getTime())) {
                $(this).text(formatTimestamp(date));
            } else {
                $(this).text(timestamp);
            }
        });
        
        window.onload = function() {
            var urlParams = new URLSearchParams(window.location.search);
            var currentTab = urlParams.get('currentTab');
            var roomId = urlParams.get('roomId');
            var ideaId = urlParams.get('ideaId');
            if (currentTab && roomId && ideaId) {
                showTab(currentTab, getTabColor(currentTab), roomId, ideaId);
            }
        };

        function getTabColor(tabName) {
            switch(tabName) {
                case 'tab-smart': return '#007bff';
                case 'tab-positive': return '#ffc107';
                case 'tab-worry': return '#28a745';
                case 'tab-strict': return '#dc3545';
                default: return '#007bff';
            }
        }

        window.showTab = function(tabName, color, roomId, ideaId) {
            var tabs = document.getElementsByClassName('tab-content');
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove('active');
            }
            document.getElementById(tabName).classList.add('active');
            document.querySelector('.tab-content.active').style.borderColor = color;

            var allTabs = document.getElementsByClassName('tab');
            for (var j = 0; j < allTabs.length; j++) {
                allTabs[j].style.borderBottom = 'none';
            }
            document.querySelector('.tab.' + tabName).style.borderBottom = '5px solid ' + color;

            // 폼의 currentTab 값을 업데이트
            var currentTabInputs = document.querySelectorAll('input[name="currentTab"]');
            for (var k = 0; k < currentTabInputs.length; k++) {
                currentTabInputs[k].value = tabName;
            }

            // URL을 업데이트하여 필요한 매개변수 포함
            history.replaceState(null, '', `?roomId=${roomId}&ideaId=${ideaId}&currentTab=${tabName}`);
        }

        // 의견을 작성하지 않은 상태로 작성 버튼 클릭시 오류 팝업창 + 작성할 수 있는 의견 수가 0개인 탭에 의견 작성시 오류 팝업창
        window.validateAndSubmitForm = function(tabName, maxComments, currentOpinionCount, userOpinions) {
            var opinionText = document.querySelector('#' + tabName + ' .opinion-textarea').value.trim();
            var userId = document.querySelector('input[name="userID"]').value;

            if (opinionText === '') {
                alert('의견을 입력해주세요!');
            } else if (currentOpinionCount >= maxComments) {
                alert('댓글 작성 제한 인원을 초과하였습니다.\n다른 의견 탭에 댓글을 작성해주세요.');
            } else {
                var alreadyCommented = userOpinions.some(function(opinion) {
                    return opinion.hatColor === tabName.split('-')[1].charAt(0).toUpperCase() + tabName.split('-')[1].slice(1);
                });

                if (alreadyCommented) {
                    alert('이미 이 탭에 댓글을 작성했습니다. 다른 탭에 댓글을 작성해주세요.');
                } else {
                    document.querySelector('#' + tabName + ' form').submit();
                }
            }
        };
        

        window.deleteOpinion = function(opinionId, currentTab) {
            var roomId = '<c:out value="${roomId}" />';
            var ideaId = '<c:out value="${ideaId}" />';
            
            // opinionId와 currentTab이 올바른지 확인
            if (!opinionId || !currentTab) {
                alert('삭제할 의견 정보가 잘못되었습니다.');
                return;
            }
            
            if (confirm('정말로 이 의견을 삭제하시겠습니까?')) {
                var url = 'deleteOpinion?opinionId=' + opinionId + '&currentTab=' + currentTab + '&roomId=' + roomId + '&ideaId=' + ideaId;
                window.location.href = url;
            }
        };

        var urlParams = new URLSearchParams(window.location.search);
        var currentTab = urlParams.get('currentTab');
        var roomId = urlParams.get('roomId');
        var ideaId = urlParams.get('ideaId');
        if (currentTab && roomId && ideaId) {
            showTab(currentTab, getTabColor(currentTab), roomId, ideaId);
        }
    });
    
    
</script>
</head>
<body>
    <div class="container">
        <div class="tabs">
            <div class="tab tab-smart" onclick="showTab('tab-smart', '#007bff', '${roomId}', '${ideaId}')">똑똑이</div>
            <div class="tab tab-positive" onclick="showTab('tab-positive', '#ffc107', '${roomId}', '${ideaId}')">긍정이</div>
            <div class="tab tab-worry" onclick="showTab('tab-worry', '#28a745', '${roomId}', '${ideaId}')">걱정이</div>
            <div class="tab tab-strict" onclick="showTab('tab-strict', '#dc3545', '${roomId}', '${ideaId}')">깐깐이</div>
        </div>
        <div class="idea-title-container">
            <div class="idea-title-inner">${ideaTitle}</div>
        </div>
        <div class="opinion-section">
            <div id="tab-smart" class="tab-content active">
                <h2>
                    <img src="./resources/message.png" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                    똑똑이 등록된 의견
                    <span style="float: right; font-size: 16px;">
                        현재 댓글 갯수: ${smartOpinionCount} / 최대 작성 가능: ${maxComments} / 추가 가능: ${maxComments - smartOpinionCount}
                    </span>
                </h2>
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty smartOpinions}">
                            <li class="no-opinions">
                                <img src="./resources/noContents.png" alt="No opinions" style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
                                <br>의견이 아직 등록되지 않았어요! <br><br>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${smartOpinions}">
                                <li class="opinion-entry">
                                    <span class="opinion-text">${opinion.userName}: ${opinion.opinionText}</span>
                                    <c:if test="${opinion.userID == userId}">
                                        <button class="delete-button" onclick="deleteOpinion(${opinion.opinionID}, 'tab-smart')">삭제</button>
                                    </c:if>
                                    <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <div class="comment-section">
                    <c:if test="${not empty error}">
                        <div class="error-message">${error}</div>
                    </c:if>
                    <form:form method="post" action="addOpinion" modelAttribute="opinionForm" style="display: flex; align-items: center; width: 100%;">
                        <form:hidden path="hatColor" value="Smart" />
                        <form:hidden path="currentTab" value="tab-smart" />
                        <form:hidden path="roomId" value="${roomId}" />
                        <form:hidden path="ideaId" value="${ideaId}" />
                        <form:hidden path="userID" value="${userId}" />
                        <form:textarea path="opinionText" class="opinion-textarea" placeholder="의견을 입력해주세요" disabled="${maxComments - smartOpinionCount <= 0}" />
                    	<button type="button" onclick='validateAndSubmitForm("tab-smart", ${maxComments}, ${smartOpinionCount}, ${userOpinions})' disabled="${maxComments - smartOpinionCount <= 0}">작성</button>
                    </form:form>
                </div>
            </div>

            <div id="tab-positive" class="tab-content">
                <h2>
                    <img src="./resources/message.png" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                    긍정이 등록된 의견
                    <span style="float: right; font-size: 16px;">
                        현재 댓글 갯수: ${positiveOpinionCount} / 최대 작성 가능: ${maxComments} / 추가 가능: ${maxComments - positiveOpinionCount}
                    </span>
                </h2>
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty positiveOpinions}">
                            <li class="no-opinions">
                                <img src="./resources/noContents.png" alt="No opinions" style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
                                <br>의견이 아직 등록되지 않았어요! <br><br>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${positiveOpinions}">
                                <li class="opinion-entry">
                                    <span class="opinion-text">${opinion.userName}: ${opinion.opinionText}</span>
                                    <c:if test="${opinion.userID == userId}">
                                        <button class="delete-button" onclick="deleteOpinion(${opinion.opinionID}, 'tab-positive')">삭제</button>
                                    </c:if>
                                    <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <div class="comment-section">
                    <c:if test="${not empty error}">
                        <div class="error-message">${error}</div>
                    </c:if>
                    <form:form method="post" action="addOpinion" modelAttribute="opinionForm" style="display: flex; align-items: center; width: 100%;">
                        <form:hidden path="hatColor" value="Positive" />
                        <form:hidden path="currentTab" value="tab-positive" />
                        <form:hidden path="roomId" value="${roomId}" />
                        <form:hidden path="ideaId" value="${ideaId}" />
                        <form:hidden path="userID" value="${userId}" />
                        <form:textarea path="opinionText" class="opinion-textarea" placeholder="의견을 입력해주세요" disabled="${maxComments - positiveOpinionCount <= 0}" />
                        <button type="button" onclick='validateAndSubmitForm("tab-positive", ${maxComments}, ${positiveOpinionCount}, ${userOpinions})' disabled="${maxComments - positiveOpinionCount <= 0}">작성</button>
                    </form:form>
                </div>
            </div>

            <div id="tab-worry" class="tab-content">
                <h2>
                    <img src="./resources/message.png" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                    걱정이 등록된 의견
                    <span style="float: right; font-size: 16px;">
                        현재 댓글 갯수: ${worryOpinionCount} / 최대 작성 가능: ${maxComments} / 추가 가능: ${maxComments - worryOpinionCount}
                    </span>
                </h2>
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty worryOpinions}">
                            <li class="no-opinions">
                                <img src="./resources/noContents.png" alt="No opinions" style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
                                <br>의견이 아직 등록되지 않았어요! <br><br>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${worryOpinions}">
                                <li class="opinion-entry">
                                    <span class="opinion-text">${opinion.userName}: ${opinion.opinionText}</span>
                                    <c:if test="${opinion.userID == userId}">
                                        <button class="delete-button" onclick="deleteOpinion(${opinion.opinionID}, 'tab-worry')">삭제</button>
                                    </c:if>
                                    <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <div class="comment-section">
                    <c:if test="${not empty error}">
                        <div class="error-message">${error}</div>
                    </c:if>
                    <form:form method="post" action="addOpinion" modelAttribute="opinionForm" style="display: flex; align-items: center; width: 100%;">
                        <form:hidden path="hatColor" value="Worry" />
                        <form:hidden path="currentTab" value="tab-worry" />
                        <form:hidden path="roomId" value="${roomId}" />
                        <form:hidden path="ideaId" value="${ideaId}" />
                        <form:hidden path="userID" value="${userId}" />
                        <form:textarea path="opinionText" class="opinion-textarea" placeholder="의견을 입력해주세요" disabled="${maxComments - worryOpinionCount <= 0}" />
                        <button type="button" onclick='validateAndSubmitForm("tab-worry", ${maxComments}, ${worryOpinionCount}, ${userOpinions})' disabled="${maxComments - worryOpinionCount <= 0}">작성</button>
                    </form:form>
                </div>
            </div>

            <div id="tab-strict" class="tab-content">
                <h2>
                    <img src="./resources/message.png" style="width: 50px; height: 50px; vertical-align: middle; margin-right: 10px;">
                    깐깐이 등록된 의견
                    <span style="float: right; font-size: 16px;">
                        현재 댓글 갯수: ${strictOpinionCount} / 최대 작성 가능: ${maxComments} / 추가 가능: ${maxComments - strictOpinionCount}
                    </span>
                </h2>
                <ul class="opinion-list">
                    <c:choose>
                        <c:when test="${empty strictOpinions}">
                            <li class="no-opinions">
                                <img src="./resources/noContents.png" alt="No opinions" style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
                                <br>의견이 아직 등록되지 않았어요! <br><br>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="opinion" items="${strictOpinions}">
                                <li class="opinion-entry">
                                    <span class="opinion-text">${opinion.userName}: ${opinion.opinionText}</span>
                                    <c:if test="${opinion.userID == userId}">
                                        <button class="delete-button" onclick="deleteOpinion(${opinion.opinionID}, 'tab-strict')">삭제</button>
                                    </c:if>
                                    <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <div class="comment-section">
                    <c:if test="${not empty error}">
                        <div class="error-message">${error}</div>
                    </c:if>
                    <form:form method="post" action="addOpinion" modelAttribute="opinionForm" style="display: flex; align-items: center; width: 100%;">
                        <form:hidden path="hatColor" value="Strict" />
                        <form:hidden path="currentTab" value="tab-strict" />
                        <form:hidden path="roomId" value="${roomId}" />
                        <form:hidden path="ideaId" value="${ideaId}" />
                        <form:hidden path="userID" value="${userId}" />
                        <form:textarea path="opinionText" class="opinion-textarea" placeholder="의견을 입력해주세요" disabled="${maxComments - strictOpinionCount <= 0}" />
                        <button type="button" onclick='validateAndSubmitForm("tab-strict", ${maxComments}, ${strictOpinionCount}, ${userOpinions})' disabled="${maxComments - strictOpinionCount <= 0}">작성</button>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
