<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThinkKB</title>
<style>
.ab-body {
    font-family: Arial, sans-serif;
    background-color: #FFFFf1;
}

.header1 {
    text-align: center;
}

.header1 img {
    width: 100%;
    height: auto;
    max-height: 500px;
}

.user-info p {
    margin: 0;
}

.button-container {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 10px;
}

.progress-container {
    display: flex;
    justify-content: center;
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
    font-size: 1.3em;
    justify-content: flex-start;
}

.progress label {
    display: flex;
    align-items: center;
    margin-left: 40px;
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
    margin-top: 50px;
}

.progress-header {
    margin: 0;
    padding: 10px 0;
}

.ideas {
    margin: 70px 20px;
}

.idea {
    padding: 20px 20px;
    background-color: #ffffff;
    border-radius: 10px;
    margin-top: 30px;
    margin-left: auto;
    margin-right: auto;
    height: 100px;
    width: 80%;
    border: 1px solid #ccc;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    font-size: 1.2em;
    cursor: pointer;
}

.idea h3, .idea p {
    margin: 0;
}

.idea-left {
    text-align: left;
}

.idea-right {
    display: flex;
    justify-content: center;
    align-items: center;  /* 세로 가운데 정렬 */
    flex-direction: column;
    height: 100%;
}

.idea-status {
    padding: 10px 20px;
    border-radius: 10px;
    color: white;
    font-weight: bold;
    text-align: center;
}

.idea-complete {
    background-color: #CEFBC9; /* 완료 상태 배경색 */
}

.idea-incomplete {
    background-color: #EAEAEA; /* 미완료 상태 배경색 */
}

.idea-incomplete:hover {
    background-color: #D3D3D3; /* 미완료 상태 호버 배경색 */
}

.vote-button-container {
    display: flex;
    justify-content: center;
    margin-top: 30px;
}

.vote-button {
    background-color: #ffc107;
    font-size: 1.2em;
    border: none;
    width: 300px;
    padding: 15px 30px;
    border-radius: 25px;
    cursor: pointer;
}

.vote-button:hover {
    background-color: #e0a800;
}
</style>
</head>

<body class="ab-body">
    <div class="header1">
        <img src="./resources/header2.jpg" alt="Header Image">
    </div>
    <div class="progress-header-container">
        <h2 class="progress-header">진행중인 단계</h2>
    </div>
    <div class="progress-container">
        <div class="progress">
            <label><input type="checkbox" id="selectAll" onchange="toggleSelectAll(this)">전체 선택</label> 
            <label><input type="checkbox" data-stage="incomplete" onchange="filterIdeas()">미완료</label> 
            <label><input type="checkbox" data-stage="complete" onchange="filterIdeas()">완료</label> 
        </div>
    </div>
    <div class="ideas">
        <c:forEach var="test" items="${abTests}">
            <div class="idea ${test.participated ? 'idea-complete' : 'idea-incomplete'} active" onclick="redirectToDetail(${test.ABTestID})">
                <div class="idea-left">
                    <h3>${test.testName}</h3>
                    <br>
                </div>
                <div class="idea-right">
                    <div class="idea-status">
                        ${test.participated ? '완료' : '미완료'}
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</body>

<script>
function redirectToDetail(abTestId) {
    // 아이디어 클릭 시 해당 아이디어의 상세 페이지로 이동
    window.location.href = './adTsetdetail?abTestId=' + abTestId;
}
function filterIdeas(event) {
    event.preventDefault(); // 이벤트의 기본 동작(페이지 이동)을 막음

    var checkboxes = document.querySelectorAll('.progress input[data-stage]');
    var ideas = document.querySelectorAll('.idea');
    var anyChecked = false;

    checkboxes.forEach(function(checkbox) {
        if (checkbox.checked) {
            anyChecked = true;
        }
    });

    if (!anyChecked) {
        ideas.forEach(function(idea) {
            idea.style.display = 'flex';  // 모든 아이디어를 보이도록 설정
        });
    } else {
        ideas.forEach(function(idea) {
            idea.style.display = 'none';  // 기본적으로 숨김 처리
        });

        checkboxes.forEach(function(checkbox) {
            if (checkbox.checked) {
                var stage = checkbox.getAttribute('data-stage');
                var matchingIdeas = document.querySelectorAll('.' + stage);
                matchingIdeas.forEach(function(idea) {
                    idea.style.display = 'flex';  // 해당하는 아이디어만 보이도록 설정
                });
            }
        });
    }
}

function toggleSelectAll(selectAllCheckbox) {
    var checkboxes = document.querySelectorAll('.progress input[data-stage]');
    checkboxes.forEach(function(checkbox) {
        checkbox.checked = selectAllCheckbox.checked;
    });
    filterIdeas(event); // toggleSelectAll 함수에서 filterIdeas를 호출할 때 이벤트 객체를 전달
}

document.addEventListener('DOMContentLoaded', function() {
    var checkboxes = document.querySelectorAll('.progress input[data-stage]');
    checkboxes.forEach(function(checkbox) {
        checkbox.addEventListener('change', function(event) {
            filterIdeas(event); // change 이벤트 발생 시 filterIdeas 함수 호출
        });
    });
    filterIdeas(new Event('preventDefault')); // 페이지 로드 시 기본 필터링
});
</script>
</html>
