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
					<th>직원번호</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="member" items="${members}">
					<tr>
						<td>${member.userName}(${member.departmentName})-
							${member.teamName}</td>						
						<td>${member.email}</td>
						<td>${member.userId}</td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
</body>
</html>