<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%
// 사용자 확인
List<Integer> userIdList = (List<Integer>) request.getAttribute("userIdList");
Integer userId = (Integer) session.getAttribute("userId");
boolean isParticipant = false;

if (userIdList != null && userId != null) {
    for (Integer id : userIdList) {
        if (id.equals(userId)) {
            isParticipant = true;
            break;
        }
    }
}

if (!isParticipant) {
	%>
    <script>
        alert("회의방 참여자가 아닙니다. 회의방 목록 화면으로 이동합니다.");
        window.location.href = "./meetingList";
    </script>
    <%
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>thinKB - 의견 모으기</title>
<style>
.stage3-header {
	position: relative;
	z-index: 1;
}

.ideaOpinions-body {
	font-family: KB금융 본문체 Light;
	margin: 0;
	background-color: #FFFFFF;
	width: 60%;
	margin: 0 auto;
	box-sizing: border-box;
	padding: 20px;
	/* 수지 */
	/*  display: flex; */
	/* align-items: center; */
	/* display: flex; */
}

/* 5개 단계 표시 */
.stages {
	font-family: KB금융 본문체 Light;
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
.active2 {
   color: #FFD700;
   font-weight: bold;
}
.inactive {
   color: #999;
   pointer-events: none;
}

/* 뒤로가기 버튼 */
.back-btn{
   width: 30px;
   height: 30px;
   margin-top: 40px;
   margin-right: 15px;
   text-decoration: none; /* 링크의 기본 밑줄 제거 */
}
.back-btn:hover {
    opacity: 0.8; /* 이미지가 살짝 투명해지게 설정 */
    transform: scale(1.2); /* 이미지가 살짝 커지도록 설정 */
    transition: all 0.3s ease; /* 부드러운 전환 효과 */
}
a {
    text-decoration: none; /* 링크 전체에 밑줄 제거 */
}

/* 아이디어 제목 */
.ideaOpinionList-title1 {
	font-family: KB금융 제목체 Light;
   font-size: 20pt;
   color: #909090;
   font-weight: bold;
   margin-top: 10px;
   /* font-style: italic; */
   vertical-align: middle; /* 이미지와 텍스트를 수직 가운데 정렬 */
}
.ideaOpinionList-title2 {
	font-family: KB금융 제목체 Light;
   font-size: 17pt;
   color: black;
   font-weight: bold;
   margin-bottom: 20px;
   vertical-align: middle; /* 이미지와 텍스트를 수직 가운데 정렬 */
}

/* 상세설명 - 토글 */
.title-detail {
	font-family: KB금융 본문체 Light;
    display: flex;
    flex-direction: column;
    margin-bottom: 20px;
        width: 100%;
    box-sizing: border-box;
}
.toggle-container {
    display: flex;
    align-items: center;
}
.toggle-switch {
    position: relative;
    display: inline-block;
    width: 60px;
    height: 34px;
    margin-right: 10px;
}
.toggle-text {
    margin-left: 10px;
    vertical-align: middle;
}
#descriptionContent {
	font-family: KB금융 본문체 Light;
    margin-top: 10px;
    padding: 10px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 5px;
    overflow-x: auto; /* 가로 스크롤을 추가합니다 */
    max-width: 100%; /* 최대 너비를 부모 요소에 맞춥니다 */
}
#descriptionContent pre {
	font-family: KB금융 본문체 Light;
    white-space: pre-wrap; /* 긴 줄을 wrap합니다 */
    word-wrap: break-word; /* 긴 단어를 강제로 줄바꿈합니다 */
    max-width: 100%; /* 최대 너비를 부모 요소에 맞춥니다 */
}
.toggle-input {
    opacity: 0;
    width: 0;
    height: 0;
}
.toggle-label {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #ccc;
    transition: .4s;
    border-radius: 34px;
}
.toggle-label:before {
    position: absolute;
    content: "";
    height: 26px;
    width: 26px;
    left: 4px;
    bottom: 4px;
    background-color: white;
    transition: .4s;
    border-radius: 50%;
}
.toggle-input:checked + .toggle-label {
    background-color: #FFCC00;
}
.toggle-input:checked + .toggle-label:before {
    transform: translateX(26px);
}
.toggle-text {
    margin-left: 10px;
    vertical-align: middle;
}

/* 구분선 */
.line {
   margin-top: 15px;
   margin-bottom: 15px;
   border: 2px solid lightgrey;
}


.rightAligned {
	display: flex;
	justify-content: flex-end;
	align-items: center;
}
/* 현재 단계 완료 참여자 수 */
.countDone {
	font-family: KB금융 본문체 Light;
	font-size: 13pt;
	margin-right: 10px;
}
/* 다음단계로 버튼 */
.nextStepButton {
	font-family: KB금융 제목체 Light;
	background-color: #FFCC00;
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	font-weight: bold;
	cursor: pointer;
	margin-right: 10px;
}

.nextStepButton:hover {
	background-color: #D4AA00;
}

/* 4가지 탭 */
.tabs {
	font-family: KB금융 제목체 Light;
	display: flex;
	justify-content: flex-start; /* 탭들을 왼쪽으로 몰리게 함 */
	gap: 10px; /* 탭 간의 간격 조절 */
	margin-top: 15px;
}

