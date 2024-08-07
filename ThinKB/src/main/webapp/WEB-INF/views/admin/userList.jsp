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
        background-color: #f5f5f5;
        margin: 0 auto;
        padding: 20px;
    }
    .container {
        display: flex;
    }
    .content {
        flex: 1;
        padding: 20px;
        font-size: 11pt;
    }
    
     /* 섹션 박스 */
    .section {
        background-color: #fff;
        margin-bottom: 20px;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    
    /* 섹션별 제목 */
	.section-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-top: 30px;
		margin-bottom: 15px;
	}
	.addUser-btn {
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .section-title {
        font-size: 16pt;
        font-weight: bold;
    }
    .section-Intitle {
    	font-size: 12pt;
    	margin-bottom: 15px;
    	color: #007AFF;
    	text-align: left;
    }
    
    /* 회원 검색 */
    .search-box {
        display: flex;
        margin-bottom: 20px;
    }
    .search-box input {
        flex-grow: 1;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        margin-right: 10px;
    }
    .search-btn {
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    
    
    .user-list-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    .user-list-header h2 {
        margin: 0;
        font-size: 24px;
    }
    
    
    /* 표 */
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        text-align: left;
        padding: 12px;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #f8f8f8;
        font-weight: bold;
    }
    tr:hover {
        background-color: #f5f5f5;
    }
</style>
</head>
<body>
<%@ include file="../adminSideBar.jsp"%>
 
<div class="container">
    <div class="search-box">
        <input type="text" placeholder="검색">
        <button class="search-btn">검색</button>
    </div>
    <div class="user-list">
        <div class="section-header">
            <h2>사용자 목록</h2>
            <button class="addUser-btn" onclick="location.href='./addUser'">사용자 추가</button>
        </div>
        <table>
            <thead>
                <tr>
                    <th>부서</th>
                    <th>팀</th>
                    <th>직원명</th>
                    <th>직원번호</th>
                    <th>이메일</th>
                    <th>생일</th>
                    <th>재직여부</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${userList}">
                    <tr>
                        <td>${user.departmentName}</td>
                        <td>${user.teamName}</td>
                        <td>${user.userName}</td>
                        <td>${user.userId}</td>
                        <td>${user.email}</td>
                        <td>${user.birth}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.delete == false}">Y</c:when>
                                <c:otherwise>N</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>