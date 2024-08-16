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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .header-container {
            top: 0;
            left: 0;
            z-index: 1000;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            font-family: KB금융 본문체 Light;
        }

        .header {
            width: 100%;
            padding: 10px 5%;
            top: 0;
            display: flex;
            background: #ffcc00;
            justify-content: space-between;
            align-items: center;
            box-sizing: border-box;
            z-index: 1000;
        }
body.modal-open {
    overflow: hidden;
}

        .logo {
            font-size: 24px;
            font-weight: bold;
            display: flex;
            align-items: center;
            padding: 10px 30px;
            height: auto;
            background-color: #ffffff;
            z-index: 1000;
        }

        .logo img {
            height: 40px;
        }

        .menu {
            flex: 1;
            display: flex;
            justify-content: center;
            gap: 50px;
        }

        .menu a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
            margin: 0 10px;
        }

        .right-section {
            display: flex;
            align-items: center;
            gap: 50px;
            margin-right: 7%;
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

        #scrollToTopBtn {
            position: fixed;
            bottom: 4%;
            right: 4%;
            background-color: #ffcc00;
            color: white;
            border: none;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            font-size: 24px;
            cursor: pointer;
            display: none;
            /* 기본적으로 숨기기 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }

        #scrollToTopBtn:hover {
            background-color: #D4AA00;
        }

        #guideBtn {
            position: fixed;
            bottom: 12%;
            right: 4%;
            background-color: #ffcc00;
            color: white;
            border: none;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }

        #guideBtn:hover {
            background-color: #D4AA00;
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
            min-width: 8px;
            height: 16px;
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
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            z-index: 1;
            border-radius: 10px;
            padding: 10px;
        }

        #notificationList {
            list-style-type: none;
            padding: 0;
            margin: 10px 0 0 0;
            max-height: 200px;
            overflow-y: auto;
        }

        #notificationList li {
            padding: 10px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
            transition: background-color 0.3s ease;
            overflow: hidden;
            /* 내용이 넘치지 않도록 */
        }

        #notificationList li .room-titleNoti {
            white-space: nowrap;
            /* 줄바꿈 방지 */
            overflow: hidden;
            /* 넘치는 텍스트 숨김 */
            text-overflow: ellipsis;
            /* 말줄임표 추가 */
            max-width: 300px;
            /* 최대 너비 설정 (필요에 따라 조정) */
            display: inline-block;
            /* 인라인 블록으로 설정 */
        }

        #notificationList li:last-child {
            border-bottom: none;
        }

        #notificationList li:hover {
            background-color: #f5f5f5;
        }

        /* 전체 읽음 버튼 스타일 */
        #readAllNotifications {
            width: 35%;
            padding: 3px 10px 3px;
            background-color: #FFCC00;
            color: white;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            margin-right: 10px;
            transition: background-color 0.3s ease;

        }

        #readAllNotifications:hover {
            background-color: #D4AA00;
        }
        
       /* 모달 내부 스크롤바 스타일링 */
.guide-content {
    overflow-y: scroll; /* 모달의 세로 스크롤바 활성화 */
    scrollbar-width: thin; /* 스크롤바 두께 */
    scrollbar-color: #888 #f1f1f1; /* 스크롤바 색상 */
    	overflow-x: hidden; /* 가로 스크롤 방지 */
}

/* 웹킷 브라우저용 스크롤바 스타일링 */
.guide-content::-webkit-scrollbar {
    width: 8px; /* 스크롤바 너비 */
}

.guide-content::-webkit-scrollbar-track {
    background: #f1f1f1; /* 스크롤바 트랙 배경 */
}

