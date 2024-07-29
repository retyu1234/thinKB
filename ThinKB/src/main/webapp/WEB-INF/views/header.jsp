<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:requestEncoding value="UTF-8" />
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <style>
        .header {
            position: fixed;
            top: 30px;
            left: 50px;
            right: 50px;
            background: white;
            border-radius: 30px;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1000; /* 다른 요소들보다 위에 오도록 설정 */
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .logo img {
            height: 40px; /* 원하는 크기로 조정 */
        }

        .menu {
            display: flex;
            gap: 30px;
        }

        .menu a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
            margin: 0 10px;
        }

        .profile {
            display: flex;
            align-items: center;
        }

        .profile img {
            border-radius: 50%;
            width: 40px;
            height: 40px;
            margin-right: 10px;
        }

        .logout-icon {
            width: 24px;
            height: 24px;
            cursor: pointer;
            margin-left: 20px;
        }
    </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
@keyframes blink {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }

        @keyframes ring {
            0% { transform: rotate(0); }
            10% { transform: rotate(30deg); }
            20% { transform: rotate(-28deg); }
            30% { transform: rotate(34deg); }
            40% { transform: rotate(-32deg); }
            50% { transform: rotate(30deg); }
            60% { transform: rotate(-28deg); }
            70% { transform: rotate(34deg); }
            80% { transform: rotate(-32deg); }
            90% { transform: rotate(30deg); }
            100% { transform: rotate(0); }
        }
/* 알림 아이콘 및 카운트 */
#notificationIcon {
    cursor: pointer;
    display: inline-block;
    font-size: 23pt;
    position: relative;
    caret-color: transparent;
}

#notificationIcon .bell {
    display: inline-block;
}

#notificationIcon.blink .bell {
    animation: blink 1s linear infinite, ring 2s 1s ease-in-out infinite;
}

#notificationCount {
    position: absolute;
    bottom: -5px;
    right: -8px;
    background-color: red;
    color: white;
    border-radius: 50%;
    padding: 2px 6px;
    font-size: 12px;
    min-width: 7px;
    height: 18px;
    display: flex;
    align-items: center;
    justify-content: center;
    caret-color: transparent;
}

/* 드롭다운 메뉴 스타일 */
#notificationDropdown {
    display: none;
    position: absolute;
    right: 0;
    background-color: white;
    min-width: 300px;
    max-height: 300px;
    overflow-y: auto;
    box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
    z-index: 1;
    border-radius: 10px;
    padding: 10px;
}

#notificationDropdown ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

#notificationDropdown li {
    padding: 12px 16px;
    border-bottom: 1px solid #e0e0e0;
    list-style-type: none;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

#notificationDropdown li:last-child {
    border-bottom: none;
}

#notificationDropdown li:hover {
    background-color: #f1f1f1;
}

/* 전체 읽음 버튼 스타일 */
#readAllNotifications {
    width: 100%;
    padding: 10px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-bottom: 10px;
    transition: background-color 0.3s ease;
}

#readAllNotifications:hover {
    background-color: #45a049;
}

/* 모달 스타일 */
.modal {
    display: none;
    position: fixed;
    z-index: 1001;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0,0,0,0.4);
}

.modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 500px;
    border-radius: 10px;
}

.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

    </style>