.tab {
	padding: 15px 25px;
	cursor: pointer;
	font-size: 15pt;
	font-weight: bold;
	color: #909090; /* 기본 색상 */
	transition: background-color 0.3s ease, color 0.3s ease;
	clip-path: polygon(0 0, 100% 0, 90% 100%, 10% 100%);
	text-align: center;
	text-decoration: none; /* 기본 밑줄 제거 */
	flex: 1;
}
/* 탭 색상 */
/* .tab-smart {
    background-color: #007bff;
} 
.tab-positive {
    background-color: #ffc107;
    color: black;
}
.tab-worry {
    background-color: #28a745;
}
.tab-strict {
    background-color: #dc3545;
}  */

/* 선택된 탭 */
.tab.active {
    color: black; /* 선택된 탭의 글자색 */
    border-bottom: 6px solid #FFE297; /* 선택된 탭의 밑줄 색상 */
    width: 80%; /* 선택된 탭의 밑줄 길이 줄이기 */
    margin: 0 auto; /* 가운데 정렬 */
}
/* 각 탭별 active 상태의 border-bottom 색상 */
/* .tab-smart.active {
	border-bottom-color: #007bff !important;
}

.tab-positive.active {
	border-bottom-color: #ffc107 !important;
}

.tab-worry.active {
	border-bottom-color: #28a745 !important;
}

.tab-strict.active {
	border-bottom-color: #dc3545 !important;
} */
/* 탭 설명 */
.tabExplain {
	font-size: 10pt;
	margin-bottom: 50px;
	text-align: center; /* 가운데 정렬 */
}

/* 추가 작성 의견수, 작성된 전체 의견 갯수, 최대 작성 가능, 추가 가능 */ 
.opinion-counts {
	font-size: 12pt;
	font-weight: bold;
	display: flex;
	justify-content: flex-end;
	align-items: center;
	width: auto;
	margin-top: 40px;
	margin-bottom: 10px;
	margin-right: 100px;
	text-align: right; /* 텍스트를 오른쪽으로 정렬 */
}

h1 {
	text-align: center;
	margin: 20px 0;
}

/* 전체 흰색 네모 */
.tab-content {
	display: none;
}

.tab-content.active {
	display: block;
}

/* 의견 박스 */
/* .opinion-section {
	border: 1px solid #000;
	background-color: #EEEEEE;
	padding: 20px;
	width: 100%;
	box-sizing: border-box;
	display: flex;
	flex-direction: column;
} */

/* 달린 의견 박스 */
.opinion-entry {
	/* background-color: #FFE297; */
	background-color: #EEEEEE;
	padding: 20px;
	border-radius: 20px;
	width: 85%;
	margin: 0 auto; /* 가운데 정렬 */
	margin-bottom: 10px;
	font-size: 22px;
	position: relative; /* 삭제 버튼 위치를 절대 위치로 설정하기 위해 상대 위치로 설정 */
}

/* 의견들 */
.name-date {
	display: flex;
	align-items: center;
}
.name {
    margin-right: 10px;
    font-size: 13pt;
    font-weight: bold;
}
.date {
    font-size: 10pt;
    color: #777;
}
.opinion-text {
	white-space: pre-wrap;
	word-wrap: break-word;
    margin: 10px 0;
    font-size: 10pt;
}
    


.delete-button {
	background-color: #EEEEEE;
	color: #777 !important;
	text-align: left; /* 좌측 정렬 */
	border: none;
	cursor: pointer;
	font-weight: bold;
	font-weight: bold;
}

/* 등록된 의견이 없을 때 */
.no-opinions {
	color: #909090; /* 기본 색상 */
	font-style: italic; /* 기울임꼴로 표시 */
	text-align: center;
	margin-top: 20px;
	margin-bottom: 100px;
	font-size: 13pt;
}

.no-opinions img {
	margin-bottom: 20px; /* 이미지 아래 여백 */
}

/* 폼을 가운데 정렬 */
.input-form {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 85%; /* opinion-entry와 동일한 너비 */
	margin: 0 auto; /* 가운데 정렬 */
}
/* 의견을 입력해주세요란 */
.comment-section {
	font-family: KB금융 본문체 Light;
	display: flex;
	align-items: center;
	margin-top: 20px;
	border-top: 1px solid #000;
	padding-top: 10px;
/* 	flex-wrap: nowrap; /* 요소들이 한 줄에 유지되도록 설정 */ */
	font-size: 12pt;
}

.opinion-textarea {
	font-family: KB금융 본문체 Light;
    width: calc(100% - 110px);
    height: 50px; /* 고정된 높이 설정 */
    min-height: 50px;
    max-height: 150px; /* 최대 높이 설정 */
    margin-right: 10px;
    margin-bottom: 50px;
    border: 2px solid #ccc;
    padding: 12px;
    border-radius: 5px;
    box-sizing: border-box;
    font-size: 12pt;
    transition: border-color 0.3s ease;
    rresize: none; /* 사용자가 크기를 조절할 수 없게 함 */
    overflow-y: auto;
    line-height: 1.5; /* 줄 간격 설정 */
}
.opinion-textarea:focus {
	outline: none; /* 기본 포커스 스타일 제거 */
	border: 1px solid #ffc107; /* 두꺼운 노란색 테두리 */
	box-shadow: 0 0 5px rgba(255, 193, 7, 0.5); /* 선택적: 약간의 그림자 효과 */
}

