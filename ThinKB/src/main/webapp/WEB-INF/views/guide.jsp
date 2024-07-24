<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Home</title>
<style>
.main-body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif; 
}
</style>

</head>
<body class="main-body">
	<%@ include file="./header.jsp"%>
	<img src="<c:url value='/resources/guide.png' />" />
</body>
</html>

