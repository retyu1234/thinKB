<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
}
.sidebar {
    width: 250px;
    height: auto;
    background-color: #2c2c2c;
    color: white;
    padding-top: 20px;
    box-sizing: border-box;
}
.logo {
    display: flex;
    align-items: center;
    padding: 20px;
    border-bottom: 1px solid #f4f4f4;
    margin-bottom: 30px;
}
.logo img {
    height: 30px;
    /* margin-right: 10px; */
}
.sidebar ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
}
.sidebar li {
    padding: 10px 15px;
    cursor: pointer;
    transition: background-color 0.3s;
}
/* 대신 다음 스타일을 추가합니다 */
.sidebar > ul > li > span:hover,
.sidebar > ul > li > a:hover,
.sidebar li ul li:hover {
    background-color: #3a3a3a;
}

/* 추가로, 메인 메뉴 항목과 서브 메뉴 항목에 패딩을 개별적으로 적용합니다 */
.sidebar > ul > li > span,
.sidebar > ul > li > a {
    display: block;
    padding: 10px 20px;
}



.sidebar > ul > li {
    font-weight: bold;
}
.sidebar li ul {
    margin-top: 5px;
}
.sidebar li ul li {
    font-weight: normal;
}
.sidebar a {
    color: white;
    text-decoration: none;
    display: block;
}
.sidebar .icon {
    margin-right: 10px;
    width: 20px;
    display: inline-block;
    text-align: center;
}
.badge {
    background-color: #007bff;
    color: white;
    padding: 2px 6px;
    border-radius: 10px;
    font-size: 0.8em;
    float: right;
}
</style>
</head>
<body>
<div class="sidebar">
    <div class="logo">
    	<a href="<c:url value='./adminMain'/>">
        	<img src="<c:url value='./resources/logo.png'/>" alt="Linweb">
        </a>
    </div>
    <ul>
        <li><span class="icon">PJ</span>프로젝트 관리
        	<ul>
                <li><a href="./departmentReportList">프로젝트 결재 목록</a></li>
                <li>프로젝트 조회</li>
            </ul>
        </li>
        <li>
            <span class="icon">📁</span>사용자 관리
            <ul>
                <li><a href="./userAdminView">직원 목록</a></li>
                <li><a href="./addUserView">직원 추가</a></li> 
            </ul>
        </li>
        <li><span class="icon">📊</span>사용량 관리</li>
		<li><span class="icon">⚙️</span>설정</li>
<!--         <li><span class="icon">🛒</span>쇼핑 <span class="badge">7</span></li>
        <li><span class="icon">📅</span>예약</li>
        <li><span class="icon">📊</span>컨텐츠 관리</li>
        <li><span class="icon">💬</span>마케팅 관리 <span class="badge">N</span></li>
        <li><span class="icon">📱</span>App 신청 및 관리</li>
        <li><span class="icon">📌</span>디자인보드</li> -->
    </ul>
</div>
</body>
</html>

<%-- <div class="sidebar">
	<div class="logo">
        <a href="<c:url value='./adminMain'/>"> <img src="<c:url value='./resources/logo.png'/>" alt="Logo"></a>
    </div>
    
    <ul>
        <li>📋 프로젝트 관리
            <ul>
                <li><a href="./departmentReportList">프로젝트 결재 목록</a></li>
            </ul>
        </li>
        <li>👥 사용자 관리
            <ul>
            	<li><a href="./userAdminView">직원 목록</a></li>
                <li>직원 추가</li>
            </ul>
        </li>
        <li>📈 사용량 관리</li>
        <li>⚙️ 설정</li>
    </ul>
</div>
</body>
</html> --%>