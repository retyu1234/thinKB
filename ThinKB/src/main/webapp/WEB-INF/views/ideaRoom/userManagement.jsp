<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>참여자 관리</title>
<style>
.newRoom-body {
    margin: 0;
    padding: 0;
    background-image: url('${pageContext.request.contextPath}/resources/23029.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    height: 400px;
}

.content {
    padding: 20px;
    margin-left: 25%;
    margin-right: 25%;
}

.participant-list {
    margin-top: 20px;
    border: 1px solid #ccc;
    padding: 10px;
    background-color: #fff;
}

.participant {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 5px 0;
    border-bottom: 1px solid #ddd;
}

.participant:last-child {
        margin-left: 20px;
    padding: 5px 10px;
    background-color: #e74c3c;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.participant button:hover {
    background-color: #c0392b;
}

.add-participant {
    text-align: center;
    margin-top: 30px;
}

.add-participant button {
    padding: 10px 20px;
    background-color: #3498db;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.add-participant button:hover {
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
}

.modal-content {
    background-color: #fff;
    margin: 10% auto;
    padding: 20px;
    border: 1px solid #ddd;
    width: 50%;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
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

.employee-list {
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

</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        <div class="participant-list">
            <div class="participant">
                <span>참여자 1</span>
                <button onclick="removeParticipant(this)">강퇴</button>
            </div>
            <div class="participant">
                <span>참여자 2</span>
                <button onclick="removeParticipant(this)">강퇴</button>
            </div>
            <div class="participant">
                <span>참여자 3</span>
                <button onclick="removeParticipant(this)">강퇴</button>
            </div>
        </div>

        <div class="add-participant">
            <button onclick="openModal()">참가자 추가</button>
        </div>

        <div class="chart-container">
            <h2>기여도</h2>
            <canvas id="contributionChart"></canvas>
        </div>
    </div>

    <div class="modal" id="addParticipantModal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>직원 리스트</h2>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <div class="employee-list">
                <div class="employee">
                    <span>직원 1</span>
                    <button onclick="addParticipant(this)">추가</button>
                </div>
                <div class="employee">
                    <span>직원 2</span>
                    <button onclick="addParticipant(this)">추가</button>
                </div>
                <div class="employee">
                    <span>직원 3</span>
                    <button onclick="addParticipant(this)">추가</button>
                </div>
            </div>
            <div class="modal-footer">
                <button class="close" onclick="closeModal()">닫기</button>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        function removeParticipant(button) {
            var participant = button.parentElement;
            participant.remove();
        }

        function openModal() {
            document.getElementById('addParticipantModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('addParticipantModal').style.display = 'none';
        }

        function addParticipant(button) {
            var employee = button.parentElement;
            var participantList = document.querySelector('.participant-list');
            var newParticipant = document.createElement('div');
            newParticipant.classList.add('participant');
            newParticipant.innerHTML = '<span>' + employee.querySelector('span').textContent + '</span><button onclick="removeParticipant(this)">강퇴</button>';
            participantList.appendChild(newParticipant);
            closeModal();
        }

        // 기여도 차트 생성
        var ctx = document.getElementById('contributionChart').getContext('2d');
        var contributionChart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: ['참여자 1', '참여자 2', '참여자 3'],
                datasets: [{
                    label: '기여도',
                    data: [30, 50, 20],
                    backgroundColor: ['#ff6384', '#36a2eb', '#cc65fe'],
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                var label = context.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                label += context.raw + '%';
                                return label;
                            }
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
