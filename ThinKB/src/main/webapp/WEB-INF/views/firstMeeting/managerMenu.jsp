<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방 관리자</title>
<style>
body, html {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}

.room1 {
	background: url('<c:url value="/resources/sf_23043.jpg"/>') no-repeat
		center center fixed;
	background-size: cover;
	height: 50vh;
	z-index: -1;
	position: relative;
}

.header {
	position: relative;
	z-index: 1;
}

.room1-content {
	padding: 20px;
	margin-left: 15%;
	margin-right: 15%;
	position: relative;
	z-index: 2;
}
</style>
</head>
<body>
	<header class="header">
		<%@ include file="../header.jsp"%>
	</header>
	<div class="room1"></div>
	<!-- 배경 이미지를 위한 영역 -->
	<div class="room1-content">
	<h1>회의방 관리 메뉴</h1>
	
	</div>
	
</body>
</html>