<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>thinKB - error</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: KB금융 본문체 Light;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .error-container {
            text-align: center;
        }
        .error-image {
            width: 40%;
            height: auto;
        }
        .error-message {
            font-size: 20px;
            margin-top: 20px;
            color: #333;
        }
        .error-title {
            font-size: 40px;
            font-weight: bold;
            margin: 20px 0;
        }
        .main-button {
            display: inline-block;
            margin-top: 30px;
            padding: 10px 20px;
            background-color: #fff;
            color: #333;
            text-decoration: none;
            border-radius: 5px;
            border: 2px solid #ffcc00;
            font-size: 20px;
            font-weight: bold;
            text-align: center;
        }
        .main-button img {
            vertical-align: middle;
            margin-right: 8px;
            height: 35px; /* 이미지 높이를 버튼 내 텍스트 크기에 맞게 조정 */
            width: auto; /* 이미지 비율을 유지 */
        }
    </style>
</head>
<body>
    <div class="error-container">
        <!-- Error 이미지 -->
        <img src="<c:url value='./resources/404error.png' />" alt="ERROR" class="error-image">
        
        <!-- 에러 메시지 -->
        <div class="error-title">찾을 수 없는 페이지입니다.</div>
        <div class="error-message">
            요청하신 페이지가 사라졌거나, 잘못된 경로를 이용하셨어요.
        </div>
        
        <!-- 메인으로 가기 버튼 -->
        <a href="./main" class="main-button">
            <img src="<c:url value='./resources/logoFinal.png' />" alt="Logo">
            메인으로 가기
        </a>
    </div>
</body>
</html>
