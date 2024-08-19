<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>thinKB - 참여자 관리</title>
<style>
.newRoom-body {
	margin: 0;
	padding: 0;
	caret-color: transparent;
	font-family: KB금융 본문체 Light;
}

.content {
	padding: 30px; /* content 영역의 여백 설정 */
	margin-left: 20%;
	margin-right: 20%;
	caret-color: transparent;
	font-family: KB금융 본문체 Light;
}

.usertable {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	border-radius: 25px;
}

.usertable th, td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

.usertable th {
	background-color: #AB9A80;
	color: white;
	font-family: KB금융 제목체 Light;
}

.usertable button {
	padding: 8px 12px;
	border: none;
	border-radius: 4px;
	color: #fff;
	cursor: pointer;
}

.btn-danger {
	background-color: transparent;
}

.btn-danger:hover {
	background-color: #EAEAEA;
}

.btn-primary {
	background-color: #FFCC00;
	color: white;
	border: none; padding : 10px 15px;
	border-radius: 25px;
	cursor: pointer;
	transition: background-color 0.3s;
	padding: 10px 15px;
}

.btn-primary:hover {
	background-color: #D4AA00;
}

.btn-primary1 {
	background-color: #978A8F;
	color: white;
	border: none;
	padding: 10px 15px;
	border-radius: 25px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.btn-primary1:hover {
	background-color: #AB9A80;
}
.manage-buttons {
	display: flex;
	gap: 10px;
}

.userModal {
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

.userModal-content {
	background-color: #fff;
	margin: 5% auto;
	padding: 20px;
	border: 1px solid #ddd;
	width: 80%;
	max-width: 800px;
	height:auto;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.userModal-header, .userModal-footer {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.userModal-header {
	border-bottom: 1px solid #ddd;
}

.userModal-footer {
	margin-top: 20px;
	display: flex;
	justify-content: center;
	gap:5px;
	font-size:
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
	text-align: left;
}

.employee {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	padding-left:10px;
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

.employee-lists {
	display: flex;
	
}

.employee-list, .selected-employee-list {
	width: 45%;
}

.charts-container {
	display: flex;
	justify-content: space-between;
	margin-top: 5%;
	margin-bottom: 5%;
}

.chart-wrapper {
	width: 45%;
}

.barChart-wrapper {
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

/* 추가된 스타일 */
.notification-container {
	margin-bottom: 10px;
}

#notificationTextarea {
	width: 90%;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	resize: vertical;
	margin-left: 10px;
}

.input-container {
	margin-bottom: 10px;
	display: flex;
	gap: 10px;
}

#inputField {
	flex-grow: 1;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}


.button-container {
	display: flex;
	gap: 10px;
}



.modal1 {
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

.modal-content1 {
	background-color: #fff;
	margin: 5% auto;
	padding: 20px;
	border: 1px solid #ddd;
	width: 100%;
	max-width: 400px;
	height:auto;
	min-height:600px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.modal-header1{
	display: flex;
	justify-content: space-between;
	align-items: center;
}
.modal-footer1 {
	display: flex;
	justify-content: center;
	align-items: center;
}

.modal-header1 {
	border-bottom: 1px solid #ddd;
}

.close1 {
	color: #333;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.close1:hover {
	color: #000;
}



.selected-user-item {
	padding: 5px 0;
	border-bottom: 1px solid #ddd;
}

.selected-user-item:last-child {
	border-bottom: none;
}

.manageTop {
	display: flex;
	justify-content: space-between;
}

#backButton {
	border: none;
	background-color: #ffffff;
	font-size: 26pt;
	transition: font-size 0.3s ease;
}

#backButton:hover {
	font-size: 30pt;
}

.manage-subject {
	font-size: 11pt;
	color: black;
	padding: 10px;
	background-color: white;
	margin-bottom: 3px;
	position: relative;
	width: 100%;
}

input.manage-subject {
	font-size: 11pt;
	color: black;
	border: 3px solid lightgrey;
	border-radius: 20px;
	padding: 10px;
	padding-left: 20px;
	width: 100%;
	box-sizing: border-box;
}

input.manage-subject:focus {
	border-color: #FFD700;
	outline: none;
}

.manage-top-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.search-container {
	width: 50%;
	margin-left: auto;
	margin-right: 0;
	display: flex;
	justify-content: flex-end;
}

.search-button {
	position: absolute;
	right: 30px;
	top: 50%;
	transform: translateY(-50%);
	background: none;
	border: none;
	cursor: pointer;
	font-size: 18px;
	padding: 0;
	line-height: 1;
}

.search-button span {
	position: relative;
	top: -2px;
	font-size: 20pt;
}

#timer-section, #timer, #timer-message {
	display: none;
}
#employeeSearch{
	width:90%;
	font-size:11pt;
	padding: 10px;
    border-radius: 20px;
    margin-bottom: 10px;
}
.gtltBtn{
	background-color: #978A8F;
	color: white; 
	font-size: 1.4em;
    border: none;
    border-radius: 5px;
    padding:10px;
}
.gtltBtn:hover{
	background-color: #60584C; 
}
.employee-table {
    border:none;
    border-radius: 4px;
    overflow: hidden;
    width: 100%;
    margin-bottom: 10px;
}

.employee-header {
    background-color: #AB9A80;
    border-radius:10px;
    border:none;
    font-weight: bold;
    padding:10px;
    color: white;
}

.employee {
    display: flex;
    align-items: center;
    padding: 10px;
    border-bottom: 1px solid #ddd;
}

.employee:last-child {
    border-bottom: none;
}

.employee input[type="checkbox"] {
    margin-right: 10px;
}


.employee-list, .selected-employee-list {
    width: 45%;
}

#employeeList, #selectedEmployees {
    max-height: 300px;
    overflow-y: auto;
}
.noPickUser{

}
#warningMessage {
    margin: 5%;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    width: 90%;
    height: 260px;
    
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    
    color: black;
    padding: 10px;
    box-sizing: border-box;
}
#warningMessage img {
    max-width: 50%;
    max-height: 50%;
    object-fit: contain;
    margin-bottom: 10px;
}

