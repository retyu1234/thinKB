<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<title>직원관리</title>
<style>
.userAdmin-body {
	margin: 0;
	padding: 0;
	background-image:
		url('${pageContext.request.contextPath}/resources/aguu.jpg');
	background-size: cover; /* 이미지가 요소에 완전히 맞도록 비율을 조정 */
	background-position: center; /* 이미지를 가운데 정렬 */
	background-repeat: no-repeat;
	height: 400px; /* 요소의 높이를 400px로 고정 */
}

.employee-content {
	padding: 20px;
	max-width: 1200px;
	margin: 0 auto;
}

.employee-title {
	font-size: 30px;
	font-weight: bold;
	margin-top: 30px;
}

.employee-search-form {
	margin-bottom: 30px;
}

.input-group {
	position: relative;
	display: flex;
}

.input-group input {
	width: 100%;
	border-radius: 15px;
}

.input-group button {
	position: absolute;
	top: 5px;
	bottom: 5px;
	right: 5px;
	border-radius: 15px;
}

.employee-search-input {
	flex: 1; /* 화면 가로에 꽉 차도록 설정 (여백 20px 고려) */
	padding: 12px; /* 내부 여백 설정 */
	border: 3px solid #666; /* 테두리 두께와 색상 설정 */
	border-radius: 8px; /* 테두리 둥글기 설정 */
	transition: border-color 0.3s ease; /* 테두리 색 변화에 대한 transition 설정 */
	/* 기본 테두리 색상 */
	border-color: #666;
	font-size: 16px; /* 글자 크기 설정 */
}

.employee-search-input:focus {
	border-color: #ffcc00;
	outline: none;
}

.employee-search-button {
	background: none;
	border: none;
	font-size: 20px;
	color: #666;
	cursor: pointer;
}

.employee-list-container {
	overflow-x: auto;
}

.employee-list-header, .employee-item {
	display: flex;
	align-items: center;
	padding: 10px 0;
}

.employee-list-header {
	background-color: #f0f0f0;
	font-weight: bold;
	border-bottom: 2px solid #ddd;
	margin-bottom: 20px;
}

.employee-header-item, .employee-info {
	flex: 1;
	padding: 0 10px;
	text-align: center;
}

.employee-list {
	border: none;
}

.employee-item {
	border: 1px solid #ddd;
	margin-bottom: 5px; /* 여기서 간격 조정 */
	display: flex; /* 아이템을 가로로 정렬 */
	align-items: center; /* 세로 정렬 */
	padding: 10px;
	border-radius: 8px; /* 모서리 둥글게 */
}

.employee-delete-button {
	padding: 5px 10px;
	background-color: #ff4d4d;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.employee-delete-button:hover {
	background-color: #ff1a1a;
}

.add-employee-button {
	padding: 10px 20px;
	background-color: #ffcc00;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	font-weight: bold;
	margin-bottom: 20px;
	transition: background-color 0.3s;
}

.add-employee-button:hover {
	background-color: #ffcd50;
}

.add-btn {
	display: flex;
	justify-content: flex-end;
}
</style>
<script>
    function deleteEmployee(userId) {
        var confirmation = confirm("정말로 이 직원을 삭제하시겠습니까?");
        if (confirmation) {
            // 지정한 경로로 이동 (예: /deleteEmployee 경로로 이동)
            window.location.href = './deleteEmployee?userId=' + userId;
        }
    }
</script>
</head>
<body>
	<div class="userAdmin-body">
		<%@ include file="../headerAdmin.jsp"%>
	</div>
	<div class="employee-content">
		<div class="employee-title">직원조회</div>
		<div class="add-btn">
			<a href="./addUserView?departmentId=${departmentId}"><button
					class="add-employee-button">직원 추가</button></a>
		</div>
		<form action="./userAdminView" method="get"
			class="employee-search-form">
			<div class="input-group">
				<input type="text" class="employee-search-input" name="searchTerm"
					value="${param.searchTerm}" placeholder="여기에 입력하세요">
				<div class="input-group-append">
					<button class="employee-search-button" type="submit">
						<i class="fa fa-search"></i>
					</button>
				</div>
			</div>
		</form>

		<div class="employee-list-container">
			<div class="employee-list-header">
				<div class="employee-header-item">직원명</div>
				<div class="employee-header-item">직원번호</div>
				<div class="employee-header-item">부서</div>
				<div class="employee-header-item">팀</div>
				<div class="employee-header-item">이메일</div>
				<div class="employee-header-item">삭제</div>
			</div>
			<div class="employee-list">
				<c:forEach var="employee" items="${userList}">
					<c:choose>
						<c:when
							test="${employee.isDelete == null ? false : !employee.isDelete && employee.userId != 1}">
							<div class="employee-item">
								<div class="employee-info">${employee.userName}</div>
								<div class="employee-info">${employee.userId}</div>
								<div class="employee-info">${employee.departmentName}</div>
								<div class="employee-info">${employee.teamName}</div>
								<div class="employee-info">${employee.email}</div>
								<div class="employee-info">
									<button class="employee-delete-button"
										onclick="deleteEmployee(${employee.userId})">삭제</button>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<!-- Do nothing or provide some default behavior -->
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
            <nav>
                <ul class="pagination justify-content-center">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="./userAdminView?searchTerm=${param.searchTerm}&page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
			<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
			<script
				src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
		</div>
	</div>
</body>
</html>
