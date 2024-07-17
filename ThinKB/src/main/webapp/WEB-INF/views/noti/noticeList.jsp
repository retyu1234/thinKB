<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Notification Panel</title>
<style>
.noticeListBody {
	padding: 20px;
	font-family: Arial, sans-serif;
	width: 60%;
	margin: 0 auto; /* 가운데 정렬을 위한 설정 */
	margin-top: 120px;
}

.notification-container {
	margin-bottom: 20px;
}

.noticeListheader {
	display: flex;
	align-items: center;
	justify-content: space-between;
	background-color: #ffeb3b;
	padding: 20px; /* 패딩 두께 증가 */
	border-radius: 5px;
	font-size: 1.2em; /* 글자 크기 증가 */
}

.noticeListheader img {
	width: 32px; /* 이미지 크기 증가 */
	height: 32px; /* 이미지 크기 증가 */
}

.noticeListheader .user {
	font-weight: bold;
}

.tabs {
	display: flex;
	margin-top: 15px;
}

.tab {
	padding: 15px 30px; /* 탭 두께 증가 */
	cursor: pointer;
	font-size: 1.2em; /* 글자 크기 증가 */
	/* background-color: #f0f0f0; /* 기본 탭 색상 */ */
	margin-right: 5px; /* 탭 간격 */
	border-radius: 5px;
	/* border: 1px solid #ddd; */
	transition: background-color 0.3s;
}

.tab:hover {
	background-color: #e0e0e0; /* 마우스 오버 시 색상 */
}

.tab.active {
	background-color: #ffeb3b; /* 클릭된 탭 색상 */
	border: 1px solid #ccc;
	border-bottom: 3px solid #ffeb3b; /* 클릭된 탭에 밑줄 */
	padding-bottom: 12px; /* 밑줄과 텍스트 사이의 간격 조정 */
}

.notification-list {
	margin-top: 10px;
}

.notification {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 20px; /* 패딩 두께 증가 */
	margin-bottom: 10px;
	border-radius: 5px;
	background-color: #d3d3d3;;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
	font-size: 1.1em; /* 글자 크기 증가 */
}

.notification.unread {
	background-color: #fffde7;
}

.notification-content {
	display: flex;
	flex-direction: column;
}

.notification-footer {
	display: flex;
	align-items: center;
}

.notification-footer .date {
	margin-right: 10px;
}

.notification-footer .delete {
	cursor: pointer;
	color: red;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        function formatTimestamp(timestamp) {
            const date = new Date(timestamp);
            const year = date.getFullYear();
            const month = ("0" + (date.getMonth() + 1)).slice(-2);
            const day = ("0" + date.getDate()).slice(-2);
            return `${year}.${month}.${day}`;
        }

        $('.tab').click(function() {
            $('.tab').removeClass('active');
            $(this).addClass('active');

            if ($(this).attr('id') === 'unreadTab') {
                $('#allNotifications').addClass('hidden');
                $('#unreadNotifications').removeClass('hidden');
            } else {
                $('#unreadNotifications').addClass('hidden');
                $('#allNotifications').removeClass('hidden');
            }
        });

        // 포맷된 날짜를 표시하기 위해 createdAt 값을 변환
        $('.date').each(function() {
            const timestamp = $(this).text().trim();
            $(this).text(formatTimestamp(timestamp));
        });

        $(document).on('click', '.notification .delete', function() {
            const notificationId = $(this).data('id');
            $.ajax({
                url: `/deleteNotification/${notificationId}`,
                type: 'DELETE',
                success: function(result) {
                    location.reload(); // 페이지 새로고침으로 알림 목록 갱신
                }
            });
        });
    });
</script>
</head>
<body>
<%@ include file="../header.jsp"%>
<div class="noticeListBody">
    <div class="notification-container">
        <div class="noticeListheader">
            <div>
                <img src="./resources/bell.png" alt="알림">
            </div>
            <c:set var="userName" value="${sessionScope.userName}" />
            <div class="user">${userName}님</div> <!-- 세션의 userName 출력 -->
        </div>
        <div class="tabs">
            <div id="unreadTab" class="tab active">미확인</div>
            <div id="allTab" class="tab">전체</div>
        </div>
    </div>

    <div class="notification-list" id="unreadNotifications">
        <c:forEach var="notification" items="${notifications}">
            <c:if test="${!notification.read}">
                <div class="notification unread" data-id="${notification.notificationID}">
                    <div class="notification-content">
                        <c:forEach var="idea" items="${ideas}">
                            <c:if test="${idea.ideaID == notification.ideaID}">
                                <div class="title">${idea.title}</div>
                                <div>${notification.message}</div>
                                <div>회의방: ${idea.roomID}</div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="notification-footer">
                        <div class="date">${notification.createdAt}</div>
                        <div class="delete" data-id="${notification.notificationID}">x</div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
    <div class="notification-list hidden" id="allNotifications">
        <c:forEach var="notification" items="${notifications}">
            <div class="notification ${notification.read ? 'read' : 'unread'}" data-id="${notification.notificationID}">
                <div class="notification-content">
                    <c:forEach var="idea" items="${ideas}">
                        <c:if test="${idea.ideaID == notification.ideaID}">
                            <div class="title">${idea.title}</div>
                            <div>${notification.message}</div>
                            <div>회의방: ${idea.roomID}</div>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="notification-footer">
                    <div class="date">${notification.createdAt}</div>
                    <div class="delete" data-id="${notification.notificationID}">x</div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>

</body>
</html>