#warningMessage p {
    font-size: 1em;
    word-wrap: break-word;
    max-width: 100%;
}
.selected-user-table {
    width: 100%;
    border: none;
    margin-bottom: 15px;
    border-radius: 20px;
    margin-top: 15px;
}

.selected-user-table th {
    background-color: #AB9A80;
    color: white;
    padding: 10px;
    text-align: center;
    border-radius: 20px;
}

.selected-user-table td {
    border-bottom: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

        #selectedUserContainer {
            margin-bottom: 15px;
            max-height: 260px; /* 최대 높이 설정 */
            overflow-y: auto; /* 세로 스크롤 활성화 */
        }

        #selectedUserList {
            max-height: 230px; /* tbody의 최대 높이 설정 */
            overflow-y: auto; /* tbody에 스크롤 적용 */
            display: block; /* tbody를 블록 레벨 요소로 변경 */
        }

        #selectedUserList tr {
            display: table; /* tr을 테이블로 표시하여 width: 100% 적용 */
            width: 100%;
            table-layout: fixed; /* 고정 테이블 레이아웃 사용 */
        }
.line {
	margin-top: 15px;
	margin-bottom: 15px;
	border: 2px solid lightgrey;
}
</style>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    var roomId = '${meetingRoom.roomId}';
    var links = document.querySelectorAll('.side-menu a');
    links.forEach(function(link) {
        var url = new URL(link.href);
        url.searchParams.set('roomId', roomId);
        link.href = url.toString();
    });

    document.getElementById('backButton').addEventListener('click', function() {
        var roomId = '${meetingRoom.roomId}';
        var stageId = '${meetingRoom.stageId}';
        var ideaId='${ideaId}';
        window.location.href = './roomDetail?roomId=' + roomId + '&stage=' + stageId+'&ideaId='+ideaId;
    });
});
</script>
</head>
<body>

	<div class="newRoom-body">
		<%@ include file="../header.jsp"%>
	</div>
	<%@ include file="../leftSideBar.jsp"%>
	<%@ include file="../rightSideBar.jsp"%>

	<div class="content">
		<div class="manageTop">
			<h2 style="font-size: 20pt font-family: KB금융 제목체 Light;">👩‍👧‍👦참여자 관리</h2>
			<button id="backButton"><img src="./resources/back.png" style="width:35px; height:35px;"/></button>
		</div>
		<hr class="line">

		<h3 style="margin-bottom: 0;">- 참여자 리스트</h3>
		<div style="display:flex; justify-content:flex-end;">
				<p style="margin-left:3%; font-size:10pt; margin-bottom:0;">※ 참여자 리스트에서 선택한 직원에게 알림을 보내실 수 있습니다.</p>
				</div>
		<div class="manage-top-container">
			<div class="search-container">
				<form action="./userManagement" method="GET" class="manage-subject">
					<input type="hidden" name="roomId" value="${roomId}"> <input
						type="text" class="manage-subject" name="searchKeyword"
						placeholder="이름 또는 팀명으로 검색" value="${searchKeyword}">
					<button type="submit" class="search-button">
						<i class="fa fa-search"></i>
					</button>
				</form>
			</div>
			<div class="manage-buttons">
				<button class="btn-primary1" onclick="openModal()">참가자 추가</button>
				<button class="btn-primary" onclick="openModal1()">알림발송</button>
			</div>
		</div>
		<table class="usertable">
			<thead>
				<tr>
					<th><input type="checkbox" id="selectAll"></th>
					<th>참여자</th>
					<th>이메일</th>
					<th>기여도 점수</th>
					<th>생년월일</th>
					<th>강퇴</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="member" items="${members}">
					<tr>
						<td><input type="checkbox" name="selectedUsers"
							value="${member.userId}"></td>
						<td>${member.userName}(${member.userId})-${member.teamName}</td>
						<td>${member.email}</td>
						<td>${member.contributionCnt}점</td>
						<td>${member.birth}</td>
						<td><button class="btn-danger"
								onclick="removeParticipant(${member.userId},${roomId})">❌</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<h3>- 참여자 기여도 보기</h3>
		<!-- 기여도 차트 -->
		<div class="charts-container">
			<div class="chart-wrapper">
				<canvas id="contributionPieChart"></canvas>
			</div>
			<div class="barChart-wrapper">
				<canvas id="contributionBarChart"></canvas>
			</div>
		</div>

		<!-- 모달 -->
		<div id="addParticipantModal" class="userModal">
			<div class="userModal-content">
				<div class="userModal-header">
					<h2>직원 리스트</h2>
					<span class="close" onclick="closeModal()">&times;</span>
				</div>
				<form id="addParticipantForm" action="./addParticipants"
					method="POST">
					<input type="hidden" name="roomId" value="${roomId}"> <input
						type="hidden" name="stageId" value="${meetingRoom.stageId}">
