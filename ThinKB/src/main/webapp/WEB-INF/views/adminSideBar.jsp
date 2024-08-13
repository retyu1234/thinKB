<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
/* 로고 */
.logo {
	display: flex;
	align-items: center;
	width:100%;
	height:auto;
	margin-left: 20px;
	margin-bottom: 40px;
}
.logo img {
	height: 40px;
}


/* 사이드바 */
.sidebar {
    width: 230px;
    height: auto;
    background-color: #333;
    color: white;
    padding-top: 50px;
}
.sidebar ul {
    list-style-type: none;
    padding: 0;
}
.sidebar li {
    padding: 10px 20px;
    cursor: pointer;
    position: relative;
}
/* 메인 탭 hover 효과 제거 */
.sidebar > ul > li:hover {
    background-color: #333;
}
/* 메인 탭 클릭 시 스타일 */
.sidebar > ul > li.active {
    background-color: #444;
}
/* 세부탭 */
.sidebar li ul {
    display: none;
    list-style-type: none;
    padding: 0;
    margin: 0;
}
.sidebar li ul li {
    padding: 10px 20px;
}
/* 세부탭 hover 효과 */
.sidebar li ul li:hover {
    background-color: #555;
}
.sidebar .active > ul {
    display: block;
}
</style>
<script>
function toggleSubmenu(event) {
    const parentLi = event.currentTarget;
    // 모든 메인 탭의 active 클래스 제거
    document.querySelectorAll('.sidebar > ul > li').forEach(item => {
        item.classList.remove('active');
    });
    // 클릭된 메인 탭에 active 클래스 추가
    parentLi.classList.add('active');
    // 서브메뉴 토글
    const submenu = parentLi.querySelector('ul');
    if (submenu) {
        submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
    }
    // 이벤트 버블링 방지
    event.stopPropagation();
}

document.addEventListener('DOMContentLoaded', function() {
    const menuItems = document.querySelectorAll('.sidebar > ul > li');
    menuItems.forEach(function(item) {
        item.addEventListener('click', toggleSubmenu);
    });
});
</script>
</head>
<body>
<div class="sidebar">
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
</html>