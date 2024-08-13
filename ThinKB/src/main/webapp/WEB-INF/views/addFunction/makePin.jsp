<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트 생성</title>
<head>
<meta charset="UTF-8">
<title>테스트 생성</title>
<style>
html, body {
    max-width: 100%;
    overflow-x: hidden;
}
.pin-body {
	font-family: Arial, sans-serif;
}


.pin-content {
	padding: 20px;
	margin-left: 17%;
	margin-right: 17%;
	margin-top: 1%;
}

.titleAndDetail {
	display: flex; 
	justify-content: space-between; 
	align-items: center; 
	margin-bottom: 10px;
}
.titleAndDetail-title {
	margin: 0;
	font-size: 18pt;
	color: black;
	font-weight: bold;
}
.titleAndDetail-detail {
	font-size: 13pt;
}

.new-subject {
	font-size: 15pt; /* 제목의 글자 크기 */
	color: black;
	border: 3px solid #FFD700; /* 진한 노란색 테두리 */
	border-radius: 20px; /* 라운드 처리 */
	padding: 20px; /* 내부 여백 */
	background-color: white; /* 배경색 */
}

input.new-subject {
	font-size: 13pt;
	color: black;
	border: 3px solid lightgrey;
	border-radius: 10px;
	padding: 20px;
	width: 100%;
	box-sizing: border-box;
}

input.new-subject:focus {
	border-color: #FFD700; /* 포커스 시 테두리 색상 */
	outline: none; /* 기본 포커스 스타일 제거 */
}

.yellow-button {
	background-color: #FFCC00;
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	cursor: pointer;
	font-weight: bold;
}

.yellow-button:hover {
	background-color: #D4AA00;
}

/* 회색버튼 */
.grey-button {
	background-color: #978A8F;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 10px;
	font-size: 13pt;
	cursor: pointer;
	font-weight: bold;
}

.grey-button:hover {
	background-color: #60584C;
}

/* A/B 이미지 창 */
.image-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 20px 0;
}

.image-box {
    width: 100%; /* 양쪽 간격을 위해 조정 */
    height: 400px;
    border: 2px solid #ccc;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    position: relative;
    background-color: #f0f0f0;
    overflow: hidden;
}

.image-box-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    background-color: #e0e0e0;
}

.image-box-title {
    font-weight: bold;
    font-size: 15pt;
    margin-left: 20px;
}

.image-preview {
    flex-grow: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
}

.image-preview img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
}

.image-preview-text {
    color: #888;
    font-size: 14px;
}

</style>

</head>
<body>
    
    <body class="pin-body">
	<!-- 헤더 영역 -->
	<%@ include file="../header.jsp"%>
	
	
	<!-- 콘텐츠 시작 -->
	<div class="pin-content">
	<div class="titleAndDetail-title" style="margin-bottom:50pt;">새로운 핀메모 만들기</div>
	
	<form id="pinTestForm" action="./processPinTest" method="post" enctype="multipart/form-data">
		<div class="titleAndDetail">
			<div class="titleAndDetail-title">핀메모 주제</div>
		</div>
		
		<input type="text" class="new-subject" name="testName" style="margin-bottom: 50px;"
			placeholder="핀메모 주제를 작성해주세요">
	
	
		<div class="image-container">
		    <div class="image-box">
		        <div class="image-box-header">
		            <span class="image-box-title">핀메모 이미지</span>
		            <input type="file" id="file" name="file" style="display: none;" onchange="previewImage(this, 'previewPin')">
		            <label for="file" class="grey-button">파일 선택</label>
		        </div>
		        <div class="image-preview" id="previewPin">
		            <span class="image-preview-text">핀메모 이미지 미리보기</span>
		        </div>
		    </div>
		</div>
		<div style="text-align: center; margin-top: 50px; margin-bottom: 200px;">
        	<button class="yellow-button" type="button" onclick="validateForm()">등록하기</button>
		</div>
    </form>

</div>
    



	<script>
	function showAlert() {
	       alert("정상적으로 등록되었습니다.");
	   }

	   function previewImage(input, previewId) {
		    const preview = document.getElementById(previewId);
		    const file = input.files[0];
		    const reader = new FileReader();

		    reader.onload = function(e) {
		        preview.innerHTML = '<img src="' + e.target.result + '" alt="Preview">';
		    }

		    if (file) {
		        reader.readAsDataURL(file);
		    } else {
		        preview.innerHTML = '<span class="image-preview-text">' +  '핀메모 이미지 미리보기</span>';
		    }
		}
	   
	   function validateForm() {
		    var testName = document.getElementsByName("testName")[0].value;
		    var fileA = document.getElementById("file").files.length;

		    if (testName.trim() === "" || file=== 0 ) {
		        alert("핀메모를 위해 모든 항목을 입력해주세요");
		    } else {
		        document.getElementById("pinTestForm").submit();
		    }
		}
</script>
</body>
</html>