/* 작성 버튼 */
.btn-write {
	font-family: KB금융 제목체 Light;
	width: 100px;
	height: 50px;
	border: none;
	background-color: #FFCC00;
	color: #000;
	font-weight: bold; /* 텍스트 두께를 두껍게 조정 */
	font-size: 13pt;
	padding: 0 20px;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	margin-bottom: 50px;
}
.btn-write:hover {
	background-color: #D4AA00;
}

.opinion-list {
	clear: both;
	list-style: none;
	padding: 0;
	margin: 0;
}

.opinion-list li {
	margin-bottom: 10px;
}
    /* 비활성화된 요소를 위한 스타일 추가 */
    .disabled-element {
        opacity: 0.5;
        pointer-events: none;
    }
    .meeting-ended-notice {
        color: #cc0000;
        padding: 10px;
        text-align: center;
        font-weight: bold;
        width: 100%;
        box-sizing: border-box;
        position: sticky;
        top: 0;
        z-index: 1000;
    }
    /* 스테이지 네비게이션 링크 스타일 */
    .stages a {
        pointer-events: auto !important;
        opacity: 1 !important;
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
            var currentTab = urlParams.get('currentTab') || 'tab-smart'; // 기본값을 'tab-smart'로 설정
            var roomId = urlParams.get('roomId');
            var ideaId = urlParams.get('ideaId');
            var stage = urlParams.get('stage');


            if (roomId && ideaId) {
                showTab(currentTab, roomId, ideaId, stage);
            }
        };

