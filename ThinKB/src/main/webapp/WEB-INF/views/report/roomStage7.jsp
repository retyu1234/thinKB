<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
	rel="stylesheet">
<meta charset="UTF-8">
<title>보고서 양식</title>
<style>
html {
	margin: 0;
	padding: 0;
}

.report-body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background-color: #ffffff;
	margin-top: 8%;
	caret-color: transparent;
}

.form-group {
	margin-bottom: 15px;
}

.input-row {
	display: flex;
	justify-content: space-between;
}

.input-row .form-group {
	width: 48%;
}

.report-form-container {
	background-color: #ffffff;
	padding: 20px;
	border: none;
	max-width: 80%;
	margin: 0 auto;
}

#report-content {
	height: 500px;
	border-radius: 10px;
	border: 1px solid #ccc;
	padding: 10px;
	caret-color: auto; /* 커서 색상을 기본값으로 설정 */
}

.ql-container.ql-snow {
	border: none;
}

.ql-toolbar.ql-snow {
	border: none;
	border-bottom: 1px solid #ccc;
}

.report-form-container h2 {
	text-align: left;
	margin: 0;
	font-size: 22pt;
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
	font-size: 15pt;
}

.report-form-container textarea {
	height: 150px;
	resize: none;
}

.report-button-container {
	display: flex;
	gap: 10px;
	justify-content: flex-end;
	margin-bottom: 20px;
}

.report-button-container button {
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 15px;
	font-weight: bold;
	transition: background-color 0.3s;
}

.report-button-container .report-save-button {
	background-color: #978A8F;
	color: white;
}

.report-button-container .report-save-button:hover {
	background-color: #60584C;
}

.report-button-container .report-submit-button {
	background-color: #ffcc00;
	color: white;
}

.report-button-container .report-submit-button:hover {
	background-color: #D4AA00;
}

.summary-report {
	margin-top: 30px;
	margin-left: 10%;
	margin-right: 10%;
	margin-bottom: 5%;
}

.idea-list {
	display: flex;
	gap: 10px;
	margin-bottom: 20px;
}

.idea-button {
	padding: 10px 20px;
	background-color: #f0f0f0;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.idea-button:hover {
	background-color: #e0e0e0;
}

.idea-container {
	margin-bottom: 30px;
}

.idea-container h4 {
	font-size: 18pt;
	margin-bottom: 15px;
	border-bottom: 1px solid #ccc;
	padding-bottom: 5px;
}

.summary-report h3 {
	font-size: 22pt;
	margin-bottom: 20px;
}

.four-hat-container {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 20px;
	margin-top: 20px;
}

.hat-section {
	margin-bottom: 20px;
}

.hat-section h4 {
	margin-top: 0;
	text-align: center;
	font-size: 1.2em;
	margin-bottom: 15px;
}

.hat-section h5 {
	font-size: 16pt;
	margin-bottom: 10px;
	color: #333;
}

.idea-item {
	background-color: #f9f9f9;
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
	font-size: 13px;
}

.reportToggleBtn {
	background-color: #ffffff;
	border: none;
	color: white;
	padding: 0;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 26px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 5px;
}

.ql-snow .ql-picker.ql-size .ql-picker-label::before, .ql-snow .ql-picker.ql-size .ql-picker-item::before
	{
	content: attr(data-value) !important;
}

.ql-size-8px {
	font-size: 8px;
}

.ql-size-9px {
	font-size: 9px;
}

.ql-size-10px {
	font-size: 10px;
}

.ql-size-11px {
	font-size: 11px;
}

.ql-size-12px {
	font-size: 12px;
}

.ql-size-14px {
	font-size: 14px;
}

.ql-size-16px {
	font-size: 16px;
}

.ql-size-18px {
	font-size: 18px;
}

.ql-size-20px {
	font-size: 20px;
}

.ql-size-22px {
	font-size: 22px;
}

.ql-size-24px {
	font-size: 24px;
}

.ql-size-26px {
	font-size: 26px;
}

.ql-size-28px {
	font-size: 28px;
}

