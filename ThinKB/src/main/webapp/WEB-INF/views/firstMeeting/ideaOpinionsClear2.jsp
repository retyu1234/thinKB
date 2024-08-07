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
	width: 70%;
	text-align: center; 
}
.ideaList {
	text-align: left; 
	margin-top: 50px;
	width: 70%;
	font-weight: bold;
	font-size: 18pt;
}

table {
	width: 70%;
	margin-left: auto;
    margin-right: auto;
    font-size: 13pt;
}

th, td {
	border: 1px solid #ddd;
	padding: 10px; /* padding을 사용하여 셀 내부의 여백을 추가 */
    height: 40px; /* 각 셀의 최소 높이를 50px로 설정 */
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

/* 보고서 작성하러 가기 버튼 */
.btn-write {
	background-color: #FFCC00;
	border: none;
	color: #000;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 13pt;
	margin: 4px 2px;
	cursor: pointer;
	text-align: center; 
	margin-top: 50px;"
	margin: 0 auto;
}
.btn-write:hover {
	background-color: #D4AA00;
}
</style>

</head>
<body style="margin: 0;">
	<div class="stage3-header">
		<%@ include file="../header.jsp"%>
	</div>
	<%@ include file="../leftSideBar.jsp"%>
	<%@ include file="../rightSideBar.jsp"%>

	<div class="content-container">

			<form action="./goStage5" id="goStage5" method="get">
				<input type="hidden" name="roomId" value="${roomId}">
				<input type="hidden" name="ideaId" value="${ideaId}"> 
				<input type="hidden" name="stage" value=5>
				
	            <table>
	           	 	<div class="ideaList" style="margin-left: 230px; margin-bottom: 30px;"> 아이디어 목록 - 완료여부</div>
	                <tr>
	                    <th>아이디어 제목</th>
	                    <th>2차의견 완료 여부</th>
	                </tr>
	                <c:forEach items="${ideasInfo}" var="idea"> <!-- Ideas -->
	                    <tr>
	                        <td>${idea.title}</td>
	                        <td>
	                             <c:choose>
							        <c:when test="${idea.stageID == 5}">
							            <span style="color: blue;">완료</span>
							        </c:when>
							        <c:when test="${idea.stageID == 4}">
							            <span style="color: red;">진행중</span>
							        </c:when>
							    </c:choose>
	                        </td>
	                    </tr>
	                </c:forEach>
	            </table>
				
				<div>
					<button type="submit" class="btn-write">보고서 작성하러가기</button>
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
        var stage = this.querySelector('input[name="stage"]').value;
        // var url = this.action; // URL 설정
        var url = this.action + '?roomId=' + roomId + '&ideaId=' + ideaId+ '&stage=' + stage; // URL 설정
        window.location.href = url; // URL로 이동
    } else {
        // 하나라도 진행 중인 아이디어가 있을 때
        alert("아직 진행이 완료되지 않은 아이디어가 있습니다.");
    }
});
</script>
	
</body>
</html>