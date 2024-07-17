<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ThinkKB</title>
<style>
        body {
            font-family: Arial, sans-serif;
        }

        .notification-container {
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 5px;
            overflow: hidden;
        }

        .tabs {
            display: flex;
        }

        .tab {
            flex: 1;
            padding: 10px;
            cursor: pointer;
            text-align: center;
            background-color: #f1f1f1;
            border-bottom: 2px solid transparent;
        }

        .tab.active {
            border-bottom: 2px solid #000;
        }

        .notification-list {
            max-height: 400px;
            overflow-y: auto;
        }

        .hidden {
            display: none;
        }

        .notification {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .notification.unread {
            background-color: #fff8d1;
        }

        .notification.read {
            background-color: #f9f9f9;
        }

        .notification .title {
            font-weight: bold;
        }

        .notification .date {
            font-size: 0.9em;
            color: #999;
        }

        .notification .delete {
            float: right;
            cursor: pointer;
            color: red;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            function renderNotifications(list, containerId) {
                const container = $(`#${containerId}`);
                container.empty();
                list.forEach(notification => {
                    const notificationElem = $(`
                        <div class="notification ${notification.isRead ? 'read' : 'unread'}">
                            <span class="title">${notification.message}</span>
                            <span class="date">${new Date(notification.createdAt).toLocaleString()}</span>
                            <span class="delete" data-id="${notification.notificationID}">x</span>
                        </div>
                    `);
                    container.append(notificationElem);
                });
            }

            $('#unreadTab').click(function() {
                $('#allTab').removeClass('active');
                $(this).addClass('active');
                $('#allNotifications').addClass('hidden');
                $('#unreadNotifications').removeClass('hidden');
            });

            $('#allTab').click(function() {
                $('#unreadTab').removeClass('active');
                $(this).addClass('active');
                $('#unreadNotifications').addClass('hidden');
                $('#allNotifications').removeClass('hidden');
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

            // 초기 알림 목록 렌더링
            const notifications = ${notifications};
            const unreadNotifications = notifications.filter(n => !n.isRead);
            renderNotifications(unreadNotifications, 'unreadNotifications');
            renderNotifications(notifications, 'allNotifications');
        });
    </script>
</head>
<body>
    <div class="notification-container">
        <div class="tabs">
            <button id="unreadTab" class="tab active">미확인</button>
            <button id="allTab" class="tab">전체</button>
        </div>
        <div class="notification-list" id="unreadNotifications">
            <c:forEach var="notification" items="${notifications}">
                <c:if test="${!notification.isRead}">
                    <div class="notification unread">
                        <span class="title">${notification.message}</span>
                        <span class="date">${notification.createdAt}</span>
                        <span class="delete" data-id="${notification.notificationID}">x</span>
                    </div>
                </c:if>
            </c:forEach>
        </div>
        <div class="notification-list hidden" id="allNotifications">
            <c:forEach var="notification" items="${notifications}">
                <div class="notification ${notification.isRead ? 'read' : 'unread'}">
                    <span class="title">${notification.message}</span>
                    <span class="date">${notification.createdAt}</span>
                    <span class="delete" data-id="${notification.notificationID}">x</span>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>