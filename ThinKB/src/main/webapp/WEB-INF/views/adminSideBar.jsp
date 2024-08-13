<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.admin-sidebar {
    width: 250px;
    height: 100vh;
    background-color: #2c2c2c;
    color: white;
    padding-top: 20px;
    box-sizing: border-box;
    position: fixed;
    left: 0;
    top: 0;
    overflow-y: auto;
}
.admin-logo {
    display: flex;
    align-items: center;
    padding: 20px;
    border-bottom: 1px solid #f4f4f4;
    margin-bottom: 30px;
}
.admin-logo img {
    height: 30px;
    /* margin-right: 10px; */
}
.admin-sidebar ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
}
.admin-sidebar li {
    padding: 10px 15px;
    cursor: pointer;
    transition: background-color 0.3s;
}
/* 대신 다음 스타일을 추가합니다 */
.admin-sidebar > ul > li > span:hover,
.admin-sidebar > ul > li > a:hover,
.admin-sidebar li ul li:hover {
    background-color: #3a3a3a;
}

/* 추가로, 메인 메뉴 항목과 서브 메뉴 항목에 패딩을 개별적으로 적용합니다 */
.admin-sidebar > ul > li > span,
.admin-sidebar > ul > li > a {
    display: block;
    padding: 10px 20px;
}



.admin-sidebar > ul > li {
    font-weight: bold;
}
.admin-sidebar li ul {
    margin-top: 5px;
}
.admin-sidebar li ul li {
    font-weight: normal;
}
.admin-sidebar a {
    color: white;
    text-decoration: none;
    display: block;
}
.admin-sidebar .admin-icon {
    margin-right: 10px;
    width: 20px;
    display: inline-block;
    text-align: center;
}
.admin-badge {
    background-color: #007bff;
    color: white;
    padding: 2px 6px;
    border-radius: 10px;
    font-size: 0.8em;
    float: right;
}
.admin-sidebar > ul > li > span {
    display: block;
    padding: 10px 15px;
    font-weight: bold;
    cursor: pointer;
}

/* 링크 스타일 (서브 메뉴 항목 및 직접 이동 메뉴) */
.admin-sidebar li ul li a,
.admin-sidebar > ul > li > a {
    padding: 10px 15px;
    display: block;
    text-decoration: none;
    color: white;
}

/* 서브 메뉴 들여쓰기 */
.admin-sidebar li ul li a {
    padding-left: 45px;
}

/* 호버 효과 */
.admin-sidebar > ul > li > span:hover,
.admin-sidebar li ul li a:hover,
.admin-sidebar > ul > li > a:hover {
    background-color: #3a3a3a;
}

/* 아이콘 스타일 */
.admin-icon {
    margin-right: 10px;
    width: 20px;
    display: inline-block;
    text-align: center;
}
.admin-sidebar-footer {
    position: absolute;
    bottom: 0;
    width: 100%;
    padding: 15px;
    background-color: #222;
    font-size: 0.8em;
    text-align: center;
    box-sizing: border-box;
}

.admin-sidebar-footer p {
    margin: 5px 0;
    color: #888;
}

.admin-sidebar-footer a {
    color: #aaa;
    text-decoration: none;
}

.admin-sidebar-footer a:hover {
    text-decoration: underline;
}
</style>
</head>
<body>
<div class="admin-sidebar">
    <div class="admin-logo">
    	<a href="<c:url value='./adminMain'/>">
        	<img src="<c:url value='./resources/logo.png'/>" alt="Linweb">
        </a>
    </div>
    <ul>
        <li><span class="admin-icon">PJ</span>프로젝트 관리
        	<ul>
                <li><a href="./departmentReportList">프로젝트 결재</a></li>
                <li><a href="./departmentReportList">프로젝트 조회</a></li>
            </ul>
        </li>
        <li>
            <span class="admin-icon">📁</span>사용자 관리
            <ul>
                <li><a href="./userAdminView">직원 목록</a></li>
                <li><a href="./addUserView">직원 추가</a></li> 
            </ul>
        </li>
<!--        <li><span class="admin-icon">📊</span>사용량 관리</li> -->
		        <li>
            <a href="<c:url value='./adminMypage'/>"><span class="admin-icon">⚙️</span>부서 현황</a>
        </li>
    </ul>
    
        <div class="admin-sidebar-footer">
        <p>© 2024 ThinKB Admin</p>
        <p>버전 1.0.0</p>
        <p><a href="#">도움말</a> | <a href="#">문의하기</a></p>
    </div>
</div>
</body>
</html>