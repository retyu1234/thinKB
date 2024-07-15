<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
</head>

<body>
    <header>
        <div class="header">
            <div class="logo">
                <a href="<c:url value='/'/>"> <img src="<c:url value='/resources/logo1.png'/>" alt="Logo"> </a>
            </div>
            <div class="menu">
                <a href="#">사용가이드</a> <a href="#">회의방</a> <a href="#">내 보고서</a> <a href="#">알림함</a> <a href="#">마이페이지</a>
                <a href="#">A/B테스트</a> <a href="#">투표</a>
            </div>
            <div class="profile">
                <img src="<c:url value='/resources/images.jpg'/>" alt="Profile Picture"> 김국민 님
            </div>
            <a href="<c:url value='/logout'/>"> <img src="<c:url value='/resources/logout.png'/>" alt="Logout Icon" class="logout-icon"> </a>
        </div>
    </header>
</body>

</html>
