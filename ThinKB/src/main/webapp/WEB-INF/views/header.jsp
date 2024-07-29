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
                <a href="./pinList">핀메모(수정중)</a>
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
        🔔 <span id="notificationCount">0</span>
    </div>
    <ul id="notificationDropdown">
    <div id="notificationList">
        <c:forEach items="${notifications}" var="notification">
            <li>${notification.message}</li>
        </c:forEach>
    </div></ul>
            </div>
            <a href="<c:url value='/logout'/>"> <img src="<c:url value='/resources/logout.png'/>" alt="Logout Icon" class="logout-icon"> </a>
        </div>

    </header>
</body>

</html>
