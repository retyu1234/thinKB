<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notification Panel</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .notification-container {
            width: 360px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .noticeListheader {
            background-color: #fdd835;
            color: #fff;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .noticeListheader img {
            width: 24px;
            height: 24px;
        }

        .noticeListheader .user {
            font-size: 16px;
            font-weight: bold;
        }

        .tabs {
            display: flex;
            background-color: #f1f1f1;
        }

        .tab {
            flex: 1;
            padding: 10px;
            cursor: pointer;
            text-align: center;
            border-bottom: 2px solid transparent;
            transition: background-color 0.3s, border-bottom 0.3s;
        }

        .tab.active {
            background-color: #fff;
            border-bottom: 2px solid #fdd835;
            font-weight: bold;
        }

        .notification-list {
            max-height: 400px;
            overflow-y: auto;
        }

        .notification {
            padding: 15px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background-color 0.3s;
        }

        .notification.unread {
            background-color: #fff8d1;
        }

        .notification.read {
            background-color: #f9f9f9;
        }

        .notification .title {
            font-weight: bold;
            margin-bottom: 5px;
        }

        .notification .date {
            font-size: 0.8em;
            color: #888;
        }

        .notification .delete {
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

            $('.date').each(function() {
                const timestamp = $(this).text();
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
    <div class="notification-container">
        <div class="noticeListheader">
            <div>
                <a href="/your-target-url"><img src="./resources/bell.png" alt="알림"></a>
            </div>
            <c:set var="userName" value="${sessionScope.userName}" />
            <div class="user">${userName}님</div> <!-- 세션의 userName 출력 -->
        </div>
        <div class="tabs">
            <div id="unreadTab" class="tab active">미확인</div>
            <div id="allTab" class="tab">전체</div>
        </div>
        <div class="notification-list" id="unreadNotifications">
            <c:forEach var="notification" items="${notifications}">
                <c:if test="${!notification.read}">
                    <div class="notification unread">
                        <div>
                            <div class="title">${notification.message}</div>
                            <c:forEach var="idea" items="${ideas}">
                                <c:if test="${idea.ideaID == notification.ideaID}">
                                    <div>${idea.title}</div>
                                    <div>회의방: ${idea.roomID}</div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <div>
                            <div class="date">${notification.createdAt}</div>
                            <div class="delete" data-id="${notification.notificationID}">x</div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
        <div class="notification-list hidden" id="allNotifications">
            <c:forEach var="notification" items="${notifications}">
                <div class="notification ${notification.read ? 'read' : 'unread'}">
                    <div>
                        <div class="title">${notification.message}</div>
                        <c:forEach var="idea" items="${ideas}">
                            <c:if test="${idea.ideaID == notification.ideaID}">
                                <div>${idea.title}</div>
                                <div>회의방: ${idea.roomID}</div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div>
                        <div class="date">${notification.createdAt}</div>
                        <div class="delete" data-id="${notification.notificationID}">x</div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>