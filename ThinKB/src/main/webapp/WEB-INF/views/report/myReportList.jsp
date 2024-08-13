<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB - 보고서 목록</title>
<style>
html, body {
    max-width: 100%;
    overflow-x: hidden;
}
.report-body {
	font-family: Arial, sans-serif;
}

.report-banner {
	margin-top: 50px; /* content 영역의 여백 설정 */
	margin-left: 15%;
	margin-right: 15%;
	margin-top: 1%;
}

.report-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
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
    padding: 10px 20px;
    border-radius: 25px;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 50px;
    width: 80%;
    border: 1px solid #ccc;
    font-size: 1.1em;
    margin-bottom: 50px;
}

.progress label {
    display: flex;
    align-items: center;
    margin: 0 50px;
}

.progress input {
    margin-right: 5px;
}

/* 진행중인 단계 스타일은 그대로 유지 */
.progress-header-container {
    display: flex;
    justify-content: left;
    width: 80%;
    margin: 0 auto;
    margin-top: 10px;
}

.progress-header {
    margin: 0;
    padding: 10px 0;
}
/*  */
.reports {
    display: flex;
    flex-wrap: wrap;
    gap: 30px;
    padding: 0;
    width: 100%;
}

.report {
    width: calc(50% - 15px);
    min-height: 200px;
    padding: 15px;
    border-radius: 20px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    cursor: pointer;
    transition: transform 0.3s ease;
    display: flex;
    flex-direction: column;
    box-sizing: border-box; 
    margin-bottom: 20px;
}

.report:hover {
    transform: translateY(-5px);
}

/* 추가: 화면 크기가 작아질 때 한 줄에 하나씩 표시 */
@media (max-width: 768px) {
    .report {
        width: 100%;
    }
}

.report.complete {
    background-color: #f0f0f0;
}

.report.draft {
    background-color: #fffbe6;
}

.status-tag {
    align-self: flex-start;
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 11pt;
    font-weight: bold;
    margin-bottom: 10px;
}

.report.complete .status-tag {
    background-color: #4a4a4a;
    color: white;
}

.report.draft .status-tag {
    background-color: #ffd700;
    color: black;
}

.report-title {
    font-size: 15pt;
    font-weight: bold;
    text-align: center;
    margin: 10px 0;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
}

.related-room {
    color: blue;
    font-size: 10pt;
    margin-bottom: 5px;
}

.room-title-container {
    background-color: white;
    border-radius: 5px;
    padding: 5px;
    margin-bottom: 10px;
}

.room-title {
    font-size: 13pt;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.report-action {
    font-size: 11pt;
    text-align: right;
    margin-top: auto;
}

.no-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    padding: 50px 0;
    margin-bottom: 100px;
}

.no-content img {
    max-width: 200px;
    margin-bottom: 20px;
}

.no-content p {
    font-size: 15pt;
    text-align: center;
    color: #666;
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

<body class="report-body">
	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>
	
	<!-- 상단 배너영역 -->
	<div class="report-banner">
		<img src="<c:url value='./resources/myReportBanner.png'/>" alt="abtestBanner" 
		style="max-width: 100%; height: auto;">
	</div>
	
	<!-- 단계별 조회 -->
	<div class="report-content">
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
	
	<!-- 보고서 목록 -->
<%-- 	<div class="reports">
	    <c:choose>
	        <c:when test="${not empty reportList}">
	            <c:forEach var="report" items="${reportList}" varStatus="status">
	                <div class="report ${report.stageId == 6 ? 'complete' : report.stageId == 5 ? 'draft' : ''}"
	                    onclick="handleIdeaClick('${report.stageId}', '${report.reportId}', '${report.roomId}')">
	                    <div class="report-left">
	                        <h3>${report.reportTitle}</h3>
	                        <h3>${report.getRoomTitle()}</h3>
	                    </div>
	                    <div class="report-right">
	                        <p>${report.stageId == 6 ? '완료' : '작성중'}</p>
	                    </div>
	                </div>
	            </c:forEach>
	        </c:when>
	        <c:otherwise>
	            <div class="noReport">
	                <p>리스트가 없습니다.</p>
	            </div>
	        </c:otherwise>
	    </c:choose>
	</div> --%>
	<!-- 보고서 목록 -->
	<div class="reports">
	    <c:choose>
	        <c:when test="${empty reportList}">
	            <div class="no-content">
	                <img src="<c:url value='./resources/noContent.png'/>" alt="No Content">
	                <p>내가 작성한 보고서가 아직 없어요!</p>
	            </div>
	        </c:when>
	        <c:otherwise>
	            <c:forEach var="report" items="${reportList}" varStatus="status">
	                <div class="report ${report.getStatus() == '완료' ? 'complete' : 'draft'}"
	                     onclick="handleIdeaClick('${report.stageId}', '${report.roomId}')">
	                    <div class="status-tag">${report.getStatus() == '완료' ? '제출 완료' : '작성중'}</div>
	                    <h3 class="report-title">${report.getReportTitle()}</h3>
	                    <div style="display:flex; justify-content:flex-end;"><p>작성일자 : ${report.getUpdateAt()}</p></div>
	                    <p class="related-room">연결된 아이디어 회의방</p>
	                    <div class="room-title-container">
	                        <p class="room-title">${report.getRoomTitle()}</p>
	                    </div>
	                    <p class="report-action">
	                        ${report.getStatus() == '완료' ? '보고서 다운로드' : '보고서 수정하러가기'}
	                    </p>
	                </div>
	            </c:forEach>
	        </c:otherwise>
	    </c:choose>
	</div>
	
</div>
	<script>
	function filterIdeas() {
	    var checkboxes = document.querySelectorAll('.progress input');
	    var reports = document.querySelectorAll('.report'); // '.idea'를 '.report'로 변경
	    var stageFilters = {
	        'draft': false,
	        'complete': false
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

	    reports.forEach(function(report) { // 'idea'를 'report'로 변경
	        var reportStage = report.classList.contains('draft') ? 'draft'
	                : report.classList.contains('complete') ? 'complete'
	                : null;
	        if (reportStage && stageFilters[reportStage]) {
	            report.style.display = 'flex';
	        } else if (!anyFilterChecked) {
	            report.style.display = 'flex';
	        } else {
	            report.style.display = 'none';
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
		
		function handleIdeaClick(stageId, roomId) {
		    if (stageId != 6) {
		        window.location.href = './roomDetail?roomId=' + roomId+'&stage='+stageId;
		    } else if (stageId == 6) {
		        // 다운로드 확인을 위한 alert
		        var userConfirmed = window.confirm('보고서를 다운받으시겠습니까?');
		        if (userConfirmed) {
		            window.location.href = './upload/formData_' + roomId + '.docx';
		        }
		    }
		}
	</script>
	</body>
</html>
