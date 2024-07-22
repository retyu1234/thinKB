<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
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
    .report-form-container input[type="text"],
    .report-form-container input[type="email"],
    .report-form-container input[type="date"],
    .report-form-container textarea {
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
        <form action="./submitForm" method="post" onsubmit="handleFormSubmit(event)">
            <label for="report-title">Report Title:</label>
            <input type="text" id="report-title" name="reportTitle" value="${reports.reportTitle != null ? reports.reportTitle : ''}" required><br>

            <label for="report-content">Report Content:</label>
            <textarea id="report-content" name="reportContent" required>${reports.reportContent != null ? reports.reportContent : ''}</textarea><br>

            <label for="user-id">User ID:</label>
            <input type="text" id="user-id" name="userId" value="${reports.userId != null ? reports.userId : ''}" required><br>

            <label for="date">Date:</label>
            <input type="date" id="date" name="date" value="${reports.updatedAt != null ? reports.updatedAt : ''}" required><br>
            <label for="date">부서명:</label>
            <input type="text" name="departmentName" value="${reportsFirst.departmentName != null ? reportsFirst.departmentName : ''}">
            <label for="date">팀명:</label>
            <input type="text" name="teamName" value="${reportsFirst.teamName != null ? reportsFirst.teamName : ''}">
            <label for="date">팀장(방장):</label>
            <input type="text" name="roomManagerName" value="${reportsFirst.roomManagerName != null ? reportsFirst.roomManagerName : ''}">
            <label for="date">기안자:</label>
            <input type="text" name="yesPickUserName" value="${reportsFirst.yesPickUserName != null ? reportsFirst.yesPickUserName : ''}">
            <!-- Hidden fields for additional data -->

            <input type="hidden" name="roomId" value="${reportsFirst.roomId != null ? reportsFirst.roomId : ''}">

            <div class="report-button-container">
                <button type="submit" name="action" value="save" class="report-save-button">임시 저장</button>
                <button type="submit" name="action" value="submit" class="report-submit-button">제출</button>
            </div>
        </form>
    </div>
</body>
</html>