/*         function getTabColor(tabName) {
            switch(tabName) {
                case 'tab-smart': return '#007bff';
                case 'tab-positive': return '#ffc107';
                case 'tab-worry': return '#28a745';
                case 'tab-strict': return '#dc3545';
                default: return '#007bff';
            }
        } */
        /* window.showTab = function(tabName, color, roomId, ideaId) {
            // 모든 탭 컨텐츠와 탭을 비활성화
            var tabs = document.getElementsByClassName('tab-content');
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove('active');
            }
            var allTabs = document.getElementsByClassName('tab');
            for (var j = 0; j < allTabs.length; j++) {
                allTabs[j].classList.remove('active');
            }

            // 선택된 탭 컨텐츠와 탭을 활성화
            document.getElementById(tabName).classList.add('active');
            document.querySelector('.tab.' + tabName).classList.add('active');

            // 폼의 currentTab 값을 업데이트
            var currentTabInputs = document.querySelectorAll('input[name="currentTab"]');
            for (var k = 0; k < currentTabInputs.length; k++) {
                currentTabInputs[k].value = tabName;
            }

            // URL을 업데이트
            history.replaceState(null, '', `?roomId=${roomId}&ideaId=${ideaId}&currentTab=${tabName}`);
            
         // URL 업데이트
            if (tabName !== 'tab-smart' || (urlParams.get('currentTab') && urlParams.get('currentTab') !== 'tab-smart')) {
                history.replaceState(null, '', `?roomId=${roomId}&ideaId=${ideaId}&currentTab=${tabName}`);
            } else {
                history.replaceState(null, '', `?roomId=${roomId}&ideaId=${ideaId}`);
            }
        } */
        window.showTab = function(tabName, roomId, ideaId,stage) {
            // 모든 탭 컨텐츠와 탭을 비활성화
            var tabs = document.getElementsByClassName('tab-content');
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove('active');
            }
            var allTabs = document.getElementsByClassName('tab');
            for (var j = 0; j < allTabs.length; j++) {
                allTabs[j].classList.remove('active');
            }

            // 선택된 탭 컨텐츠와 탭을 활성화
            var selectedContent = document.getElementById(tabName);
            var selectedTab = document.querySelector('.tab.' + tabName);
            
            if (selectedContent && selectedTab) {
                selectedContent.classList.add('active');
                selectedTab.classList.add('active');
            }

            // 폼의 currentTab 값을 업데이트
            var currentTabInputs = document.querySelectorAll('input[name="currentTab"]');
            for (var k = 0; k < currentTabInputs.length; k++) {
                currentTabInputs[k].value = tabName;
            }

            // URL을 업데이트
            history.replaceState(null, '', '?roomId=' + roomId + '&ideaId=' + ideaId + '&currentTab=' + tabName+'&stage='+stage);
        };

    	// 의견을 작성하지 않은 상태로 작성 버튼 클릭시 오류 팝업창 + 작성할 수 있는 의견 수가 0개인 탭에 의견 작성시 오류 팝업창
         window.validateAndSubmitForm = function(tabName, maxComments, currentOpinionCount) {
            var opinionText = document.querySelector('#' + tabName + ' .opinion-textarea').value.trim();
            if (opinionText === '') {
                alert('의견을 입력해주세요!');
            } else {
                document.querySelector('#' + tabName + ' form').submit();
                form.submit(); 
            }
        }; 
        
        window.deleteOpinion = function(opinionId, currentTab) {
            var roomId = '<c:out value="${roomId}" />';
            var ideaId = '<c:out value="${ideaId}" />';
            var stage = '<c:out value="${stage}" />';
            
            // opinionId와 currentTab이 올바른지 확인
            if (!opinionId || !currentTab) {
                alert('삭제할 의견 정보가 잘못되었습니다.');
                return;
            }
            
            if (confirm('정말로 이 의견을 삭제하시겠습니까?')) {
                var url = 'deleteOpinion?opinionId=' + opinionId + '&currentTab=' + currentTab + '&roomId=' + roomId + '&ideaId=' + ideaId+'&stage='+stage;
                window.location.href = url;
            }
        };

        var urlParams = new URLSearchParams(window.location.search);
        var currentTab = urlParams.get('currentTab');
        var roomId = urlParams.get('roomId');
        var ideaId = urlParams.get('ideaId');
        var stage = urlParams.get('stage');
        if (currentTab && roomId && ideaId && stage) {
            showTab(currentTab, roomId, ideaId,stage);
        }
    });
    
    /* 타이머 종료시 함수 */
    function onTimerEnd() {
	    // 방장
/* 		if ("${roomManagerId}" === "${userId}") {
	        document.getElementById("nextStepButton").style.display = "block";
		} */
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
        if (confirm("정말로 다음 페이지로 넘어가시겠습니까? \n아이디어 2개가 모두 제출됩니다.")) {
        	const roomId = "${roomId}";
            const ideaId = "${ideaId}";
            window.location.href = "./ideaOpinionsClear?roomId=" + roomId + "&ideaId=" + ideaId;
        }
    }
 	
  	//상세내역 토글
    document.addEventListener('DOMContentLoaded', function() {
    	const toggleSwitch = document.getElementById('toggleDescription');
        const toggleText = document.querySelector('.toggle-text');
        const descriptionContent = document.getElementById('descriptionContent');

        if (toggleSwitch) {  // 요소가 존재하는지 확인
            toggleSwitch.addEventListener('change', function() {
                if (this.checked) {
                    descriptionContent.style.display = 'block';
                    toggleText.textContent = '설명 숨기기';
                } else {
                    descriptionContent.style.display = 'none';
                    toggleText.textContent = '설명 보기';
                }
            });
        }
    });
  	
    document.addEventListener('DOMContentLoaded', function() {
        function adjustTextareaHeight(textarea) {
            textarea.style.height = 'auto';
            textarea.style.height = (textarea.scrollHeight) + 'px';
        }

        document.querySelectorAll('.opinion-textarea').forEach(function(textarea) {
            textarea.addEventListener('input', function() {
                adjustTextareaHeight(this);
            });

            // 초기 높이 설정
            adjustTextareaHeight(textarea);
        });
    });
  	
  	// 타이머 종료시 Time Out 표시(다음 단계에서 되돌아올 때)
    document.addEventListener("DOMContentLoaded", function() {
        const stageId = ${meetingRoom.getStageId()};
        const timerElement = document.getElementById("timer");
        const timerMessageElement = document.getElementById("timer-message");
        if (stageId >= 4) {
            if (timerElement) {
                timerElement.innerHTML = "Time Out";
            }
            if (timerMessageElement) {
                timerMessageElement.innerHTML = "지금은 작성할 수 없어요";
                timerMessageElement.classList.remove("active");
                timerMessageElement.classList.add("expired");
            }
            window.updateTimer = function() {
            };
            
            // 입력창 숨기고 타이머 종료 메세지 띄우기
            document.querySelectorAll(".comment-section").forEach(function(el) {
                el.style.display = "none";
            });
            document.querySelectorAll(".comment-ended").forEach(function(el) {
                el.style.display = "block";
            });
        }
    });
  	

</script>
<script>
    // 특정 요소 비활성화 함수
    function disableInteraction() {
        const elementsToDisable = document.querySelectorAll('input, textarea, button, select');
        elementsToDisable.forEach(element => {
            if (!element.closest('.stages')) {  // stages 클래스 내부의 요소는 제외
                element.disabled = true;
                element.classList.add('disabled-element');
            }
        });

        // 폼 제출 방지
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
            form.onsubmit = function(e) {
                e.preventDefault();
                return false;
            };
        });

        // 회의 종료 안내 메시지 추가
        const notice = document.createElement('div');
        notice.className = 'meeting-ended-notice';
        notice.innerHTML = '회의 기간이 종료되어 더 이상 수정이 불가능합니다. 단, 스테이지 간 이동은 가능합니다.';
        
        // 헤더 다음에 알림 삽입
        const header = document.querySelector('header');
        if (header && header.nextSibling) {
            header.parentNode.insertBefore(notice, header.nextSibling);
        } else {
            document.body.insertBefore(notice, document.body.firstChild);
        }

        // stages 클래스 내부의 요소들은 비활성화에서 제외
        const stageLinks = document.querySelectorAll('.stages a');
        stageLinks.forEach(link => {
            link.classList.remove('disabled-element');
        });
    }

 // 페이지 로드 시 실행
    window.onload = function() {
        // 기존 onload 함수 내용 유지
        
        // 회의 기간 종료 확인
        const endDateStr = '${meetingRoom.getEndDate()}';
        if (endDateStr) {
            const endDate = new Date(endDateStr);
            const now = new Date();
            
            // 종료일의 다음날 자정을 계산
            const dayAfterEnd = new Date(endDate);
            dayAfterEnd.setDate(dayAfterEnd.getDate() + 1);
            dayAfterEnd.setHours(0, 0, 0, 0);
            
            if (now >= dayAfterEnd) {
                disableInteraction();
            }
        }
    };
