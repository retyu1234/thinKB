<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thinKB-보고서 리스트</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<style>
    .reportList-body { font-family: KB금융 본문체 Light; background-color: #f4f4f4; margin: 0; padding: 20px; }
    .reportList-container { width: 70%; margin: 0 0 0 350px; padding: 20px; border-radius: 8px;}
    .reportList-title { font-family: KB금융 제목체 Light; font-size: 18pt;  font-weight: bold; color: #333; margin-bottom: 30px; display: flex; align-items: center;}
    .back2 {width: 30px; height: auto;  margin-right: 20px; margin-top: 10px;}
    .tab-container { display: flex; margin-bottom: 20px; border-bottom: 1px solid #ddd; }
    .tab { font-family: KB금융 제목체 Light; font-size: 13pt; padding: 10px 20px; cursor: pointer; color: #007bff; background: none; border: none; }
    .tab.active { font-family: KB금융 제목체 Light; border-bottom: 2px solid #007bff; }
    .search-container { font-family: KB금융 본문체 Light; display: flex; justify-content: flex-end; align-items: center; margin-bottom: 20px; }
    .search-container input, .search-container select { font-family: KB금융 본문체 Light; margin-left: 10px; padding: 9pt; border: 1px solid #ddd; border-radius: 4px; }
    .search-icon, .calendar-icon { cursor: pointer; font-size: 18px; margin-left: 10px; color: #007bff; }
    table { font-family: KB금융 본문체 Light; width: 100%; border-collapse: collapse; background-color: #ffffff;}
    th, td { padding: 9pt; text-align: center; border-bottom: 1px solid #ddd; }
    td a { color: inherit; text-decoration: none; }
    th { background-color: #AB9A80; font-weight: bold; color: #fff; }
    .approve-btn, .reject-btn { border: none; cursor: pointer; border-radius: 4px; color: 007BFF; background-color: transparent; display: inline-block;}
    .approve-btn{color: #007bff; }
    .reject-btn {color: red; }
    .approve-btn:hover, .reject-btn:hover { color: #666; }
    .download-btn {color: black; border: none; padding: 6px 12px; cursor: pointer; background-color: transparent;}
    .download-btn:hover {color: #333;}
    th:nth-child(1), td:nth-child(1) { width: 8%; } /* 팀 */
    th:nth-child(2), td:nth-child(2) { width: 28%; } /* 보고서 제목 */
    th:nth-child(3), td:nth-child(3) { width: 20%; } /* 회의방 */
    th:nth-child(4), td:nth-child(4) { width: 8%; } /* 작성자 */
    th:nth-child(5), td:nth-child(5) { width: 10%; } /* 작성일 */
    th:nth-child(6), td:nth-child(6) { width: 8%; } /* 상태 */
    th:nth-child(7), td:nth-child(7) { width: 8%; } /* 다운 */
    th:nth-child(8), td:nth-child(8) { width: 10%; } /* 채택 */
    
    /* 페이지네이션 */
    .employee-pagination {
	    display: flex;
	    justify-content: center;
	    margin-top: 2%;
	}
	.employee-pagination-list {
	    list-style-type: none;
	    padding: 0;
	    display: flex;
	}
	.employee-pagination-item {
	    margin: 0 5px;
	}
	.employee-pagination-link {
	    text-decoration: none;
	    padding: 5px 10px;
	    border: none;
	    color: #333;
	    border-radius: 3px;
	    transition: background-color 0.3s;
	}
	.employee-pagination-link:hover {
	    background-color: #f0f0f0;
	    border-radius: 30px;
	}
	.employee-pagination-item.active .employee-pagination-link {
	    background-color: #ffcc00;
	    color: white;
	    border-radius: 30px;
	}
</style>
</head>
<body class="reportList-body">
    <div class="reportList-container">
    
    	<%@ include file="../adminSideBar.jsp"%>
    	
    	<div class="reportList-title">
			<a href="./adminMain"><img src="./resources/back2.png" alt="back2" class="back2"></a>
			<span>보고서 리스트</span>
		</div>
        
        <div class="tab-container">
            <button class="tab active" data-status="all" onclick="filterByStatus('all')">전체</button>
            <button class="tab" data-status="pending" onclick="filterByStatus('pending')">결재대기</button>
            <button class="tab" data-status="approved" onclick="filterByStatus('approved')">채택</button>
            <button class="tab" data-status="rejected" onclick="filterByStatus('rejected')">미채택</button>
        </div>

        <div class="search-container">
            <select id="teamFilter" onchange="filterReports()">
                <option value="">모든 팀</option>
                <c:forEach items="${teams}" var="team">
                    <option value="${team}">${team}</option>
                </c:forEach>
            </select>
            <input type="text" id="searchInput" placeholder="보고서 제목 / 작성자로 검색">
            <i class="fas fa-search search-icon" onclick="filterReports()"></i>
            <i class="far fa-calendar-alt calendar-icon" id="dateRange"></i>
        </div>

        <table id="reportTable">
            <thead>
                <tr>
                	<th>팀</th>
                    <th>보고서 제목</th>
                    <th>회의방</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>상태</th>
                    <th>다운</th>
                    <th>채택</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${reports}" var="report">
                    <tr data-status="${report.isChoice == null ? 'pending' : (report.isChoice == 1 ? 'approved' : 'rejected')}">
                        <td>${report.teamName}</td>
                        <td style="color: #007bff;"><a href="./reportDetail?reportId=${report.reportId}">${report.reportTitle}</a></td>
                        <td>${report.roomTitle}</td>
                        <td>${report.authorName}</td>
                        <td>${report.updatedAt}</td>
                        <td>
                            <c:choose>
                                <c:when test="${report.isChoice == null}">결재대기</c:when>
                                <c:when test="${report.isChoice == 1}">채택</c:when>
                                <c:when test="${report.isChoice == 0}">미채택</c:when>
                                <c:otherwise>알 수 없음</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button class="download-btn" onclick="downloadReport(${report.roomId})"><i class="fas fa-download"></i></button>
                        </td>
                        <td>    
                            <c:if test="${report.isChoice == null}">
                                <button class="approve-btn" onclick="handleChoice(${report.reportId}, 1)">채택</button>
                                <button class="reject-btn" onclick="handleChoice(${report.reportId}, 0)">미채택</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <!-- 페이지네이션 -->
        <div style="margin-top:2%;justify-content:center; display:flex;">
		    <div class="employee-pagination">
		        <nav>
		            <ul class="employee-pagination-list">
		                <c:forEach var="i" begin="1" end="${totalPages}">
		                    <li class="employee-pagination-item ${i == currentPage ? 'active' : ''}">
		                        <a class="employee-pagination-link" href="./departmentReportList?searchTerm=${param.searchTerm}&page=${i}">${i}</a>
		                    </li>
		                </c:forEach>
		            </ul>
		        </nav>
		    </div>
		</div>
    </div>
    
    <script>
	    document.addEventListener('DOMContentLoaded', function() {
	    	
	    	// 기본 탭 설정
	    	var initialTab = '${initialTab}' || 'all';
    		filterByStatus(initialTab);
    		
	        // 보고서 검색창 enter 검색 기능
	        document.getElementById('searchInput').addEventListener('keypress', function(e) {
	            if (e.key === 'Enter') {
	                e.preventDefault(); // 폼 제출 방지
	                filterReports();
	            }
	        });
	    });
    
        let startDate, endDate;

        flatpickr("#dateRange", {
            mode: "range",
            dateFormat: "Y-m-d",
            onChange: function(selectedDates) {
                if (selectedDates.length === 2) {
                    startDate = selectedDates[0];
                    endDate = selectedDates[1];
                    filterReports();
                }
            }
        });

        function downloadReport(roomId) {
            var userConfirmed = window.confirm('보고서를 다운받으시겠습니까?');
            if (userConfirmed) {
                window.location.href = './upload/formData_' + roomId + '.docx';
            }
        }

        function handleChoice(reportId, choice) {
            var confirmationMessage = choice === 1 ? '아이디어를 채택하시겠습니까?' : '아이디어를 미채택하시겠습니까?';
            if (confirm(confirmationMessage)) {
                window.location.href = './approveReport?reportId=' + reportId + '&isChoice=' + choice;
            }
        }

        function filterByStatus(status) {
            document.querySelectorAll('.tab').forEach(tab => {
                tab.classList.remove('active');
                if (tab.getAttribute('data-status') === status) {
                    tab.classList.add('active');
                }
            });

            var table = document.getElementById("reportTable");
            var tr = table.getElementsByTagName("tr");

            for (var i = 1; i < tr.length; i++) {
                var rowStatus = tr[i].getAttribute('data-status');
                if (status === 'all' || status === rowStatus) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }

        function filterReports() {
            var input, filter, table, tr, i, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("reportTable");
            tr = table.getElementsByTagName("tr");
            var teamFilter = document.getElementById("teamFilter").value;
            var activeTab = document.querySelector('.tab.active').getAttribute('data-status');

            for (i = 1; i < tr.length; i++) {
                var tdTeam = tr[i].getElementsByTagName("td")[0];
                var tdTitle = tr[i].getElementsByTagName("td")[1];
                var tdAuthor = tr[i].getElementsByTagName("td")[3];
                var tdDate = tr[i].getElementsByTagName("td")[4];
                var rowStatus = tr[i].getAttribute('data-status');
                
                if (tdTeam && tdTitle && tdAuthor && tdDate) {
                    var teamValue = tdTeam.textContent || tdTeam.innerText;
                    var titleValue = tdTitle.textContent || tdTitle.innerText;
                    var authorValue = tdAuthor.textContent || tdAuthor.innerText;
                    var dateValue = new Date(tdDate.textContent || tdDate.innerText);

                    // 날짜 계산
                    var dateInRange = true;
                    if (startDate && endDate) {
                        dateValue.setHours(0, 0, 0, 0);
                        dateInRange = dateValue >= startDate && dateValue <= endDate;
                    }

                    var statusMatch = activeTab === 'all' || activeTab === rowStatus;
                    var teamMatch = teamFilter === "" || teamValue === teamFilter;
                    var searchMatch = titleValue.toUpperCase().indexOf(filter) > -1 || 
                                      authorValue.toUpperCase().indexOf(filter) > -1;

                    if (searchMatch && teamMatch && dateInRange && statusMatch) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
        /* function filterReports() {
            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("reportTable");
            tr = table.getElementsByTagName("tr");
            var teamFilter = document.getElementById("teamFilter").value;
            var activeTab = document.querySelector('.tab.active').textContent.toLowerCase();

            for (i = 1; i < tr.length; i++) {
                var tdTitle = tr[i].getElementsByTagName("td")[0];
                var tdAuthor = tr[i].getElementsByTagName("td")[1];
                var tdTeam = tr[i].getElementsByTagName("td")[2];
                var tdDate = tr[i].getElementsByTagName("td")[4];
                var rowStatus = tr[i].getAttribute('data-status');
                
                if (tdTitle && tdAuthor && tdTeam && tdDate) {
                    var titleValue = tdTitle.textContent || tdTitle.innerText;
                    var authorValue = tdAuthor.textContent || tdAuthor.innerText;
                    var teamValue = tdTeam.textContent || tdTeam.innerText;
                    var dateValue = new Date(tdDate.textContent || tdDate.innerText);

                    var dateInRange = true;
                    if (startDate && endDate) {
                        dateInRange = dateValue >= startDate && dateValue <= endDate;
                    }

                    var statusMatch = activeTab === '전체' || activeTab === rowStatus;

                    if ((titleValue.toUpperCase().indexOf(filter) > -1 || 
                         authorValue.toUpperCase().indexOf(filter) > -1) && 
                        (teamFilter === "" || teamValue === teamFilter) &&
                        dateInRange && statusMatch) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        } */
    </script>
</body>
</html>