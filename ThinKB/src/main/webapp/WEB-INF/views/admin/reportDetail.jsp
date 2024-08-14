<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>보고서 상세</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
/*         body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .admin-content {
            padding: 20px;
            font-size: 11pt;
            max-width: 1200px;
            margin: 0 auto;
            margin-left: 150px;
        } */
        .reportDetail-body { font-family: KB금융 본문체 Light; background-color: #f4f4f4; margin: 0; padding: 20px; }
    	.reportDetail-content { width: 70%; margin: 0 0 0 350px; padding: 20px; border-radius: 8px;}
        .reportDetail-title { font-family: KB금융 제목체 Light; font-size: 18pt;  font-weight: bold; color: #333; margin-bottom: 20px; display: flex; align-items: center;}
        .back2 {width: 30px; height: auto;  margin-right: 20px; margin-top: 10px;}
        .reportDetail-line {margin-bottom: 50px; border-bottom: 1px solid #ddd;}
        .section-container {
            display: flex;
            gap: 20px;
            min-height: calc(100vh - 40px);
        }
        .left-section, .right-section {
            display: flex;
            flex-direction: column;
        }
        .left-section {
            flex: 3;
        }
        .right-section {
            flex: 2;
        }
        .section {
            background-color: #fff;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            flex-grow: 1;
            display: flex;
        	flex-direction: column;
        	padding: 20px;
        }
        .section-title {
            font-size: 11pt;
            color: #007AFF;
            margin-bottom: 20px;
        }
        .outer-title {
            font-size: 14pt;
            font-weight: bold;
            color: #000;
            margin-bottom: 10px;
        }
        table {
        	font-family: KB금융 본문체 Light;
            width: 100%;
            border-collapse: collapse;
            text-align: center;
        }
        th, td {
            border: none;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            border-bottom: 1px solid #ddd;
        }
        td {
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background-color: #f2f2f2;
        }
        #contributionChart {
            width: 100%;
            height: 300px;
        }
		.chart-container {
	        position: relative;
	        height: 300px;
	        width: 100%;
	        max-height: 300px;
	        margin-bottom: 10px; /* 원형 그래프 아래 여백 줄임 */
	    }
	    
	    
	    /* 보고서 내용 */
	    .report-header {
	        width: 100%;
	        border-collapse: collapse;
	        margin-bottom: 20px;
	        text-align: center;
	    }
	    .report-header td {
	        border: 1px solid #ddd;
	        padding: 10px;
	        text-align: center;
	        vertical-align: middle;
	    }
	    .logo-cell {
	        width: 100px;
	        text-align: center;
	    }
	    .logo {
	        max-width: 100%;
	        height: auto;
	    }
	    .title-cell {
	        font-size: 18px;
	        font-weight: bold;
	    }
	    .date-cell, .department-cell, .author-cell {
	        font-size: 14px;
	    }
	    .department-cell, .author-cell {
	        width: 200px;
	    }
	    .report-content-wrapper {
	        border: 1px solid #ddd;
	        padding: 10px;
	        margin-top: 1px;
	        flex-grow: 1;
	        display: flex;
	        flex-direction: column;
	    }
	    #report-content {
	        flex-grow: 1;
	        overflow-y: auto; /* 내용이 많을 경우 스크롤 */
	    }
	    .report-header td {
	        text-align: center;
	        vertical-align: middle;
	    }
    </style>
</head>
<body class="reportDetail-body">
<div class="reportDetail-content">
	<%@ include file="../adminSideBar.jsp"%>
	
	<div class="reportDetail-title">
		<a href="./departmentReportList"><img src="./resources/back2.png" alt="back2" class="back2"></a>
		<span>보고서 상세보기</span>
	</div>
	<hr class="reportDetail-line">
	
    <div class="section-container">
    
        <!-- 최종 보고서 섹션 -->
        <div class="left-section">
            <div class="outer-title">📋 보고서 내용</div>
            <div class="section">
	            <table class="report-header">
				    <tr>
				        <td rowspan="2" class="logo-cell">
				            <img src="./resources/logo-report.png" alt="KB 국민은행 로고" class="logo">
				        </td>
				        <td colspan="3" class="title-cell">
				            ${reportDetail.reportTitle}
				        </td>
				        <td class="department-cell">
				            ${reportAuthor.teamName}
				        </td>
				    </tr>
				    <tr>
				        <td colspan="3" class="date-cell">
				            ${reportDetail.updatedAt}
				        </td>
				        <td class="author-cell">
				            기안자: ${reportAuthor.userName}
				        </td>
				    </tr>
				</table>
				<div class="report-content-wrapper">
					<div id="report-content"></div>
				</div>
			</div>
		</div>
			
            <%-- <div class="section">
                <div class="section-title"> 최종 보고서</div>
                <h3>${reportDetail.reportTitle}</h3>
                <div id="report-content"></div>
                <p>작성일: ${reportDetail.createdAt}</p>
                <p>수정일: ${reportDetail.updatedAt}</p>
                <p>회의실: ${reportDetail.roomTitle}</p>
                <p>회의 관리자: ${reportDetail.roomManagerName}</p>
            </div> --%>
        
        
        <div class="right-section">
            <!-- 회의 참여자 정보 섹션 -->
            <div class="outer-title">👥 회의 참여자 정보</div>
            <div class="section">
                <div class="section-title">회의 참여자 정보</div>
                <table>
                    <thead>
                        <tr>
                            <th>이름</th>
                            <th>팀</th>
                            <th>기여도</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${reportMembers}" var="member">
                            <tr>
                                <td>${member.userName}</td>
                                <td>${member.teamName}</td>
                                <td>${member.contributionCnt}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <!-- 기여도 그래프 섹션 -->
            <div class="outer-title">📊 기여도</div>
			<div class="section">
			    <div class="section-title">회의 참여자별 기여도</div>
			    <div class="chart-container">
			        <canvas id="contributionChart"></canvas>
			    </div>
			</div>
        </div>
    </div>
</div>

<!-- Quill 라이브러리 추가 -->
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<script>
/* 보고서 불러오기 */
document.addEventListener('DOMContentLoaded', function() {
    var reportContent = ${reportDetail.reportContent};
    var quill = new Quill('#report-content', {
        readOnly: true,
        modules: {
            toolbar: false
        },
        theme: 'snow'
    });
    quill.setContents(reportContent);
});

/* 기여도 차트 */
var ctx = document.getElementById('contributionChart').getContext('2d');
var data = {
    labels: [<c:forEach items="${reportMembers}" var="member">'${member.userName}',</c:forEach>],
    datasets: [{
        data: [<c:forEach items="${reportMembers}" var="member">${member.contributionCnt},</c:forEach>],
        backgroundColor: [
            'rgba(255, 99, 132, 0.8)',
            'rgba(54, 162, 235, 0.8)',
            'rgba(255, 206, 86, 0.8)',
            'rgba(75, 192, 192, 0.8)',
            'rgba(153, 102, 255, 0.8)'
        ]
    }]
};
var myPieChart = new Chart(ctx, {
    type: 'pie',
    data: data,
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                position: 'top',
                labels: {
                    boxWidth: 12,
                    padding: 5
                }
            }
        },
        layout: {
            padding: {
                top: 20,
                bottom: 40 // 하단 패딩 증가
            }
        }
    }
});
</script>
</body>
</html>