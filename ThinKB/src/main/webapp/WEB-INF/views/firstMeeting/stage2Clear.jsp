<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디어 투표 결과</title>
<style>
    table {
        width: 70%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
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
    }
    .rank-2 {
        color: silver;
    }
    .rank-3 {
        color: #cd7f32;
    }
</style>
</head>
<body>
<h1>아이디어 투표결과</h1>
<h3>1, 2위 아이디어만 추가 의견 받기가 가능합니다.</h3>
<div>
    <table>
        <tr>
            <th>순위</th>
            <th>아이디어 제목</th>
            <th>득표수</th>
        </tr>
        <c:forEach var="idea" items="${list}" varStatus="status">
            <tr>
                <td class="rank-${status.index + 1}">
                    <c:choose>
                        <c:when test="${status.index + 1 <= 2}">
                            ${status.index + 1}
                        </c:when>
                        <c:otherwise>
                            -
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${idea.getTitle()}</td>
                <td>${idea.getPickNum()}</td>
            </tr>
        </c:forEach>
    </table>
    
    <form action="./goStage3" id="goStage3Form" method="post">
				<input type="hidden" name="roomId" value="${roomId}">
				<input type="hidden" name="stage" value="${stage}">
				<input type="hidden" name="firstIdeaId" value="${list[0].getIdeaID()}">
				<input type="hidden" name="secondIdeaId" value="${list[1].getIdeaID()}">
				<h2 style="text-align: left; margin-top:50px;">의견 받기 타이머 설정</h2>
				<div>
					<input type="number" class="timer-input" name="timer_hours" min="0"
						max="23" placeholder="HH">&nbsp;시&nbsp;&nbsp;&nbsp; <input
						type="number" class="timer-input" name="timer_minutes" min="0"
						max="59" placeholder="MM">&nbsp;분&nbsp;&nbsp;&nbsp; <input
						type="number" class="timer-input" name="timer_seconds" min="0"
						max="59" placeholder="SS">&nbsp;초&nbsp;&nbsp;&nbsp; <span
						class="error-message" id="timerError"></span>
				</div>
				
				<button type="submit" class="button">투표하기</button>
			</form>
</div>

<script>
document.getElementById('goStage3Form').addEventListener('submit', function(e) {
    e.preventDefault();

    var timerHours = this.querySelector('input[name="timer_hours"]').value;
    var timerMinutes = this.querySelector('input[name="timer_minutes"]').value;
    var timerSeconds = this.querySelector('input[name="timer_seconds"]').value;
    
    if (timerHours === "" && timerMinutes === "" && timerSeconds === "") {
        alert('타이머 설정을 위해 최소한 하나의 시간 단위를 입력해주세요.');
        
        // 입력 필드 강조
        this.querySelectorAll('input[type="number"]').forEach(function(input) {
            input.style.border = "2px solid red";
        });
    } else {
        // 정상 상태로 복원
        this.querySelectorAll('input[type="number"]').forEach(function(input) {
            input.style.border = "";
        });
        
        // 모든 조건이 만족되면 폼을 수동으로 제출합니다.
        this.submit();
    }
});
</script>
</body>
</html>