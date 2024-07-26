<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Page</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        @keyframes blink {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }

        #notificationIcon { 
            cursor: pointer;
            display: none;
        }

        #notificationIcon.blink {
            animation: blink 1s linear infinite;
        }

        #notificationDropdown { 
            display: none; 
            position: absolute; 
            background-color: #f9f9f9; 
            min-width: 160px; 
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); 
            z-index: 1; 
        }

        #notificationDropdown li { 
            padding: 12px 16px; 
        }
    </style>
    <script>
        $(document).ready(function() {
            function updateNotifications() {
                $.get("${pageContext.request.contextPath}/getUnreadNotifications", function(notifications) {
                    var count = notifications.length;
                    $("#notificationCount").text(count);
                    var notificationList = $("#notificationDropdown");
                    notificationList.empty();
                    notifications.forEach(function(notification) {
                        notificationList.append("<li>" + notification.message + "</li>");
                    });

                    // 알림이 있을 때 아이콘을 표시하고 반짝이게 함
                    if (count > 0) {
                        $("#notificationIcon").show().addClass('blink');
                    } else {
                        $("#notificationIcon").hide().removeClass('blink');
                    }
                });
            }

            setInterval(updateNotifications, 3000); // 3초마다 업데이트

            $("#notificationIcon").click(function() {
                $("#notificationDropdown").toggle();
                // 클릭 시 반짝임 효과 제거
                $(this).removeClass('blink');
            });
        });
    </script>
</head>
<body>
    <div id="notificationIcon">
        🔔 <span id="notificationCount">0</span>
    </div>
    <ul id="notificationDropdown">
    <h1>Notifications</h1>
    <div id="notificationList">
        <c:forEach items="${notifications}" var="notification">
            <li>${notification.message}</li>
        </c:forEach>
    </div></ul>

</body>
</html>