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
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
    }
    .container {
        display: flex;
    }
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
    .content {
        flex: 1;
        padding: 20px;
    }
    .header {
        background-color: #fff;
        padding: 10px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .section {
        background-color: #fff;
        margin-bottom: 20px;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .section-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 15px;
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
    .chart {
        height: 300px;
        /* 차트 관련 스타일은 여기에 추가 */
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
            <table>
                <thead>
                    <tr>
                        <th>프로젝트명</th>
                        <th>생성자</th>
                        <th>생성일</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 프로젝트 목록 데이터 -->
                    <tr>
                        <td>프로젝트 A</td>
                        <td>홍길동</td>
                        <td>2024-03-15</td>
                        <td>승인 대기</td>
                    </tr>
                    <!-- 추가 행... -->
                </tbody>
            </table>
        </div>
        
        <div class="section">
            <div class="section-title">사용량 관리</div>
            <div class="chart">
                <!-- 차트를 그릴 캔버스 또는 div -->
                <!-- 차트 라이브러리를 사용하여 여기에 차트를 그립니다 -->
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