<script>
    $(document).ready(function() {
        // 페이지 로드 즉시 알림 상태 복원
        restoreNotificationState();

        function restoreNotificationState() {
            var notificationData = sessionStorage.getItem('notificationData');
            if (notificationData) {
                updateNotificationUI(JSON.parse(notificationData));
            }
            // 초기 데이터 로드 (세션 스토리지에 데이터가 없는 경우)
            if (!notificationData) {
                initializeNotifications();
            }
        }

        function initializeNotifications() {
            $.get("${pageContext.request.contextPath}/getInitialNotifications", function(notifications) {
                updateNotificationUI(notifications);
                sessionStorage.setItem('notificationData', JSON.stringify(notifications));
            });
        }

        function updateNotifications() {
            $.get("${pageContext.request.contextPath}/getUnreadNotifications", function(notifications) {
                updateNotificationUI(notifications);
                // 세션 스토리지 업데이트
                sessionStorage.setItem('notificationData', JSON.stringify(notifications));
            });
        }

        function updateNotificationUI(notifications) {
            var count = notifications.length;
            $("#notificationCount").text(count);
            var notificationList = $("#notificationList");
            notificationList.empty();
            notifications.forEach(function(notification) {
                var listItem = $("<li>")
                    .attr("data-id", notification.notificationID)
                    .attr("data-room", notification.roomTitle)
                    .attr("data-message", notification.message)
                    .html("Room: " + notification.roomTitle);
                notificationList.append(listItem);
            });

            if (count > 0) {
                $("#notificationIcon").show().addClass('blink');
                $("#notificationCount").show();
            } else {
                $("#notificationIcon").removeClass('blink');
                $("#notificationCount").hide();
            }
        }

        $("#notificationIcon").click(function() {
            $("#notificationDropdown").toggle();
            $(this).removeClass('blink');
        });
        $("#readAllNotifications").click(function() {
            $.post("${pageContext.request.contextPath}/readAllNotifications", function(response) {
                if(response.success) {
                    updateNotifications();
                }
            });
        });
        $(document).on("click", "#notificationList li", function() {
            var notificationId = $(this).data("id");
            var roomTitle = $(this).data("room");
            var message = $(this).data("message");

            $("#modalRoomTitle").text("RoomTitle : "+roomTitle);
            $("#modalMessage").text(message);
            $("#notificationModal").show();

            $.post("${pageContext.request.contextPath}/readNotification", { notificationId: notificationId }, function(response) {
                if(response.success) {
                    updateNotifications();
                }
            });
        });

        $(".close").click(function() {
            $("#notificationModal").hide();
        });
        // 주기적 업데이트 (3초마다)
        setInterval(updateNotifications, 3000);

    });
</script>
</head>
<body>
    <header>
        <div class="header">
            <div class="logo">
                <a href="<c:url value='./main'/>"> <img src="<c:url value='./resources/logo1.png'/>" alt="Logo"> </a>
            </div>
            <div class="menu">
                <a href="./guide">사용가이드</a> 
                <a href="./meetingList">회의방</a> 
                <a href="./myReportList">내 보고서</a> 
                <a href="./noticeList">알림함</a> 
                <a href="#">마이페이지</a>
                <a href="./AorBList">A/B테스트</a> 
                <a href="./voteList">투표</a>
            </div>
            <div class="profile">
            <a href="<c:url value='./mypage'/>">
               <c:choose>
            <c:when test="${not empty profileImg}">
                <img src="<c:url value='./upload/${profileImg}'/>" alt="Profile Image">
            </c:when>
            <c:otherwise>
                <img src="<c:url value='./resources/profile1.png'/>" alt="Logo">
            </c:otherwise>
        </c:choose></a> ${userName} 님
            </div>
            <div>
                <div id="notificationIcon">
                    <span class="bell">🔔</span>
                    <span id="notificationCount">0</span>
                </div>
                <div id="notificationDropdown">
                 <button id="readAllNotifications">전체 읽음</button>
                    <ul id="notificationList">
                        <!-- 알림 내용이 여기에 동적으로 추가됩니다 -->
                    </ul>
                   
                </div>
            </div>
            <a href="<c:url value='/logout'/>"> <img src="<c:url value='/resources/logout.png'/>" alt="Logout Icon" class="logout-icon"> </a>
        </div>

    </header>
        <!-- 알림 상세 모달 -->
    <div id="notificationModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2 id="modalRoomTitle"></h2><hr>
            <h3>Noti Contents : </h3>
            <p id="modalMessage"></p>
        </div>
    </div>
</body>

</html>
