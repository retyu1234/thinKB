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
<title>직원관리</title>
<style>
.container {
    display: flex;
}
.employee-content {
	padding: 20px;
	width: 65%;
	margin : 0% 10% 6% 20%;
	flex: 1;
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
	background-color: #AB9A80;
	color:white;
	border-radius : 5px;
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
        .employee-pagination {
            display: flex;
            justify-content: center;
            margin-top: 2%;
        }

        .employee-pagination-list {
            list-style-type: none;
            padding: 0;
            display: flex;
        }

        .employee-pagination-item {
            margin: 0 5px;
        }

        .employee-pagination-link {
            text-decoration: none;
            padding: 5px 10px;
            border: none;
            color: #333;
            border-radius: 3px;
            transition: background-color 0.3s;
        }

        .employee-pagination-link:hover {
            background-color: #f0f0f0;
            border-radius: 30px;
        }

        .employee-pagination-item.active .employee-pagination-link {
            background-color: #ffcc00;
            color: white;
            border-radius: 30px;
        }
        .employee-sort-icon {
            margin-left: 5px;
            cursor: pointer;
            display: inline-block;
            vertical-align: middle;
        }

        .employee-sort-icon i {
            color: #ccc;
        }

        .employee-sort-icon i.active {
            color: #ffcc00;
        }

        .employee-header-item {
            display: flex;
            align-items: center;
            justify-content: center;
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
       <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.employee-sort-icon').click(function() {
                var sortBy = $(this).data('sort');
                var currentOrder = $(this).data('order') || 'none';
                var newOrder = currentOrder === 'asc' ? 'desc' : 'asc';

                // 모든 아이콘 초기화
                $('.employee-sort-icon i').removeClass('active');
                
                // 클릭된 아이콘 활성화
                $(this).find('i').addClass('active');
                
                // 정렬 순서 저장
                $(this).data('order', newOrder);

                // 직원 목록 정렬
                var $employees = $('.employee-item').get();
                $employees.sort(function(a, b) {
                    var aValue = $(a).find('.employee-info[data-' + sortBy + ']').text().trim();
                    var bValue = $(b).find('.employee-info[data-' + sortBy + ']').text().trim();
                    
                    if (sortBy === 'totalContribution') {
                        aValue = parseInt(aValue) || 0;
                        bValue = parseInt(bValue) || 0;
                        return newOrder === 'asc' ? aValue - bValue : bValue - aValue;
                    } else if (sortBy === 'userName') {
                        return newOrder === 'asc' ? 
                            aValue.localeCompare(bValue, 'ko') : 
                            bValue.localeCompare(aValue, 'ko');
                    }
                });

                // 정렬된 목록을 다시 삽입
                $('.employee-list').empty().append($employees);
            });
        });
    </script>
</head>
<body>
<div class="container">
	
	<%@ include file="../adminSideBar.jsp"%>
	<div class="employee-content">
		<div class="employee-title">직원조회</div>
		<div class="add-btn">
			<a href="./addUserView?departmentId=${departmentId}"><button
					class="add-employee-button">직원 추가</button></a>
		</div><hr style="margin-bottom:2%;"/>
		<form action="./userAdminView" method="get"
			class="employee-search-form">
			<div class="input-group">
				<input type="text" class="employee-search-input" name="searchTerm"
					value="${param.searchTerm}" placeholder="이름/팀명으로 검색하세요..">
				<div class="input-group-append">
					<button class="employee-search-button" type="submit">
						<i class="fa fa-search"></i>
					</button>
				</div>
			</div>
		</form>

		<div class="employee-list-container">
			<div class="employee-list-header">
				<div class="employee-header-item">팀</div>
				<div class="employee-header-item">직원명
				                                <span class="employee-sort-icon" data-sort="userName">
                    <i class="fas fa-sort"></i>
                </span></div>
				<div class="employee-header-item">직원번호</div>
				<div class="employee-header-item">생일</div>
				<div class="employee-header-item">이메일</div>
				<div class="employee-header-item">기여도 점수
               <span class="employee-sort-icon" data-sort="totalContribution">
                    <i class="fas fa-sort"></i>
                </span></div>
				<div class="employee-header-item">삭제</div>
			</div>
			<div class="employee-list">
				<c:forEach var="employee" items="${userList}">
                <c:choose>
                    <c:when test="${employee.isDelete == null ? false : !employee.isDelete && employee.userId != 1}">
                        <div class="employee-item">
                            <div class="employee-info" data-teamName="${employee.teamName}">${employee.teamName}</div>
                            <div class="employee-info" data-userName="${employee.userName}">${employee.userName}</div>
                            <div class="employee-info" data-userId="${employee.userId}">${employee.userId}</div>
                            <div class="employee-info" data-birth="${employee.birth}">${employee.birth}</div>
                            <div class="employee-info" data-email="${employee.email}">${employee.email}</div>
                            <div class="employee-info" data-totalContribution="${employee.totalContribution}">${employee.totalContribution}</div>
                            <div class="employee-info">
                                <button class="employee-delete-button" onclick="deleteEmployee(${employee.userId})">삭제</button>
                            </div>
                        </div>
                    </c:when>
                </c:choose>
				</c:forEach>
			</div>
			<div style="margin-top:2%;justify-content:center; display:flex;">
<div class="employee-pagination">
        <nav>
            <ul class="employee-pagination-list">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="employee-pagination-item ${i == currentPage ? 'active' : ''}">
                        <a class="employee-pagination-link" href="./userAdminView?searchTerm=${param.searchTerm}&page=${i}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div></div>
			<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

		</div>
	</div>
	</div>
</body>
</html>
