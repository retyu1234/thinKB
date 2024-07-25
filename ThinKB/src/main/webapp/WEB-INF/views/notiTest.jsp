<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>실시간 알림</title>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>
    <h1>실시간 알림 예제</h1>
    <div id="notificationContainer"></div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        var currentUserId = ${sessionScope.userId};
        
        $.ajaxSetup({
            beforeSend: function(xhr) {
                var token = $("meta[name='_csrf']").attr("content");
                var header = $("meta[name='_csrf_header']").attr("content");
                if (token && header) {
                    xhr.setRequestHeader(header, token);
                }
            }
        });

        function checkNotifications() {
            var lastCheckTime = localStorage.getItem('lastCheckTime') || 0;
            
            $.ajax({
                url: '<c:url value="/notifications"/>',
                method: 'GET',
                data: {
                    userId: currentUserId,
                    lastCheckTime: lastCheckTime
                },
                dataType: 'json',  // JSON으로 응답을 기대
                success: function(response) {
                    var notifications = response.notifications;
                    if (notifications && notifications.length > 0) {
                        displayNotifications(notifications);
                        localStorage.setItem('lastCheckTime', Date.now());
                    }
                },
                error: function(xhr, status, error) {
                    console.error("알림을 가져오는 중 오류 발생:", error);
                    console.error("상태:", status);
                    console.error("XHR 객체:", xhr);
                    if (xhr.responseText) {
                        console.error("응답 텍스트:", xhr.responseText);
                    } else {
                        console.error("응답이 없습니다.");
                    }
                },
                complete: function() {
                    setTimeout(checkNotifications, 5000);
                }
            });

        }

        function displayNotifications(notifications) {
            var container = $('#notificationContainer');
            notifications.forEach(function(notification) {
                var notificationElement = $('<div class="notification"></div>');
                notificationElement.text(notification.message);
                container.prepend(notificationElement);
            });
            $('.notification:gt(4)').remove();
        }

        $(document).ready(function() {
            checkNotifications();
        });
    </script>
</body>
</html>