<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<style>
	/* 전체 */
    .admin-body {
       font-family: KB금융 본문체 Light;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
        display: flex;
    }
    .userAdmin-body {
        width: 250px;
        position: fixed;
        top: 0;
        left: 0;
        height: 100vh;
        overflow-y: auto;
        z-index: 1000;
    }
    .admin-container {
        display: flex;
        width: 100%;
        margin-left: 100px;
    }
    .admin-content {
        flex: 1;
        padding: 20px;
        font-size: 11pt;
        margin-left: 250px; /* 사이드바의 너비만큼 여백 추가 */
    }
    
    /* 배너 */
    .banner {
    	width: 92.5%;
		background-color: #fff;
		height: 100px;
	    margin-bottom: 20px;
	    padding: 0px;
	    border-radius: 5px;
	    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
	    display: flex;
	    justify-content: space-between; /* 양쪽 정렬 */
	    align-items: center; /* 세로 중앙 정렬 */
	}
	.banner-text {
	    flex: 1;
	    font-size: 11pt;
	    font-weight: bold;
	    margin-left: 50px;
	}
	.banner img {
	    width: 250px; 
	    height: auto;
	    margin-right: 50px;
	}
    
    
    /* 관리자 대시보드 */
    .header {
    	width: 89.7%;
        padding: 10px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #fff;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .header-left {
	    display: flex;
	    align-items: center;
	}
	
	.header-right {
	    display: flex;
	    align-items: center;
	}
    .header-title {
    	font-family: KB금융 제목체 Light;
    	font-size: 20pt;
    	font-weight: bold;
    	padding: 15px;
    }
    .profile {
        display: flex;
        align-items: center;
        margin-right: 50px;
    }
    .profile img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        margin-right: 15px; /* 프로필 이미지와 이름 간의 간격 */
    }
    /* 로그아웃 */
    .img-logout button {
	    background-color: transparent; /* 배경색 투명하게 설정 */
	    border: none; /* 테두리 없애기 */
	    cursor: pointer; /* 손 모양의 커서 설정 */
	}
	.img-logout i {
	    color: #333; /* 아이콘 색상 설정 (필요 시 변경 가능) */
	    font-size: 20px; /* 아이콘 크기 조정 */
	}
    
    /* 섹션 박스 */
    .section {
    	width: 88.5%;
        background-color: #fff;
        margin-bottom: 20px;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    /* 절반 섹션 */
    .section-container {
	    display: flex;
	    gap: 50px;
	    /* justify-content: space-between; */
	    margin-bottom: 20px;
	}
	.section-wrapper {
	    width: 44.5%; /* 전체 너비의 48%를 차지하도록 설정 */
	    display: flex;
    	flex-direction: column;
	}
	.section-half {
	    background-color: #fff;
	    padding: 20px;
	    border-radius: 5px;
	    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
	    flex-grow: 1; /* 남은 공간을 채우도록 설정 */
	    display: flex;
	    flex-direction: column;
	}
	/* 섹션별 제목 */
	.section-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-top: 30px;
		margin-bottom: 15px;
	}
    .section-title {
    	font-family: KB금융 제목체 Light;
        font-size: 16pt;
        font-weight: bold;
    }
    .section-Intitle {
    	font-family: KB금융 제목체 Light;
    	font-size: 12pt;
    	margin-bottom: 15px;
    	color: #007AFF;
    	text-align: left;
    }
    /* 더보기 버튼 */
    .more-button { 
		border: none;
		background-color: transparent; /* 배경색 제거 */
		align-items: center;
		cursor: pointer;
		font-size: 9pt;
		color: #007AFF;
		margin-top: 10px;
	}
	.more-button:hover {
		color: #0056B3;
	}
    
    /* 일반적인 표들 */
    table {
        width: 100%;
        border-collapse: collapse;/* 테이블 경계선을 합칩니다 */
        text-align: center; /* 모든 글자를 가운데 정렬 */
/*         flex-grow: 1;
	    display: flex;
	    flex-direction: column;  */
    }
    .table table {
	    /* flex-grow: 1; */ 
	}
    th, td {
        border: none; /* 모든 테이블 선 제거 */
        padding: 8px;
        text-align: center;
    }
    th {
        background-color: #f2f2f2;
        /* background-color: #F2F9FF; */
        border-bottom: 1px solid #ddd; /* 가로선만 남깁니다 */
    }
    td {
	    border-bottom: 1px solid #ddd; /* 가로선만 남깁니다 */
	}
    tr:hover {
       background-color: #f2f2f2;
    }
    
    /* 프로젝트 관리 */
    .approval-status {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
        text-align: center;
    }
    .approval-box {
        flex: 1;
        display: flex;
    	flex-direction: column; /* 요소들을 세로 방향으로 배치 */
        justify-content: center; /* 가로 방향 가운데 정렬 */
    	align-items: center; /* 세로 방향 가운데 정렬 */
        text-align: center;
        padding: 20px;
        background-color: #f8f9fa;
        border-radius: 5px;
        margin: 0 10px;
        height: 150px;
        width: auto;
    }
    .approval-box h3 {
        color: #A8D2A0;
        margin-bottom: 10px;
    }
    .approval-box .count {
        font-size: 24px;
        font-weight: bold;
    }
	
	/* 회원관리 */
	.search-btn {
		background-color: #FFCC00;
		color: #000;
		font-weight: bold; /* 텍스트 두께를 두껍게 조정 */
		font-size: 9pt;
		padding: 0 20px;
		cursor: pointer;
		border: none;
		transition: background-color 0.3s ease;
		/* width: 100px;
		height: 50px;
		border-radius: 5px; */
	}
	.search-btn:hover {
		background-color: #D4AA00;
	}
	
    /* 시스템 사용량 관리 */
    .usage-graph {
	    margin: 0 auto;
	    flex: 1;
	    margin-right: 10px; /* 그래프와 테이블 사이의 간격 조정 */
	}
    .usage-management {
	    display: flex;
	    justify-content: space-between;
	    padding: 30px;
	}
	.usage-half {
	    width: 48%; /* 각 half가 섹션의 절반을 차지하도록 설정 */
	}
	.usage-table {
	    flex: 1;
	    margin-left: 50px; /* 그래프와 테이블 사이의 간격 조정 */
	    text-align: center; /* 모든 글자를 가운데 정렬 */
	}
	.usage-table table {
	    width: 70%;
	    border-collapse: collapse; /* 테이블 경계선을 합칩니다 */
	    text-align: center; /* 테이블의 모든 글자를 가운데 정렬 */
	}
	.usage-table th, .usage-table td {
	    border: none; /* 모든 테이블 선 제거 */
	    padding: 8px;
	    text-align: center;
	}
	.usage-table th {
	    background-color: #f2f2f2;
	    border-bottom: 1px solid #ddd; /* 가로선만 남깁니다 */
	}
	.usage-table td {
	    border-bottom: 1px solid #ddd; /* 가로선만 남깁니다 */
	}
	
	/* 회원관리 - 검색 */