<div class="employee-lists">
    <div class="employee-list">
        <h3>전체 직원</h3>
        <input type="text" id="employeeSearch" placeholder="직원 검색...">
        <div class="employee-table">
            <div class="employee-header">
                <input type="checkbox" id="selectAllEmployees">
                <label for="selectAllEmployees">전체 선택</label>
            </div>
            <div id="employeeList">
                <c:forEach var="user" items="${addUser}">
                    <div class="employee">
                        <input type="checkbox" id="user-${user.userId}" value="${user.userId}" class="employee-checkbox">
                        <label for="user-${user.userId}">${user.teamName}/${user.userName}(${user.userId})</label>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="transfer-buttons">
        <button type="button" class="gtltBtn" onclick="transferEmployees('right')">&gt;</button>
        <button type="button" class="gtltBtn" onclick="transferEmployees('left')">&lt;</button>
    </div>
    <div class="selected-employee-list">
        <h3>선택된 직원</h3>
        <p style="font-size:13px;">※선택된 직원들을 현재 회의방에 추가하실 수 있습니다. 선택된 직원들은 현재 단계부터 기여도 점수가 산정됩니다.</p>
        <div class="employee-table">
            <div class="employee-header" style="margin-top:3px;">
                <input type="checkbox" id="selectAllSelectedEmployees">
                <label for="selectAllSelectedEmployees">전체 선택</label>
            </div>
            <div id="selectedEmployees"></div>
        </div>
    </div>
