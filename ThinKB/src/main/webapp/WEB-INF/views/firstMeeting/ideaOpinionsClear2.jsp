<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보고서 작성 설정</title>
<style>
.content-container {
	padding: 20px;
	margin-left: 15%;
	margin-right: 15%;
	position: relative;
	z-index: 2;
}

body {
    padding-top: 100px;
}

table {
	width: 70%;
	margin-left: auto;
    margin-right: auto;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
	font-weight: bold;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

tr:hover {
	background-color: #f5f5f5;
}

.rank-1, .rank-2, .rank-3 {
	font-weight: bold;
}

.rank-1 {
	color: gold;
	font-weight: bold;
	font-size: 13pt;
}

.rank-2 {
	color: silver;
	font-weight: bold;
	font-size: 13pt;
}

.timer-container {
	margin-top: 30px;
	display: flex;
	align-items: center;
}

.timer-label {
	margin-right: 10px;
	font-size: 20px;
	font-weight: bold;
}

.button {
	background-color: #4CAF50;
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
}
</style>

</head>
<body>
	<%@ include file="../header.jsp"%>
	
	<c:if test="${userId == meetingRoom.roomManagerId}">
	<%@ include file="../sideBar.jsp"%></c:if>

	<div class="content-container">
		<h1>보고서 작성 설정</h1>

			<form action="./goStage5" id="goStage5" method="post">
				<input type="hidden" name="roomId" value="${roomId}">
				<input type="hidden" name="ideaId" value="${ideaId}"> 
				
				<h2 style="text-align: left; margin-top: 50px;">아이디어 목록</h2>
	            <table>
	                <tr>
	                    <th>아이디어 제목</th>
	                    <th>2차의견 완료 여부</th>
	                </tr>
	                <c:forEach items="${ideasInfo}" var="idea"> <!-- Ideas -->
	                    <tr>
	                        <td>${idea.title}</td>
	                        <td>
	                            <c:choose>
	                                <c:when test="${idea.stageID == 5}">완료</c:when>
	                                <c:when test="${idea.stageID == 4}">진행중</c:when>
	                            </c:choose>
	                        </td>
	                    </tr>
	                </c:forEach>
	            </table>
				
				<div style="text-align: center;">
					<button type="submit" class="button">보고서 작성하러가기</button>
				</div>
			</form>
	</div>

<script>
document.getElementById('goStage5').addEventListener('submit', function(e) {
    e.preventDefault();
    
 	// 모든 아이디어의 진행 상태 확인
    var allCompleted = true;
    var ideaStatuses = document.querySelectorAll('table tr td:nth-child(2)');
    
    ideaStatuses.forEach(function(status) {
        if (status.textContent.trim() === '진행중') {
            allCompleted = false;
        }
    });

    if (allCompleted) {
        // 모든 아이디어가 완료 상태일 때
        var roomId = this.querySelector('input[name="roomId"]').value;
        var ideaId = this.querySelector('input[name="ideaId"]').value;
        // var url = this.action; // URL 설정
        var url = this.action + '?roomId=' + roomId + '&ideaId=' + ideaId; // URL 설정
        window.location.href = url; // URL로 이동
    } else {
        // 하나라도 진행 중인 아이디어가 있을 때
        alert("아직 진행이 완료되지 않은 아이디어가 있습니다.");
    }
});
</script>
	
</body>
</html>