/*     .search-box {
        margin-bottom: 15px;
    }
    .search-box input {
        padding: 5px;
        width: 200px;
    }
    .search-box button {
        padding: 5px 10px;
        background-color: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    } */
        @media (max-width: 768px) {
        .admin-content {
            margin-left: 0;
        }
        .userAdmin-body {
            width: 100%;
            position: static;
            height: auto;
        }
    }
</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="admin-body">
<div class="admin-container">
    <div class="userAdmin-body">
        <%@ include file="./adminSideBar.jsp"%>
    </div>
    <div class="admin-content">
        <div class="header">
        	<div class="header-left">
            	<div class="header-title">관리자 대시보드</div>
            </div>
            <div class="header-right">
	            <!-- 프로필 -->
	            <div class="profile">
		            <a href="<c:url value='./mypage'/>">
		                <c:choose>
		                    <c:when test="${not empty profileImg}">
		                        <img src="<c:url value='./upload/${profileImg}'/>" alt="Profile Image">
		                    </c:when>
		                    <c:otherwise>
		                        <img src="<c:url value='./resources/noprofile.png'/>" alt="Logo">
		                    </c:otherwise>
		                </c:choose>
		            </a>
		            <span>${userName} 님</span>
		        </div>
		        <!-- 로그아웃 -->
	            <div class="img-logout">
					<button onclick="logout()">
						<i class="fas fa-sign-out-alt"></i>
					</button>
				</div>
			</div>
        </div>
        
        <!-- 프로젝트 관리 -->
        <div class="section-container">
        	<div class="section-wrapper">
        	<div class="section-header">
        		<div class="section-title">📋 프로젝트 관리</div>
        		<button class="more-button" onclick="location.href='./departmentReportList'">+ 더보기</button>
        	</div>
        	<div class="section-half">
        	<div class="section-Intitle">프로젝트 결재 현황</div>
        		<div class="approval-status">
		            <div class="approval-box">
		                <h3>결재대기</h3>
		                <div class="count">${pendingCount}건</div>
		            </div>
		            <div class="approval-box">
		                <h3>채택</h3>
		                <div class="count">${approvedCount}건</div>
		            </div>
		            <div class="approval-box">
		                <h3>미채택</h3>
		                <div class="count">${rejectedCount}건</div>
		            </div>
		        </div>
	            <!-- <div class="table">
		            <table>
		                <thead>
		                    <tr>
		                        <th>프로젝트명</th>
		                        <th>팀 명</th>
		                        <th>생성자</th>
		                        <th>기안자</th>
		                        <th>상태</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    프로젝트 목록 데이터
		                    <tr>
		                        <td>프로젝트 A</td>
		                        <td>인사팀</td>
		                        <td>홍길동</td>
		                        <td>2024-03-15</td>
		                        <td>승인 대기</td>
		                    </tr>
		                    추가 행...
		                </tbody>
		            </table>
		    	</div> -->
	        </div>
	    	</div>
	    
	    	<!-- 사용자 관리 -->
	    	<div class="section-wrapper">
	    	<div class="section-header">
        		<div class="section-title">👥 사용자 관리</div>
        		<button class="more-button" onclick="location.href='./userAdminView'">+ 더보기</button>
        	</div>
	        <div class="section-half">
	        <div class="section-Intitle">직원 조회</div>
	            <!-- <div class="search-box">
	                <input type="text" id="searchInput" placeholder="검색할 내용을 입력해주세요">
	                <button class="search-btn">검색</button>
	            </div> -->
	            <table>
	                <thead>
	                    <tr>
	                    	<th>부서</th>
	                        <th>팀</th>
	                        <th>직원명</th>
	                        <th>직원번호</th>
	                        <th>이메일</th>
	                        <th>생일</th>
	                        <!-- <th>재직여부</th> -->
	                    </tr>
	                </thead>
	                <tbody>
	                    <c:forEach var="user" items="${userList}" varStatus="status">
           					<c:if test="${status.index < 5}">
					            <tr>
					                <td>${user.departmentName}</td>
					                <td>${user.teamName}</td>
					                <td>${user.userName}</td>
					                <td>${user.userId}</td>
					                <td>${user.email}</td>
					                <td>${user.birth}</td>
					                <%-- <td><c:choose>
					                    <c:when test="${user.delete == false}">Y</c:when>
					                    <c:otherwise>N</c:otherwise>
					                </c:choose></td> --%>
					            </tr>
				            </c:if>
				        </c:forEach>
	                </tbody>
	            </table>
	        </div>
	    	</div>
	    </div>
	    
	    
        <div class="section-header">
       		<div class="section-title">📈 사용량 관리</div>
       		<!-- <button class="more-button" onclick="location.href='./meetingList'">+ 더보기</button> -->
       	</div>
        <!-- 배너 -->
        <div class="banner">
		    <div class="banner-text">
		        체계적인 시스템 사용량, <br> 통계 분석 서비스로 확인해 보세요
		    </div>
		    <img src="<c:url value='/resources/chart.png'/>" alt="통계 차트">
		</div>
        <div class="section usage-management">
            <div class="usage-half">
	            <div class="usage-graph">
	            	<div class="section-Intitle">사용량 그래프</div>
	                <!-- 차트를 그릴 캔버스 -->
	                <canvas id="usageChart"></canvas>
	            </div>
	         </div>
	         <div class="usage-half">
	            <div class="usage-table">
	            	<div class="section-Intitle">팀별 분석</div>
	                <table id="teamAnalysisTable">
	                    <thead>
	                        <tr>
	                            <th>팀</th>
	                            <th>사용횟수</th>
	                            <th>채택률</th>
	                        </tr>
	                    </thead>
	                     <tbody>
				            <c:forEach var="usage" items="${bestUsage}" varStatus="status">
				                <tr class="team-row" data-team-name="${usage.teamName}">
		                            <td>${usage.teamName}</td>
		                            <td>${usage.teamCount}회</td>
		                            <td>${usage.adoptionRate}%</td>
		                        </tr>
		                    </c:forEach>
		                </tbody>
		            </table>
	                
	                <div class="section-Intitle" style="margin-top: 20px;">팀원 정보</div>
				    <table id="teamMembersTable">
				        <thead>
				            <tr>
				                <th>직원명</th>
				                <th>직원번호</th>
				                <th>기여도</th>
				            </tr>
				        </thead>
				        <tbody>
				            <!-- <tr class="team-A" style="display: none;">
				                <td>홍길동</td>
				                <td>001</td>
				                <td>50%</td>
				            </tr> -->
				        </tbody>
				    </table>
	             </div>
	    	</div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
	// 차트
    // 테이블에서 데이터 추출
    const table = document.querySelector('.usage-table table');
    const departments = [];
    const usageCounts = [];
    const adoptionRates = [];

    table.querySelectorAll('tbody tr').forEach(row => {
        departments.push(row.cells[0].textContent);
        usageCounts.push(parseInt(row.cells[1].textContent));
        adoptionRates.push(parseFloat(row.cells[2].textContent));
    });

    const ctx = document.getElementById('usageChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: departments,
            datasets: [{
                label: '사용횟수',
                data: usageCounts,
                borderColor: '#88BFFF',  // 이 부분을 수정
                // backgroundColor: '#007BFF',  // 이 부분을 추가
                tension: 0.1,
                yAxisID: 'y-axis-1'
            }, {
                label: '채택률',
                data: adoptionRates,
                borderColor: '#A8D2A0',  // 이 부분을 수정
                // backgroundColor: '#EDE1C9',  // 이 부분을 추가
                tension: 0.1,
                yAxisID: 'y-axis-2'
            }]
        },
        options: {
            responsive: true,
            scales: {
                'y-axis-1': {
                    type: 'linear',
                    position: 'left',
                    beginAtZero: true,
                    suggestedMax: function(context) {
                        const max = Math.max(...context.chart.data.datasets[0].data);
                        return Math.ceil(max * 1.2); // 최대값의 120%로 설정
                    },
                    ticks: {
                        stepSize: function(context) {
                            const max = context.max;
                            return Math.ceil(max / 5); // 5개의 주요 눈금으로 나누기
                        }
                    },
                    title: {
                        display: true,
                        text: '사용횟수'
                    }
                },
                'y-axis-2': {
                    type: 'linear',
                    position: 'right',
                    beginAtZero: true,
                    max: 100,
                    ticks: {
                        stepSize: 20 // 20% 간격으로 눈금 설정
                    },
                    title: {
                        display: true,
                        text: '채택률 (%)'
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: '팀'
                    }
                }
            }
        }
    });
    
 	// 팀 행 클릭 이벤트 처리
    const teamRows = document.querySelectorAll('#teamAnalysisTable tbody tr');
    console.log("Number of team rows:", teamRows.length);
    teamRows.forEach(row => {
        row.addEventListener('click', function() {
            const teamName = this.cells[0].textContent;
            console.log("Row clicked:", teamName);
            fetchTeamMembers(teamName);
        });
    });
});

function fetchTeamMembers(teamName) {
    console.log("Fetching team members for:", teamName);
    fetch('./getBestEmployees?teamName=' + encodeURIComponent(teamName), {
    	headers: {
            'Accept': 'application/json;charset=UTF-8'
        }
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(text => { throw new Error(text) });
        }
        return response.json();
    })
    .then(data => {
        console.log("Received data:", data);
        updateTeamMembersTable(data);
    })
    .catch(error => console.error('Error:', error));
}

function updateTeamMembersTable(employees) {
    const tableBody = document.querySelector('#teamMembersTable tbody');
    tableBody.innerHTML = '';
    employees.forEach(employee => {
        const row = tableBody.insertRow();
        row.insertCell(0).textContent = employee.userName;
        row.insertCell(1).textContent = employee.userId;
        row.insertCell(2).textContent = employee.totalContribution;
    });
}

//팀 행 클릭 이벤트 처리
document.querySelectorAll('.usage-table tbody tr').forEach(row => {
    row.addEventListener('click', function() {
        const teamName = this.cells[0].textContent;
        fetchTeamMembers(teamName);
    });
});
// 로그아웃 
function logout() {
	window.location.href = './logout';
	alert('로그아웃 되었습니다.');
}
</script>
</body>
</html>

