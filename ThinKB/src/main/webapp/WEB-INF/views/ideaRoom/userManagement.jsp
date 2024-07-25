<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>참여자 관리</title>
<style>
.newRoom-body {
	margin: 0;
	padding: 0;
	background-image:
		url('${pageContext.request.contextPath}/resources/23029.jpg');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	height: 400px;
}

.content {
	padding: 20px;
	margin: 20px auto;
	max-width: 900px;
	background-color: #fff;
}

h2 {
	margin-top: 0;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th, td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #f2f2f2;
}

button {
	padding: 8px 12px;
	border: none;
	border-radius: 4px;
	color: #fff;
	cursor: pointer;
}

.btn-danger {
	background-color: #e74c3c;
}

.btn-danger:hover {
	background-color: #c0392b;
}

.btn-primary {
	background-color: #3498db;
}

.btn-primary:hover {
	background-color: #2980b9;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	overflow: auto;
}

.modal-content {
	background-color: #fff;
	margin: 5% auto;
	padding: 20px;
	border: 1px solid #ddd;
	width: 80%;
	max-width: 600px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.modal-header, .modal-footer {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.modal-header {
	border-bottom: 1px solid #ddd;
}

.modal-footer {
	border-top: 1px solid #ddd;
}

.close {
	color: #333;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.close:hover {
	color: #000;
}

.employee-list, .chart-container {
	margin-top: 20px;
}

.employee {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 15px;
	border-bottom: 1px solid #ddd;
}

.employee:last-child {
	border-bottom: none;
}

.employee button {
	padding: 5px 10px;
	background-color: #2ecc71;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.employee button:hover {
	background-color: #27ae60;
}

.chart-container {
	text-align: center;
}

.employee-lists {
	display: flex;
	justify-content: space-between;
}

.employee-list, .selected-employee-list {
	width: 45%;
}

.transfer-buttons {
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.transfer-buttons button {
	margin: 5px;
}
</style>
</head>
<body>

	<div class="newRoom-body">
		<%@ include file="../header.jsp"%>
	</div>
	<c:if test="${userId == meetingRoom.roomManagerId}">
		<%@ include file="../sideBar.jsp"%>
	</c:if>

	<div class="content">
		<h2>참여자 관리</h2>

		<table>
			<thead>
				<tr>
					<th>참여자</th>
					<th>이메일</th>
					<th>기여도 점수</th>
					<th>강퇴</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="member" items="${members}">
					<tr>
						<td>${member.userName}(${member.departmentName})-
							${member.teamName}</td>
						<td>${member.email}</td>
						<td>${member.contributionCnt}</td>
						<td><button class="btn-danger"
								onclick="removeParticipant(${member.userId},${roomId})">강퇴</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div class="add-participant">
			<button class="btn-primary" onclick="openModal()">참가자 추가</button>
		</div>

		<!-- 기여도 차트 -->
		<div class="chart-container">
			<canvas id="contributionChart"></canvas>
		</div>
	</div>

	<!-- 모달 -->
	<div id="addParticipantModal" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<h2>직원 리스트</h2>
				<span class="close" onclick="closeModal()">&times;</span>
			</div>
			<form id="addParticipantForm" action="./addParticipants"
				method="POST">
				<input type="hidden" name="roomId" value="${roomId}">
				<input type="hidden" name="stageId" value="${meetingRoom.stageId}">
				<div class="employee-lists">
					<div class="employee-list">
						<h3>전체 직원</h3>
						<c:forEach var="user" items="${addUser}">
							<div class="employee">
								<input type="checkbox" id="user-${user.userId}"
									value="${user.userId}"> <label
									for="user-${user.userId}">${user.userName}
									(${user.departmentName}) - ${user.teamName}</label>
							</div>
						</c:forEach>
					</div>
					<div class="transfer-buttons">
						<button type="button" onclick="transferEmployees('right')">&gt;</button>
						<button type="button" onclick="transferEmployees('left')">&lt;</button>
					</div>
					<div class="selected-employee-list">
						<h3>선택된 직원</h3>
						<div id="selectedEmployees"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn-primary">참여자 추가</button>
					<button type="button" class="btn-secondary" onclick="closeModal()">닫기</button>
				</div>
			</form>
		</div>
	</div>


	<script>
	function removeParticipant(userId, roomId) {
	    // 지정된 URL로 userId를 쿼리 파라미터로 포함하여 페이지 이동
	    window.location.href = './removeParticipant?id=' + encodeURIComponent(userId) + '&roomId=' + encodeURIComponent(roomId);
	}
function transferEmployees(direction) {
    if (direction === 'right') {
        const checkboxes = document.querySelectorAll('.employee-list input[type="checkbox"]:checked');
        checkboxes.forEach(checkbox => {
            const employee = checkbox.parentElement;
            document.getElementById('selectedEmployees').appendChild(employee.cloneNode(true));
            employee.remove();
        });
    } else {
        const checkboxes = document.querySelectorAll('.selected-employee-list input[type="checkbox"]:checked');
        checkboxes.forEach(checkbox => {
            const employee = checkbox.parentElement;
            document.querySelector('.employee-list').appendChild(employee.cloneNode(true));
            employee.remove();
        });
    }
}

document.getElementById('addParticipantForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const selectedEmployees = document.querySelectorAll('#selectedEmployees input[type="checkbox"]');
    const selectedIds = Array.from(selectedEmployees).map(checkbox => checkbox.value);
    
    // 선택된 직원 ID들을 hidden input으로 추가
    selectedIds.forEach(id => {
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'selectedEmployees';
        input.value = id;
        this.appendChild(input);
    });

    // 폼 제출
    this.submit();
});

function openModal() {
    document.getElementById('addParticipantModal').style.display = 'block';
}

function closeModal() {
    document.getElementById('addParticipantModal').style.display = 'none';
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
    var modal = document.getElementById('addParticipantModal');
    if (event.target == modal) {
        closeModal();
    }
}
    document.addEventListener('DOMContentLoaded', function() {
        var labels = [
            <c:forEach var="member" items="${members}" varStatus="status">
                '${member.userName}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        var data = [
            <c:forEach var="member" items="${members}" varStatus="status">
                ${member.contributionCnt}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        
        var ctx = document.getElementById('contributionChart').getContext('2d');
        var contributionChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: '기여도',
                    data: data,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.7)',
                        'rgba(54, 162, 235, 0.7)',
                        'rgba(255, 206, 86, 0.7)',
                        'rgba(75, 192, 192, 0.7)',
                        'rgba(153, 102, 255, 0.7)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return value + '%';
                            }
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.parsed.y + '%';
                            }
                        }
                    }
                }
            }
        });
    });
</script>
</body>
</html>