</script>
</head>


<body style="margin: 0;">
	<div class="stage3-header">
		<%@ include file="../header.jsp"%>
	</div>
	<%@ include file="../leftSideBar.jsp"%>
	<%@ include file="../rightSideBar.jsp"%>

	<div class="ideaOpinions-body">
		<div class="container">
		
			<!-- 5개 단계 표시 -->
	         <%String[] stages = {"아이디어 초안", "초안 투표하기", "관점별 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
	         request.setAttribute("stages", stages);%>
	         
	         <div class="stages">
	             <c:forEach var="stage" items="${stages}" varStatus="status">
	                 <c:choose>
	                     <c:when test="${meetingRoom.getStageId() >= status.index + 1}">
	                         <a
	                             href="./roomDetail?roomId=${meetingRoom.getRoomId()}&stage=${status.index + 1}&ideaId=${yesPickList[0].getIdeaID()}"
	                             class="stage ${meetingRoom.getStageId() == status.index + 1 ? 'active2' : ''}">
	                             ${status.index + 1}. ${stage}
	                         </a>
	                     </c:when>
	                     <c:otherwise>
	                         <div class="stage inactive">${status.index + 1}. ${stage}</div>
	                     </c:otherwise>
	                 </c:choose>
	             </c:forEach>
	         </div>
	         
	         <!-- 제목 -->
	         <div class="ideaOpinionList-title1">
	            <c:choose>
	               <c:when test="${ideaId == yesPickList[0].ideaID}">
				        <!-- 뒤로가기버튼(ideaOpinionsList로 이동) -->
	               		<a href="./ideaOpinionsList?roomId=${roomId}&ideaId=${ideaId}&stage=${stage}">
				        	<img src="./resources/back2.png" alt="뒤로가기" class="back-btn">
				        </a>
	                    아이디어 A
	               </c:when>
	               <c:otherwise>
	               		<a href="./ideaOpinionsList?roomId=${roomId}&ideaId=${ideaId}&stage=${stage}">
				        	<img src="./resources/back2.png" alt="뒤로가기" class="back-btn">
				        </a>	               
	                    아이디어 B
	               </c:otherwise>
	            </c:choose>
	         </div>
	         <div class="ideaOpinionList-title2">
	              [${ideaTitle}]
	          </div>
	          
	          <!-- 상세설명 -->
	         <!-- <button class="grey-button">설명 보기/숨기기</button> -->
	         <div class="title-detail">
	             <div class="toggle-container">
	                 <div class="toggle-switch">
	                     <input type="checkbox" id="toggleDescription" class="toggle-input">
	                     <label for="toggleDescription" class="toggle-label">
	                         <span class="toggle-inner"></span>
	                         <span class="toggle-switch"></span>
	                     </label>
	                 </div>
	                 <span class="toggle-text">설명 보기</span>
	             </div>
	             <div id="descriptionContent" style="display:none;">
	                 <pre>${meetingRoom.getDescription()}</pre>
	             </div>
	         </div>
	          
	         <!-- 방장이면 표시 -->
	          <%-- <div class="rightAligned">
	            <c:if test="${userId == roomManagerId}">
	               <!-- 현재 단계 완료 참여자 수 -->
	               <span class="countDone"> 현재 단계 완료 참여자 수:
	                  ${doneUserCount}/${userCount}</span>
	               <!-- 다음 단계로 버튼 -->
	               <button id="nextStepButton" class="nextStepButton"
	                  onclick="confirmNextStep()">다음 단계로</button>
	            </c:if>
	         </div>  --%>
	         
	         <hr class="line">


			<!-- 4가지 탭 -->
			<div class="tabs">
				<div class="tab tab-smart" onclick="showTab('tab-smart', '${roomId}', '${ideaId}','${stage}')">객관적관점<br>
					<div style="font-size: 11pt;">(추가작성 ${maxComments-smartOpinionCount}개 가능)</div>
				</div>
				<div class="tab tab-positive" onclick="showTab('tab-positive', '${roomId}', '${ideaId}','${stage}')">기대효과<br>
					<div style="font-size: 11pt;">(추가작성 ${maxComments-positiveOpinionCount}개 가능)</div>
				</div>
				<div class="tab tab-worry" onclick="showTab('tab-worry', '${roomId}', '${ideaId}','${stage}')">문제점<br>
					<div style="font-size: 11pt;">(추가작성 ${maxComments-worryOpinionCount}개 가능)</div>
				</div>
				<div class="tab tab-strict" onclick="showTab('tab-strict', '${roomId}', '${ideaId}','${stage}')">실현가능성<br>
					<div style="font-size: 11pt;">(추가작성 ${maxComments-strictOpinionCount}개 가능)</div>
				</div>
			</div>


			<!-- 겍관적관점 -->
			<div class="opinion-section">
				<div id="tab-smart" class="tab-content active">
					<div class="tabExplain" style="margin-left: -840px;">현황, 관련 데이터 등 <br> 객관적인 관점을 작성해주세요.</div>
					<div class="opinion-counts" style="text-align: right; width: 92%; margin-bottom: 10px;">
						나는 2개 중 ${userOpinionCount}개의 댓글을 작성했어요! <br> 
						<%-- 현재 탭의 작성된 의견 수: ${smartOpinionCount}/(최대)${maxComments} --%>
					</div>

					<ul class="opinion-list">
						<c:choose>
							<c:when test="${empty smartOpinions}">
								<li class="no-opinions"><img
									src="./resources/noContents.png" alt="No opinions"
									style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
									<br> 의견이 아직 등록되지 않았어요! <br><br></li>
							</c:when>
							<c:otherwise>
								<c:forEach var="opinion" items="${smartOpinions}">
									<li class="opinion-entry">
										<div class="name-date">
											<span class="name">${opinion.userName}</span>
											<div class="date">
												<fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" />
											</div>
										</div>
										<pre  class="opinion-text">${opinion.opinionText}</pre> 
										<c:if test="${opinion.userID == userId}">
											<button class="delete-button"onclick="deleteOpinion(${opinion.opinionID}, 'tab-smart')">삭제</button>
										</c:if>
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</ul>

					<div class="comment-section">
					    <c:if test="${not empty error}">
					        <div class="error-message">${error}</div>
					    </c:if>
					    <c:choose>
					        <c:when test="${(2 - userOpinionCount > 0) && (smartOpinionCount < maxComments) && !userCommentedTabs.contains('Smart')}">
					            <form:form method="post" action="./addOpinion"
					                class="input-form" modelAttribute="opinionForm">
					                <form:hidden path="hatColor" value="Smart" />
					                <form:hidden path="currentTab" value="tab-smart" />
					                <form:hidden path="roomId" value="${roomId}" />
					                <form:hidden path="ideaId" value="${ideaId}" />
					                <input type="hidden" name="stage" value="${stage}" />
					                <form:textarea path="opinionText" class="opinion-textarea" placeholder="의견을 입력해주세요" rows="1" />
					                <button type="button" class="btn-write"
					                    onclick="validateAndSubmitForm('tab-smart', ${maxComments}, ${smartOpinionCount})">작성 
					                </button>
					            </form:form>
					        </c:when>
					        <c:when test="${2 - userOpinionCount <= 0}">
					            <div style="margin-left: 80px; margin-bottom: 200px;">
					            	필수 의견 2개 작성을 완료하셨습니다. 더 이상 의견을 작성할 수 없습니다.
					            </div>
					        </c:when>
						    <c:when test="${userCommentedTabs.contains('Smart')}">
					            <div style="margin-left: 80px; margin-bottom: 200px;">
					                이미 해당 탭에 의견을 작성하셨습니다. 다른 탭에 의견을 작성해주세요.
					            </div>
					        </c:when>
					        <c:when test="${smartOpinionCount >= maxComments}">
					            <div style="margin-left: 80px; margin-bottom: 200px;">
					                의견 작성 제한 인원을 초과하였습니다. 다른 의견 탭에 의견을 작성해주세요.
					            </div>
					        </c:when>
					    </c:choose>
					</div>
					<div class="comment-ended" style="display: none; margin-left: 80px; margin-bottom: 200px;">
					    타이머가 종료되었습니다. 더 이상 의견을 작성할 수 없습니다.
					</div>
				</div>


				<!-- 기대효과 -->
				<div id="tab-positive" class="tab-content">
					<div class="tabExplain" style="margin-left: -250px;">긍정적인 의견과 장점을 작성해주세요. </div>

					<div class="opinion-counts" style="text-align: right; width: 92%; margin-bottom: 10px;">
						나는 2개 중 ${userOpinionCount}개의 댓글을 작성했어요! <br> 
						<%-- 현재 탭의 작성된 의견 수: ${positiveOpinionCount}/(최대)${maxComments} --%>
					</div>

					<ul class="opinion-list">
						<c:choose>
							<c:when test="${empty positiveOpinions}">
								<li class="no-opinions"><img
									src="./resources/noContents.png" alt="No opinions"
									style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
									<br> 의견이 아직 등록되지 않았어요! <br> <br></li>
							</c:when>
							<c:otherwise>
								<c:forEach var="opinion" items="${positiveOpinions}">
									<li class="opinion-entry">
										<div class="name-date">
											<span class="name">${opinion.userName}</span>
											<div class="date">
												<fmt:formatDate value="${opinion.createdAt}"
													pattern="yyyy-MM-dd HH:mm" />
											</div>
										</div>
										<pre class="opinion-text">${opinion.opinionText}</pre> 
										<c:if
											test="${opinion.userID == userId}">
											<button class="delete-button"
												onclick="deleteOpinion(${opinion.opinionID}, 'tab-positive')">삭제</button>
										</c:if>
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</ul>

					<div class="comment-section">
					    <c:if test="${not empty error}">
					        <div class="error-message">${error}</div>
					    </c:if>
					    <c:choose>
					    	<c:when test="${(2 - userOpinionCount > 0) && (positiveOpinionCount < maxComments) && !userCommentedTabs.contains('Positive')}">
					            <form:form method="post" action="./addOpinion"
					                modelAttribute="opinionForm" class="input-form">
					                <form:hidden path="hatColor" value="Positive" />
					                <form:hidden path="currentTab" value="tab-positive" />
					                <form:hidden path="roomId" value="${roomId}" />
					                <form:hidden path="ideaId" value="${ideaId}" />
					                <input type="hidden" name="stage" value="${stage}" />
					                <form:textarea path="opinionText" class="opinion-textarea" placeholder="의견을 입력해주세요" rows="1" />
					                <button type="button" class="btn-write"
					                    onclick="validateAndSubmitForm('tab-positive', ${maxComments}, ${positiveOpinionCount})">작성</button>
					            </form:form>
					        </c:when>
					        <c:when test="${2 - userOpinionCount <= 0}">
					            <div style="margin-left: 80px; margin-bottom: 200px;">
					                필수 의견 2개 작성을 완료하셨습니다. 더 이상 의견을 작성할 수 없습니다.
					            </div>
					        </c:when>
					        <c:when test="${userCommentedTabs.contains('Positive')}">
					            <div style="margin-left: 80px; margin-bottom: 200px;">
					                이미 해당 탭에 의견을 작성하셨습니다. 다른 탭에 의견을 작성해주세요.
					            </div>
					        </c:when>
					        <c:when test="${positiveOpinionCount >= maxComments}">
					            <div style="margin-left: 80px; margin-bottom: 200px;">
					                의견 작성 제한 인원을 초과하였습니다. 다른 의견 탭에 의견을 작성해주세요.
					            </div>
					        </c:when>
					    </c:choose>
					</div>
					<div class="comment-ended" style="display: none; margin-left: 80px; margin-bottom: 200px;">
					    타이머가 종료되었습니다. 더 이상 의견을 작성할 수 없습니다.
					</div>
				</div>



				<!-- 문제점 -->
				<div id="tab-worry" class="tab-content">
				    <div class="tabExplain" style="margin-left: 290px;"> 아이디어에 대한 보완점 <br> 또는 우려사항을 작성해주세요.</div>
				    
				    <div class="opinion-counts" style="text-align: right; width: 92%; margin-bottom: 10px;">
				    	나는 2개 중 ${userOpinionCount}개의 댓글을 작성했어요! <br> 
						<%-- 현재 탭의 작성된 의견 수: ${worryOpinionCount}/(최대)${maxComments} --%>
				    </div>
				    
				    <ul class="opinion-list">
				        <c:choose>
				            <c:when test="${empty worryOpinions}">
				                <li class="no-opinions"><img src="./resources/noContents.png" alt="No opinions"
				                    style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
				                    <br> 의견이 아직 등록되지 않았어요! <br><br>
				                </li>
				            </c:when>
				            <c:otherwise>
				                <c:forEach var="opinion" items="${worryOpinions}">
				                    <li class="opinion-entry">
				                    <div class="name-date">
				                        <span class="name">${opinion.userName}</span>
				                        <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
				                    </div>
				                    <pre class="opinion-text">${opinion.opinionText}</pre>
				                    <c:if test="${opinion.userID == userId}">
				                        <button class="delete-button" onclick="deleteOpinion(${opinion.opinionID}, 'tab-worry')">삭제</button>
				                    </c:if>
				                    </li>
				                </c:forEach>
				            </c:otherwise>
				        </c:choose>
				    </ul>
				    
				    <div class="comment-section">
					    <c:if test="${not empty error}">
					        <div class="error-message">${error}</div>
					    </c:if>
					    <c:choose>
					    	<c:when test="${(2 - userOpinionCount > 0) && (worryOpinionCount < maxComments) && !userCommentedTabs.contains('Worry')}">
					            <form:form method="post" action="./addOpinion"
					                modelAttribute="opinionForm" class="input-form">
					                <form:hidden path="hatColor" value="Worry" />
					                <form:hidden path="currentTab" value="tab-worry" />
					                <form:hidden path="roomId" value="${roomId}" />
					                <form:hidden path="ideaId" value="${ideaId}" />
					                <input type="hidden" name="stage" value="${stage}" />
					                <form:textarea path="opinionText" class="opinion-textarea" placeholder="의견을 입력해주세요" rows="1" />
					                <button type="button" class="btn-write"
					                    onclick="validateAndSubmitForm('tab-worry', ${maxComments}, ${worryOpinionCount})">작성</button>
					            </form:form>
					        </c:when>
					        <c:when test="${2 - userOpinionCount <= 0}">
					            <div style="margin-left: 80px; margin-bottom: 200px;">
					                필수 의견 2개 작성을 완료하셨습니다. 더 이상 의견을 작성할 수 없습니다.
					            </div>
					        </c:when>
					        <c:when test="${userCommentedTabs.contains('Worry')}">
					            <div style="margin-left: 80px; margin-bottom: 200px;">
					                이미 해당 탭에 의견을 작성하셨습니다. 다른 탭에 의견을 작성해주세요.
					            </div>
					        </c:when>
					        <c:when test="${worryOpinionCount >= maxComments}">
					            <div style="margin-left: 80px; margin-bottom: 200px;">
					                의견 작성 제한 인원을 초과하였습니다. 다른 의견 탭에 의견을 작성해주세요.
					            </div>
					        </c:when>
					    </c:choose>
					</div>
					<div class="comment-ended" style="display: none; margin-left: 80px; margin-bottom: 200px;">
					    타이머가 종료되었습니다. 더 이상 의견을 작성할 수 없습니다.
					</div>
				</div>


				<!-- 실현가능성 -->
				<div id="tab-strict" class="tab-content">
				    <div class="tabExplain" style="margin-left: 840px;"> 개발 비용, 실현 가능성 등 <br> 현실적 관점을 작성해주세요. </div>
				    
				    <div class="opinion-counts" style="text-align: right; width: 92%; margin-bottom: 10px;">
				    	나는 2개 중 ${userOpinionCount}개의 댓글을 작성했어요! <br> 
				    	<%-- 내가 작성한 의견 수: ${2-userOpinionCount}/2(필수) --%> 
						<%-- 현재 탭의 작성된 의견 수: ${strictOpinionCount}/(최대)${maxComments} --%>
				    </div>
				    
				    <ul class="opinion-list">
				        <c:choose>
				            <c:when test="${empty strictOpinions}">
				                <li class="no-opinions"><img
				                    src="./resources/noContents.png" alt="No opinions"
				                    style="width: 180px; height: 200px; vertical-align: middle; margin-right: 10px;">
				                    <br> 의견이 아직 등록되지 않았어요! <br>
				                <br></li>
				            </c:when>
				            <c:otherwise>
				                <c:forEach var="opinion" items="${strictOpinions}">
				                    <li class="opinion-entry">
				                    <div class="name-date">
				                        <span class="name">${opinion.userName}</span>
				                        <div class="date"><fmt:formatDate value="${opinion.createdAt}" pattern="yyyy-MM-dd HH:mm" /></div>
				                    </div>
				                    <pre class="opinion-text">${opinion.opinionText}</pre>
				                    <c:if test="${opinion.userID == userId}">
				                        <button class="delete-button" onclick="deleteOpinion(${opinion.opinionID}, 'tab-strict')">삭제</button>
				                    </c:if>
				                    </li>
				                </c:forEach>
				            </c:otherwise>
				        </c:choose>
				    </ul>
				    
				    <div class="comment-section">
					    <c:if test="${not empty error}">
					        <div class="error-message">${error}</div>
					    </c:if>
					    <c:choose>
					    	<c:when test="${(2 - userOpinionCount > 0) && (strictOpinionCount < maxComments) && !userCommentedTabs.contains('Strict')}">
					            <form:form method="post" action="./addOpinion"
					                modelAttribute="opinionForm" class="input-form">
					                <form:hidden path="hatColor" value="Strict" />
					                <form:hidden path="currentTab" value="tab-strict" />
					                <form:hidden path="roomId" value="${roomId}" />
					                <form:hidden path="ideaId" value="${ideaId}" />
					                <input type="hidden" name="stage" value="${stage}" />
					                <form:textarea path="opinionText" class="opinion-textarea" placeholder="의견을 입력해주세요" rows="1" />
					                <button type="button" class="btn-write"
					                    onclick="validateAndSubmitForm('tab-strict', ${maxComments}, ${strictOpinionCount})">작성</button>
					            </form:form>
					        </c:when>
					        <c:when test="${2 - userOpinionCount <= 0}">
					            <div style="margin-left: 80px; margin-bottom: 200px;">
					                필수 의견 2개 작성을 완료하셨습니다. 더 이상 의견을 작성할 수 없습니다.
					            </div>
					        </c:when>
					        <c:when test="${userCommentedTabs.contains('Strict')}">
					            <div style="margin-left: 80px; margin-bottom: 200px;">
					                이미 해당 탭에 의견을 작성하셨습니다. 다른 탭에 의견을 작성해주세요.
					            </div>
					        </c:when>
					        <c:when test="${strictOpinionCount >= maxComments}">
					            <div style="margin-left: 80px; margin-bottom: 200px;">
					                의견 작성 제한 인원을 초과하였습니다. 다른 의견 탭에 의견을 작성해주세요.
					            </div>
					        </c:when>
					    </c:choose>
					</div>
					<div class="comment-ended" style="display: none; margin-left: 80px; margin-bottom: 200px;">
					    타이머가 종료되었습니다. 더 이상 의견을 작성할 수 없습니다.
					</div>
				</div>
			
			
			
			</div>
		</div>
	</div>
</body>
</html>