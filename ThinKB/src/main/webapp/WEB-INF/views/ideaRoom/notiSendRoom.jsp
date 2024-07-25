<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>알림 발송</title>
</head>
<body>
    <h1>알림 발송</h1>
    		<table>
			<thead>
				<tr>
					<th>참여자</th>
					<th>이메일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="member" items="${members}">
					<tr>
						<td>${member.userName}(${member.departmentName})-
							${member.teamName}</td>
						<td>${member.email}</td>
						
					</tr>
				</c:forEach>
			</tbody>
		</table>
    <form action="sendNotifications" method="post">
    
        <input type="hidden" name="roomId" value="${roomId}">
        <input type="hidden" name="selectedMembers" value="${selectedMembers}">

        <label for="message">알림 메시지:</label><br>
        <textarea id="message" name="message" rows="4" cols="50"></textarea><br><br>

        <button type="submit">발송</button>
    </form>
</body>
</html>