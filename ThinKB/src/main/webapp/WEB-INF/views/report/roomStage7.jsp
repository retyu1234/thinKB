<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보고서 양식</title>
<style>
.report-body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	padding: 20px;
}

.report-form-container {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	max-width: 600px;
	margin: 0 auto;
}

.report-form-container h2 {
	text-align: center;
	margin-bottom: 20px;
}

.report-form-container label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
}

.report-form-container input[type="text"], .report-form-container input[type="email"],
	.report-form-container input[type="date"], .report-form-container textarea
	{
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

.report-form-container textarea {
	height: 150px;
	resize: none;
}

.report-button-container {
	display: flex;
	justify-content: space-between;
}

.report-button-container button {
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	font-weight: bold;
	transition: background-color 0.3s;
}

.report-button-container .report-save-button {
	background-color: #ffc107;
	color: white;
}

.report-button-container .report-save-button:hover {
	background-color: #e0a800;
}

.report-button-container .report-submit-button {
	background-color: #28a745;
	color: white;
}

.report-button-container .report-submit-button:hover {
	background-color: #218838;
}
.summary-report {
        margin-top: 30px;
        margin-left:15%;
        margin-right:15%;
    }
    
    .four-hat-container {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
        margin-top: 20px;
    }
    
    .hat-section {
        border-radius: 10px;
        padding: 15px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    .hat-section h4 {
        margin-top: 0;
        text-align: center;
        font-size: 1.2em;
        margin-bottom: 15px;
    }
    
    .idea-item {
        background-color: rgba(255, 255, 255, 0.8);
        border-radius: 5px;
        padding: 10px;
        margin-bottom: 10px;
    }
    
    .idea-item h5 {
        margin: 0 0 5px 0;
        font-size: 1em;
    }
    
    .idea-item p {
        margin: 0;
        font-size: 0.9em;
    }
    
    .worry {
        background-color: #FFD1DC;
    }
    
    .positive {
        background-color: #BAFFC9;
    }
    
    .smart {
        background-color: #BAE1FF;
    }
    
    .strict {
        background-color: #FFFFBA;
    }
    
    .reportToggleBtn {
        background-color: #4CAF50;
        border: none;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
        border-radius: 5px;
    }
</style>
<script>
	function handleFormSubmit(event) {
		const action = event.submitter.value;
		if (action === 'save') {
			alert('저장되었습니다');
		} else if (action === 'submit') {
			const confirmSubmit = confirm('정말로 제출하시겠습니까?');
			if (!confirmSubmit) {
				event.preventDefault();
			}
		}
	}
</script>
</head>
<body class="report-body">
	<div class="report-form-container">
		<h2>보고서 양식</h2>
		<form action="./submitForm" method="post"
			onsubmit="handleFormSubmit(event)">
			<label for="report-title">Report Title:</label> <input type="text"
				id="report-title" name="reportTitle"
				value="${reports.reportTitle != null ? reports.reportTitle : ''}"
				required><br> <label for="report-content">Report
				Content:</label>
			<textarea id="report-content" name="reportContent" required>${reports.reportContent != null ? reports.reportContent : ''}</textarea>
			<br> <label for="date">작성일자:</label> <input type="date"
				id="date" name="date"
				value="${reports.updatedAt != null ? reports.updatedAt : ''}"
				required><br> <label for="date">부서명:</label> <input
				type="text" name="departmentName"
				value="${reportsFirst.departmentName != null ? reportsFirst.departmentName : ''}">
			<label for="date">팀명:</label> <input type="text" name="teamName"
				value="${reportsFirst.teamName != null ? reportsFirst.teamName : ''}">
			<label for="date">팀장(방장):</label> <input type="text"
				name="roomManagerName"
				value="${reportsFirst.roomManagerName != null ? reportsFirst.roomManagerName : ''}">
			<label for="date">기안자:</label> <input type="text"
				name="yesPickUserNames"
				value="${reportsFirst.yesPickUserNames != null ? reportsFirst.yesPickUserNames : ''}">
			<!-- Hidden fields for additional data -->

			<input type="hidden" name="roomId"
				value="${reportsFirst.roomId != null ? reportsFirst.roomId : ''}">
			<input type="hidden" name="userId" value="${userId}" required><br>

			<div class="report-button-container">
				<button type="submit" name="action" value="save"
					class="report-save-button">임시 저장</button>
				<button type="submit" name="action" value="submit"
					class="report-submit-button">제출</button>
			</div>
		</form>
	</div>
	<div class="summary-report">
		<h3>
			요약 보고서
			<button onclick="toggleSummary()">토글</button>
		</h3>
		<div id="summaryContent" style="display: none;">
			<c:forEach var="idea"
				items="${ideaSummaries.stream().map(s->s.ideaId).distinct().toList()}"
				varStatus="ideaStatus">
				<div class="idea-container">
					<h4>${ideaStatus.index + 1}안:
						${ideaSummaries.stream().filter(s->s.ideaId == idea).findFirst().get().ideaTitle}</h4>
					<div class="four-hat-container">
						<c:forEach var="hatColor" items="Worry,Positive,Smart,Strict">
							<div class="hat-section ${hatColor.toLowerCase()}">
								<h5>${hatColor}</h5>
								<c:forEach var="opinion" items="${ideaSummaries}">
									<c:if
										test="${opinion.ideaId == idea && opinion.hatColor eq hatColor}">
										<div class="idea-item">
											<p>${opinion.opinionText}(작성자:
												${opinion.opinionUserName}, 좋아요: ${opinion.likeNum})</p>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</c:forEach>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<script>
		function toggleSummary() {
			var content = document.getElementById("summaryContent");
			if (content.style.display === "none") {
				content.style.display = "block";
			} else {
				content.style.display = "none";
			}
		}
	</script>
</body>
</html>