</div>
					<div class="userModal-footer">
						<button type="submit" class="btn-primary" style="font-size:11pt;">참여자 추가</button>
					</div>
				</form>
			</div>
		</div>
		<div>
			<div id="sendNotiModal" class="modal1">
				<div class="modal-content1">
					<div class="modal-header1">
						<h2>알림 발송</h2>
						<span class="close1" onclick="closeModal1()">&times;</span>
					</div>
					<form id="sendNotiForm" action="./sendNotiUser" method="POST">
						<input type="hidden" name="roomId" value="${roomId}"> <input
							type="hidden" name="stageId" value="${meetingRoom.stageId}">
						<div class="notification-container">
						<div class="noPickUser">
						    <div id="warningMessage" style="display: none;">
    <img alt="" src="./resources/nopick.png">
    <p>선택된 직원이 없습니다.</p>
</div>
   </div> 
       <div id="selectedUserContainer" style="display: none;">
        <table class="selected-user-table">
            <thead>
                <tr>
                    <th>선택된 직원 리스트</th>
                </tr>
            </thead>
            <tbody id="selectedUserList">
                <!-- 선택된 유저들이 여기에 추가됩니다 -->
            </tbody>
        </table>
    </div>
							<textarea id="notificationTextarea" name="notificationMessage"
								rows="10" cols="100" placeholder="여기에 알림 내용을 작성하세요..."></textarea>
						</div>
						
						<div class="modal-footer1 button-container">
							<button type="submit" class="btn-primary1" id="sendNotificationButton">발송</button>
							<button type="button" class="btn-primary" id="remindNonParticipantsButton">미참여자
								알림</button>
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
	        const checkboxes = document.querySelectorAll('#employeeList .employee-checkbox:checked');
	        checkboxes.forEach(checkbox => {
	            const employee = checkbox.closest('.employee');
	            document.getElementById('selectedEmployees').appendChild(employee.cloneNode(true));
	            employee.remove();
	        });
	    } else {
	        const checkboxes = document.querySelectorAll('#selectedEmployees .employee-checkbox:checked');
	        checkboxes.forEach(checkbox => {
	            const employee = checkbox.closest('.employee');
	            document.getElementById('employeeList').appendChild(employee.cloneNode(true));
	            employee.remove();
	        });
	    }
	    // 전체 선택 체크박스 상태 초기화
	    document.getElementById('selectAllEmployees').checked = false;
	    document.getElementById('selectAllSelectedEmployees').checked = false;
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
//sendNoti
document.getElementById('sendNotiForm').addEventListener('submit', function(e) {
    e.preventDefault();

    // 선택된 사용자 ID를 hidden input으로 추가
    const selectedCheckboxes = document.querySelectorAll('input[name="selectedUsers"]:checked');
    selectedCheckboxes.forEach(checkbox => {
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'selectedUsers';
        input.value = checkbox.value;
        this.appendChild(input);
    });

    // 폼 제출
    this.submit();
});
document.getElementById('remindNonParticipantsButton').addEventListener('click', function() {
	const roomId = '${roomId}';
    const stageId = document.querySelector('input[name="stageId"]').value;

    if (!stageId) {
        console.error('Stage ID is missing or empty');
        alert('Stage ID가 설정되지 않았습니다.');
        return;
    }
    if (!roomId) {
        console.error('Stage ID is missing or empty');
        alert('roomId ID가 설정되지 않았습니다.');
        return;
    }

    const url = new URL('./noPartiNoti', window.location.href);
    url.searchParams.append('roomId', roomId);
    url.searchParams.append('stageId', stageId);

    fetch(url, {
        method: 'GET',
    }).then(response => {
        if (response.ok) {
            alert('미참여자에게 독촉 알림을 보냈습니다.');
            closeModal1();
        } else {
            alert('알림을 보내는 데 실패했습니다.');
        }
    }).catch(error => {
        console.error('Error:', error);
        alert('오류가 발생했습니다.');
    });
});
function openModal() {
    document.getElementById('addParticipantModal').style.display = 'block';
}
function openModal1() {
    const selectedCheckboxes = document.querySelectorAll('input[name="selectedUsers"]:checked');
    const warningMessage = document.getElementById('warningMessage');
    const selectedUserContainer = document.getElementById('selectedUserContainer');
    const selectedUserList = document.getElementById('selectedUserList');
    
    selectedUserList.innerHTML = '';

    if (selectedCheckboxes.length === 0) {
        warningMessage.style.display = 'flex';
        selectedUserContainer.style.display = 'none';
    } else {
        warningMessage.style.display = 'none';
        selectedUserContainer.style.display = 'block';
        selectedCheckboxes.forEach(checkbox => {
            const userName = checkbox.closest('tr').querySelector('td:nth-child(2)').innerText;
            const tr = document.createElement('tr');
            const td = document.createElement('td');
            td.innerText = userName;
            tr.appendChild(td);
            selectedUserList.appendChild(tr);
        });
    }

    document.getElementById('sendNotiModal').style.display = 'block';
}