.guide-content::-webkit-scrollbar-thumb {
    background-color: #888; /* 스크롤바 색상 */
    border-radius: 10px; /* 스크롤바 모서리 둥글게 */
    border: 2px solid #f1f1f1; /* 스크롤바 주변 테두리 */
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
            background-color: rgba(0, 0, 0, 0.4);
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

        #guide-modal-content {
            margin: 5% auto;
            width: 100%;
            padding: 10px;
            max-width: 1000px;
            height: auto;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .guide-modal-header {
            display: flex;
            justify-content: flex-end;
            /* 오른쪽 정렬 */
            align-items: center;
            padding: 10px;
        }

        .guideClose {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            margin-right: 20px;
            /* 여기에서만 오른쪽 마진을 추가 */
            margin-top: 20px;
        }

        .close:hover,
        .close:focus,
        .guideClose:hover,
        .guideClose:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
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
                $.get("${pageContext.request.contextPath}/getInitialNotifications", function (notifications) {
                    updateNotificationUI(notifications);
                    sessionStorage.setItem('notificationData', JSON.stringify(notifications));
                });
            }

            function updateNotifications() {
                $.get("${pageContext.request.contextPath}/getUnreadNotifications", function (notifications) {
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
                notifications.forEach(function (notification) {
                    var createdAt = new Date(notification.createdAt).toLocaleString();
                    var listItem = $("<li>")
                        .attr("data-id", notification.notificationID)
                        .attr("data-room", notification.roomTitle)
                        .attr("data-message", notification.message)
                        .attr("data-time", createdAt)
                        .html("🏠 : <span class='room-titleNoti'>" + notification.roomTitle + "</span><br>⏰ : " + createdAt);
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

            $("#notificationIcon").click(function () {
                $("#notificationDropdown").toggle();
                $(this).removeClass('blink');
            });
            $("#readAllNotifications").click(function () {
                $.post("${pageContext.request.contextPath}/readAllNotifications", function (response) {
                    if (response.success) {
                        updateNotifications();
                    }
                });
            });
            $(document).on("click", "#notificationList li", function () {
                var notificationId = $(this).data("id");
                var roomTitle = $(this).data("room");
                var message = $(this).data("message");
                var createdTime = $(this).data("time");  // 시간 정보 가져오기

                $("#modalRoomTitle").text("RoomTitle : " + roomTitle);
                $("#modalMessage").text(message);
                $("#modalTime").text("Created at: " + createdTime);  // 모달에 시간 표시
                $("#notificationModal").show();

                $.post("${pageContext.request.contextPath}/readNotification", { notificationId: notificationId }, function (response) {
                    if (response.success) {
                        updateNotifications();
                    }
                });
            });

            $(".close").click(function () {
                $("#notificationModal").hide();
            });
            // 주기적 업데이트 (3초마다)
            setInterval(updateNotifications, 5000);
            // 스크롤 이벤트 리스너 추가
            $(window).scroll(function () {
                if ($(this).scrollTop() > 100) {
                    $("#scrollToTopBtn").fadeIn();
                } else {
                    $("#scrollToTopBtn").fadeOut();
                }
            });

            // 위로 가기 버튼 클릭 이벤트 리스너 추가
            $("#scrollToTopBtn").click(function () {
                $("html, body").animate({ scrollTop: 0 }, "slow");
                return false;
            });

            // 가이드 버튼 클릭 시 가이드 모달 표시
            $("#guideBtn").click(function () {
                $.ajax({
                    url: "${pageContext.request.contextPath}/guide", // guide.jsp 파일의 경로
                    method: "GET",
                    dataType: "html",
                    success: function (data) {
                        // 가이드 모달의 내용에 guide.jsp의 내용을 삽입
                        $("#guideContent").html(data);
                        // 모달을 표시
                        $("#guideModal").show();
                    },
                    error: function () {
                        // 에러 발생 시 메시지 표시
                        $("#guideContent").html("<p>Failed to load guide content.</p>");
                        $("#guideModal").show();
                    }
                });
            });

            $(".guideClose").click(function () {
                $("#guideModal").hide();
            });
        });
    </script>
</head>

<body style="margin:0;">
    <header>
        <div class="header-container">
            <div class="logo">
                <a href="<c:url value='./main'/>"> <img src="<c:url value='./resources/logo1.png'/>" alt="Logo"> </a>
            </div>
            <div class="header">

                <div class="menu">
                    <a href="./meetingList">회의방</a>
                    <a href="./myReportList">내 보고서</a>
                    <a href="./noticeList">알림함</a>
                    <a href="./AorBList">A/B테스트</a>
                    <a href="./voteList">투표</a>
                    <a href="./pinList">핀메모</a>
                </div>
                <div class="right-section">
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
                            <span class="bell">📬</span>
                            <span id="notificationCount">0</span>
                        </div>
                        <div id="notificationDropdown">
                            <div style="display:flex; justify-content:space-between;">
                                <h3 style="margin:5px;">알림함</h3>
                                <button id="readAllNotifications">
                                    <i class="fas fa-check-double"></i> 전체 읽음
                                </button>
                            </div>
                            <hr>
                            <ul id="notificationList">
                                <!-- 알림 내용이 여기에 동적으로 추가됩니다 -->
                            </ul>
                        </div>
                    </div>
                    <a href="<c:url value='/logout'/>"> <img src="<c:url value='/resources/logout.png'/>" alt="Logout Icon" class="logout-icon"> </a>
                </div>
            </div>
        </div>
    </header>
    <!-- 알림 상세 모달 -->
    <div id="notificationModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2 id="modalRoomTitle"></h2>
            <p id="modalTime"></p>
            <hr>
            <h3>Noti Contents : </h3>
            <p id="modalMessage"></p>
        </div>
    </div>
    <button id="scrollToTopBtn">▲</button>

    <!-- 가이드 모달 -->
    <div id="guideModal" class="modal" style="flex-direction:column;">
        <div class="modal-content" id="guide-modal-content">
            <div class="guide-modal-header">
                <span class="guideClose">&times;</span>
            </div>
            <p id="guideContent"></p>
        </div>
    </div>
    <button id="guideBtn">?</button>

    <script>
        $(document).ready(function () {
            // 모달의 스크롤 이벤트 감지
            $("#guideModal").on('scroll', function () {
                checkScroll(); // 스크롤할 때마다 체크
            });

            // 모달이 열릴 때 초기 체크
            $("#guideModal").on('show.bs.modal', function () {
                checkScroll(); // 모달이 열릴 때 초기 체크
            });

            function checkScroll() {
                const guideItems = document.querySelectorAll('.guide-item');

                guideItems.forEach((item, index) => {
                    const rect = item.getBoundingClientRect();
                    const viewHeight = window.innerHeight || document.documentElement.clientHeight;

                    if (rect.top <= viewHeight && rect.bottom >= 0) {
                        setTimeout(() => {
                            item.classList.add('visible');
                        }, index * 100); // 각 항목마다 지연 추가
                    }
                });
            }
        });
    </script>

</body>

</html>
