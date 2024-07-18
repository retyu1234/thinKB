<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>4가지 견해 등록 1</title>
<style>
body {
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #f0f0f0;
    margin: 0;
    font-family: 'Arial', sans-serif;
}

h1 {
    text-align: center;
    margin: 20px 0;
}

.tabs {
    display: flex;
    justify-content: space-around;
    width: 80%;
    margin: 20px auto;
    border-bottom: 2px solid #ccc;
}

.tab {
    padding: 15px 25px;
    cursor: pointer;
    font-weight: bold;
    flex: 1;
    text-align: center;
    color: #fff;
    transition: background-color 0.3s ease;
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

.tab-content {
    display: none;
    width: 80%;
    border: 2px solid #ffc107; /* 노란색 두꺼운 실선 */
    margin-top: 20px;
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
}

.opinion-textarea {
    width: calc(100% - 100px);
    height: 50px;
    margin-right: 10px;
    border: 1px solid #ccc;
    padding: 10px;
    border-radius: 5px;
}

button {
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

button:hover {
    background-color: #e0a800;
}

</style>
<script>
	function showTab(tabName) {
		var tabs = document.getElementsByClassName('tab-content');
		for (var i = 0; i < tabs.length; i++) {
			tabs[i].classList.remove('active');
		}
		document.getElementById(tabName).classList.add('active');
	}
</script>
</head>
<body>
	<h1>아이디어 회의를 매일 아침 10분씩 진행하기</h1>
	<div class="tabs">
		<div class="tab tab-smart" onclick="showTab('tab-smart')">똑똑이</div>
		<div class="tab tab-positive" onclick="showTab('tab-positive')">긍정이</div>
		<div class="tab tab-worry" onclick="showTab('tab-worry')">걱정이</div>
		<div class="tab tab-strict" onclick="showTab('tab-strict')">깐깐이</div>
	</div>

	<div id="tab-smart" class="tab-content active">
		<h2>똑똑이</h2>
		<ul class="opinion-list">
			<c:forEach var="opinion" items="${smartOpinions}">
				<li>${opinion.opinionText}</li>
			</c:forEach>
		</ul>
		<div class="comment-section">
			<form:form method="post" action="addOpinion"
				modelAttribute="opinionForm">
				<form:hidden path="hatColor" value="Smart" />
				<form:textarea path="opinionText" class="opinion-textarea"
					placeholder="입력해주세요" />
				<button type="submit">등록</button>
			</form:form>
		</div>
	</div>

	<div id="tab-positive" class="tab-content">
		<h2>긍정이</h2>
		<ul class="opinion-list">
			<c:forEach var="opinion" items="${positiveOpinions}">
				<li>${opinion.opinionText}</li>
			</c:forEach>
		</ul>
		<div class="comment-section">
			<form:form method="post" action="addOpinion"
				modelAttribute="opinionForm">
				<form:hidden path="hatColor" value="Positive" />
				<form:textarea path="opinionText" class="opinion-textarea"
					placeholder="입력해주세요" />
				<button type="submit">등록</button>
			</form:form>
		</div>
	</div>

	<div id="tab-worry" class="tab-content">
		<h2>걱정이</h2>
		<ul class="opinion-list">
			<c:forEach var="opinion" items="${worryOpinions}">
				<li>${opinion.opinionText}</li>
			</c:forEach>
		</ul>
		<div class="comment-section">
			<form:form method="post" action="addOpinion"
				modelAttribute="opinionForm">
				<form:hidden path="hatColor" value="Worry" />
				<form:textarea path="opinionText" class="opinion-textarea"
					placeholder="입력해주세요" />
				<button type="submit">등록</button>
			</form:form>
		</div>
	</div>

	<div id="tab-strict" class="tab-content">
		<h2>깐깐이</h2>
		<ul class="opinion-list">
			<c:forEach var="opinion" items="${strictOpinions}">
				<li>${opinion.opinionText}</li>
			</c:forEach>
		</ul>
		<div class="comment-section">
			<form:form method="post" action="addOpinion"
				modelAttribute="opinionForm">
				<form:hidden path="hatColor" value="Strict" />
				<form:textarea path="opinionText" class="opinion-textarea"
					placeholder="입력해주세요" />
				<button type="submit">등록</button>
			</form:form>
		</div>
	</div>
</body>
</html>