function closeModal() {
    document.getElementById('addParticipantModal').style.display = 'none';
}
function closeModal1() {
    document.getElementById('sendNotiModal').style.display = 'none';
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
    var modal = document.getElementById('addParticipantModal');
    if (event.target == modal) {
        closeModal();
    }
    var modal1 = document.getElementById('sendNotiModal');
    if (event.target == modal1) {
        closeModal1();
    }
}
document.getElementById('selectAll').addEventListener('change', function() {
    const checkboxes = document.querySelectorAll('input[name="selectedUsers"]');
    checkboxes.forEach(checkbox => {
        checkbox.checked = this.checked;
    });
});



document.getElementById('sendNotificationButton').addEventListener('click', function() {
    const notificationText = document.getElementById('notificationTextarea').value;
    alert('발송할 알림 내용:\n' + notificationText);
    closeModal1();
});

document.getElementById('remindNonParticipantsButton').addEventListener('click', function() {
    alert('미참여자에게 독촉 알림을 보냅니다.');
    closeModal1();
});
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
    
    var colors = [
        'rgba(255, 99, 132, 0.7)',
        'rgba(54, 162, 235, 0.7)',
        'rgba(255, 206, 86, 0.7)',
        'rgba(75, 192, 192, 0.7)',
        'rgba(153, 102, 255, 0.7)',
        'rgba(255, 159, 64, 0.7)',
        'rgba(199, 199, 199, 0.7)',
        'rgba(83, 102, 255, 0.7)',
        'rgba(40, 159, 64, 0.7)',
        'rgba(210, 199, 199, 0.7)'
    ];

    // 파이 차트
    var ctxPie = document.getElementById('contributionPieChart').getContext('2d');
    var contributionPieChart = new Chart(ctxPie, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: colors,
                borderColor: colors.map(color => color.replace('0.7', '1')),
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false,
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            var label = context.label || '';
                            var value = context.parsed || 0;
                            var total = context.dataset.data.reduce((a, b) => a + b, 0);
                            var percentage = ((value / total) * 100).toFixed(1);
                            return label + ': ' + percentage + '%';
                        }
                    }
                }
            }
        }
    });

 // 세로 막대 차트
 // 세로 막대 차트
    var ctxBar = document.getElementById('contributionBarChart').getContext('2d');
    var contributionBarChart = new Chart(ctxBar, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: colors,
                borderColor: colors.map(color => color.replace('0.7', '1')),
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false,
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return Math.round(context.parsed.y) + '점';
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: '기여도 점수'
                    },
                    ticks: {
                        stepSize: 1,
                        callback: function(value) {
                            return Math.round(value);
                        }
                    },
                    suggestedMax: Math.max(...data) + 1
                }
            }
        }
    });
});
//전체 직원 검색
document.addEventListener('DOMContentLoaded', function() {
    const selectAllEmployees = document.getElementById('selectAllEmployees');
    const selectAllSelectedEmployees = document.getElementById('selectAllSelectedEmployees');

    selectAllEmployees.addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('#employeeList .employee-checkbox');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });

    selectAllSelectedEmployees.addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('#selectedEmployees .employee-checkbox');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });
    const searchInput = document.getElementById('employeeSearch');
    const employeeList = document.getElementById('employeeList');
    const employees = Array.from(employeeList.getElementsByClassName('employee'));

    searchInput.addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        employees.forEach(employee => {
            const text = employee.textContent.toLowerCase();
            if (text.includes(searchTerm)) {
                employee.style.display = '';
            } else {
                employee.style.display = 'none';
            }
        });
    });
});
</script>
</body>
</html>