.ql-size-36px {
	font-size: 36px;
}

.ql-size-48px {
	font-size: 48px;
}

.ql-size-72px {
	font-size: 72px;
}
/* Add a container for the main content */
.main-content {
	display: flex;
	margin-top: 0; /* 헤더 높이에 맞춰 조정 */
}

/* Style for the center content */
.center-content {
	flex: 1;
	margin: 0 15%; /* 사이드바 너비에 맞춰 조정 */
	padding-top: 20px; /* 상단 여백 추가 */
}

.page-container {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

.content-wrapper {
	flex: 1;
	display: flex;
	flex-direction: column;
}

.stages {
	display: flex;
	justify-content: space-between;
	padding: 30px 0;
	font-size: 12pt;
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
	<%
    String[] stages = {"아이디어 초안", "초안 투표하기", "관점별 의견 모으기", "더 확장하기", "기획 보고서 작성", "회의 완료"};
    request.setAttribute("stages", stages);
%>
</script>

</head>
<body style="margin: 0; overflow-x: hidden; width: 100%">

	<div class="page-container">
		<%@ include file="../header.jsp"%>
		<div class="content-wrapper">
			<%@ include file="../leftSideBar.jsp"%>
			<div class="center-content">

				<div class="report-form-container">
					<!-- 5개 단계 표시 -->
					<div class="stages">
						<c:forEach var="stage" items="${stages}" varStatus="status">
							<c:choose>
								<c:when test="${meetingRoom.getStageId() >= status.index + 1}">
									<a
										href="roomDetail?roomId=${meetingRoom.getRoomId()}&stage=${status.index + 1}"
										class="stage ${meetingRoom.getStageId() == status.index + 1 ? 'active' : ''}">
										${status.index + 1}. ${stage} </a>
								</c:when>
								<c:otherwise>
									<div class="stage inactive">${status.index + 1}. ${stage}
									</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
					<h2>🗒️아이디어 보고서 작성</h2>
					<form action="./submitForm" method="post"
						onsubmit="handleFormSubmit(event)">
						<div class="report-button-container">
							<button type="submit" name="action" value="save"
								class="report-save-button">임시 저장</button>
							<button type="submit" name="action" value="submit"
								class="report-submit-button">제출</button>
						</div>
						<hr style="margin-bottom: 30px">
						<div class="form-group">
							<label for="report-title">제목을 입력해주세요 *</label> <input type="text"
								id="report-title" name="reportTitle"
								value="${reports.reportTitle != null ? reports.reportTitle : ''}"
								required>
						</div>
						<div class="input-row">
							<div class="form-group">
								<label for="date">작성일자</label> <input type="date" id="date"
									name="date"
									value="${reports.updatedAt != null ? reports.updatedAt : ''}"
									required>
							</div>
							<div class="form-group">
								<label for="department-team">부서명 / 팀명</label> <input type="text"
									id="department-team" readonly
									value="${reportsFirst.departmentName != null ? reportsFirst.departmentName : ''} / ${reportsFirst.teamName != null ? reportsFirst.teamName : ''}">
								<input type="hidden" name="departmentName"
									value="${reportsFirst.departmentName != null ? reportsFirst.departmentName : ''}">
								<input type="hidden" name="teamName"
									value="${reportsFirst.teamName != null ? reportsFirst.teamName : ''}">
							</div>
						</div>
						<div class="input-row">
							<div class="form-group">
								<label for="writer">기안자</label> <input type="text" id="writer"
									name="yesPickUserNames"
									value="${reportsFirst.yesPickUserNames != null ? reportsFirst.yesPickUserNames : ''}">
							</div>
							<div class="form-group">
								<label for="manager">작성자</label> <input type="text" id="manager"
									name="roomManagerName"
									value="${reportsFirst.roomManagerName != null ? reportsFirst.roomManagerName : ''}">
							</div>
						</div>
						<div class="form-group">
							<label for="report-content">Report Content:</label>
							<div id="report-content"></div>
							<input type="hidden" name="reportContent"
								id="hidden-report-content">
						</div>

						<!-- Hidden fields for additional data -->

						<input type="hidden" name="roomId"
							value="${reportsFirst.roomId != null ? reportsFirst.roomId : ''}">
						<input type="hidden" name="userId" value="${userId}" required><br>


					</form>
					<script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
					<script>
var Size = Quill.import('attributors/style/size');
Size.whitelist = ['8px', '9px', '10px', '11px', '12px', '14px', '16px', '18px', '20px', '22px', '24px', '26px', '28px', '36px', '48px', '72px'];
Quill.register(Size, true);

var toolbarOptions = [
    [{ 'size': Size.whitelist }],
    ['bold', 'italic', 'underline', 'strike'],
    [{ 'color': [] }, { 'background': [] }],
    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
    ['link', 'image'],
    ['clean']
];

var quill = new Quill('#report-content', {
    modules: {
        toolbar: toolbarOptions
    },
    theme: 'snow'
});

    // 저장된 내용 불러오기
    var savedContent = `${reports.reportContent != null ? reports.reportContent : ''}`;
    console.log("savedContent:", savedContent);

    if (savedContent && savedContent.trim() !== '') {
        try {
            // 줄바꿈 문자를 이스케이프 처리
            savedContent = savedContent.replace(/\n/g, "\\n").replace(/\r/g, "\\r");
            var content = JSON.parse(savedContent);
            quill.setContents(content);
            console.log("Parsed content:", content);
        } catch (e) {
            console.log("JSON parsing failed, treating as HTML");
            console.log("Parsing error:", e);
            // JSON 파싱 실패 시, 원본 문자열을 그대로 사용
            quill.root.innerHTML = `${reports.reportContent != null ? reports.reportContent : ''}`;
        }
    }

    // 폼 제출 시 Quill 내용을 hidden input에 설정
    document.querySelector('form').onsubmit = function() {
        var delta = quill.getContents();
        document.getElementById('hidden-report-content').value = JSON.stringify(delta);
    };
</script>
				</div>
				<div class="summary-report">
					<h3>
						📌요약 보고서
						<button class="reportToggleBtn" onclick="toggleSummary()">🔽</button>
					</h3>
					<div id="summaryContent">
						<c:forEach var="idea"
							items="${ideaSummaries.stream().map(s->s.ideaId).distinct().toList()}"
							varStatus="ideaStatus">
							<div class="idea-container">
								<h4>아이디어&nbsp;${ideaStatus.index + 1}.
									${ideaSummaries.stream().filter(s->s.ideaId == idea).findFirst().get().ideaTitle}</h4>
								<c:forEach var="hatColor" items="Worry,Positive,Smart,Strict">
									<div class="hat-section">
										<h5>
											<c:choose>
												<c:when test="${hatColor == 'Worry'}">문제점/보완</c:when>
												<c:when test="${hatColor == 'Positive'}">기대효과</c:when>
												<c:when test="${hatColor == 'Smart'}">객관적 관점</c:when>
												<c:when test="${hatColor == 'Strict'}">실현가능성</c:when>
											</c:choose>
										</h5>
										<c:forEach var="opinion" items="${ideaSummaries}">
											<c:if
												test="${opinion.ideaId == idea && opinion.hatColor eq hatColor}">
												<div class="idea-item">
													<p style="font-size: 13pt; margin-bottom: 1%;">${opinion.opinionText}</p>
													<p>(작성자: ${opinion.opinionUserName}, 좋아요:
														${opinion.likeNum})</p>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</c:forEach>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<%@ include file="../rightSideBar.jsp"%>
		</div>
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

	function toggleIdea(ideaId) {
	    var ideaContainers = document.getElementsByClassName("idea-container");
	    for (var i = 0; i < ideaContainers.length; i++) {
	        ideaContainers[i].style.display = "none";
	    }
	    var selectedIdea = document.getElementById("idea-" + ideaId);
	    if (selectedIdea) {
	        selectedIdea.style.display = "block";
	    }
	}
	</script>
</body>
</html>