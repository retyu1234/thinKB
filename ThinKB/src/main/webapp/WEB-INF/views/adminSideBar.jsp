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
.admin-sidebar {
    position: fixed;
    top: 0;
    left: 0;
    width: 230px;
    height: 100vh; /* 뷰포트 높이의 100% */
    background-color: #333;
    color: white;
    padding-top: 50px;
    overflow-y: auto; /* 내용이 넘칠 경우 스크롤바 추가 */
}
.admin-sidebar ul {
    list-style-type: none;
    padding: 0;
}
.admin-sidebar li {
    padding: 10px 20px;
    cursor: pointer;
    position: relative;
}
/* 메인 탭 hover 효과 제거 */
.admin-sidebar > ul > li:hover {
    background-color: #333;
}
/* 메인 탭 클릭 시 스타일 */
.admin-sidebar > ul > li.active {
    background-color: #444;
}
/* 세부탭 */
.admin-sidebar li ul {
    display: none;
    list-style-type: none;
    padding: 0;
    margin: 0;
}
.admin-sidebar li ul li {
    padding: 10px 20px;
}
/* 세부탭 hover 효과 */
.admin-sidebar li ul li:hover {
    background-color: #555;
}
.sidebar .active > ul {
    display: block;
}
.admin-sidebar a {
    color: white;
    text-decoration: none;
}
.admin-sidebar li ul li a {
    display: block;
    width: 100%;
    height: 100%;
}
</style>
<script>
function toggleSubmenu(event) {
    const parentLi = event.currentTarget;
    // 모든 메인 탭의 active 클래스 제거
    document.querySelectorAll('.admin-sidebar > ul > li').forEach(item => {
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
    const menuItems = document.querySelectorAll('.admin-sidebar > ul > li');
    menuItems.forEach(function(item) {
        item.addEventListener('click', toggleSubmenu);
    });
});
</script>
</head>
<body>
<div class="admin-sidebar">
	<div class="logo">
        <a href="<c:url value='./adminMain'/>"> <img src="<c:url value='./resources/logo.png'/>" alt="Logo"></a>
    </div>
    
    <ul>
        <li>📋 프로젝트 관리
            <ul>
                <li>프로젝트 결재 목록</li>
            </ul>
        </li>
        <li>👥 사용자 관리
            <ul>
                <li>직원 목록</li>
                <li>직원 추가</li>
            </ul>
        </li>
        <li>📈 사용량 관리</li>
      	<a href="<c:url value='./adminMypage'/>"><li>⚙️ 부서 현황</li></a>
    </ul>
</div>
</body>
</html>