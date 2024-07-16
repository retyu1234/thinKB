<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
<style>
.admin-body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background: url('<c:url value="/resources/sf_24011.jpg"/>') no-repeat center center fixed;
	background-size: cover;
}

.admin-content {
	display: flex;
	padding: 20px;
	color: white;
	margin: 20% 13%;
	margin-bottom:0;
}

.member-list-wrapper {
	width: 40%;
	background-color: #ffffff;
	border-radius: 30px;
	padding: 30px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
	margin-right: 20px;
}

.search-container {
	margin-bottom: 20px;
}

.search-container input[type="text"] {
	width: 100%;
	padding: 10px;
	border-radius: 10px;
	border: 1px solid #ccc;
	font-size: 16px;
}

.member-list {
	display: flex;
	flex-direction: column;
	gap: 20px;
}

.member-item {
	background-color: #f0f0f0;
	padding: 20px;
	border-radius: 30px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.member-item h2 {
	color: black;
	font-size: 18px;
	font-weight: bold;
}

.member-item p {
	font-size: 14px;
	color: #666;
	margin: 0;
}

.delete-button {
	background-color: #ff4d4d;
	color: white;
	border: none;
	border-radius: 10px;
	padding: 5px 10px;
	cursor: pointer;
}

.stats-wrapper {
	width: 70%;
	display: flex;
	flex-direction: column;
	gap: 40px;
}

.chart-container {
	background-color: #f0f0f0;
	padding: 20px;
	margin-left:20px;
	border-radius: 30px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
	cursor: pointer;
}

.chart-large {
	width: 80%;
	margin: 0 auto;
}

.report-list-wrapper {
	background-color: #ffffff;
	border-radius: 30px;
	padding: 30px;
	margin-left:20px;
	color:black;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
}

.report-list {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.report-item {
	background-color: #f0f0f0;
	padding: 10px;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.footer {
	padding: 20px;
	text-align: center;
	color: white;
}

.footer hr {
	border: none;
	height: 3px;
	background-color: #f0f0f0;
	margin: 20px 0;
}
</style>

<!-- Chart.js 라이브러리 추가 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="admin-body">
	<%@ include file="./headerAdmin.jsp" %>
	<div class="admin-content">
		<div class="member-list-wrapper">
		<div style="color:black;">
			<h3>직원 조회</h3>
		</div>
			<div class="search-container">
				<input type="text" id="search" placeholder="팀 또는 회원 이름 검색">
			</div>
			<div class="member-list">
				<c:forEach var="member" items="${memberList}">
					<div class="member-item">
						<div>
							<h2>${member.UserName}</h2>
							<p>팀: ${member.TeamName}</p>
							<p>이메일: ${member.Email}</p>
						</div>
						<button class="delete-button">삭제</button>
					</div>
				</c:forEach>
				<!-- 더미 데이터 추가 -->
				<div class="member-item">
					<div>
						<h2>홍길동</h2>
						<p>팀: 개발팀</p>
						<p>이메일: hong@example.com</p>
					</div>
					<button class="delete-button">삭제</button>
				</div>
				<div class="member-item">
					<div>
						<h2>이순신</h2>
						<p>팀: 디자인팀</p>
						<p>이메일: lee@example.com</p>
					</div>
					<button class="delete-button">삭제</button>
				</div>
				<div class="member-item">
					<div>
						<h2>김철수</h2>
						<p>팀: 마케팅팀</p>
						<p>이메일: kim@example.com</p>
					</div>
					<button class="delete-button">삭제</button>
				</div>
				<div class="member-item">
					<div>
						<h2>박영희</h2>
						<p>팀: 인사팀</p>
						<p>이메일: park@example.com</p>
					</div>
					<button class="delete-button">삭제</button>
				</div>
				<div class="member-item">
					<div>
						<h2>최유리</h2>
						<p>팀: 개발팀</p>
						<p>이메일: choi@example.com</p>
					</div>
					<button class="delete-button">삭제</button>
				</div>
			</div>
		</div>
		<div class="stats-wrapper">
			<div class="chart-container" id="chartContainer">
					<div style="color:black; ">
			<h3>${departmentName} 팀별 사용량</h3>
		</div>
				<canvas id="usageChart"></canvas>
			</div>
			<div class="report-list-wrapper">
				<div class="section-title"><h3>전체 보고서 리스트</h3></div>
				<div class="report-list">
					<c:forEach var="report" items="${reportList}">
						<div class="report-item">
							<p>${report.title}</p>
						</div>
					</c:forEach>
					<!-- 더미 데이터 추가 -->
					<div class="report-item">
						<p>보고서 제목 1</p>
					</div>
					<div class="report-item">
						<p>보고서 제목 2</p>
					</div>
					<div class="report-item">
						<p>보고서 제목 3</p>
					</div>
					<div class="report-item">
						<p>보고서 제목 4</p>
					</div>
					<div class="report-item">
						<p>보고서 제목 5</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div style="height: 200px;"></div>

	<footer class="footer">
		<hr>
		<div style="text-align: center;">&copy; 2024 DigiCampus 3rd FourSideOut Team. All rights reserved.</div>
	</footer>

	<script>
		// 차트 데이터를 가져오는 부분 (예시 데이터 사용)
		const chartData = {
			labels: ['2023', '2024'],
			datasets: [
				{
					label: '팀 A',
					data: [12, 19],
					backgroundColor: 'rgba(75, 192, 192, 0.2)',
					borderColor: 'rgba(75, 192, 192, 1)',
					borderWidth: 1
				},
				{
					label: '팀 B',
					data: [8, 15],
					backgroundColor: 'rgba(54, 162, 235, 0.2)',
					borderColor: 'rgba(54, 162, 235, 1)',
					borderWidth: 1
				}
				// 추가 팀 데이터
			]
		};

		// 차트 생성
		const ctx = document.getElementById('usageChart').getContext('2d');
		const usageChart = new Chart(ctx, {
			type: 'bar',
			data: chartData,
			options: {
				indexAxis: 'y', // 가로 막대그래프
				scales: {
					y: {
						beginAtZero: true
					}
				}
			}
		});

	</script>
</body>
</html>
