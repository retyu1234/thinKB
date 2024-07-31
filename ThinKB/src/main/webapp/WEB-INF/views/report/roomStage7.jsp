<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<meta charset="UTF-8">
<title>보고서 양식</title>
<style>
.report-body {
	font-family: Arial, sans-serif;
	background-color: #ffffff;
	padding: 20px;
	margin-top:8%;
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
	border:none;
	max-width: 60%;
	margin: 0 auto;
}
#report-content{
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
	margin:0;
	font-size:22pt;
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
	font-size:15pt;
}

.report-form-container textarea {
	height: 150px;
	resize: none;
}

.report-button-container {
	display: flex;
	gap:10px;
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
        margin-left:20%;
        margin-right:20%;
    }
.summary-report h3{
        font-size:22pt;
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
<%@ include file="../header.jsp"%>
	<div class="report-form-container">
		<h2>🗒️아이디어 보고서 작성</h2>
		<form action="./submitForm" method="post"
			onsubmit="handleFormSubmit(event)">
						<div class="report-button-container">
				<button type="submit" name="action" value="save"
					class="report-save-button">임시 저장</button>
				<button type="submit" name="action" value="submit"
					class="report-submit-button">제출</button>
			</div><hr style="margin-bottom:30px">
            <div class="form-group">
                <label for="report-title">제목을 입력해주세요 *</label>
                <input type="text" id="report-title" name="reportTitle" value="${reports.reportTitle != null ? reports.reportTitle : ''}" required>
            </div>
                        <div class="input-row">
                <div class="form-group">
                    <label for="date">작성일자</label>
                    <input type="date" id="date" name="date" value="${reports.updatedAt != null ? reports.updatedAt : ''}" required>
                </div>
<div class="form-group">
    <label for="department-team">부서명 / 팀명</label>
    <input type="text" id="department-team" readonly 
           value="${reportsFirst.departmentName != null ? reportsFirst.departmentName : ''} / ${reportsFirst.teamName != null ? reportsFirst.teamName : ''}">
    <input type="hidden" name="departmentName" value="${reportsFirst.departmentName != null ? reportsFirst.departmentName : ''}">
    <input type="hidden" name="teamName" value="${reportsFirst.teamName != null ? reportsFirst.teamName : ''}">
</div>
            </div>
                        <div class="input-row">
                <div class="form-group">
                    <label for="writer">기안자</label>
                    <input type="text" id="writer" name="yesPickUserNames" value="${reportsFirst.yesPickUserNames != null ? reportsFirst.yesPickUserNames : ''}">
                </div>
                <div class="form-group">
                    <label for="manager">작성자</label>
                    <input type="text" id="manager" name="roomManagerName" value="${reportsFirst.roomManagerName != null ? reportsFirst.roomManagerName : ''}">
                </div>
            </div>
<div class="form-group">
    <label for="report-content">Report Content:</label>
    <div id="report-content">${reports.reportContent != null ? reports.reportContent : ''}</div>
    <input type="hidden" name="reportContent" id="hidden-report-content">
</div>
			
			<!-- Hidden fields for additional data -->

			<input type="hidden" name="roomId"
				value="${reportsFirst.roomId != null ? reportsFirst.roomId : ''}">
			<input type="hidden" name="userId" value="${userId}" required><br>


		</form>
<script src="https://cdn.ckeditor.com/4.24.0-lts/standard/ckeditor.js"></script>
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
<script>
    var quill = new Quill('#report-content', {
        theme: 'snow',
        modules: {
            toolbar: [
                [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                ['bold', 'italic', 'underline', 'strike'],
                [{ 'color': [] }, { 'background': [] }],
                [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                ['link', 'image', 'video'],
                ['clean']
            ]
        }
    });

    // 폼 제출 시 Quill 내용을 hidden input에 설정
    document.querySelector('form').onsubmit = function() {
        document.getElementById('hidden-report-content').value = quill.root.innerHTML;
    };
</script>
	</div>
	<div class="summary-report">
		<h3>
			📌요약 보고서
			<button class = "reportToggleBtn" onclick="toggleSummary()">🔽</button>
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
