<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 보고서 리스트</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
    body { font-family: Arial, sans-serif; }
    .container { width: 80%; margin: 0 auto; }
    table { width: 100%; border-collapse: collapse; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
    th { background-color: #f2f2f2; }
    .search-container { margin-bottom: 20px; }
    .search-container input, .search-container select { margin-right: 10px; padding: 5px; }
    .approve-btn { background-color: #4CAF50; color: white; border: none; padding: 5px 10px; cursor: pointer; }
    .approve-btn:hover { background-color: #45a049; }
    .download-btn { background-color: #008CBA; color: white; border: none; padding: 5px 10px; cursor: pointer; }
    .download-btn:hover { background-color: #007B9A; }
</style>
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-file-alt"></i> 부서 보고서 리스트</h1>
        
        <div class="search-container">
            <input type="text" id="searchInput" placeholder="검색...">
            <select id="teamFilter">
                <option value="">모든 팀</option>
                <c:forEach items="${teams}" var="team">
                    <option value="${team.teamName}">${team.teamName}</option>
                </c:forEach>
            </select>
            <button onclick="filterReports()"><i class="fas fa-search"></i> 검색</button>
        </div>

        <table id="reportTable">
            <thead>
                <tr>
                    <th>보고서 제목3</th>
                    <th>작성자</th>
                    <th>팀</th>
                    <th>회의방</th>
                    <th>작성일</th>
                    <th>상태</th>
                    <th>액션</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${reports}" var="report">
                    <tr>
                        <td>${report.reportTitle}</td>
                        <td>${report.authorName}</td>
                        <td>${report.teamName}</td>
                        <td>${report.roomTitle}</td>
                        <td>${report.updatedAt}</td>
                        <td>
		                    <c:choose>
 		                        <c:when test="${report.isChoice == null}">
		                            결재대기
		                        </c:when>
		                        <c:when test="${report.isChoice == 1}">
		                            채택
		                        </c:when>
		                        <c:when test="${report.isChoice == 0}">
							        불채택
							    </c:when>
		                    </c:choose>
		                </td>
                        <td>
		                    <button class="download-btn" onclick="downloadReport(${report.roomId})"><i class="fas fa-download"></i> 다운로드</button>
		                    <c:if test="${report.isChoice == null}">
		                        <button class="approve-btn" onclick="handleChoice(${report.reportId}, 1)"><i class="fas fa-check"></i> 채택</button>
		                        <button class="reject-btn" onclick="handleChoice(${report.reportId}, 0)"><i class="fas fa-times"></i> 불채택</button>
		                    </c:if>
		                </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script>
        function downloadReport(roomId) {
            var userConfirmed = window.confirm('보고서를 다운받으시겠습니까?');
            if (userConfirmed) {
                window.location.href = './upload/formData_' + roomId + '.docx';
            }
        }

        /* function approveReport(reportId) {
            if (confirm('이 보고서를 승인하시겠습니까?')) {
                window.location.href = './approveReport?reportId=' + reportId;
            }
        } */
        function handleChoice(reportId, choice) {
            var confirmationMessage = choice === 1 ? '아이디어를 채택하시겠습니까?' : '아이디어를 불채택하시겠습니까?';
            if (confirm(confirmationMessage)) {
                window.location.href = './updateChoice?reportId=' + reportId + '&isChoice=' + choice;
            }
        }

        function filterReports() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("reportTable");
            tr = table.getElementsByTagName("tr");
            var teamFilter = document.getElementById("teamFilter").value;

            for (i = 0; i < tr.length; i++) {
                var tdTitle = tr[i].getElementsByTagName("td")[0];
                var tdAuthor = tr[i].getElementsByTagName("td")[1];
                var tdTeam = tr[i].getElementsByTagName("td")[2];
                if (tdTitle && tdAuthor && tdTeam) {
                    var titleValue = tdTitle.textContent || tdTitle.innerText;
                    var authorValue = tdAuthor.textContent || tdAuthor.innerText;
                    var teamValue = tdTeam.textContent || tdTeam.innerText;
                    if ((titleValue.toUpperCase().indexOf(filter) > -1 || 
                         authorValue.toUpperCase().indexOf(filter) > -1) && 
                        (teamFilter === "" || teamValue === teamFilter)) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>
</html>