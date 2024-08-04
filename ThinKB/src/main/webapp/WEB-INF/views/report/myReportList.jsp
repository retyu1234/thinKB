<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThinkKB</title>
<style>
.reportList-body {
	font-family: Arial, sans-serif;
	background-color: #FFFFff;
}
.content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
}
.container {
	width: 60%;
	margin: 0 auto;
	background-color: white;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
	justify-content: flex-start; /* 전체 컨테이너에서 왼쪽 정렬 */
}

.progress label {
	display: flex;
	align-items: center;
	margin-left: 40px; /* 레이블 간의 간격 조정 */
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
/*  */
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
	border: none;
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 1.2em; /* 글자 크기를 키움 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
}

.noIdea {
	padding: 20px 20px;
	background-color: #ffffff;
	border-radius: 10px;
	margin-top: 30px;
	margin-left: auto;
	margin-right: auto;
	height: 100px;
	width: 80%;
	border: none;
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 1.2em; /* 글자 크기를 키움 */
}

.idea h3, .idea p {
	margin: 0;
}

.idea-left {
	text-align: left;
}

.idea-right {
	text-align: right;
	align-self: flex-end;
	justify-content: flex-end;
	display: flex;
	flex-direction: column;
}
.idea.complete {
    background-color: #CEFBC9; /* 완료 색상 */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

.idea.draft {
    background-color: #FFFFFF; /* 작성중 색상 */
}
.yellow-button {
	background-color: #ffc107;
	color: white;
	font-size: 1.2em; /* 글자 크기를 키움 */
	border: none;
	padding: 20px 20px;
	border-radius: 30px;
	cursor: pointer;
	margin-top: 50px;
	margin-right: 180px;
}

.yellow-button:hover {
	background-color: #e0a800;
}
</style>
</head>

<body class="reportList-body">
	<%@ include file="../header.jsp"%>
	<div class="content">
	<div class="progress-header-container">
		<h2 class="progress-header">진행중인 단계</h2>
	</div>
	<div class="progress-container">
		<div class="progress">
			<label><input type="checkbox" id="selectAll"
				onchange="toggleAll()"> 전체</label> <label><input
				type="checkbox" data-stage="draft" onchange="filterIdeas()">
				작성중</label> <label><input type="checkbox" data-stage="complete"
				onchange="filterIdeas()"> 작성완료</label>
		</div>
	</div>
	<div class="ideas">
		<c:choose>
			<c:when test="${not empty reportList}">
				<c:forEach var="report" items="${reportList}">
					<div
						class="idea ${report.stageId == 6 ? 'complete' : report.stageId == 5 ? 'draft' : ''}"
						onclick="handleIdeaClick('${report.stageId}', '${report.reportId}', '${report.roomId}')">
						<div class="idea-left">
							<h3>${report.reportTitle}</h3>
							<br>
						</div>
						<div class="idea-right">
							<p>${report.stageId == 6 ? '완료' : '작성중'}</p>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="noIdea">
					<p>리스트가 없습니다.</p>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>
	<script>
		function handleIdeaClick(stageId, reportId, roomId) {
		    if (stageId == 5) {
		        window.location.href = '/editReport?reportId=' + reportId;
		    } else if (stageId == 6) {
		        // 다운로드 확인을 위한 alert
		        var userConfirmed = window.confirm('보고서를 다운받으시겠습니까?');
		        if (userConfirmed) {
		            window.location.href = './upload/formData_' + roomId + '.docx';
		        }
		    }
		}

		function filterIdeas() {
			var checkboxes = document.querySelectorAll('.progress input');
			var ideas = document.querySelectorAll('.idea');
			var stageFilters = {
				'draft' : false,
				'complete' : false
			};

			checkboxes.forEach(function(checkbox) {
				if (checkbox.checked) {
					var stage = checkbox.getAttribute('data-stage');
					if (stageFilters.hasOwnProperty(stage)) {
						stageFilters[stage] = true;
					}
				}
			});

			var draftChecked = stageFilters['draft'];
			var completeChecked = stageFilters['complete'];
			var anyFilterChecked = draftChecked || completeChecked;

			ideas.forEach(function(idea) {
				var ideaStage = idea.classList.contains('draft') ? 'draft'
						: idea.classList.contains('complete') ? 'complete'
								: null;
				if (ideaStage && stageFilters[ideaStage]) {
					idea.style.display = 'flex';
				} else if (!anyFilterChecked) {
					idea.style.display = 'flex';
				} else {
					idea.style.display = 'none';
				}
			});

			// 전체 체크박스 상태 업데이트
			var selectAllCheckbox = document.getElementById('selectAll');
			if (draftChecked && completeChecked) {
				selectAllCheckbox.checked = true;
			} else if (!draftChecked && !completeChecked) {
				selectAllCheckbox.checked = false;
			} else {
				selectAllCheckbox.indeterminate = true;
			}
		}

		function toggleAll() {
			var selectAllCheckbox = document.getElementById('selectAll');
			var draftCheckbox = document
					.querySelector('.progress input[data-stage="draft"]');
			var completeCheckbox = document
					.querySelector('.progress input[data-stage="complete"]');

			if (selectAllCheckbox.checked) {
				draftCheckbox.checked = true;
				completeCheckbox.checked = true;
			} else {
				draftCheckbox.checked = false;
				completeCheckbox.checked = false;
			}
			filterIdeas();
		}

		document.addEventListener('DOMContentLoaded', function() {
			var checkboxes = document.querySelectorAll('.progress input');
			checkboxes.forEach(function(checkbox) {
				checkbox.addEventListener('change', filterIdeas);
			});
			filterIdeas();
		});
	</script>
	</body>
</html>
