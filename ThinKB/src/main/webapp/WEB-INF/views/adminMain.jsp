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
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
    }
    .container {
        display: flex;
    }
    .content {
        flex: 1;
        padding: 20px;
    }
    
    /* 배너 */
    .banner {
		background-color: #fff;
	    margin-bottom: 20px;
	    padding: 20px;
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
	    margin-right: 150px;
	}
    
    /* 사이드바 */
    .sidebar {
        width: 250px;
        background-color: #333;
        color: white;
        height: 100vh;
        padding-top: 20px;
    }
    .sidebar ul {
        list-style-type: none;
        padding: 0;
    }
    .sidebar li {
        padding: 10px 20px;
    }
    .sidebar li:hover {
        background-color: #444;
    }

    
    /* 관리자 대시보드 */
    .header {
        background-color: #fff;
        padding: 10px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    
    /* 흰색 섹션 틀 */
    .section {
        background-color: #fff;
        margin-bottom: 20px;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    /* 섹션별 제목 */
    .section-title {
        font-size: 18pt;
        font-weight: bold;
        margin-bottom: 15px;
    }
    .section-Intitle {
    	font-size: 15px;
    	margin-bottom: 15px;
    	color: #978A8F;
    }

    
    /* 시스템 사용량 관리 */
    .usage-management {
	    display: flex;
	}
	.usage-graph {
	    flex: 1;
	    margin-right: 10px; /* 그래프와 테이블 사이의 간격 조정 */
	}
	
	.usage-table {
	    flex: 1;
	    margin-left: 10px; /* 그래프와 테이블 사이의 간격 조정 */
	    text-align: center; /* 모든 글자를 가운데 정렬 */
	}
	.usage-table table {
	    width: 100%;
	    border-collapse: collapse; /* 테이블 경계선을 합칩니다 */
	    text-align: center; /* 테이블의 모든 글자를 가운데 정렬 */
	}
	.usage-table th, .usage-table td {
	    border: none; /* 모든 테이블 선 제거 */
	    padding: 8px;
	}
	.usage-table th {
	    background-color: #f2f2f2;
	    border-bottom: 1px solid #ddd; /* 가로선만 남깁니다 */
	}
	.usage-table td {
	    border-bottom: 1px solid #ddd; /* 가로선만 남깁니다 */
	}
	
	
	
    
        
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
    
    .search-box {
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
    }
</style>
</head>
<body>
<div class="container">
    <div class="sidebar">
        <ul>
            <li>대시보드</li>
            <li>프로젝트 관리</li>
            <li>사용자 관리</li>
            <li>통계</li>
            <li>설정</li>
        </ul>
    </div>
    <div class="content">
        <div class="header">
            <h1>관리자 대시보드</h1>
            <div>
                <button>연장/업그레이드</button>
                <button>나가기</button>
            </div>
        </div>
        
        <div class="section">
            <div class="section-title">프로젝트 결재 목록</div>
            <div class="table">
	            <table>
	                <thead>
	                    <tr>
	                        <th>프로젝트명</th>
	                        <th>팀 명</th>
	                        <th>생성자</th>
	                        <th>생성일</th>
	                        <th>상태</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <!-- 프로젝트 목록 데이터 -->
	                    <tr>
	                        <td>프로젝트 A</td>
	                        <td>인사팀</td>
	                        <td>홍길동</td>
	                        <td>2024-03-15</td>
	                        <td>승인 대기</td>
	                    </tr>
	                    <!-- 추가 행... -->
	                </tbody>
	            </table>
	    	</div>
        </div>
        
        <div class="section-title">📈 사용량 관리</div>
        <!-- 배너 -->
        <div class="banner">
		    <div class="banner-text">
		        체계적인 시스템 사용량, <br> 통계 분석 서비스로 확인해 보세요
		    </div>
		    <img src="<c:url value='/resources/chart.png'/>" alt="통계 차트">
		</div>
        <div class="section">
            <div class="usage-management">
	            <div class="usage-graph">
	                <!-- 차트를 그릴 캔버스 또는 div -->
	                <!-- 차트 라이브러리를 사용하여 여기에 차트를 그립니다 -->
	            </div>
	            <div class="usage-table">
	            <div class="section-Intitle">팀별 분석</div>
	                <table>
	                    <thead>
	                        <tr>
	                            <th>부서이름</th>
	                            <th>사용횟수</th>
	                            <th>채택률</th>
	                        </tr>
	                    </thead>
	                     <tbody>
				            <c:forEach var="usage" items="${bestUsage}" varStatus="status">
				                <tr>
				                    <td>${usage.departmentName}</td>
				                    <td>${usage.departmentCount}회</td>
				                    <td>-</td> <!-- 채택률 공란 -->
				                </tr>
				            </c:forEach>
				        </tbody>
	                </table>
	             </div>
	    	</div>
        </div>
        
        <div class="section">
            <div class="section-title">회원 관리</div>
            <div class="search-box">
                <input type="text" placeholder="회원 검색...">
                <button>검색</button>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>이름</th>
                        <th>이메일</th>
                        <th>가입일</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 회원 목록 데이터 -->
                    <tr>
                        <td>김철수</td>
                        <td>kim@example.com</td>
                        <td>2024-01-01</td>
                        <td>활성</td>
                    </tr>
                    <!-- 추가 행... -->
                </tbody>
            </table>
        </div>
        
        <div class="section">
            <!-- 네 번째 섹션은 비워둠 -->
        </div>
    </div>
</div>
</body>
</html>