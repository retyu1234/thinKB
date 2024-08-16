<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
.admin-sidebar {
	font-family: KB금융 제목체 Light;
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
	height: 50px;
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
.admin-sidebar>ul>li>span:hover, .admin-sidebar>ul>li>a:hover,
	.admin-sidebar li ul li:hover {
	background-color: #3a3a3a;
}

/* 추가로, 메인 메뉴 항목과 서브 메뉴 항목에 패딩을 개별적으로 적용합니다 */
.admin-sidebar>ul>li>span, .admin-sidebar>ul>li>a {
	display: block;
	padding: 10px 20px;
}

.admin-sidebar>ul>li {
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

.admin-sidebar>ul>li>span {
	display: block;
	padding: 10px 15px;
	font-weight: bold;
	cursor: pointer;
}

/* 링크 스타일 (서브 메뉴 항목 및 직접 이동 메뉴) */
.admin-sidebar li ul li a, .admin-sidebar>ul>li>a {
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
.admin-sidebar>ul>li>span:hover, .admin-sidebar li ul li a:hover,
	.admin-sidebar>ul>li>a:hover {
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
	font-family: KB금융 본문체 Light;
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

.admin-sidebar li.active>a, .admin-sidebar li.active>span {
	background-color: #3a3a3a;
	border-left: 4px solid #007bff;
}

.admin-sidebar li.active>a:hover, .admin-sidebar li.active>span:hover {
	background-color: #4a4a4a;
}

/* 새로운 스타일 추가 */
.admin-controls {
	position: absolute;
	bottom: 13%;
	left: 0;
	right: 0;
	padding: 14px;
	background-color: #333;
	display: flex;
	flex-direction: column;
	align-items: center;
	font-size: 11pt;
	font-family: KB 본문체 bold;
}

.admin-controls button {
	background-color: transparent;
	color: white;
	border: none;
	padding: 10px;
	margin-bottom: 10px;
	cursor: pointer;
	display: flex;
	align-items: center;
	width: 100%;
	font-size: 12pt;
	font-family: KB금융 제목체 Light;
	font-weight: bold;
}

.admin-controls button:hover {
	background-color: #444;
}

.admin-controls button i {
	margin-right: 10px;
}
</style>
<script>
	// 현재 페이지 URL에서 페이지 이름 추출
	function getCurrentPage() {
		var path = window.location.pathname;
		var page = path.split("/").pop().split(".")[0];
		return page || "adminMain"; // 기본값으로 adminMain 설정
	}

	// 페이지 로드 시 실행
	document.addEventListener("DOMContentLoaded", function() {
		var currentPage = getCurrentPage();
		var menuItems = document.querySelectorAll('.menu-item');

		menuItems.forEach(function(item) {
			if (item.getAttribute('data-page') === currentPage) {
				item.parentElement.classList.add('active');
				var parentLi = item.closest('li');
				if (parentLi.parentElement.tagName === 'UL') {
					parentLi.parentElement.parentElement.classList
							.add('active');
				}
			}
		});
	});
	function logout() {
		// 여기에 로그아웃 로직을 구현하세요
		window.location.href = './logout';
		alert('로그아웃 되었습니다.');
		// 실제로는 서버에 로그아웃 요청을 보내고 리다이렉트하는 로직이 필요합니다.
	}
</script>
</head>
<body>
	<div class="admin-sidebar">
		<div class="admin-logo">
			<a href="<c:url value='./adminMain'/>"> <img
				src="<c:url value='./resources/logo-white.png'/>" alt="Linweb">
			</a>
		</div>
		<ul>
			<li><span class="admin-icon">PJ</span>프로젝트 관리
				<ul>
					<li><a href="./departmentReportList" class="menu-item"
						data-page="departmentReportList">프로젝트 조회</a></li>
					<li><a href="./departmentReportList2" class="menu-item"
						data-page="departmentReportList2">프로젝트 결재</a></li>
				</ul></li>
			<li><span class="admin-icon">📁</span>사용자 관리
				<ul>
					<li><a href="./userAdminView" class="menu-item"
						data-page="userAdminView">직원 조회</a></li>

					<li><a href="./addUserView?departmentId=${departmentId}">직원
							추가</a></li>
				</ul></li>
			<!--        <li><span class="admin-icon">📊</span>사용량 관리</li> -->
			<li><a href="<c:url value='./adminMypage'/>" class="menu-item"
				data-page="adminMypage"><span class="admin-icon">⚙️</span>부서 현황</a>
			</li>
			</li>
		</ul>
		<div class="admin-controls">
			<button onclick="logout()">
				<i class="fas fa-sign-out-alt"></i> 로그아웃
			</button>
		</div>
		<div class="admin-sidebar-footer">
			<p>© 2024 ThinKB Admin</p>
			<p>버전 1.0.0</p>
			<p>
				<a href="#">도움말</a>
			</p>
			<p>
				<a href="#">문의하기</a>
			</p>
		</div>
	</div>
</body>
</html>